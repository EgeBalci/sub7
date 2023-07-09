unit ICQAPICalls;

interface

{$IFNDEF __ICQAPICALLS_H_}
{$DEFINE __ICQAPICALLS_H_}

uses Windows, ICQAPIData;

function ICQAPICall_SetLicenseKey( pszName: PChar;
                                   pszPassword: PChar;
                                   pszLicense: PChar): BOOL; stdcall;

function ICQAPICall_GetVersion( var iVersion: integer): BOOL; stdcall;

function ICQAPICall_GetDockingState( var iDockingState: integer): BOOL; stdcall;

function ICQAPICall_GetFirewallSettings( var oFireWallData: TBSICQAPI_FireWallData ): BOOL; stdcall;

function ICQAPICall_GetFullOwnerData( var ppUser: PBPSICQAPI_User;
                                      iVersion: integer ): BOOL; stdcall;

function ICQAPICall_GetFullUserData( pUser: PBPSICQAPI_User;
                                     iVersion: integer ): BOOL; stdcall;

function ICQAPICall_GetOnlineListDetails( var iCount: integer;
                                          var ppUsers: array of PBPSICQAPI_User): BOOL; stdcall;

function ICQAPICall_GetOnlineListHandle( var hWindow: HWND): BOOL; stdcall;

function ICQAPICall_GetOnlineListPlacement( var iIsShowOnlineList: integer): BOOL; stdcall;

function ICQAPICall_GetWindowHandle( var hWindow: HWND): BOOL; stdcall;

function ICQAPICall_RegisterNotify( iVersion: integer;
                                    iCount: integer;
                                    piEvents: PByte): BOOL; stdcall;

function ICQAPICall_UnRegisterNotify: BOOL; stdcall;

function ICQAPICall_SendFile( iPIN: integer;
                              pszFileNames: PChar): BOOL; stdcall;

function ICQAPICall_SendMessage( iUIN: integer;
                              pszMessage: PChar): BOOL; stdcall;

function ICQAPICall_SendURL( iUIN: integer;
                              pszMessage: PChar): BOOL; stdcall;


// Version 1.0001

function ICQAPICall_GetOnlineListType( var iListType: integer): BOOL; stdcall;

{type
  PPBPSICQAPI = ^PBPSICQAPI;}

{function ICQAPICall_GetGroupOnlineListDetails( var iGroupCount: integer;
                                               var ppGroups: PPBPSICQAPI): BOOL;
                                               stdcall;
 }
type
  PPointer = ^Pointer;

function ICQAPICall_Generic( iCode: integer;
                             pInBuffer: Pointer;
                             iInSize: integer;
                             ppOutBuffer: PPointer;
                             var iOutSize: integer): BOOL; stdcall;

const
  ICQMsgAPI = 'ICQMAPI.dll';

implementation

function ICQAPICall_SetLicenseKey( pszName: PChar;
                                   pszPassword: PChar;
                                   pszLicense: PChar):bool;
  external ICQMsgAPI name 'ICQAPICall_SetLicenseKey';

function ICQAPICall_GetVersion( var iVersion: integer):bool;
  external ICQMsgAPI name 'ICQAPICall_GetVersion';

function ICQAPICall_GetDockingState( var iDockingState: integer):bool;
  external ICQMsgAPI name 'ICQAPICall_GetDockingState';

function ICQAPICall_GetFirewallSettings( var oFireWallData: TBSICQAPI_FireWallData ):bool;
  external ICQMsgAPI name 'ICQAPICall_GetFirewallSettings';

function ICQAPICall_GetFullOwnerData( var ppUser: PBPSICQAPI_User;
                                      iVersion: integer ):bool;
  external ICQMsgAPI name 'ICQAPICall_GetFullOwnerData';

function ICQAPICall_GetFullUserData( pUser: PBPSICQAPI_User;
                                     iVersion: integer ):bool;
  external ICQMsgAPI name 'ICQAPICall_GetFullUserData';

function ICQAPICall_GetOnlineListDetails( var iCount: integer;
                                          var ppUsers:array of PBPSICQAPI_User):bool;
  external ICQMsgAPI name 'ICQAPICall_GetOnlineListDetails';

function ICQAPICall_GetOnlineListHandle( var hWindow: HWND):bool;
  external ICQMsgAPI name 'ICQAPICall_GetOnlineListHandle';

function ICQAPICall_GetOnlineListPlacement( var iIsShowOnlineList: integer):bool;
  external ICQMsgAPI name 'ICQAPICall_GetOnlineListPlacement';

function ICQAPICall_GetWindowHandle( var hWindow: HWND):bool;
  external ICQMsgAPI name 'ICQAPICall_GetWindowHandle';

function ICQAPICall_RegisterNotify( iVersion: integer;
                                    iCount: integer;
                                    piEvents: PByte):bool;
  external ICQMsgAPI name 'ICQAPICall_RegisterNotify';

function ICQAPICall_UnRegisterNotify;
  external ICQMsgAPI name 'ICQAPICall_UnRegisterNotify';

function ICQAPICall_SendFile( iPIN: integer;
                              pszFileNames: PChar):bool;
  external ICQMsgAPI name 'ICQAPICall_SendFile';

function ICQAPICall_SendMessage( iUIN: integer;
                              pszMessage: PChar):bool;
  external ICQMsgAPI name 'ICQAPICall_SendMessage';

function ICQAPICall_SendURL( iUIN: integer;
                              pszMessage: PChar):bool;
  external ICQMsgAPI name 'ICQAPICall_SendURL';
// Version 1.0001

function ICQAPICall_GetOnlineListType( var iListType: integer):bool;
  external ICQMsgAPI name 'ICQAPICall_GetOnlineListType';

{function ICQAPICall_GetGroupOnlineListDetails( var iGroupCount: integer;
                                               var ppGroups: PPBPSICQAPI);
  external ICQMsgAPI name 'ICQAPICall_GetGroupOnlineListDetails';}

function ICQAPICall_Generic( iCode: integer;
                             pInBuffer: Pointer;
                             iInSize: integer;
                             ppOutBuffer: PPointer;
                             var iOutSize: integer):bool;
  external ICQMsgAPI name 'ICQAPICall_Generic';
{$ENDIF}	// __ICQAPICALLS_H_
end.
