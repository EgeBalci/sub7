unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm5.Button1Click(Sender: TObject);
begin
 Form5.Enabled:=False;
 Form1.Enabled:=True;
 Form5.Visible:=False;
end;

end.
