unit aboutbox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RXCtrls, Flame{, RXCtrls};

type
  Tabout = class(TForm)
    Button1: TButton;
    SecretPanel1: TSecretPanel;
    Flame1: TFlame;
    procedure Button1Click(Sender: TObject);
    procedure SecretPanel1Enter(Sender: TObject);
    procedure SecretPanel1Exit(Sender: TObject);
    procedure Flame1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  about: Tabout;

implementation

uses Unit2;
{$R *.DFM}

procedure Tabout.Button1Click(Sender: TObject);
begin
 Form1.Enabled:=True;
 About.Enabled:=False;
 About.Hide;
end;

procedure Tabout.SecretPanel1Enter(Sender: TObject);
begin
 SecretPanel1.Interval:=67;
 SecretPanel1.Active:=True;
end;

procedure Tabout.SecretPanel1Exit(Sender: TObject);
begin
 SecretPanel1.Active:=False;
end;

procedure Tabout.Flame1Click(Sender: TObject);
begin
 Flame1.FadeOut:=not Flame1.FadeOut;
end;

procedure Tabout.FormShow(Sender: TObject);
begin
 Flame1.Enabled:=True;
end;

procedure Tabout.FormHide(Sender: TObject);
begin
 Flame1.Enabled:=False;
end;

end.
