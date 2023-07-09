program SubSeven;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MainColors in 'MainColors.pas',
  //parole in 'parole.pas',
  AnimUnit in 'AnimUnit.pas' {Anim},
  KeyLoggerUnit in 'KeyLoggerUnit.pas' {Keylogger},
  showmessageunit in 'showmessageunit.pas' {GetTextForm},
  DispInfoUnit in 'DispInfoUnit.pas' {DispInfo},
  MessageUnit in 'MessageUnit.pas' {MsgForm},
  ClientChatUnit in 'ClientChatUnit.pas' {ClientChat},
  VictimChatUnit in 'VictimChatUnit.pas' {VictimChat},
  FindFilesUnit in 'FindFilesUnit.pas' {FindFiles},
  PassUnit in 'PassUnit.pas' {Pass},
  RegEditUnit in 'RegEditUnit.pas' {RegEdit},
  ICQunit in 'ICQunit.pas' {ICQForm},
  nonstopUnit in 'nonstopUnit.pas' {nonstopForm},
  ShowImgUnit in 'ShowImgUnit.pas' {ShowImg},
  webcamUnit in 'webcamUnit.pas' {webcam},
  winmUnit in 'winmUnit.pas' {winM},
  FileMunit in 'FileMunit.pas' {fileM},
  GetPathUnit in 'GetPathUnit.pas' {GetNewPath},
  PopUpUnit in 'PopUpUnit.pas' {PopUp},
  ShortcutUnit in 'ShortcutUnit.pas' {ShortcutForm},
  msnUnit in 'msnUnit.pas' {msnForm},
  aimUnit in 'aimUnit.pas' {aimForm},
  TheMatrixUnit in 'TheMatrixUnit.pas' {TheMatrix},
  htmltotxt in 'htmltotxt.pas',
  AboutUnit in 'AboutUnit.pas' {About},
  iptoolUnit in 'iptoolUnit.pas' {IPTool},
  procUnit in 'procUnit.pas' {procM},
  ThreadUnit in 'ThreadUnit.pas' {Dlg},
  AddPortUnit in 'AddPortUnit.pas' {AddPort},
  AddressBookUnit in 'AddressBookUnit.pas' {AddressBook},
  BookMarkUnit in 'BookMarkUnit.pas' {Bookmarks};
  //ZLIBArchive in '..\..\Delphi4\_Sub7_2000\_ZIP\zlibarchive.PAS',
  // in '..\..\Delphi4\3.0\skins\gifimage.pas';

{$R *.RES}
var SplashAbout:TMsgForm;

begin
  Application.Initialize;
  SplashAbout:=TMsgForm.Create(Application);
  SplashAbout.MakeSplash2;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TIPTool, IPTool);
  Application.CreateForm(TprocM, procM);
  Application.CreateForm(TDlg, Dlg);
  Application.CreateForm(TAddPort, AddPort);
  Application.CreateForm(TAddressBook, AddressBook);
  Application.CreateForm(TBookmarks, Bookmarks);
  Application.OnMinimize:=MainForm.MinimizeIT;
  Application.CreateForm(TAnim, Anim);
  Application.CreateForm(TKeylogger, Keylogger);
  Application.CreateForm(TGetTextForm, GetTextForm);
  Application.CreateForm(TDispInfo, DispInfo);
  Application.CreateForm(TMsgForm, MsgForm);
  Application.CreateForm(TClientChat, ClientChat);
  Application.CreateForm(TVictimChat, VictimChat);
  Application.CreateForm(TFindFiles, FindFiles);
  Application.CreateForm(TPass, Pass);
  Application.CreateForm(TRegEdit, RegEdit);
  Application.CreateForm(TICQForm, ICQForm);
  Application.CreateForm(TnonstopForm, nonstopForm);
  Application.CreateForm(TShowImg, ShowImg);
  Application.CreateForm(Twebcam, webcam);
  Application.CreateForm(TwinM, winM);
  Application.CreateForm(TfileM, fileM);
  Application.CreateForm(TGetNewPath, GetNewPath);
  Application.CreateForm(TPopUp, PopUp);
  Application.CreateForm(TShortcutForm, ShortcutForm);
  Application.CreateForm(TmsnForm, msnForm);
  Application.CreateForm(TaimForm, aimForm);
  Application.CreateForm(TTheMatrix, TheMatrix);
  Application.CreateForm(TAbout, About);
  Application.OnException:=MainForm.HandleErrors;
  SplashAbout.Hide;
  SplashAbout.Destroy;
  Application.Run;
end.
