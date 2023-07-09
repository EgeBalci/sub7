{
  Helper to handle packet
  ----------------------------------
  Writen by: Jagad (don@indo.net.id)
  Updates by FP (francois.piette@pophost.eunet.be, http://www.rtfm.be/fpiette)
  May 12, 1999  FPiette  Added UDP Support
  May 14, 1999: Jagad    Add Length property at TIngusIPPacket
}
unit IngusPacket;

interface

uses windows, Protohdr, Ingusclass;

type
(*
typedef struct tagTRANSPORT_PROTOCOLS {
	UCHAR	Protocol;
	TCHAR	szName[20];
	TCHAR	szDescription[MAX_PATH];
} TRANSPORT_PROTOCOLS, *LPTRANSPORT_PROTOCOLS;
*)

tagTRANSPORT_PROTOCOLS = packed record
  Protocol: UCHAR;
  szName: array [0..19] of Char;
  szDescription: array[0..MAX_PATH-1] of Char;
end;
TRANSPORT_PROTOCOLS = tagTRANSPORT_PROTOCOLS;
LPTRANSPORT_PROTOCOLS = ^TRANSPORT_PROTOCOLS;

(*
//see rfc1340.txt
TRANSPORT_PROTOCOLS transProtos[] = {
	{1 , "ICMP",    "Internet Control Message" },
	{2 , "IGMP",    "Internet Group Management"},
	{3 , "GGP" ,    "Gateway-to-Gateway"},
	{4 , "IP"  ,    "IP in IP (encasulation)"},
	{5 , "ST"  ,    "Stream"},
	{6 , "TCP" ,    "Transmission Control"},
	{8 , "EGP" ,    "Exterior Gateway Protocol"},
	{9 , "IGP" ,    "any private interior gateway"},
	{17, "UDP" ,    "User Datagram"},
	{27, "RDP" ,    "Reliable Data Protocol"},
	{28, "IRTP",    "Internet Reliable Transaction"},
	{29, "ISO-TP4" ,  "ISO Transport Protocol Class 4"},
	{35, "IDPR"    ,  "Inter-Domain Policy Routing Protocol"},
	{37, "DDP"     ,  "Datagram Delivery Protocol"},
	{38, "IDPR-CMTP", "IDPR Control Message Transport Proto"},
	{88, "IGRP"     , "IGRP"},
	{89, "OSPFIGP"  , "OSPFIGP"},
	{92, "MTP"      , "Multicast Transport Protocol"},
	{94, "IPIP"     , "IP-within-IP Encapsulation Protocol"},
	{97, "ETHERIP"  , "Ethernet-within-IP Encapsulation"},
	{98, "ENCAP"    , "Encapsulation Header"}
};
#define TRANSPROTOS_MAX	(sizeof(transProtos)/sizeof(TRANSPORT_PROTOCOLS))
*)
TRANSPORT_PROTOCOLS_ARRAY = array [0..20] of TRANSPORT_PROTOCOLS;
const
    transProtos: TRANSPORT_PROTOCOLS_ARRAY = (
    (Protocol: 1;     szName: 'ICMP';      szDescription: 'Internet Control Message'),
    (Protocol: 2;     szName: 'IGMP';      szDescription: 'Internet Group Management'),
    (Protocol: 3;     szName: 'GGP';       szDescription: 'Gateway-to-Gateway'),
    (Protocol: 4;     szName: 'IP' ;       szDescription: 'IP in IP (encasulation)'),
    (Protocol: 5;     szName: 'ST' ;       szDescription: 'Stream'),
    (Protocol: 6;     szName: 'TCP';       szDescription: 'Transmission Control'),
    (Protocol: 8;     szName: 'EGP';       szDescription: 'Exterior Gateway Protocol'),
    (Protocol: 9;     szName: 'IGP';       szDescription: 'any private interior gateway'),
    (Protocol: 17;    szName: 'UDP';       szDescription: 'User Datagram'),
    (Protocol: 27;    szName: 'RDP';       szDescription: 'Reliable Data Protocol'),
    (Protocol: 28;    szName: 'IRTP';      szDescription: 'Internet Reliable Transaction'),
    (Protocol: 29;    szName: 'ISO-TP4';   szDescription: 'ISO Transport Protocol Class 4'),
    (Protocol: 35;    szName: 'IDPR'   ;   szDescription: 'Inter-Domain Policy Routing Protocol'),
    (Protocol: 37;    szName: 'DDP'    ;   szDescription: 'Datagram Delivery Protocol'),
    (Protocol: 38;    szName: 'IDPR-CMTP'; szDescription: 'IDPR Control Message Transport Proto'),
    (Protocol: 88;    szName: 'IGRP'    ;  szDescription: 'IGRP'),
    (Protocol: 89;    szName: 'OSPFIGP' ;  szDescription: 'OSPFIGP'),
    (Protocol: 92;    szName: 'MTP'     ;  szDescription: 'Multicast Transport Protocol'),
    (Protocol: 94;    szName: 'IPIP'    ;  szDescription: 'IP-within-IP Encapsulation Protocol'),
    (Protocol: 97;    szName: 'ETHERIP' ;  szDescription: 'Ethernet-within-IP Encapsulation'),
    (Protocol: 98;    szName: 'ENCAP'   ;  szDescription: 'Encapsulation Header')
);

const
  TRANSPROTOS_MAX =	20; //it's Delphi :)

(*
typedef struct _XICMPProto{
    UCHAR icmp_type;
	UCHAR icmp_code;
	USHORT icmp_cksum;
	ULONG filler;
}XICMP_HDR, *PXICMP_HDR;
*)

type
_XICMPProto = packed record
  icmp_type: UCHAR;
  icmp_code: UCHAR;
  icmp_cksum: SHORT;
  filler: ULONG;
end;
XICMP_HDR = _XICMPProto;
PXICMP_HDR = ^XICMP_HDR;

(*
typedef struct _XARPProto{
    USHORT  ar_hwtype;
    USHORT  ar_prtype;
    UCHAR   ar_hwlen;
    UCHAR   ar_prlen;
    UCHAR   ar_op;
    char    ar_addr[1];
}XARP_HDR, *XPARP_HDR;
*)

_XARPProto = packed record
  ar_hwtype: SHORT;
  ar_prtype: SHORT;
  ar_hwlen: UCHAR;
  ar_prlen: UCHAR;
  ar_op: UCHAR;
  ar_addr: array[0..0] of Char;
end;

(*
#define ARP_REQUEST     1
#define ARP_REPLY       2
#define RARP_REQUEST    3
#define RARP_REPLY      4
*)
const
  ARP_REQUEST  =    1;
  ARP_REPLY    =    2;
  RARP_REQUEST =    3;
  RARP_REPLY   =    4;

type
  //
  //This classes will allow to trap event based on type of packet
  //
  TIngusIPPacket = class(TIngusPacketBase)
  private
    FIPProto: integer;
    FIPSourceAddr: PChar;
    FIPDestAddr: PChar;
    FData: PChar;
    FpIPHdr: PIP_RHDR;
    FIPLength: integer;
  protected
  public
    constructor Create(MacAddr: PChar; uBuffer: PChar); override;
    destructor Destroy; override;

    property IPProtocol: integer read FIPProto;
    property IPHeader: PIP_RHDR read FpIPHdr;
    property IPSourceAddr: PChar read FIPSourceAddr;
    property IPDestAddr: PChar read FIPDestAddr;
    property IPData: PChar read FData;
    property IPLength: integer read FIPLength;
  end;

  TIngusICMPPacket = class(TIngusIPPacket)
  private
    FIcmpType: UCHAR;
    FIcmpCode: UCHAR;
    FpIcmpHdr: PXICMP_HDR;
  protected
  public
    constructor Create(MacAddr: PChar; uBuffer: PChar); override;
    destructor Destroy; override;

    property ICMPHdr: PXICMP_HDR read FpIcmpHdr;
    property ICMPType: UCHAR read FIcmpType;
    property ICMPCode: UCHAR read FIcmpCode;

  end;

  TIngusTCPPacket = class(TIngusIPPacket)
  private
    FSourcePort: SHORT;
    FDestPort: SHORT;
    FSeq: ULONG;
    FAck: ULONG;
    FFlag: integer;
    FTCPHdr: PTCP_RHDR;
    FTCPData: PChar;
  protected
    function GetFlag: integer;
  public
    constructor Create(MacAddr: PChar; uBuffer: PChar); override;
    destructor Destroy; override;

    property TCPHeader: PTCP_RHDR read FTCPHdr;
    property SourcePort: SHORT read FSourcePort;
    property DestPort: SHORT read FDestPort;
    property SeqNum: ULONG read FSeq;
    property AckNum: ULONG read FAck;
    property Flag: integer read FFlag;
    property TCPData: PChar read FTCPData;
  end;

  TIngusUDPPacket = class(TIngusIPPacket)
  private
    FSourcePort: SHORT;
    FDestPort: SHORT;
    FUDPHdr: PUDP_RHDR;
    FUDPData: PChar;
  public
    constructor Create(MacAddr: PChar; uBuffer: PChar); override;
    property UDPHeader: PUDP_RHDR read FUDPHdr;
    property SourcePort: SHORT read FSourcePort;
    property DestPort: SHORT read FDestPort;
    property UDPData: PChar read FUDPData;
  end;

implementation

//------ TIngusUDPPacket ------//
constructor TIngusUDPPacket.Create(MacAddr: PChar; uBuffer: PChar);
begin
  inherited Create(MacAddr, uBuffer);
  FUDPHdr     := PUDP_RHDR(IPData);
  FSourcePort := TOUSHORT(@(FUDPHdr^.Source[0]));
  FDestPort   := TOUSHORT(@(FUDPHdr^.Destination[0]));
  FUDPData := @PUDP_RHDR(IPData)^.Data;
end;

//------ TIngusTCPPacket ------//
function TIngusTCPPacket.GetFlag: integer;
begin
  Result := FTCPHdr^.Flags_Rsvd1 and $FC;
  if Result <> 0 then
    Result := FTCPHdr^.Flags_Rsvd1 div $4; //Shift Right 2 bits
end;

constructor TIngusTCPPacket.Create(MacAddr: PChar; uBuffer: PChar);
begin
  inherited Create(MacAddr, uBuffer);
  FTCPHdr := PTCP_RHDR(IPData);
  FSourcePort := TOUSHORT(@(FTCPHdr^.Source[0]));
  FDestPort := TOUSHORT(@(FTCPHdr^.Destination[0]));
  FSeq := TOULONG(@(FTCPHdr^.Seq[0]));
  FAck := TOULONG(@(FTCPHdr^.Ack[0]));
  FFlag := GetFlag;
  FTCPData := @PTCP_RHDR(IPData)^.Data;
end;

destructor TIngusTCPPacket.Destroy;
begin
  //...
  inherited Destroy;
end;

//----- TIngusIPPacket -----//
constructor TIngusIPPacket.Create(MacAddr: PChar; uBuffer: PChar);
begin
  inherited Create(MacAddr, uBuffer);
  FpIPHdr := PIP_RHDR(EthernetData);
  FIPSourceAddr := @(FpIPHdr^.Source[0]);
  FIPDestAddr := @(FpIPHdr^.Destination[0]);
  FData := @(FpIPHdr^.Data[0]);
  FIPProto := FpIPHdr^.Protocol;
  FIPLength := TOUSHORT(@(FpIPHdr^.Length[0]));
end;

destructor TIngusIPPacket.Destroy;
begin
  //...
  inherited Destroy;
end;

//----- TIngusICMPPacket -----//

constructor TIngusICMPPacket.Create(MacAddr: PChar; uBuffer: PChar);
begin
  inherited Create(MacAddr, uBuffer);
  FpIcmpHdr := PXICMP_HDR(IPData);
  FIcmpType := FpIcmpHdr^.icmp_type;
  FIcmpCode := FpIcmpHdr^.icmp_code;
end;

destructor TIngusICMPPacket.Destroy;
begin
  //...
  inherited Destroy;
end;

end.
