unit key_log_unit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TKeyLogUnit = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KeyLogUnit: TKeyLogUnit;

implementation

{$R *.DFM}

procedure TKeyLogUnit.Button1Click(Sender: TObject);
begin
 keylogunit.hide;
end;

procedure TKeyLogUnit.Button2Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
  Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
 