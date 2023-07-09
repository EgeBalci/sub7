unit Protohdr;
{
  PROTOHDR.PAS

  Original source is PROTOHDR.H
  Written by Sang-Eun Han
  (seh@brabo1.korea.ac.kr,  http://widecomm.korea.ac.kr/~seh).

  Convert to Delphi 4.0 by: Jagad (don@indo.net.id)
  May 10, 1999: Make faster TOULONG and TOUSHORT function and make it works
                with D3 by: Francois Piette (francois.piette@pophost.eunet.be)
}

{$ALIGN ON}

interface
uses windows;

type
// Ethernet Frame Header
(*
typedef	struct	_ETHERNET_HDR {
	UCHAR	Destination[6];
	UCHAR	Source[6];
	UCHAR	Protocol[2];
	UCHAR	Data[1];
} ETHERNET_HDR, *PETHERNET_HDR;
*)
ETHERNET_HDR = packed record
  Destination: array[0..5] of UCHAR;
  Source:      array[0..5] of UCHAR;
  Protocol:    array[0..1] of UCHAR;
  Data:        array[0..0] of UCHAR;
end;
PETHERNET_HDR = ^ETHERNET_HDR;

const
//rfc1340
PROTO_IP      =	$0800;
PROTO_ARP     =	$0806;
PROTO_XNS     =	$0600;
PROTO_SNMP    =	$814C;
PROTO_OLD_IPX =	$8137;
PROTO_NOVELL  =	$8138;
PROTO_IPNG    =	$86DD;


OFFSET_IP =	14;

type
// IPv4 Header
(*
typedef	struct	_IP_RHDR {
	UCHAR	VerLen;
	UCHAR	Service;
	UCHAR	Length[2];
	UCHAR	Ident[2];
	UCHAR	Flagoff[2];
	UCHAR	Timelive;
	UCHAR	Protocol;
	UCHAR	Checksum[2];
	UCHAR	Source[4];
	UCHAR	Destination[4];
	UCHAR	Data[1];
} IP_RHDR, *PIP_RHDR;
*)
IP_RHDR = packed record
  Verlen:       UCHAR;
  Service:      UCHAR;
  Length:       array[0..1] of UCHAR;
  Ident:        array[0..1] of UCHAR;
  Flagoff:      array[0..1] of UCHAR;
  TimeLive:     UCHAR;
  Protocol:     UCHAR;
  Checksum:     array[0..1] of UCHAR;
  Source:       array[0..3] of UCHAR;
  Destination:  array[0..3] of UCHAR;
  Data:         array[0..0] of UCHAR;
end;
PIP_RHDR = ^IP_RHDR;

// IPv6 Header
(*
typedef	struct	_IPNG_RHDR {
	UCHAR	VerPrio;
	UCHAR	FlowLabel[3];
	UCHAR	Length[2];
	UCHAR	NextHdr;
	UCHAR	HopLimit;
	UCHAR	Source[16];
	UCHAR	Destination[16];
	UCHAR	Data[1];
} IPNG_RHDR, *PIPNG_RHDR;
*)
IPNG_RHDR = packed record
  VerPrio:        UCHAR;
  FlowLabel:      array[0..2] of UCHAR;
  Length:         array[0..1] of UCHAR;
  NextHadr:       UCHAR;
  HopLimit:       UCHAR;
  Source:         array[0..15] of UCHAR;
  Destination:    array[0..15] of UCHAR;
  Data:           array[0..0] of UCHAR;
end;
PIPNG_RHDR = ^IPNG_RHDR;

// TCP Header, RFC793
(*
typedef	struct	_TCP_RHDR {
	UCHAR	Source[2];
	UCHAR	Destination[2];
	UCHAR	Seq[4];
	UCHAR	Ack[4];
	UCHAR	Rsvd0:4;
	UCHAR	Offset:4;
	UCHAR	Flags:6;
	UCHAR	Rsvd1:2;
	UCHAR	Window[2];
	UCHAR	Checksum[2];
	UCHAR	UrgPoint[2];
	UCHAR	Data[1];
} TCP_RHDR, *PTCP_RHDR;
*)
TCP_RHDR = packed record
  Source:        array[0..1] of UCHAR; //Source Port
  Destination:   array[0..1] of UCHAR; //Destination Port
  Seq:           array[0..3] of UCHAR;
  Ack:           array[0..3] of UCHAR;
  Rsvd0_Off:     UCHAR;
  Flags_Rsvd1:   UCHAR;
  Window:        array[0..1] of UCHAR;
  Checksum:      array[0..1] of UCHAR;
  UrgPoint:      array[0..1] of UCHAR;
  Data:          array[0..0] of UCHAR;
end;
PTCP_RHDR = ^TCP_RHDR;

const
TCP_FLAG_FIN =	$01;
TCP_FLAG_SYN =	$02;
TCP_FLAG_RST =	$04;
TCP_FLAG_PSH =	$08;
TCP_FLAG_ACK =	$10;
TCP_FLAG_URG =	$20;

PROTO_TCP = 6;

type
// UDP Header
(*
typedef	struct	_UDP_RHDR {
	UCHAR	Source[2];
	UCHAR	Destination[2];
	UCHAR	Length[2];
	UCHAR	Checksum[2];
	UCHAR	Data[1];
} UDP_RHDR, *PUDP_RHDR;
*)
UDP_RHDR = packed record
  Source:        array[0..1] of UCHAR;
  Destination:   array[0..1] of UCHAR;
  Length:        array[0..1] of UCHAR;
  Checksum:      array[0..1] of UCHAR;
  Data:          array[0..0] of UCHAR;
end;
PUDP_RHDR = ^UDP_RHDR;


// Pseudo Header for evaluating TCP/UDP Checksum
(*
typedef	struct	_PSU_RHDR {
	UCHAR	Source[4];
	UCHAR	Destination[4];
	UCHAR	Zero;
	UCHAR	Protocol;
	UCHAR	Length[2];
	UCHAR	Data[1];
} PSU_RHDR, *PPSU_RHDR;
*)
PSU_RHDR = packed record
  Source:        array[0..3] of UCHAR;
  Destination:   array[0..3] of UCHAR;
  Zero:          UCHAR;
  Protocol:      UCHAR;
  Length:        array[0..1] of UCHAR;
  Data:          array[0..0] of UCHAR;
end;
PPSU_RHDR = ^PSU_RHDR;


//Borland CBuilder is 32 bit Win App
//#ifdef	WIN32
//#define	TOUSHORT(x)	(USHORT)(*(x)<<8|*(x+1))
//#define	TOULONG(x)	(ULONG)(*(x)<<24|*(x+1)<<16|*(x+2)<<8|*(x+3))
//#else
//#define	TOUSHORT(x)	(*(USHORT *)x)	//Big-Endian
//#define	TOULONG(x)	(*(ULONG *)x)
//#endif

function TOUSHORT(x: PChar): SHORT;
function TOULONG(x: PChar): ULONG;

implementation

function TOUSHORT(x: PChar): SHORT;
begin
    Result := (SHORT(x^) shl 8) or (SHORT((x + 1)^));  // FP May 10, 1999
end;

function TOULONG(x: PChar): ULONG;
begin
    Result := (ULONG(x^) shl 24) or                    // FP May 10, 1999
              (ULONG((x + 1)^) shl 16) or              // FP May 10, 1999
              (ULONG((x + 2)^) shl 8) or               // FP May 10, 1999
              (ULONG((x + 3)^));                       // FP May 10, 1999
end;

end.
