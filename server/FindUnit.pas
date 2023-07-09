unit FindUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFindForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Label2: TLabel;
    ListBox1: TListBox;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit3: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FindForm: TFindForm;

implementation

uses Unit2, waitunit;

{$R *.DFM}

procedure TFindForm.FormShow(Sender: TObject);
begin
 edit1.text:=form1.path.caption;
end;

procedure TFindForm.Button2Click(Sender: TObject);
begin
 close;
end;

procedure TFindForm.Button1Click(Sender: TObject);
var bigstr,str,str2,len:string;
begin
 listbox1.clear;
 if checkbox1.checked then bigstr:='T' else bigstr:='F';
 str:=edit2.text;
 str2:=edit1.text;
 if str2[length(str2)]<>'\' then str2:=str2+'\';
 if length(str)<10 then len:='0'+inttostr(length(str)) else len:=IntToStr(length(str));
 bigstr:=bigstr+len+str+str2;
 Form1.ClientSocket.Socket.SendText('FFN'+bigstr);
  with waitform do begin
   label1.caption:='searching for files...';
   bevel1.height:=bevel1.height-21;
   height:=height-21;
   Form1.SetTransferON;
  end;
end;

procedure TFindForm.ListBox1Click(Sender: TObject);
begin
 edit3.text:=listbox1.items[listbox1.itemindex];
end;

procedure TFindForm.Button4Click(Sender: TObject);
begin
 close;
end;

procedure TFindForm.Button3Click(Sender: TObject);
begin
 form1.path.caption:=extractfilepath(edit3.text);
 form1.refreshfm;
 close;
end;

end.
