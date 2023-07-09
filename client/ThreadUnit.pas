unit ThreadUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn, TFlatComboBoxUnit;

type
  TDlg = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    cbClass: TFlatComboBox;
    Label1: TLabel;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn2: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
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
  Dlg: TDlg;

implementation

uses Unit1, MainUnit, procUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TDlg.WMNCHitText(var Msg:TWMNCHitTest);
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

procedure TDlg.SetTheColors;
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
 Label1.Font.Color:=cFormText;
 Label1.Color:=cFormBackground;
 with cbClass do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;
  ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;
 Invalidate;
end;

procedure TDlg.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TDlg.CloseButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDlg.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TDlg.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TDlg.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TDlg.OutlookBtn2Click(Sender: TObject);
begin
 close;
end;

procedure TDlg.OutlookBtn1Click(Sender: TObject);
begin
 MainForm.SendCommand('CTP'+IntToStr(cbClass.ItemIndex)+IntToStr(ProcM.CurNum),'changing thread priority...','2.1');
 Close;
end;

procedure TDlg.FormPaint(Sender: TObject);
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

procedure TDlg.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
