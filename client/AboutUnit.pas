unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, WavePlay, OutlookBtn, ShellApi,
  Psock, NMHttp;

type
  TAbout = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Panel1: TPanel;
    buf: TImage;
    temp: TImage;
    Timer1: TTimer;
    PlayerWave1: TPlayerWave;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    bufMemo: TMemo;
    Label1: TLabel;
    NMHTTP1: TNMHTTP;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bufMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure bufMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure InitScreen;
    procedure PaintLetter(xxx, yyy: integer; letter: string);
    procedure PaintRow(y: integer; rowstr: string);
    procedure Delay(msecs: integer);
    procedure StartPainting;
    procedure ClearPage;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
    procedure GET_MOTD(care:integer);
  end;

type _Link=record
      Lx,Ly:Integer;
      L,H:Integer;
      Text:string;
     end;
const Plus=20;
      LinkColor=$00FF8080;
      CloseIT:bool=false;
      ExitOnclick:bool=false;
      ColorOne=clWhite;
      ColorTwo=$00CE6700;
var
    About: TAbout;
    Link:array[1..5] of _Link;
    LinkCount:Integer;
    Linked:array[1..5] of boolean;
    ResPtr: Pointer;
    FindHandle, ResHandle: THandle;

implementation

uses Unit1, MainUnit;

{$R *.DFM}

procedure TAbout.SetTheColors;
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
 Color:=cFormBackground;
 Label1.Font.Color:=cFormText;
 bufMemo.Color:=cFormForeGround;
 bufMemo.Font.Color:=cFormText;
 Invalidate; 
end;

procedure TAbout.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TAbout.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TAbout.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TAbout.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TAbout.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TAbout.FormShow(Sender: TObject);
begin
 ExitOnClick:=False;
 Timer1.Enabled:=True;
 CloseIT:=False;
 Label1.Visible:=False;
 bufMemo.Visible:=False;
 InitScreen;
end;

procedure TAbout.InitScreen;
begin
 with buf.canvas do begin
  Brush.Color:=clBlack;
  Brush.Style:=bsSolid;
  Pen.Color:=clBlack;
  Font.Color:=clWhite;
  Font.Name:='Courier New';
  Font.Size:=11;
{  Font.Style:=[fsBold];}
  FillRect(Bounds(0,0,buf.Width,buf.Height));
 end;
end;

procedure TAbout.Delay(msecs:integer);
var
   FirstTickCount:longint;
begin
 if CloseIT then Exit;
     FirstTickCount:=GetTickCount;
     repeat
           Application.ProcessMessages; {allowing access to other
                                         controls, etc.}
     until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;


procedure TAbout.PaintLetter(xxx,yyy:integer;letter:string);
begin
 Application.ProcessMessages;
 if letter<>' ' then try PlayerWave1.Play;except end;
{ SndPlaySound(PChar('ptsub7.wav'),Snd_Sync);}
 buf.canvas.font.color:=ColorOne;
 buf.canvas.TextOut(xxx,yyy,letter);
 buf.canvas.font.color:=ColorTwo;
 buf.canvas.TextOut(xxx+buf.Canvas.TextWidth(letter)+4,yyy,'_');
 Application.ProcessMessages;
 delay(30);
 Application.ProcessMessages;
 buf.canvas.font.color:=ColorTwo;
 buf.canvas.TextOut(xxx,yyy,letter);
 Application.ProcessMessages;
 delay(15);
 Application.ProcessMessages;
 buf.canvas.font.color:=clBlack;
 buf.canvas.TextOut(xxx+buf.Canvas.TextWidth(letter)+4,yyy,'_');
 Application.ProcessMessages;
end;

