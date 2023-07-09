unit flipUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TflipForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  flipForm: TflipForm;

implementation

{$R *.DFM}

procedure TflipForm.Button2Click(Sender: TObject);
begin
 flipform.tag:=0;
 close;
end;

procedure TflipForm.Button1Click(Sender: TObject);
begin
 if (not checkbox1.checked) and (not checkbox2.checked) then
  begin
   showmessage('you gotta click on a type of flipping!'#13#10'horizontally, vertically or both');
   exit;
  end;
 if (checkbox1.checked) and (checkbox2.checked) then tag:=3;
 if (checkbox1.checked) and (not checkbox2.checked) then tag:=1;
 if (not checkbox1.checked) and (checkbox2.checked) then tag:=2;
 close;
end;

end.
