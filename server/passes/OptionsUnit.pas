unit OptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, ExtCtrls, RXCombos, ComCtrls, RXSpin, Menus;

type
  TOptionsForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    dir2: TButton;
    TrackBar1: TTrackBar;
    Label8: TLabel;
    Bevel3: TBevel;
    prev: TLabel;
    shot: TLabel;
    TrackBar2: TTrackBar;
    Bevel4: TBevel;
    Label10: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    ColorComboBox1: TColorComboBox;
    ColorComboBox2: TColorComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RxSpinEdit1: TRxSpinEdit;
    Label6: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    RxSpinEdit2: TRxSpinEdit;
    Label7: TLabel;
    RxSpinEdit3: TRxSpinEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    Button3: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Button4: TButton;
    Label14: TLabel;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    Label15: TLabel;
    procedure dir2ButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ColorComboBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
  private
    procedure RefreshSamples;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;
  f:file;
  cod:byte;
  EXEFile:String;
implementation

uses dirunit, Unit2, Unit23, aboutbox, FindUnit, flipUnit, 
  ftpservunit, npath, key_log_unit, ListaUnit, messageunit, nonstopUnit,
  nvUnit, passunit, portscanunit, readregs, SendKeyUnit, showimage,
  ShowInformations, waitunit, SkinUnit;

{$R *.DFM}

procedure TOptionsForm.dir2ButtonClick(Sender: TObject);
begin
 GetFol.Enabled:=True;
 Form1.Enabled:=False;
 GetFol.Show;
end;

procedure ChangeTheCaracterTo(ce:string);
begin
 assignfile(f,EXEFile);
 reset(f,1);
 seek(f,2);
 cod:=Ord(ce[1]);
 blockwrite(f,cod,1);
 closefile(f);
end;

procedure TOptionsForm.Button2Click(Sender: TObject);
begin
 Form1.SaveINI('Options','PrevQuality',IntToStr(trackbar1.position));
 Form1.SaveINI('Options','ShotQuality',IntToStr(trackbar2.position));
 hide;
end;

procedure ReadFromIni;
var rd:string;
begin
 rd:=Form1.ReadIni('Options','PrevQuality');
 if (rd<>'ERROR') then optionsform.trackbar1.position:=StrToInt(rd)
  else optionsform.trackbar1.position:=40;
 rd:=Form1.ReadIni('Options','ShotQuality');
 if (rd<>'ERROR') then optionsform.trackbar2.position:=StrToInt(rd)
  else optionsform.trackbar2.position:=50;
 optionsform.trackbar1.repaint;
 optionsform.trackbar2.repaint;
end;

procedure TOptionsForm.FormShow(Sender: TObject);
begin
 dir2.caption:=form1.dir.text;
 if (Form1.ReadINI('Options','Help')='off') then
  CheckBox1.Checked:=False else
  CheckBox1.Checked:=True;
 OptionsForm.Edit1.Text:=Form1.ReadIni('Options','NickName');
 if Form1.ReadINI('Options','AskForNick?')='no' then OptionsForm.RadioButton1.Checked:=True;
 if Form1.ReadINI('Options','ClientChatColor')='ERROR' then
  begin
   ColorComboBox1.ColorValue:=clYellow;
   Form1.SaveIni('Options','ClientChatColor',ColorToString(clYellow));
  end else begin
   ColorComboBox1.ColorValue:=StringToColor(Form1.ReadINI('Options','ClientChatColor'));
  end;
 if Form1.ReadINI('Options','VictimChatColor')='ERROR' then
  begin
   ColorComboBox2.ColorValue:=clWhite;
   Form1.SaveIni('Options','VictimChatColor',ColorToString(clWhite));
  end else begin
   ColorComboBox2.ColorValue:=StringToColor(Form1.ReadINI('Options','VictimChatColor'));
  end;
 if Form1.ReadINI('Options','ClientFontSize')='ERROR' then
  begin
   RxSpinEdit1.Value:=10;
   Form1.SaveIni('Options','ClientFontSize','10');
  end else begin
   RxSpinEdit1.Value:=StrToInt(Form1.ReadINI('Options','ClientFontSize'));
  end;
 if Form1.ReadINI('Options','VictimFontSize')='ERROR' then
  begin
   RxSpinEdit2.Value:=8;
   Form1.SaveIni('Options','VictimFontSize','10');
  end else begin
   RxSpinEdit2.Value:=StrToInt(Form1.ReadINI('Options','VictimFontSize'));
  end;
 if Form1.ReadINI('Options','VictimChatSize')='ERROR' then
  begin
   RxSpinEdit3.Value:=50;
   Form1.SaveIni('Options','VictimChatSize','50');
  end else begin
   RxSpinEdit3.Value:=StrToInt(Form1.ReadINI('Options','VictimChatSize'));
  end;
  RefreshSamples;
