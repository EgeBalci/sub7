unit PassUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, TFlatHintUnit,
  RXSplit;

type
  TPass = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    FlatHint: TFlatHint;
    Panel1: TPanel;
    Name: TListBox;
    box: TMemo;
    RxSplitter1: TRxSplitter;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NameClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
    procedure UpdatePasses;
  end;

var
  Pass: TPass;

implementation

uses Unit1, MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TPass.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with Pass,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with Pass,msg do begin
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

procedure TPass.SetTheColors;
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
 with FlatHint do begin
  ColorArrow:=cFormText;ColorArrowBackground:=cFormCaption;ColorBackground:=cFormBackground;ColorBorder:=cFormLine;Font.Color:=cFormText;end;
 Name.Color:=cFormForeGround;
 Name.Font.Color:=cFormText;
 Box.Color:=cFormForeGround;
 Box.Font.Color:=cFormText;
 Panel1.Color:=cFormBackground;
 Label1.Font.Color:=cFormText;
 Label2.Font.Color:=cFormText;
 RxSplitter1.Color:=cFormCaption;
{ Spliter.BorderColor:=cFormForeGround;
 Spliter.Color:=cFormCaption;
 Spliter.FocusedColor:=cFormText;}
 Invalidate;
end;

procedure TPass.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TPass.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TPass.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TPass.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TPass.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure Tpass.UpdatePasses;
var s,namestr,boxstr:string;
    la,i,a:integer;
    exista:boolean;
    FileName:String;
    f:textfile;
begin
 la:=0;
 name.items.clear;
 box.lines.clear;
 FileName:=MainForm.DownloadFolder+'temp.dat';
 {ShowMessage(FileName);}
assignfile(f,FileName);reset(f);
repeat
  readln(f,s);
{  showmessage(s);
  box.Lines.add(s);}
  for i:=1 to length(s) do
   if (copy(s,i,3)='___') then la:=i-1;
  namestr:=copy(s,1,la);
  boxstr:=copy(s,la+4,length(s));
  exista:=false;
  for a:=0 to name.items.count-1 do
   if name.items.strings[a]=namestr then exista:=true;
  if not exista then name.items.add(namestr);
until eof(f);
 closefile(f);
end;

procedure TPass.NameClick(Sender: TObject);
var s,namestr,boxstr:string;
    la,i:integer;
    exista:boolean;
    FileName:String;
    f:textfile;
    curline:String;
begin
box.clear;
la:=0;
FileName:=MainForm.DownloadFolder+'temp.dat';
curline:=name.items.strings[name.itemindex];
{showmessage(curline);    }
assignfile(f,FileName);reset(f);
repeat
  readln(f,s);
{  showmessage(s);
  box.Items.add(s);}
  for i:=1 to length(s) do
   if (copy(s,i,3)='___') then la:=i-1;
  namestr:=copy(s,1,la);
  boxstr:=copy(s,la+4,length(s));
{  showmessage(curline+'='+namestr+'!'+boxstr);}
  exista:=false;
  if namestr=curline then exista:=true;
  if exista then box.lines.add(boxstr);
until eof(f);
 closefile(f);
end;

procedure TPass.FormPaint(Sender: TObject);
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

procedure TPass.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
