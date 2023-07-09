unit EditServer_Sizes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin;

type
  TES_Sizes = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ES_Sizes: TES_Sizes;

implementation

{$R *.DFM}

procedure TES_Sizes.Button2Click(Sender: TObject);
begin
 if (CheckBox1.Checked) and (SpinEdit1.Value<=0) then
  begin showmessage(IntToStr(SpinEdit1.Value)+' is not a valid number of bytes.');exit;end;
 if (CheckBox2.Checked) and (SpinEdit2.Value<=0) then
  begin showmessage(IntToStr(SpinEdit2.Value)+' is not a valid number of bytes.');exit;end;
 Hide;
end;

end.
