unit AnimUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit;

type
  TAnim = class(TForm)
    Timer1: TTimer;
    list: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
  public
    AnimationDone:Boolean;
    procedure Animeaza(t:TForm);
    procedure SetTheColors;
  end;

var
  Anim: TAnim;

implementation
  
uses MainUnit;


const delay=35;
var cx,cy,curx,cury,x,y:integer;
    _t:TForm;

{$R *.DFM}

procedure TAnim.Animeaza(t:TForm);
var x1,x2,y1,y2:integer;
    r:TRect;
    i:integer;
    fao:boolean;
begin
_t:=t;
if t.visible then begin t.show;exit;end;
if (not MainForm.FlatCheckBox12.Checked) then begin t.show;exit;end;
fao:=true;
for i:=0 to list.Lines.Count do
 if list.lines[i]=t.caption then fao:=false;
if (t.caption='offline logged keys') then fao:=true;
if t.tag<>0 then fao:=false; 
if (fao) then
 begin
  list.lines.add(t.caption);
  t.left:=((screen.width-t.width) div 2);
  t.top:=((screen.height-t.height) div 2);
 end;
x1:=t.left;
x2:=t.left+t.width;
y1:=t.top;
y2:=t.top+t.height;
with Anim do begin
 Height:=5;
 Width:=5;
 cx:=((x2-x1) div 2)+x1;
 cy:=((y2-y1) div 2)+y1;
 curx:=20;
 cury:=20;
 x:=x2-x1;
 y:=y2-y1;
 Anim.Show;
 AnimationDone:=False;
 Timer1.Enabled:=True;
end;
end;


procedure TAnim.SetTheColors;
begin
 Invalidate;
end;

procedure TAnim.FormCreate(Sender: TObject);
begin
 SetTheColors;
 Caption:='';
end;

procedure TAnim.Timer1Timer(Sender: TObject);
{var DC:HDC;}
begin
  if curx<(x) then inc(curx,delay) else curx:=(x);
  if cury<(y) then inc(cury,delay) else cury:=(y);
  if curx>=x then curx:=x;
  if cury>=y then cury:=y;
  Left:=cx-(curx div 2);
  Top :=cy-(cury div 2);
  Width:=curx;
  Height:=cury;
{  DC:=GetDC(GetDesktopWindow);
  DC.}
 if (curx>=(x)) and (cury>=(y)) then
  begin
   Timer1.Enabled:=False;
   _t.Show;
   Anim.Hide;
   AnimationDone:=True;
  end; 
end;

procedure TAnim.FormPaint(Sender: TObject);
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

procedure TAnim.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
