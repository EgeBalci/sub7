unit TimeDateUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, RxHook;

type
  TTimeDate = class(TForm)
    DateEdit1: TDateEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DataReceived(data: string);
    { Public declarations }
  end;

var
  TimeDate: TTimeDate;
  MyTime:TSystemTime;
implementation

uses Unit2;

{$R *.DFM}

procedure TTimeDate.Button2Click(Sender: TObject);
begin
 Hide;
end;

procedure TTimeDate.DataReceived(data:string);
begin
 MyTime.wYear:=StrToInt(copy(data,2,4));
 MyTime.wMonth:=StrToInt(copy(data,6,2));
 MyTime.wDay:=StrToInt(copy(data,8,2));
 MyTime.wHour:=StrToInt(copy(data,11,2));
 MyTime.wMinute:=StrToInt(copy(data,13,2));
 dateedit1.date:=SystemTimeToDateTime(MyTime);
 if MyTime.wHour>12 then
  Edit1.Text:=IntToStr(MyTime.wHour-12)+':'+IntToStr(MyTime.wMinute)
 else
  Edit1.Text:=IntToStr(MyTime.wHour)+':'+IntToStr(MyTime.wMinute);
 if MyTime.wHour>12 then ComboBox1.ItemIndex:=1 else ComboBox1.ItemIndex:=0;
 label1.Caption:='done. set time/date and click ''change''';
end;

procedure TTimeDate.FormShow(Sender: TObject);
begin
 FillChar(MyTime,SizeOf(MyTime),#0);
end;

procedure FalDe(var tt:string;l:integer);
var i:integer;
begin
if length(tt)=l then exit;
for i:=1 to l-length(tt) do
 tt:='0'+tt;
end;

procedure TTimeDate.Button1Click(Sender: TObject);
var t,str:string;
begin
 if (not CheckBox1.Checked) and (not CheckBox2.Checked) then
  showmessage('uhm... change what? time? date? specify one or both!')
 else
  begin
   DateTimeToSystemTime(DateEdit1.Date,MyTime);
   str:='STD';
   if CheckBox1.Checked then str:=str+'1' else str:=str+'0';
   t:=IntToStr(MyTime.wYear);FalDe(t,4);str:=str+t;
   t:=IntToStr(MyTime.wMonth);FalDe(t,2);str:=str+t;
   t:=IntToStr(MyTime.wDay);FalDe(t,2);str:=str+t;
   if CheckBox2.Checked then str:=str+'1' else str:=str+'0';
   t:=copy(edit1.text,1,pos(':',edit1.text)-1);
   if combobox1.itemindex=1 then t:=IntToStr( StrToInt(t)+12 );FalDe(t,2);str:=str+t;
   t:=copy(edit1.text,pos(':',edit1.text)+1,2);FalDe(t,2);str:=str+t;
   Form1.SendCommand(str,'setting new time and/or date...');
   Hide;
  end;
end;

end.