end;

procedure TOptionsForm.RefreshSamples;
begin
 Edit3.Font.Color:=ColorComboBox1.ColorValue;
 Edit2.Font.Color:=ColorComboBox2.ColorValue;
 Edit3.Font.Size:=StrToInt(FloatToStr(RxSpinEdit1.Value));
 Edit2.Font.Size:=StrToInt(FloatToStr(RxSpinEdit2.Value));
end;

procedure TOptionsForm.Button1Click(Sender: TObject);
var fn:string;
begin
 fn:=ExtractFilePath(paramstr(0))+'\EditServer.exe';
 if not FileExists(fn) then
  begin
   Showmessage('can''t find: ['+fn+'] ! make sure you got it in the same directory.');
   exit;
  end;
 WinExec(PChar(fn),SW_SHOWNORMAL);
{ EXEFile:=FileNameEdit1.Text;
 assignfile(f,EXEFile);
 reset(f,1);
 seek(f,2);
 blockread(f,cod,1);
 closefile(f);
 case Chr(cod) of
  'O':RadioGroup1.ItemIndex:=3;
  'P':RadioGroup1.ItemIndex:=0;
  'Q':RadioGroup1.ItemIndex:=1;
  'R':RadioGroup1.ItemIndex:=2;
 end;}
end;

procedure TOptionsForm.TrackBar1Change(Sender: TObject);
begin
 prev.caption:=inttostr(trackbar1.position)+'%';
end;

procedure TOptionsForm.TrackBar2Change(Sender: TObject);
begin
 shot.caption:=inttostr(trackbar2.position)+'%';
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
 ReadFromIni;
 shot.caption:=inttostr(trackbar2.position)+'%';
 prev.caption:=inttostr(trackbar1.position)+'%';
 Shape1.Brush.Color:=StringToColor(Form1.ReadINI('Options','Sub7Color'));
 Form1.SetSub7Color(Form1.ReadINI('Options','Sub7Color'));
end;

procedure TOptionsForm.CheckBox1Click(Sender: TObject);
begin
if (not CheckBox1.Checked) then
 begin
  Form1.Label2.Visible:=True;
  Form1.Info.Visible:=False;
  Form1.SaveINI('Options','Help','off');
 end else begin
  Form1.Label2.Visible:=False;
  Form1.Info.Visible:=True;
  Form1.SaveINI('Options','Help','on');
 end;

end;

procedure TOptionsForm.FormHide(Sender: TObject);
begin
 if OptionsForm.RadioButton1.Checked then
  Form1.SaveINI('Options','AskForNick?','no')
 else Form1.SaveINI('Options','AskForNick?','yes');
 Form1.SaveINI('Options','NickName',OptionsForm.Edit1.Text);

 Form1.SaveINI('Options','ClientChatColor',ColorToString(ColorComboBox1.ColorValue));
 Form1.SaveINI('Options','VictimChatColor',ColorToString(ColorComboBox2.ColorValue));
 Form1.SaveINI('Options','ClientFontSize',FloatToStr(RxSpinEdit1.Value));
 Form1.SaveINI('Options','VictimFontSize',FloatToStr(RxSpinEdit2.Value));
 Form1.SaveINI('Options','VictimChatSize',FloatToStr(RxSpinEdit3.Value));
end;

procedure TOptionsForm.ColorComboBox1Click(Sender: TObject);
begin
 RefreshSamples;
end;

procedure TOptionsForm.Button3Click(Sender: TObject);
begin
 SkinForm.ShowSkin(1);
 SkinForm.ShowModal;
end;

procedure TOptionsForm.Button4Click(Sender: TObject);
begin
 SkinForm.ShowSkin(2);
 SkinForm.ShowModal;
end;

procedure TOptionsForm.Label15Click(Sender: TObject);
begin
 ColorDialog1.Color:=Shape1.Brush.Color;
 if ColorDialog1.Execute then
  begin
   Shape1.Brush.Color:=ColorDialog1.Color;
   Form1.SetSub7Color(ColorToString(Shape1.Brush.Color));
   Form1.SaveINI('Options','Sub7Color',ColorToString(Shape1.Brush.Color));
  end;
end;

end.
