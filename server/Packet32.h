/****************************************************************************
 * Written by Sang-Eun Han (seh@brabo1.korea.ac.kr).
 * 
 * Date :
 *
 * Filename : Packet32.h
 *
 * PERMISSION IS GRANTED TO USE, COPY AND DISTRIBUTE THIS SOFTWARE FOR ANY 
 * PURPOSE EXCEPT FOR A BUSINESS OR COMMERCIAL PURPOSE, AND WITHOUT FEE, PROVIDED, 
 * THAT THE ABOVE COPYRIGHT NOTICE AND THIS STATEMENT APPEAR IN ALL COPIES.
 * I MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY OF THIS
 * SOFTWARE FOR ANY PURPOSE.  THIS SOFTWARE IS PROVIDED "AS IS."
 *
 */
#ifndef __PACKET32_H_
#define __PACKET32_H_

//copied from Ndis.h
//the following constants are to be used to direct
//the underlying NIC driver to choose which type of
//packet can be delivered to the upper bound driver,
//that is, our snoop driver.
#define NDIS_PACKET_TYPE_DIRECTED           0x0001
#define NDIS_PACKET_TYPE_MULTICAST          0x0002
#define NDIS_PACKET_TYPE_ALL_MULTICAST      0x0004
#define NDIS_PACKET_TYPE_BROADCAST          0x0008
#define NDIS_PACKET_TYPE_SOURCE_ROUTING     0x0010
#define NDIS_PACKET_TYPE_PROMISCUOUS        0x0020 //for snoop
#define NDIS_PACKET_TYPE_SMT                0x0040
#define NDIS_PACKET_TYPE_MAC_FRAME          0x8000
#define NDIS_PACKET_TYPE_FUNCTIONAL         0x4000
#define NDIS_PACKET_TYPE_ALL_FUNCTIONAL     0x2000
#define NDIS_PACKET_TYPE_GROUP              0x1000
//

#define        MAX_LINK_NAME_LENGTH   5

typedef struct tagADAPTER {
	HANDLE     hFile;
	TCHAR      szAdapterName[MAX_LINK_NAME_LENGTH];
	TCHAR      SymbolicLink[MAX_PATH];
} ADAPTER, *LPADAPTER;

typedef struct tagPACKET {
	HANDLE       hEvent;
	OVERLAPPED   OverLapped;
	PVOID        Buffer;
	UINT         Length;
} PACKET, *LPPACKET;

typedef struct tagADAPTER_DESC {
	TCHAR	szAdapterName[MAX_LINK_NAME_LENGTH];
	TCHAR	szAdapterDesc[MAX_PATH];
} ADAPTER_DESC, *LPADAPTER_DESC;


#ifdef __cplusplus
extern "C" {
#endif

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


BOOLEAN	 WINAPI
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

PVOID  WINAPI
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


VOID  WINAPI
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


VOID  WINAPI
PacketFreePacket(
	LPPACKET    lpPacket
	/*
	description:
		free the pre-allocated lpPacket
		This doesn't free the lpPacket's buffer.
	return:
	*/
);



BOOLEAN	 WINAPI
PacketResetAdapter(
	LPADAPTER  AdapterObject
	/*
	description:
		flush the adpater's receive queue
		clear any pending if it is.
	return:
	*/
);


BOOLEAN	 WINAPI
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


BOOLEAN	 WINAPI
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

BOOLEAN WINAPI
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

VOID WINAPI
PacketCloseAdapter(
	LPADAPTER   lpAdapter
	/*
	description:
		close the underlying adpater
	return:
	*/
	);

BOOLEAN WINAPI
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

ULONG  WINAPI
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

BOOLEAN WINAPI
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

#ifdef __cplusplus
}
#endif

#endif
