unit IRCBotUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, TFlatEditUnit, OutlookBtn;

type
  TIrcBotForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Label1: TLabel;
    ircbot1: TFlatEdit;
    ircbot4: TFlatEdit;
    ircbot6: TFlatEdit;
    Label3: TLabel;
    ircbot7: TFlatEdit;
    ircbot5: TFlatEdit;
    ircbot2: TFlatEdit;
    OutlookBtn1: TOutlookBtn;
    ircbot3: TFlatEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    procedure FormShow(Sender: TObject);
  private
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  IrcBotForm: TIrcBotForm;

implementation

uses EditUnit;

{$R *.DFM}

var KeepX,KeepY:Integer;

procedure TIrcBotForm.SetTheColors;
begin
// myShape.Brush.Color:=cFormBackground;
// myShape.Pen.Color:=cFormLine;
 CaptionLabel.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 with ircbot1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot3 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot4 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot5 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot6 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ircbot7 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 Label1.Font.Color:=cFormText;Label2.Font.Color:=cFormText;
 Label3.Font.Color:=cFormText;Label4.Font.Color:=cFormText;
 Label5.Font.Color:=cFormText;Label6.Font.Color:=cFormText;
 Label7.Font.Color:=cFormText;Label8.Font.Color:=cFormText;
 with CloseButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
  Glyph.Assign(EditForm.bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
 Invalidate;
end;

procedure TIrcBotForm.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TIrcBotForm.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TIrcBotForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TIrcBotForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TIrcBotForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TIrcBotForm.OutlookBtn1Click(Sender: TObject);
begin
 close;
end;

procedure TIrcBotForm.FormPaint(Sender: TObject);
var i:integer;
begin
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
end;

procedure TIrcBotForm.FormShow(Sender: TObject);
begin
 Invalidate;
end;

end.
