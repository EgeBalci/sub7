program EditServer;

uses
  Forms,
  EditServerUnit in 'EditServerUnit.pas' {Form1},
  changeicon in 'changeicon.pas' {Form2},
  ES_messageunit in 'ES_messageunit.pas' {messagemanager},
  EditServer_Sizes in 'EditServer_Sizes.pas' {ES_Sizes};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tmessagemanager, messagemanager);
  Application.CreateForm(TES_Sizes, ES_Sizes);
  Application.Run;
end.
