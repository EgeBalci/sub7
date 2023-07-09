unit HoldOnUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  THoldOnForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HoldOnForm: THoldOnForm;

implementation

uses Unit2;

{$R *.DFM}

procedure THoldOnForm.Timer1Timer(Sender: TObject);
begin
 if label1.font.color=clBlue then label1.font.color:=clWhite
  else label1.color:=clBlue;
end;

procedure THoldOnForm.FormShow(Sender: TObject);
begin
 timer1.enabled:=true;
end;

procedure THoldOnForm.FormHide(Sender: TObject);
begin
 timer1.enabled:=false;
end;

procedure THoldOnForm.Button1Click(Sender: TObject);
begin
 Form1.CancelTransfer;
end;

end.