procedure TAbout.PaintRow(y:integer;rowstr:string);
var xx,l,i:integer;
begin
 l:=buf.canvas.TextWidth(rowstr);
 xx:=(buf.width-l) div 2;
 buf.canvas.font.color:=ColorTwo;
 buf.canvas.TextOut(xx,y,'_');
 Delay(50);
 buf.canvas.font.color:=clBlack;
 buf.canvas.TextOut(xx,y,'_');
 for i:=1 to length(rowstr) do
  begin
   if CloseIT then Exit;
   Application.ProcessMessages;
   PaintLetter(xx,y,rowstr[i]);
   Inc(xx,buf.canvas.TextWidth(rowstr[i]));
  end;
 if (copy(rowstr,1,4)='http') then
  begin
   inc(LinkCount);
   Link[LinkCount].Text:=rowstr;
   Link[LinkCount].Lx:=(buf.width-l) div 2;
   Link[LinkCount].Ly:=y;
   Link[LinkCount].L:=buf.canvas.textwidth(rowstr);
   Link[LinkCount].H:=buf.canvas.textheight(rowstr);
   buf.canvas.font.color:=LinkColor;
   buf.canvas.TextOut(Link[LinkCount].Lx,Link[LinkCount].Ly,Link[LinkCount].Text);
   buf.canvas.font.color:=ColorTwo;
  end;
 if (copy(rowstr,1,5)='[http') then
  begin
   inc(LinkCount);
   Link[LinkCount].Text:=copy(rowstr,2,length(rowstr)-2);
   Link[LinkCount].Lx:=(buf.width-l) div 2+buf.canvas.TextWidth('[');
   Link[LinkCount].Ly:=y;
   Link[LinkCount].L:=buf.canvas.textwidth(rowstr)-buf.canvas.textwidth(']');
   Link[LinkCount].H:=buf.canvas.textheight(rowstr);
   buf.canvas.font.color:=LinkColor;
   buf.canvas.TextOut(Link[LinkCount].Lx,Link[LinkCount].Ly,Link[LinkCount].Text);
   buf.canvas.font.color:=ColorTwo;
  end;
 buf.canvas.font.color:=clBlack;
 buf.canvas.TextOut(xx,y,'_');buf.canvas.TextOut(xx+5,y,'_');
 Delay(250);
end;

procedure TAbout.ClearPage;
var i:integer;
begin
 delay(2000);
 for i:=1 to 5 do Linked[i]:=False;LinkCount:=0;
 temp.picture.Assign(buf.picture);
 i:=0;
 repeat
  buf.Canvas.draw(0,i,temp.picture.bitmap);
  dec(i,10);
  delay(40);
 until i+buf.height<0;
 {for i:=0 to buf.width do begin buf.Canvas.MoveTo(i,0);buf.Canvas.LineTo(i,buf.Height);delay(2);end;}
end;

procedure TAbout.StartPainting;
var at:integer;
begin
 LinkCount:=0;at:=25;
 PaintRow(at,'SubSeven version 2.1 M.U.I.E.');inc(at,plus);
 PaintRow(at,'coded by mobman');inc(at,plus);
 PaintRow(at,'[http://subseven.slak.org]');inc(at,plus+(plus div 2));
 PaintRow(at,'MUIE: special dedication for all');inc(at,plus);
 PaintRow(at,'sub7 enemies. to every piece of shit');inc(at,plus);
 PaintRow(at,'that ever made a FAKE sub7 site and');inc(at,plus);
 PaintRow(at,'to all kiddies/avs that ever said ONE');inc(at,plus);
 PaintRow(at,'bad word about sub7.');inc(at,plus);
 PaintRow(at,'this one''s for you.');inc(at,plus);
 ClearPage;
 at:=25;
 PaintRow(at,'- Sub7Crew Members -');inc(at,plus);
 PaintRow(at,'CorpseGrindeR, HeLLfiReZ, The Lamer,');inc(at,plus);
 PaintRow(at,'Mr.Q, Ganja51, Reverser, ReVeNGer,');inc(at,plus);
 PaintRow(at,'swamp rat, happyhackr, fc, Rvlation,');inc(at,plus);
 PaintRow(at,'cryptic k, MisterQ, NewPortWiz, Axel,');inc(at,plus);
 PaintRow(at,'Lord Midnight, Entropy.');inc(at,plus*2);
 PaintRow(at,'- Sub7 testers -');inc(at,plus);
 PaintRow(at,'Sub7Crew members');inc(at,plus);
 ClearPage;
 at:=25;
 PaintRow(at,'- greets to: -');inc(at,plus);
 PaintRow(at,'TaUnE, S_A_R_G_E, Oae,');inc(at,plus);
 PaintRow(at,'Int_13h, Blade, ^Cold^, Danutz.');inc(at,plus*2);
 PaintRow(at,'- greets also to: -');inc(at,plus);
 PaintRow(at,'VladyLama, ThinIce, ÆX, A_x_L,');inc(at,plus);
 PaintRow(at,'Dell, Elena, Kati, ¥±RoAd RuNnEr±¥,');inc(at,plus);
 PaintRow(at,'surej, Bug-Zero, Sub Cool, #Hook#,');inc(at,plus);
 PaintRow(at,'destruct, Betrayed, DeathWalker.');inc(at,plus);
 ClearPage;
 at:=20;
 PaintRow(at,'the sub7crew welcomes');inc(at,plus);
 PaintRow(at,'happyhackr and ReVeNGer');inc(at,plus);
 PaintRow(at,'to the crew.');inc(at,plus*2);
 PaintRow(at,'there is only _one_ official');inc(at,plus);
 PaintRow(at,'SubSeven webpage:');inc(at,plus);
 PaintRow(at,'http://subseven.slak.org');inc(at,plus);
 PaintRow(at,'visit also:');inc(at,plus);
 PaintRow(at,'http://netsnooper.real-security.org');inc(at,plus);
 PaintRow(at,'security/hacking and everything else');inc(at,plus);
 Delay(2000);
 ClearPage;
 at:=20;
 PaintRow(at,'BEWARE pokemon fans who promise too');inc(at,plus);
 PaintRow(at,'much and then piss their pants');inc(at,plus);
 PaintRow(at,'because they can''t make deadlines.');inc(at,plus);
 PaintRow(at,'..and AntiViruses who give you CRAP!');inc(at,plus*2);
 PaintRow(at,'signed: NOT one of the "mobman"');inc(at,plus);
 PaintRow(at,'posers, the one and only,');inc(at,plus*2);
 PaintRow(at,'           mobman');inc(at,plus*2);
 PaintRow(at,'(click to exit)');ExitOnclick:=True;
