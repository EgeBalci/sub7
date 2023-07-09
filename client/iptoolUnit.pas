unit iptoolUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn, TFlatEditUnit, Ping;

type
  TIPTool = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Label92: TLabel;
    FlatEdit32: TFlatEdit;
    FlatEdit34: TFlatEdit;
    OutlookBtn117: TOutlookBtn;
    OutlookBtn118: TOutlookBtn;
    OutlookBtn119: TOutlookBtn;
    DisplayMemo: TMemo;
    Label93: TLabel;
    PingUtil: TPing;
    OutlookBtn1: TOutlookBtn;
    FlatEdit1: TFlatEdit;
    Label1: TLabel;
    Label2: TLabel;
    OutlookBtn2: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn117Click(Sender: TObject);
    procedure OutlookBtn118Click(Sender: TObject);
    procedure OutlookBtn119Click(Sender: TObject);
    procedure PingUtilDnsLookupDone(Sender: TObject; Error: Word);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure PingUtilDisplay(Sender, Icmp: TObject; Msg: String);
    procedure PingUtilEchoReply(Sender, Icmp: TObject; Error: Integer);
    procedure PingUtilEchoRequest(Sender, Icmp: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  IPTool: TIPTool;

implementation

uses Unit1, MainUnit;

{$R *.DFM}


procedure TIPTool.SetTheColors;
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
 with DisplayMemo do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with FlatEdit32 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit34 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 Label1.Font.Color:=cFormText;
 Label2.Font.Color:=cFormText;
 Label92.Font.Color:=cFormText;
 Label93.Font.Color:=cFormText;
 Invalidate; 
end;

procedure TIPTool.FormCreate(Sender: TObject);
begin
 SetTheColors;
 Tag:=14;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
// if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
// if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
end;

procedure TIPTool.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TIPTool.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TIPTool.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TIPTool.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TIPTool.OutlookBtn117Click(Sender: TObject);
begin
 if OutlookBtn117.Caption='cancel' then
  begin
   PingUtil.CancelDnsLookup;
   OutlookBtn117.Caption:='resolve host name';
   Exit;
  end;
{ DisplayMemo.Clear;}
 DisplayMemo.Lines.Add('resolving host ''' + FlatEdit32.Text + '''');
 OutlookBtn117.Caption:='cancel';
 PingUtil.DnsLookup(FlatEdit32.Text);
end;

procedure TIPTool.OutlookBtn118Click(Sender: TObject);
begin
 PingUtil.Address := FlatEdit34.Text;
 PingUtil.Ping;
end;

procedure TIPTool.OutlookBtn119Click(Sender: TObject);
begin
 DisplayMemo.Clear;
end;

procedure TIPTool.PingUtilDnsLookupDone(Sender: TObject; Error: Word);
begin
 OutlookBtn117.Caption:='resolve host name';

 if Error <> 0 then begin
  DisplayMemo.Lines.Add('unknown host ''' + FlatEdit32.Text + '''');
  Exit;
 end;

 DisplayMemo.Lines.Add('host ''' + FlatEdit32.Text + ''' is ' + PingUtil.DnsResult);
 FlatEdit34.Text:=PingUtil.DnsResult;
end;

procedure TIPTool.OutlookBtn1Click(Sender: TObject);
var done:bool;
    ip:string;
begin
 DisplayMemo.Lines.Add('resolving uin: '+FlatEdit1.Text+'...');
 //buhahaha
 ip:=MainForm.GetUINIP(FlatEdit1.Text);
 if ip='0.0.0.0' then done:=false else done:=true;
// done:=true;ip:='208.28.57.23';
 if not done then DisplayMemo.Lines.Add('failed to retrieve ip number.')
  else
   begin
    DisplayMemo.Lines.Add('ip number for uin: '+FlatEdit1.Text+' is '+ip);
    FlatEdit34.Text:=ip;
   end; 
end;

procedure TIPTool.OutlookBtn2Click(Sender: TObject);
begin
 DisplayMemo.Lines.Add('resolving ip ''' + FlatEdit34.Text + '''');
 MainForm.hunt1.ReverseDnsLookup(FlatEdit34.Text); { Start DnsLookup }
end;

procedure TIPTool.PingUtilDisplay(Sender, Icmp: TObject; Msg: String);
begin
 DisplayMemo.Lines.Add(Msg);
end;

procedure TIPTool.PingUtilEchoReply(Sender, Icmp: TObject; Error: Integer);
begin
 if Error = 0 then
  DisplayMemo.Lines.Add('can''t ping host (' + PingUtil.HostIP + ') : ' +
                              PingUtil.ErrorString)
 else DisplayMemo.Lines.Add('received ' + IntToStr(PingUtil.Reply.DataSize) +
                              ' bytes from ' + PingUtil.HostIP +
                              ' in ' + IntToStr(PingUtil.Reply.RTT) + ' msecs');

end;

procedure TIPTool.PingUtilEchoRequest(Sender, Icmp: TObject);
begin
 DisplayMemo.Lines.Add('sending ' + IntToStr(PingUtil.Size) + ' bytes to ' +
{                          PingUtil.HostName + ' (' +} PingUtil.HostIP{ + ')'}+'...');

end;

procedure TIPTool.FormPaint(Sender: TObject);
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

procedure TIPTool.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
