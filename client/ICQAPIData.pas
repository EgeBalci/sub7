unit ICQAPIData;

interface

{$IFNDEF __ICQAPIDATA_H_}
{$DEFINE __ICQAPIDATA_H_}

uses Windows;

type

  TBSICQAPI_FireWallData = record
	  m_bEnabled     : Byte;
	  m_bSocksEnabled: Byte;
	  m_sSocksVersion: SmallInt;
	  m_szSocksHost  : array[0..511]of char;
	  m_iSocksPort   : integer;
	  m_bSocksAuthenticationMethod: Byte;
  end;
  PBPSICQAPI_User = ^TBSICQAPI_User;
  TBSICQAPI_User = record
	  m_iUIN         : integer;
	  m_hFloatWindow : HWND;
	  m_iIP          : integer;
	  m_szNickname   : array[0..19]of char;
	  m_szFirstName  : array[0..19]of char;
	  m_szLastName   : array[0..19]of char;
	  m_szEmail      : array[0..99]of char;
	  m_szCity       : array[0..99]of char;
	  m_szState      : array[0..99]of char;
	  m_iCountry     : integer;
	  m_szCountryName: array[0..99]of char;
	  m_szHomePage   : array[0..99]of char;
	  m_iAge         : integer;
	  m_szPhone      : array[0..19]of char;
	  m_bGender      : Byte;
	  m_iHomeZip     : integer;
	  // Version 1.0001
	  m_iStateFlags  : integer;
  end;

  PBPSICQAPI_Group = ^TBSICQAPI_Group;
	TBSICQAPI_Group = record
    m_szName    : array[0..49]of char;
	  m_iUserCount: integer;
    m_ppUsers   : PBPSICQAPI_User;
  end;


procedure ICQAPIUtil_FreeUser(pUser: pBPSICQAPI_User); stdcall;
procedure ICQAPIUtil_FreeGroup(pGroup: PBPSICQAPI_Group); stdcall;

const
  ICQMsgAPI = 'ICQMAPI.dll';

implementation

procedure ICQAPIUtil_FreeUser(pUser: pBPSICQAPI_User);
  external ICQMsgAPI name 'ICQAPIUtil_FreeUser';
procedure ICQAPIUtil_FreeGroup(pGroup: PBPSICQAPI_Group);
  external ICQMsgAPI name 'ICQAPIUtil_FreeGroup';
 
{$ENDIF}	// __ICQAPIDATA_H_
end.
