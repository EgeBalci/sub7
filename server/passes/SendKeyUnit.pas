unit SendKeyUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSendKeyForm = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    memo: TMemo;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    procedure UpdateTheList(deaci:boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure memoKeyPress(Sender: TObject; var Key: Char);
    procedure memoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendKeyForm: TSendKeyForm;
  KeysToSend:String;
implementation

uses Unit2;

{$R *.DFM}


procedure TSendKeyForm.UpdateTheList;
var i:integer;
begin
if not deaci then exit;
 SendKeyForm.ListBox1.Items.Clear;
 for i:=0 to Form1.ListBox2.Items.Count do
  SendKeyForm.ListBox1.Items.Add(Form1.ListBox2.Items[i]);
end;

procedure TSendKeyForm.Button2Click(Sender: TObject);
begin
 Form1.RefreshIT(sender);
end;

procedure TSendKeyForm.Button3Click(Sender: TObject);
begin
 hide;
end;

procedure TSendKeyForm.Button1Click(Sender: TObject);
var len:string;
begin
 len:=IntToStr(ListBox1.ItemIndex+1);
 if length(len)=1 then len:='0'+len;
 Form1.ClientSocket.Socket.SendText('MTK'+len+{capt+}KeysToSend);
 if checkbox1.checked then hide else
  begin
   KeysToSend:='';
   memo.lines.clear;
  end;
end;

procedure TSendKeyForm.FormShow(Sender: TObject);
begin
 KeysToSend:='';
 memo.lines.clear;
 UpdateTheList(true);
end;

procedure TSendKeyForm.memoKeyPress(Sender: TObject; var Key: Char);
begin
 KeysToSend:=KeysToSend+Key;
end;

procedure TSendKeyForm.memoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then
  KeysToSend:=KeysToSend+#130;
end;

procedure TSendKeyForm.memoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=8 then
 KeysToSend:=copy(KeysToSend,1,length(KeysToSend)-1);
end;

end.
