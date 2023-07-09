unit passunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tpass = class(TForm)
    Button1: TButton;
    name: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    box: TMemo;
    Memo1: TMemo;
    procedure UpdatePasses;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nameClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pass: Tpass;

implementation

uses Unit2;

{$R *.DFM}

procedure Tpass.UpdatePasses;
var s,namestr,boxstr:string;
    la,i,a:integer;
    exista:boolean;
    FileName:String;
    f:textfile;
begin
 la:=0;
 name.items.clear;
 box.lines.clear;
 if Form1.dir.text<>'<default>' then
   FileName:=Form1.dir.text+'\temp.dat'
  else
   FileName:='temp.dat';
{ ShowMessage(strs.text);}
assignfile(f,FileName);reset(f);
repeat
  readln(f,s);
{  showmessage(s);
  box.Items.add(s);}
  for i:=1 to length(s) do
   if (copy(s,i,3)='___') then la:=i-1;
  namestr:=copy(s,1,la);
  boxstr:=copy(s,la+4,length(s));
  exista:=false;
  for a:=0 to name.items.count-1 do
   if name.items.strings[a]=namestr then exista:=true;
  if not exista then name.items.add(namestr);
until eof(f);
 closefile(f);
end;


procedure Tpass.Button1Click(Sender: TObject);
begin
 {modalresult:=1;}
 {close;}
  hide;
  memo1.visible:=false;
end;

procedure Tpass.FormShow(Sender: TObject);
begin
 UpdatePasses;
 form1.Status.Caption:='passwords retrieved.';
end;

procedure Tpass.nameClick(Sender: TObject);
var s,namestr,boxstr:string;
    la,i:integer;
    exista:boolean;
    FileName:String;
    f:textfile;
    curline:String;
begin
box.clear;
la:=0;
 if Form1.dir.text<>'<default>' then
   FileName:=Form1.dir.text+'\temp.dat'
  else
   FileName:='temp.dat';
curline:=name.items.strings[name.itemindex];
{showmessage(curline);    }
assignfile(f,FileName);reset(f);
repeat
  readln(f,s);
{  showmessage(s);
  box.Items.add(s);}
  for i:=1 to length(s) do
   if (copy(s,i,3)='___') then la:=i-1;
  namestr:=copy(s,1,la);
  boxstr:=copy(s,la+4,length(s));
{  showmessage(curline+'='+namestr+'!'+boxstr);}
  exista:=false;
  if namestr=curline then exista:=true;
  if exista then box.lines.add(boxstr);
until eof(f);
 closefile(f);
end;

procedure Tpass.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Form1.dir.text<>'<default>' then
   deletefile(Form1.dir.text+'\temp.dat')
  else
 deletefile('temp.dat');
 memo1.visible:=false;
end;

end.
