{
  IngusClass.Pas - Packet32 Helper
  ----------------------------------
  Writen by: Jagad (don@indo.net.id)
  Updates by FP (francois.piette@pophost.eunet.be, http://www.rtfm.be/fpiette)
  May 12, 1999  FP  Added UDP Support
                    Changed TIngusSnifferThread.MacAddr property to PChar to be
                    consistent with TIngusPacketBase.MacAddr property.
                    Existing code may need to be changed.
}
unit Ingusclass;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Packet32, Protohdr;

const
  MAX_ADAPTER_COUNT = 5;

type
  TIngusPacketBase = class;
  TPacketDirection = (pdOutput, pdInput, pdPassThrough);
  TParsePacketEvent = procedure( nPacketSeq: Longint;
                                 uBuffer: PChar;
                                 nRecvBytes: integer;
                                 sPacket: TIngusPacketBase ) of object;

  TIngusPacketBase = class(TObject)
  private
    FMacAddr: PChar;
    FBuffer: PChar;
    FEthernetHdr: PETHERNET_HDR;
    FPacketDirection: TPacketDirection;
    FProtocol: Integer;
    FData: PChar;

  protected
  public
    constructor Create(MacAddr: PChar; uBuffer: PChar); virtual;
    destructor Destroy; override;

    property EthernetProtocol: integer read FProtocol;
    property PacketDirection: TPacketDirection read FPacketDirection;
    property EthernetHeader: PETHERNET_HDR read FEthernetHdr;
    property EthernetData: PChar read FData;

  end;

  TIngusSnifferThread = class(TThread)
  private
    FMacAddr: PChar;  // FPiette May 12, 1999
    FpAdapter: LPADAPTER;
    FpPacket: LPPACKET;
    FdwRxBytes: DWORD;
    FRxPacketSeq: Longint;
    FParsePacketEvent: TParsePacketEvent;

  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Execute; override;
    procedure SyncParseEvent;

    property MacAddr: PChar read FMacAddr write FMacAddr;
    property Adapter: LPADAPTER read FpAdapter write FpAdapter;
    property Packet: LPPACKET read FpPacket write FpPacket;
    property OnParsePacket: TParsePacketEvent read FParsePacketEvent write FParsePacketEvent;

  end;


  TAfterGetAdapterDesc = procedure(bStatus: Boolean; sAdapterDesc: string) of object;
  TAfterGetMacAddress = procedure(bStatus: Boolean; pMacAddr: PChar) of object;
  TAfterSetFilter = procedure(bStatus: Boolean; uFilter: ULONG) of object;

  TIngusSniffer = class(TObject)
  private
    //FuBuffer: array[0..1520] of Char;
    FuMac: array[0..5] of UCHAR;
    FAdapterDescs: array[0..MAX_ADAPTER_COUNT-1] of ADAPTER_DESC;
    FAdapterNames: TStringList;
    FAdapterCount: integer;
    FpPacket: LPPACKET;
    FhAdapter: DWORD;
    FbStartSnoop: Boolean;
    FParsePacketEvent: TParsePacketEvent;
    FIngusThread: TIngusSnifferThread;

    FAfterGetAdapterDesc: TAfterGetAdapterDesc;
    FAfterGetMacAddress: TAfterGetMacAddress;
    FAfterSetFilter: TAfterSetFilter;

  protected
    procedure GetAdapterNameList;
    function GetMacAddr: PChar;        // FP 12/05/99

  public
    constructor Create; virtual;
    destructor Destroy; override;

    //zero-based index
    function StartSnoop(nAdapterIndex: integer): Boolean;
    procedure StopSnoop;

    property MacAddr: PChar read GetMacAddr;         // FP 12/05/99
    property AdapterNameList: TStringList read FAdapterNames;
    property AdapterCount: integer read FAdapterCount;
    property OnParsePacket: TParsePacketEvent read FParsePacketEvent
                                              write FParsePacketEvent;
    property OnAfterGetAdapterDesc: TAfterGetAdapterDesc read FAfterGetAdapterDesc
                                                         write FAfterGetAdapterDesc;
    property OnAfterGetMacAddress: TAfterGetMacAddress read FAfterGetMacAddress
                                                       write FAfterGetMacAddress;
    property OnAfterSetFilter: TAfterSetFilter read FAfterSetFilter
                                                 write FAfterSetFilter;

  end;

var
   FuBuffer: array[0..1520] of Char;

implementation
uses IngusPacket;

//----- TIngusPacketBase ------//
constructor TIngusPacketBase.Create(MacAddr: PChar; uBuffer: PChar);
begin
  inherited Create;
  FMacAddr := MacAddr;
  FBuffer := uBuffer;
  FEthernetHdr := PETHERNET_HDR(FBuffer);
  FProtocol := TOUSHORT(@(FEthernetHdr^.Protocol[0]));
  FData := @(FEthernetHdr^.Data[0]);

  //Packet Direction
  FPacketDirection := pdPassThrough;
  if CompareMem(FMacAddr, @(FEthernetHdr^.Destination[0]), 6) then begin
    //Input
    FPacketDirection := pdInput;
  end
  else if CompareMem(FMacAddr, @(FEthernetHdr^.Source[0]), 6) then begin
    //Output
    FPacketDirection := pdOutput;
  end;
end;

destructor TIngusPacketBase.Destroy;
begin
  //...
  inherited Destroy;
end;

//----- TIngusSnifferThread ------//
constructor TIngusSnifferThread.Create;
begin
  //Initiate vars
  FpAdapter := nil;
  FpPacket := nil;

  inherited Create(True);
end;

destructor TIngusSnifferThread.Destroy;
begin
  //...
  inherited Destroy;
end;

procedure TIngusSnifferThread.Execute;
begin
  if (FpAdapter = nil)or(FpPacket = nil) then exit;

  FRxPacketSeq := 0;
  while (not Terminated) do begin
    PacketReceivePacket(FpAdapter, FpPacket, TRUE, @FdwRxBytes);
    if (not Terminated) then
      Synchronize(SyncParseEvent);

    Inc(FRxPacketSeq);
  end;
end;

procedure TIngusSnifferThread.SyncParseEvent;
var
  sPacket: TIngusPacketBase;
  pEthernetHdr: PETHERNET_HDR;
  pIPHeader: PIP_RHDR;
  nProto, nIPProto: integer;
begin
  if (FpPacket = nil) then exit;

  pEthernetHdr := PETHERNET_HDR(@(FpPacket^.Buffer[0]));
  nProto := TOUSHORT(@(pEthernetHdr^.Protocol[0]));

  case nProto of
  //IP
  PROTO_IP: begin
              pIPHeader := PIP_RHDR(@(pEthernetHdr^.Data[0]));
              nIPProto := pIPHeader^.Protocol;

              case nIPProto of
              //ICMP
              1: sPacket := TIngusICMPPacket.Create( FMacAddr, @(FpPacket^.Buffer[0]) );
              //TCP
              6: sPacket := TIngusTCPPacket.Create(FMacAddr, @(FpPacket^.Buffer[0]));
              //UDP
              17: sPacket := TIngusUDPPacket.Create(FMacAddr, @(FpPacket^.Buffer[0]));
              else
                sPacket := TIngusIPPacket.Create(FMacAddr, @(FpPacket^.Buffer[0]));
              end;
            end;
  else
    sPacket := TIngusPacketBase.Create( FMacAddr, @(FpPacket^.Buffer[0]) );
  end;

  //Call Event handler
  if Assigned(FParsePacketEvent) then
    FParsePacketEvent( FRxPacketSeq, @(FpPacket^.Buffer[0]), FdwRxBytes, sPacket );
  sPacket.Free;

end;

//----- TIngusSniffer ------//
procedure TIngusSniffer.GetAdapterNameList;
var
  i: integer;
begin
  //Get Adapter names
  if (PacketGetAdapterNames(@FAdapterDescs[0], MAX_ADAPTER_COUNT, @FAdapterCount) = FALSE) then
  begin
    //Error....
    exit;
  end;

  for i := 0 to FAdapterCount-1 do begin
    FAdapterNames.Add(StrPas(FAdapterDescs[i].szAdapterDesc));
  end;
end;

function TIngusSniffer.GetMacAddr: PChar;
begin
try   Result := @FuMac;  except end;// FP 12/05/99
end;

constructor TIngusSniffer.Create;
begin
  inherited Create;

try  FAdapterNames := TStringList.Create;
  //Get Adapter Names
  GetAdapterNameList;
  FbStartSnoop := FALSE;except end;
end;

destructor TIngusSniffer.Destroy;
begin
try  if FbStartSnoop then StopSnoop; //Avoid Blue-Screen :)
  FAdapterNames.Free;
   except end;
  inherited Destroy;
end;

function TIngusSniffer.StartSnoop(nAdapterIndex: integer): Boolean;
var
  i: integer;
begin
 try
  Result := False;
  if (FbStartSnoop) then exit;
  if (nAdapterIndex >= FAdapterCount) then exit;

  //Open Adapter
  FhAdapter := PacketOpenAdapter(FAdapterDescs[nAdapterIndex].szAdapterName);
  if (FhAdapter = 0) then begin
    //Error in open adapter...
    exit;
  end;

  //Get Adapter Description
  if (PacketAdapterDesc(LPADAPTER(FhAdapter), @FuBuffer[0], sizeof(FuBuffer), @i) = TRUE) then
  begin
    if Assigned(FAfterGetAdapterDesc) then
      FAfterGetAdapterDesc(TRUE, StrPas(@FuBuffer[0]));
  end
  else begin
    //Error
    if Assigned(FAfterGetAdapterDesc) then
      FAfterGetAdapterDesc(FALSE, '');
  end;

  //Get Current Mac Address
  if (PacketGetAddress(LPADAPTER(FhAdapter), @FuMac[0], 6, @i) = TRUE) then
  begin
    if Assigned(FAfterGetMacAddress) then
      FAfterGetMacAddress(TRUE, @FuMac[0]);
  end
  else begin
    //Error
    if Assigned(FAfterGetMacAddress) then
      FAfterGetMacAddress(FALSE, nil);
  end;

  //Select Filter mode
  if (PacketSetFilter(LPADAPTER(FhAdapter), NDIS_PACKET_TYPE_PROMISCUOUS) = TRUE) then
  begin
    if Assigned(FAfterSetFilter) then
      FAfterSetFilter(TRUE, NDIS_PACKET_TYPE_PROMISCUOUS);
  end
  else begin
    //Error
    if Assigned(FAfterSetFilter) then
      FAfterSetFilter(FALSE, NDIS_PACKET_TYPE_PROMISCUOUS);
  end;

  //Allocate Packet
  FpPacket := LPPACKET( PacketAllocatePacket(LPADAPTER(FhAdapter)) );
  if (FpPacket = Nil) then begin
    //Error...
    PacketCloseAdapter(LPADAPTER(FhAdapter));
    exit;
  end;

  //set the packet's buffer and its max. length
	PacketInitPacket(FpPacket, @FuBuffer[0], 1520);
  FbStartSnoop := TRUE;

  //Create Thread
  FIngusThread := TIngusSnifferThread.Create; //Create Suspended Thread
  FIngusThread.MacAddr := @FuMac[0];
  FIngusThread.Adapter := LPADAPTER(FhAdapter);
  FIngusThread.Packet := FpPacket;
  FIngusThread.OnParsePacket := FParsePacketEvent;
  FIngusThread.Resume; //Resume thread -> Execute

  Result := TRUE;except end;
end;

procedure TIngusSniffer.StopSnoop;
begin
  if not FbStartSnoop then exit;
try  FIngusThread.Terminate;

  //close the underlying adapter
	PacketCloseAdapter(LPADAPTER(FhAdapter));
    //free packet
	PacketFreePacket(FpPacket);
  FbStartSnoop := FALSE;

  FIngusThread.Free;except end;
end;

end.