end;


procedure TAbout.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=False;
 StartPainting;
end;

procedure TAbout.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CloseIT:=True;
end;

procedure TAbout.bufMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var loop,ThisTime:integer;
begin
 if (LinkCount=0) and (Cursor<>crDefault) then Cursor:=crDefault;
 if (LinkCount=0) then exit;
 ThisTime:=0;
 for loop:=1 to LinkCount do with Link[loop] do
  if (X>Lx) and (X<Lx+L) and (Y>Ly) and (Y<Ly+H) then
   begin
    buf.canvas.font.color:=clWhite;
    buf.canvas.font.style:=[fsUnderline];
    buf.canvas.TextOut(Lx,Ly,Text);
    buf.canvas.font.style:=[];
    Cursor:=crHandPoint;
    Linked[loop]:=True;
    ThisTime:=loop;
   end;
 if ThisTime=0 then Cursor:=crDefault;
 for loop:=1 to LinkCount do
  if (Linked[loop]) and (loop<>ThisTime) then with Link[loop] do
   begin
    buf.canvas.font.color:=clBlack;
    buf.canvas.font.style:=[fsUnderline];
    buf.canvas.TextOut(Lx,Ly,Text);
    buf.canvas.font.color:=LinkColor;
    buf.canvas.font.style:=[];
    buf.canvas.TextOut(Lx,Ly,Text);
    Linked[loop]:=False;
   end;
end;

procedure TAbout.bufMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var loop:integer;
begin
 if ExitOnClick then Close;
 for loop:=1 to LinkCount do with Link[loop] do
  if (X>Lx) and (X<Lx+L) and (Y>Ly) and (Y<Ly+H) then
   begin
    ShellExecute(0,PChar('open'),PChar(Text),'','',SW_SHOW);
   end;
end;

procedure TAbout.FormHide(Sender: TObject);
begin
 CloseIT:=True;
 Label1.Visible:=False;
 bufMemo.Visible:=False;
end;

procedure TAbout.OutlookBtn3Click(Sender: TObject);
begin
 CloseIT:=True;
 Hide;
end;

procedure TAbout.GET_MOTD(care:integer);
var AllThatBigString:String;
    NMHTTP1: TNMHTTP;
    ERROR:bool;
begin
  if care=1 then begin
   CloseIT:=True;delay(250);InitScreen;bufMemo.Visible:=False;Label1.Visible:=True;delay(250);
  end else MainForm.Status.Caption:='reading news...';
  AllThatBigString:='http://subseven.slak.org/NEWS21GOLD.SSF';
  NMHTTP1 := TNMHTTP.Create(Self);
  NMHTTP1.InputFileMode := FALSE;
  NMHTTP1.OutputFileMode := FALSE;
  NMHTTP1.ReportLevel := Status_None;
  bufMemo.Clear;
  ERROR:=False;
 try
  NMHTTP1.Get(AllThatBigString);
 except
  ERROR:=TRUE;
 end;
  if not ERROR then
   begin
    case care of
     1:bufMemo.Text := NMHTTP1.Body;
     2:begin MainForm.InfoMemo.Text := NMHTTP1.Body;MainForm.InfoMemo.ScrollBars:=ssVertical;MainForm.Status.Caption:='news retrieved.';end;
    end;
   end
   else begin
    bufMemo.Lines.Add('');bufMemo.Lines.Add('');bufMemo.Lines.Add('error retrieveing news.');
    MainForm.InfoMemo.Lines.Assign(bufMemo.Lines);
   end;
 if care=1 then begin
  Label1.Visible:=False;
  bufMemo.Visible:=True;
 end;
 NMHTTP1.Free;
 if care=2 then MainForm._Pagini.ActivePage:=mainform.pFirst;
end;


procedure TAbout.OutlookBtn2Click(Sender: TObject);
begin
 GET_MOTD(1);
end;

procedure TAbout.FormPaint(Sender: TObject);
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

procedure TAbout.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
