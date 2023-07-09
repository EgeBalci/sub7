program SubSeven;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form1},
  Unit4 in 'Unit4.pas' {Form2},
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
  nvUnit in 'nvUnit.pas' {nvForm},
  flipUnit in 'flipUnit.pas' {flipForm},
  nonstopUnit in 'nonstopUnit.pas' {nonstopForm},
  readregs in '..\..\..\Program Files\Borland\Delphi4\Projects\reg editor\readregs.pas' {regform},
  waitunit in 'waitunit.pas' {waitform},
  FindUnit in 'FindUnit.pas' {FindForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SubSeven';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TGetNewPath, GetNewPath);
  Application.CreateForm(TForm2, Form2);
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
  Application.CreateForm(TnvForm, nvForm);
  Application.CreateForm(TflipForm, flipForm);
  Application.CreateForm(TnonstopForm, nonstopForm);
  Application.CreateForm(Tregform, regform);
  Application.CreateForm(Twaitform, waitform);
  Application.CreateForm(TFindForm, FindForm);
  Application.OnException:=Form1.HandleErrors;
  Application.Run;
end.
