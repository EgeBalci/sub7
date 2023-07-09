unit ftpservunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXSpin;

type
  TFTPServer = class(TForm)
    host: TEdit;
    password: TEdit;
    port: TRxSpinEdit;
    clients: TRxSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    labelactive: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTPServer: TFTPServer;

implementation

uses Unit2;

{$R *.DFM}

procedure TFTPServer.Button2Click(Sender: TObject);
begin
 Form1.DisableFTPServer;
 Hide;
end;

procedure TFTPServer.Button1Click(Sender: TObject);
begin
 Form1.EnableFTPServer(password.text,Round(port.Value),Round(clients.value));
 Hide
end;

procedure TFTPServer.Button3Click(Sender: TObject);
begin
 hide;
end;

end.
