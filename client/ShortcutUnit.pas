unit ShortcutUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn;

type
  TShortcutForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    OutlookBtn4: TOutlookBtn;
    OutlookBtn5: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  ShortcutForm: TShortcutForm;

implementation

uses MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;

procedure TShortcutForm.SetTheColors;
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
 with ListBox1 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with ListBox2 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 Label1.Font.Color:=cFormText;Label2.Font.Color:=cFormText;
 Invalidate;
end;

procedure TShortcutForm.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TShortcutForm.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TShortcutForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TShortcutForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TShortcutForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TShortcutForm.FormShow(Sender: TObject);
var i,c,a:integer;
begin
 ListBox2.Items.Clear;
 try c:=StrToInt(MainForm.ReadKey('pu_count'));except exit;end;
 for i:=1 to c do
  ListBox2.Items.Add(MainForm.ReadKey('pu_'+IntToStr(i)));
 for i:=1 to c do
  for a:=0 to ListBox1.Items.Count do
   if (ListBox2.Items[i-1]=ListBox1.Items[a]) then ListBox1.Items.Delete(a);
end;

procedure TShortcutForm.OutlookBtn1Click(Sender: TObject);
begin
 if ListBox2.Items.Count>10 then
  begin
   MainForm.ShowMsg('you''re only allowed to add 11 shortcuts. remove some shortcuts and then try again');
   exit;
  end;
 ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
 ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TShortcutForm.OutlookBtn3Click(Sender: TObject);
var i,c:integer;
begin
 c:=ListBox2.Items.Count;
 MainForm.WriteKey('pu_count',IntToStr(c));
 for i:=1 to c do
  MainForm.WriteKey('pu_'+IntToStr(i),ListBox2.Items[i-1]);
 ShortcutForm.Hide;
end;

procedure TShortcutForm.OutlookBtn2Click(Sender: TObject);
begin
 if ListBox2.Items.Count=0 then exit;
 ListBox1.Items.Add(ListBox2.Items[ListBox2.ItemIndex]);
 ListBox2.Items.Delete(ListBox2.ItemIndex);
end;

procedure TShortcutForm.OutlookBtn4Click(Sender: TObject);
var i:integer;
    tine1,tine2:string;
begin
 if ListBox2.Items.Count=0 then exit;
 i:=ListBox2.ItemIndex;
 if i=0 then exit;
 tine1:=ListBox2.Items[i];
 tine2:=ListBox2.Items[i-1];
 ListBox2.Items[i]:=tine2;
 ListBox2.Items[i-1]:=tine1;
end;

procedure TShortcutForm.OutlookBtn5Click(Sender: TObject);
var i:integer;
    tine1,tine2:string;
begin
 if ListBox2.Items.Count=0 then exit;
 i:=ListBox2.ItemIndex;
 if i=ListBox2.Items.Count-1 then exit;
 tine1:=ListBox2.Items[i];
 tine2:=ListBox2.Items[i+1];
 ListBox2.Items[i]:=tine2;
 ListBox2.Items[i+1]:=tine1;
end;

procedure TShortcutForm.FormPaint(Sender: TObject);
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

procedure TShortcutForm.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
