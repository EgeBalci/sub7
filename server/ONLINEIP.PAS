{*************************************************************}
{            TOnlineIP Component for Delphi 32                }
{ Version:   1.0                                              }
{ Author:    Aleksey Kuznetsov, Kiev, Ukraine                 }
{            Алексей Кузнецов (Xacker), Киев, Украина         }
{ E-Mail:    xacker@phreaker.net                              }
{ Home Page: xacker.phiberoptix.com                           }
{ Created:   April, 9, 1999                                   }
{ Modified:  April, 9, 1999                                   }
{ Legal:     Copyright (c) 1999 by Aleksey Xacker             }
{*************************************************************}
{ This component determines online status of the computer     }
{ and returns current IP address                              }
{*************************************************************}
{ PROPERTIES:                                                 }
{   IP: String - Current IP address of local machine          }
{   Online: Boolean - Online status of local machine          }
{   DispatchInterval - Determines in milliseconds the         }
{                      intervals of time between testing      }
{                      online of a mode of computer           }
{   Enabled: Boolean - As usual... =)                         }
{ EVENTS:                                                     }
{   OnChanged - causes if online status changed.              }
{*************************************************************}
{ Please see demo program for more information.               }
{*************************************************************}
{                     IMPORTANT NOTE:                         }
{ This software is provided 'as-is', without any express or   }
{ implied warranty. In no event will the author be held       }
{ liable for any damages arising from the use of this         }
{ software.                                                   }
{ Permission is granted to anyone to use this software for    }
{ any purpose, including commercial applications, and to      }
{ alter it and redistribute it freely, subject to the         }
{ following restrictions:                                     }
{ 1. The origin of this software must not be misrepresented,  }
{    you must not claim that you wrote the original software. }
{    If you use this software in a product, an acknowledgment }
{    in the product documentation would be appreciated but is }
{    not required.                                            }
{ 2. Altered source versions must be plainly marked as such,  }
{    and must not be misrepresented as being the original     }
{    software.                                                }
{ 3. This notice may not be removed or altered from any       }
{    source distribution.                                     }
{*************************************************************}
unit OnlineIP;

interface

uses
  Windows, Messages, Winsock, Classes, Forms;

type
  TOnlineIP = class(TComponent)
  private
    FEnabled: Boolean;
    FDispatchInterval: Cardinal;
    FWindowHandle: hWnd;
    FOnline: Boolean;
    FIP: String;
    FOnChanged: TNotifyEvent;

    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure SetDispatchInterval(Value: Cardinal);
    procedure SetNoneBool(Value: Boolean);
    procedure SetNoneStr(Value: String);
    procedure WndProc(var Msg: TMessage);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property DispatchInterval: Cardinal read FDispatchInterval write SetDispatchInterval;
    property Online: Boolean read FOnline write SetNoneBool;
    property IP: String read FIP write SetNoneStr;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

procedure Register;

implementation

function LocalIP: String;
type
  TaPInAddr = Array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: Array[0..63] of Char;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I := 0;
  while pPtr^[I] <> nil do
   begin
    Result := inet_ntoa(pptr^[I]^);
    Inc(I);
   end;
  WSACleanup;
end;

constructor TOnlineIP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FDispatchInterval := 1000;
  FWindowHandle := AllocateHWnd(WndProc);
  UpdateTimer;
end;

destructor TOnlineIP.Destroy;
begin
  FEnabled := False;
  UpdateTimer;
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TOnlineIP.WndProc(var Msg: TMessage);
var
  OldState: Boolean;
begin
  with Msg do
   if Msg = wm_Timer then
    try
     FIP := LocalIP;
     OldState := FOnline;
     FOnline := FIP <> '';
     if (not OldState and FOnline) or
        (OldState and not FOnline) then
      if Assigned(FOnChanged) then FOnChanged(Self);
    except
     Application.HandleException(Self);
    end
   else
    Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TOnlineIP.UpdateTimer;
begin
  KillTimer(FWindowHandle, 1);
  if (FDispatchInterval <> 0) and FEnabled then
   SetTimer(FWindowHandle, 1, FDispatchInterval, nil);
end;

procedure TOnlineIP.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
   begin
    FEnabled := Value;
    UpdateTimer;
   end;
end;

procedure TOnlineIP.SetDispatchInterval(Value: Cardinal);
begin
  if Value <> FDispatchInterval then
   begin
    FDispatchInterval := Value;
    UpdateTimer;
   end;
end;

procedure TOnlineIP.SetNoneBool(Value: Boolean); begin {} end;

procedure TOnlineIP.SetNoneStr(Value: String); begin {} end;

procedure Register;
begin
  RegisterComponents('Xacker', [TOnlineIP]);
end;

end.
