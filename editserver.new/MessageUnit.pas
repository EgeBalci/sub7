unit MessageUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn;

type
  TMsgForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Mesaj: TLabel;
    OutlookBtn1: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
    procedure DisplayMsg(msg:String);
    procedure MakeSplash;
    procedure MakeSplash2;
  end;

var
  MsgForm: TMsgForm;

implementation

uses EditUnit;

{$R *.DFM}

procedure TMsgForm.DisplayMsg;
var l:integer;
begin
 Mesaj.Caption:=msg;
 l:=Mesaj.Canvas.TextWidth(msg);
 if l<40 then Width:=80+l else Width:=55+l;
 Left:=((Screen.Width-Width) div 2);
 Top:=((Screen.Height-Height) div 2);
 ShowModal;
end;

procedure TMsgForm.MakeSplash;
var l:integer;
begin
 Mesaj.Caption:='connecting to e-mail server...';
 OutLookBtn1.Visible:=False;
 CloseButton.Visible:=False;
 Height:=60;
 l:=Mesaj.Canvas.TextWidth(Mesaj.Caption);
 if l<40 then Width:=80+l else Width:=55+l+70;
 Left:=((Screen.Width-Width) div 2);
 Top:=((Screen.Height-Height) div 2);
 Show;Update;
end;

procedure TMsgForm.MakeSplash2;
var l:integer;
begin
 Mesaj.Caption:='loading... hold on.';
 OutLookBtn1.Visible:=False;
 CloseButton.Visible:=False;
 Color:=clBlack;
 Height:=60;
 l:=Mesaj.Canvas.TextWidth(Mesaj.Caption);
 if l<40 then Width:=80+l else Width:=55+l;
 Left:=((Screen.Width-Width) div 2);
 Top:=((Screen.Height-Height) div 2);
 Show;Update;
end;

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TMsgForm.SetTheColors;
begin
 CaptionLabel.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 Mesaj.Font.Color:=cFormText;
 Mesaj.Color:=cFormCaption;
 with CloseButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
  try Glyph.Assign(EditForm.bit_close_btn);except end;
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end; 
 Invalidate;
end;

procedure TMsgForm.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TMsgForm.CloseButtonClick(Sender: TObject);
begin
 close;
end;

procedure TMsgForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TMsgForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TMsgForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TMsgForm.OutlookBtn1Click(Sender: TObject);
begin
 close;
end;

procedure TMsgForm.FormPaint(Sender: TObject);
var i:integer;
begin
try
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),EditForm.bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),EditForm.bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),EditForm.bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),EditForm.bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),EditForm.bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),EditForm.bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),EditForm.bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),EditForm.bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=EditForm.BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
 except end;
end;

procedure TMsgForm.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
