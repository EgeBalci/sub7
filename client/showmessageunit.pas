unit showmessageunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn,
  TFlatEditUnit;

type
  TGetTextForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    TitleLabel: TLabel;
    EditBox: TFlatEdit;
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
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure EditBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
    procedure GetText(_title,_caption,_default:String;masked:boolean;var r:string);
{    procedure Show}
  end;

var
  GetTextForm: TGetTextForm;
  Entered:Boolean;

implementation

uses AnimUnit, MainUnit;

{$R *.DFM}

procedure TGetTextForm.GetText;
begin
 CaptionLabel.Caption:=_title;
 TitleLabel.Caption:=_caption;
 EditBox.Text:=_default;
 if masked then EditBox.PasswordChar:='*' else
  EditBox.PasswordChar:=#0;
  Entered:=False;
 GetTextForm.ShowModal;
 r:='';
 if Entered then r:=EditBox.Text else r:='';
end;

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TGetTextForm.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with GetTextForm,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
{ if (Msg.Result = HTCLIENT) then
  with GetTextForm,msg do begin
  if (Merge(xpos,ypos ,Left         ,top+Corner        ,left+Offset       ,top+height-Corner)) then Result := htLeft;
  if (Merge(xpos,ypos ,Left+width-Offset ,top+Corner        ,left+width   ,top+height-Corner)) then Result := htRight;
  if (Merge(xpos,ypos ,Left+Corner       ,top          ,left+width-Corner ,top+Offset       )) then Result := htTop;
  if (Merge(xpos,ypos ,Left+Corner       ,top+height-Offset ,left+width-Corner ,top+height  )) then Result := htBottom;
  if (Merge(xpos,ypos ,Left,Top,Left+Corner,Top+Corner)) then Result:=htTopLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top,Left+Width,Top+Corner)) then Result:=htTopRight;
  if (Merge(xpos,ypos ,Left,Top+Height-Corner,Left+Corner,Top+Height)) then REsult:=htBottomLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top+Height-Corner,Left+Width,Top+Height)) then Result:=htBottomRight;
 end;}
end;

procedure TGetTextForm.SetTheColors;
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
 TitleLabel.Font.Color:=cFormText;
 with EditBox do begin
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 Invalidate;
end;

procedure TGetTextForm.FormCreate(Sender: TObject);
begin
 SetTheColors;
 Entered:=False;
 Caption:=CaptionLabel.Caption;
end;

procedure TGetTextForm.CloseButtonClick(Sender: TObject);
begin
 Entered:=False;
 Close;
end;

procedure TGetTextForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TGetTextForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TGetTextForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TGetTextForm.OutlookBtn1Click(Sender: TObject);
begin
 Entered:=True;
 close;
end;

procedure TGetTextForm.OutlookBtn2Click(Sender: TObject);
begin
 Entered:=False;
 close;
end;

procedure TGetTextForm.EditBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_Return then
  begin
   Entered:=True;
   close;
  end;
 if key=vk_Escape then
  begin
   Entered:=False;
   close;
  end;
end;

procedure TGetTextForm.EditBoxKeyPress(Sender: TObject; var Key: Char);
begin
if Key = Chr(VK_RETURN) then key:= #0;
end;

procedure TGetTextForm.FormPaint(Sender: TObject);
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

procedure TGetTextForm.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
