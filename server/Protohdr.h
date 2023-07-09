/****************************************************************************
 * Written by Sang-Eun Han (seh@brabo1.korea.ac.kr).
 * 
 * Date :
 *
 * Filename : protohdr.h
 *
 *
 * PERMISSION IS GRANTED TO USE, COPY AND DISTRIBUTE THIS SOFTWARE FOR ANY 
 * PURPOSE EXCEPT FOR A BUSINESS OR COMMERCIAL PURPOSE, AND WITHOUT FEE, PROVIDED, 
 * THAT THE ABOVE COPYRIGHT NOTICE AND THIS STATEMENT APPEAR IN ALL COPIES.
 * I MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY OF THIS
 * SOFTWARE FOR ANY PURPOSE.  THIS SOFTWARE IS PROVIDED "AS IS."
 *
 */

#ifndef	_PROTOCOL_HEADER_H_
#define	_PROTOCOL_HEADER_H_

// Ethernet Frame Header
typedef	struct	_ETHERNET_HDR {
	UCHAR	Destination[6];
	UCHAR	Source[6];
	UCHAR	Protocol[2];
	UCHAR	Data[1];
} ETHERNET_HDR, *PETHERNET_HDR;

//rfc1340
#define PROTO_IP		(0x0800)
#define	PROTO_ARP		(0x0806)
#define	PROTO_XNS		(0x0600)
#define	PROTO_SNMP		(0x814C)
#define	PROTO_OLD_IPX	(0x8137)
#define	PROTO_NOVELL	(0x8138)
#define	PROTO_IPNG		(0x86DD)


#define	OFFSET_IP	(14)

// IPv4 Header
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

// IPv6 Header
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

// TCP Header, RFC793
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
#define	TCP_FLAG_FIN	0x01
#define	TCP_FLAG_SYN	0x02
#define	TCP_FLAG_RST	0x04
#define	TCP_FLAG_PSH	0x08
#define	TCP_FLAG_ACK	0x10
#define	TCP_FLAG_URG	0x20

#define	PROTO_TCP	(6)

// UDP Header
typedef	struct	_UDP_RHDR {
	UCHAR	Source[2];
	UCHAR	Destination[2];
	UCHAR	Length[2];
	UCHAR	Checksum[2];
	UCHAR	Data[1];
} UDP_RHDR, *PUDP_RHDR;


// Pseudo Header for evaluating TCP/UDP Checksum
typedef	struct	_PSU_RHDR {
	UCHAR	Source[4];
	UCHAR	Destination[4];
	UCHAR	Zero;
	UCHAR	Protocol;
	UCHAR	Length[2];
	UCHAR	Data[1];
} PSU_RHDR, *PPSU_RHDR;


//Borland CBuilder is 32 bit Win App
//#ifdef	WIN32
#define	TOUSHORT(x)	(USHORT)(*(x)<<8|*(x+1))
#define	TOULONG(x)	(ULONG)(*(x)<<24|*(x+1)<<16|*(x+2)<<8|*(x+3))
//#else
//#define	TOUSHORT(x)	(*(USHORT *)x)	//Big-Endian
//#define	TOULONG(x)	(*(ULONG *)x)
//#endif


#endif	/* _PROTOCOL_HEADER_H_ */