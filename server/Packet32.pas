unit packet32;
{
     PACKET32.PAS

     Original source is PACKET32.H
     Written by Sang-Eun Han
     (seh@brabo1.korea.ac.kr,  http://widecomm.korea.ac.kr/~seh).
     Convert to Delphi 4.0 by: Jagad (don@indo.net.id)
     Some updates by francois.piette@pophost.eunet.be (see below)
     Use static link to Packet32.DLL

     Note:
      - BOOLEAN convert to Boolean, don't convert to BOOL because
        BOOL is LongBool.
      - ULONG convert to BOOL if it's return TRUE or FALSE
     Updates:
      May 10, 1999  Jagad   Add Directive to support D3
      May 10, 1999          Change UINT to Longint for D3
      May 10, 1999  FPiette confirm update: OVERLAPPED changes
                            TOverlapped for D3
      May 17, 1999  FPiette Added automatic Delphi3/Delphi4 detection
                    FPiette introduced USLONG type to unify between D3 and D4
                    with simplified directives
}

{$ALIGN ON}

interface
uses windows;

const

//copied from Ndis.h
//the following constants are to be used to direct
//the underlying NIC driver to choose which type of
//packet can be delivered to the upper bound driver,
//that is, our snoop driver.
NDIS_PACKET_TYPE_DIRECTED =           $0001;
NDIS_PACKET_TYPE_MULTICAST =          $0002;
NDIS_PACKET_TYPE_ALL_MULTICAST =      $0004;
NDIS_PACKET_TYPE_BROADCAST =          $0008;
NDIS_PACKET_TYPE_SOURCE_ROUTING =     $0010;
NDIS_PACKET_TYPE_PROMISCUOUS =        $0020; //for snoop
NDIS_PACKET_TYPE_SMT =                $0040;
NDIS_PACKET_TYPE_MAC_FRAME =          $8000;
NDIS_PACKET_TYPE_FUNCTIONAL =         $4000;
NDIS_PACKET_TYPE_ALL_FUNCTIONAL =     $2000;
NDIS_PACKET_TYPE_GROUP =              $1000;
//

MAX_LINK_NAME_LENGTH =   5;

type
{ Jagad like to have DELPHI3/DELPHI4 defined for lisibility }
{ VER100 is automatically defined by Delphi3 compiler       }
{ VER120 is automatically defined by Delphi4 compiler       }
{$IFDEF VER100}
    {$DEFINE DELPHI3}
{$ELSE}
    {$DEFINE DELPHI4}
{$ENDIF}

{$IFDEF DELPHI3}
    USLONG = LongInt;
{$ELSE}
    USLONG = LongWord;
{$ENDIF}

//typedef struct tagADAPTER {
//	HANDLE     hFile;
//	TCHAR      szAdapterName[MAX_LINK_NAME_LENGTH];
//	TCHAR      SymbolicLink[MAX_PATH];
//} ADAPTER, *LPADAPTER;
ADAPTER = packed record
  hFile:                THandle;
  szAdapterName:        array [0..MAX_LINK_NAME_LENGTH-1] of Char;
  SymbolicLink:         array [0..MAX_PATH-1] of Char;
end;
LPADAPTER = ^ADAPTER;

//typedef struct tagPACKET {
//	HANDLE       hEvent;
//	OVERLAPPED   OverLapped;
//	PVOID        Buffer;
//	UINT         Length;
//} PACKET, *LPPACKET;
PACKET = packed record
  hEvent:      THandle;
  xOverlapped: TOVERLAPPED;    // FPiette May 10, 1999
  Buffer:      PChar;
  Length:      USLONG;         // FPiette May 17, 1999
end;
LPPACKET = ^PACKET;

//typedef struct tagADAPTER_DESC {
//	TCHAR	szAdapterName[MAX_LINK_NAME_LENGTH];
//	TCHAR	szAdapterDesc[MAX_PATH];
//} ADAPTER_DESC, *LPADAPTER_DESC;
ADAPTER_DESC = packed record
  szAdapterName:     array[0..MAX_LINK_NAME_LENGTH-1] of Char;
  szAdapterDesc:     array[0..MAX_PATH-1] of Char;
end;
LPADAPTER_DESC = ^ADAPTER_DESC;

(*
PVOID WINAPI
PacketOpenAdapter(
	LPTSTR   AdapterName
	/*
	description:
		open the adapter named as the argument.
		to get the adapter name, call PacketGetAdapterNames.
	return:
		if success, return the pointer to the allocated ADAPTER structure.
		else, return NULL
	*/
);
*)
function PacketOpenAdapter( AdapterName: LPSTR ): DWORD; stdcall;


(*BOOLEAN	 WINAPI
PacketSendPacket(
	LPADAPTER   AdapterObject,
	LPPACKET    lpPacket,
	BOOLEAN     Sync
	/*
	description:
		send the user-supplied data via lpPacket.
		Sync value is ignored.
	return:
		if success, return TRUE
		else, return FALSE
	*/
);
*)
function PacketSendPacket( AdapterObject: LPADAPTER;
                           plpPacket:     LPPACKET;
                           Sync:          Boolean ): Boolean; stdcall;

(*PVOID  WINAPI
PacketAllocatePacket(
	LPADAPTER   AdapterObject
	/*
	description:
		allocate the new packet
	return:
		if success, return the pointer to the allocated PACKET structure
		else, return NULL
	*/
);
*)
function PacketAllocatePacket( AdapterObject: LPADAPTER ): DWORD; stdcall;


(*VOID  WINAPI
PacketInitPacket(
	LPPACKET    lpPacket,
	PVOID       Buffer,
	UINT        Length
	/*
	description:
		set lpPacket's buffer to the user-passed Buffer
		set lpPacket's length to the user-passed Length
	return:
	*/
);
*)
procedure PacketInitPacket(
    plpPacket: LPPACKET;
    Buffer:    PChar;
    Length:    USLONG); stdcall;  // FPiette May 17, 1999
(*VOID  WINAPI
PacketFreePacket(
	LPPACKET    lpPacket
	/*
	description:
		free the pre-allocated lpPacket
		This doesn't free the lpPacket's buffer.
	return:
	*/
);
*)
procedure PacketFreePacket( plpPacket: LPPACKET ); stdcall;



(*BOOLEAN	 WINAPI
PacketResetAdapter(
	LPADAPTER  AdapterObject
	/*
	description:
		flush the adpater's receive queue
		clear any pending if it is.
	return:
	*/
);
*)
function PacketResetAdapter( AdapterObject: LPADAPTER ): Boolean; stdcall;


(*BOOLEAN	 WINAPI
PacketGetAddress(
	LPADAPTER  AdapterObject,
	PUCHAR     AddressBuffer,
	DWORD		cbBytes,
	LPDWORD		lpcbBytes
	/*
	description:
		get the adapter's current MAC address
	return:
		if success, AddressBuffer contains the MAC address,
					lpcbBytes is of the real size of the MAC address in bytes,
					return TRUE
		else, return FALSE
	*/
	);
*)
function PacketGetAddress( AdapterObject: LPADAPTER;
                           AddressByffer: PUCHAR;
                           cbBytes:       DWORD;
                           lpcbBytes:     LPDWORD): Boolean; stdcall;


(*BOOLEAN	 WINAPI
PacketWaitPacket(
	LPADAPTER  AdapterObject,
	LPPACKET   lpPacket,
	PULONG     BytesReceived
	/*
	description:
		if the user called PacketReceivePacket with the 3rd argument, Sync, set to FALSE
		before calling this and PacketReceivePacket returned FALSE, then,
		this function waits until a packet is received.
	return:
		if success, the contents of the received packet is passed via lpPacket's Buffer,
					the length of the received packet in bytes is passed via *BytesReceived,
					and return TRUE
		else, return FALSE
	*/
	);
*)
function PacketWaitPacket( AdapterObject: LPADAPTER;
                           plpPacket:     LPPACKET;
                           BytesReceived: PULONG): Boolean; stdcall;

(*BOOLEAN WINAPI
PacketReceivePacket(
	LPADAPTER   AdapterObject,
	LPPACKET    lpPacket,
	BOOLEAN     Sync,
	PULONG      BytesReceived
	/*
	description:
		receive a packet transitted over the transmission line attached to this PC.
		if Sync is set to FALSE, then it immediately returns (later, call PacketWaitPacket)
		;otherwise, it waits until any packet is received.
	return:
		if success, the contents of the received packet is passed via lpPacket's Buffer,
					the length of the received packet in bytes is passed via *BytesReceived,
					and return TRUE
		else, *BytesReceived = 0 and return FALSE
	*/
	);
*)
function PacketReceivePacket( AdapterObject: LPADAPTER;
                              plpPacket:     LPPACKET;
                              Sync:          Boolean;
                              BytesReceived: PULONG): Boolean; stdcall;

(*VOID WINAPI
PacketCloseAdapter(
	LPADAPTER   lpAdapter
	/*
	description:
		close the underlying adpater
	return:
	*/
	);
*)
procedure PacketCloseAdapter( AdapterObject: LPADAPTER ); stdcall;

(*BOOLEAN WINAPI
PacketSetFilter(
	LPADAPTER  AdapterObject,
	ULONG      Filter
	/*
	description:
		select the mode of how to receive packets.
		For Filter, see the topmost part of this header file.
	return:
		if success, return TRUE
		else, return FALSE
	*/
	);
*)
function PacketSetFilter( AdapterObject: LPADAPTER;
                          Filter:        ULONG): Boolean; stdcall;

(*ULONG  WINAPI
PacketGetAdapterNames(
	PVOID	pAdapterDescs,
	UINT	nAdapterDescs,
	PUINT	pnAdapterDescsMax
	/*
	description:
		find all the adapters installed into this PC.
		The user should set the maximum bound of the number of adapters,
		normally 3 is enough.
	return:
		if found, *pnAdapterDescsMax is the total number of the found adapters
					and return TRUE.
		else, *pnAdapterDescsMax = 0 and return FALSE
	*/
	);
*)
function PacketGetAdapterNames(
    pAdapterDescs:      PChar;
    nAdapterDescs:      USLONG;         // FPiette May 17, 1999
    pnAdapterDescsMax:  PUINT ): BOOL; stdcall;

(*BOOLEAN WINAPI
PacketAdapterDesc(
	LPADAPTER	AdapterObject,
	LPSTR		lpszVendorSays,
	DWORD		cbBytes,
	LPDWORD		lpcbBytes
	/*
	description:
		get the vendor's description of the underlying NIC.
	return:
		if success, the vendor's description is passed via lpszVendorSays,
					*lpcbBytes is of the length of the description in bytes.
					and return TRUE.
		else, return FALSE.
	*/
	);
*)
function PacketAdapterDesc( AdapterObject:  LPADAPTER;
                            lpszVendorSays: LPSTR;
                            cbBytes:        DWORD;
                            lpcbBytes:      LPDWORD ): Boolean; stdcall;

implementation

const Packet32Lib = 'Packet32.dll';

function PacketOpenAdapter; external Packet32Lib name 'PacketOpenAdapter';
function PacketSendPacket; external Packet32Lib name 'PacketSendPacket';
function PacketAllocatePacket; external Packet32Lib name 'PacketAllocatePacket';
procedure PacketInitPacket; external Packet32Lib name 'PacketInitPacket';
procedure PacketFreePacket; external Packet32Lib name 'PacketFreePacket';
function PacketResetAdapter; external Packet32Lib name 'PacketResetAdapter';
function PacketGetAddress; external Packet32Lib name 'PacketGetAddress';
function PacketWaitPacket; external Packet32Lib name 'PacketWaitPacket';
function PacketReceivePacket; external Packet32Lib name 'PacketReceivePacket';
procedure PacketCloseAdapter; external Packet32Lib name 'PacketCloseAdapter';
function PacketSetFilter; external Packet32Lib name 'PacketSetFilter';
function PacketGetAdapterNames; external Packet32Lib name 'PacketGetAdapterNames';
function PacketAdapterDesc; external Packet32Lib name 'PacketAdapterDesc';

end.
