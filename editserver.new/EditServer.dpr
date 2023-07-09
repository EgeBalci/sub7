program EditServer;

uses
  Forms,
  EditUnit in 'EditUnit.pas' {EditForm},
  HelpUnit in 'HelpUnit.pas' {GiveHelp},
  ChangeIconUnit in 'ChangeIconUnit.pas' {ChangeIconForm},
  IRCBotUnit in 'IRCBotUnit.pas' {IrcBotForm},
  MessageUnit in 'MessageUnit.pas' {MsgForm},
  showmessageunit in 'showmessageunit.pas' {GetTextForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TGiveHelp, GiveHelp);
  Application.CreateForm(TChangeIconForm, ChangeIconForm);
  Application.CreateForm(TIrcBotForm, IrcBotForm);
  Application.CreateForm(TMsgForm, MsgForm);
  Application.CreateForm(TGetTextForm, GetTextForm);
  Application.Run;
end.
