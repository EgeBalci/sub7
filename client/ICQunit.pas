unit ICQunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn,
  TFlatMemoUnit, TB97Ctls, ScktComp, ImgList;

type
  TICQForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Label1: TLabel;
    Shape1: TShape;
    Simbol: TToolbarButton97;
    Shape2: TShape;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Shape3: TShape;
    Label7: TLabel;
    Button1: TOutlookBtn;
    Button2: TOutlookBtn;
    Button3: TOutlookBtn;
    ImageList1: TImageList;
    hBox: TMemo;
    Memo1: TMemo;
    OutlookBtn1: TOutlookBtn;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
    procedure UpDateICQSpy;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure AddToMemo(FileName: String);
    procedure SetTheColors;
  end;

const receiving:Boolean=False;
var
  ICQForm: TICQForm;

implementation

uses Unit1, MainUnit;

{$R *.DFM}

type _Message=record
      cod:String[3];
      info:array [1..2] of string[50];
      mesaj:String;
     end;
var Msg:array of _Message;
    TotalMsgs:Integer;
    Current:Integer;

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TICQForm.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with ICQForm,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with ICQForm,msg do begin
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

procedure TICQForm.SetTheColors;
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
 with Label1 do begin Font.Color:=cFormText;Color:=cFormBackground;end;
 with Label2 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with Label3 do begin Font.Color:=cFormText;Color:=cFormBackground;end;
 with Label4 do begin Font.Color:=cFormText;Color:=cFormBackground;end;
 with Label5 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with Label6 do begin Font.Color:=cFormText;Color:=cFormBackground;end;
 with Label7 do begin Font.Color:=cFormText;Color:=cFormBackground;end;
 Simbol.Color:=cFormForeground;
 Simbol.Font.Color:=cFormText;
 Shape1.Pen.Color:=cFormLine;
 Shape2.Pen.Color:=cFormLine;
 Shape3.Pen.Color:=cFormLine;
 with Memo1 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 Invalidate;
end;

procedure TICQForm.FormCreate(Sender: TObject);
begin
 Button2.Enabled:=False;Button1.Enabled:=False;
 Tag:=5;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 SetLength(Msg,250);
 TotalMsgs:=0;
 Current:=0;
 SetTheColors;
end;

procedure TICQForm.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TICQForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TICQForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TICQForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TICQForm.Button3Click(Sender: TObject);
begin
 hide;
end;

procedure TICQForm.Button1Click(Sender: TObject);
begin
 dec(Current);
 UpDateICQSpy;
end;

procedure TICQForm.Button2Click(Sender: TObject);
begin
 inc(Current);
 UpDateICQSpy;
end;

procedure TICQForm.UpDateICQSpy;
begin
 if Current=1 then button1.enabled:=false else button1.enabled:=true;
 if Current=TotalMsgs then button2.enabled:=false else button2.enabled:=true;
 label7.caption:='[total messages: '+inttostr(TotalMsgs)+'] - [current message: '+inttostr(Current)+']';
 memo1.lines.clear;
 if Msg[Current].cod='MSG' then
  begin
   Simbol.ImageIndex:=0;
   label2.caption:=msg[Current].info[1];
   label5.caption:=msg[Current].info[2];
   memo1.lines.text:=Msg[Current].Mesaj;
  end else
 if Msg[Current].cod='URL' then
  begin
   Simbol.ImageIndex:=1;
   label2.caption:=msg[Current].info[1];
   label5.caption:=msg[Current].info[2];
   memo1.lines.text:=Msg[Current].Mesaj;
  end else
 if Msg[Current].cod='WWP' then
  begin
   Simbol.ImageIndex:=2;
   label2.caption:='n/a';
   label5.caption:='n/a';
   memo1.lines.text:=Msg[Current].Mesaj;
  end;
end;

procedure TICQForm.AddToMemo(FileName:String);
var f:TextFile;
    i,loop:integer;
    s:string;
begin
 TotalMsgs:=TotalMsgs+1;
 AssignFile(f,FileName);
 Reset(f);
 try
 ReadLn(f,s);Msg[TotalMsgs].cod:=s;
 ReadLn(f,s);Msg[TotalMsgs].info[1]:=s;
 ReadLn(f,s);Msg[TotalMsgs].info[2]:=s;
 memo1.lines.clear;
 while not eof(f) do
  begin
   ReadLn(f,s);
   memo1.lines.add(s);
  end;
 Msg[TotalMsgs].mesaj:=memo1.lines.text;
 except;
 end;
 CloseFile(f);
 try DeleteFile(FileName);except end;
 Current:=TotalMsgs;
 ICQForm.Show;
 UpDateICQSpy;
end;


procedure TICQForm.OutlookBtn1Click(Sender: TObject);
var f:TextFile;
    loop:integer;
begin
 if TotalMsgs=0 then
  begin
   MainForm.ShowMsg('nothing to save');
   Exit;
  end;
 SaveDialog1.FileName:=MainForm.KeepConnectedIP+'.txt';
 if not SaveDialog1.Execute then Exit;
 if (FileExists(SaveDialog1.Filename)) and (not MainForm.AreYouSure('file exists. overwrite?')) then exit;
 try DeleteFile(SaveDialog1.Filename);except end;
 try AssignFile(f,SaveDialog1.Filename);
 Rewrite(f);WriteLn(f,'ICQ Spy results on '+MainForm.KeepConnectedIP);except mainform.showmsg('error writing txt file');end;
 for loop:=1 to TotalMsgs do
  begin
   WriteLn(f,' ');
   if Msg[loop].Cod='MSG' then WriteLn(f,'ICQ Message');
   if Msg[loop].Cod='URL' then WriteLn(f,'ICQ URL');
   if Msg[loop].Cod='WWP' then WriteLn(f,'ICQ Pager');
   WriteLn(f,'From: '+Msg[loop].Info[1]+' [UIN: '+Msg[loop].Info[2]+']');
   WriteLn(f,'Data: '+Msg[loop].Mesaj);
  end;
  WriteLn(f,' ');
  WriteLn(f,'»eof«');
  try CloseFile(f);except mainform.showmsg('wrror writing to file');end;
end;

procedure TICQForm.FormPaint(Sender: TObject);
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

procedure TICQForm.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
