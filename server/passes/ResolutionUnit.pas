unit ResolutionUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TResolutionForm = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResolutionForm: TResolutionForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TResolutionForm.Button2Click(Sender: TObject);
begin
 hide;
end;

procedure TResolutionForm.Button1Click(Sender: TObject);
begin
 Form1.ClientSocket.Socket.SendText('CRT'+inttostr(ListBox1.ItemIndex));
 hide;
end;

end.
