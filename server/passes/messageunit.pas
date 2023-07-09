unit messageunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls;

type
  Tmessagemanager = class(TForm)
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  messagemanager: Tmessagemanager;
  CIcon : integer;
  IconConst : array [0..4] of integer=(0, MB_ICONEXCLAMATION,
         MB_ICONINFORMATION, MB_ICONSTOP,  MB_ICONQUESTION);

implementation

uses Unit2;

{$R *.DFM}

procedure Tmessagemanager.FormCreate(Sender: TObject);
begin
 CIcon:=0;
end;

procedure Tmessagemanager.Button1Click(Sender: TObject);
 var TSum : LongInt;
     MCapt, MText : PChar;
     MT, RT : string;
     i : integer;
begin
 TSum:=0;
 case radiogroup1.ItemIndex of
  1 : TSum:=MB_ABORTRETRYIGNORE;
  2 : TSum:=MB_OKCANCEL;
  3 : TSum:=MB_RETRYCANCEL;
  4 : TSum:=MB_YESNO;
  5 : TSum:=MB_YESNOCANCEL;
 end;
 TSum:=TSum+IconConst[CIcon];
 getMem (MCapt, 100);
 StrPCopy (MCapt, edit1.Text);
 RT:='';
 MT:=edit2.Text;
 for i:=1 to Length (MT) do
  if MT[i]='|' then RT:=RT+chr(13)+chr(10) else RT:=RT+MT[i];
 getMem (MText, 500);
 StrPCopy (MText, RT);
 MessageBox (messagemanager.Handle, MText, MCapt, TSum);
 freeMem (MText);
 freeMem (MCapt);
end;

procedure Tmessagemanager.Button3Click(Sender: TObject);
begin
 hide;
end;

procedure Tmessagemanager.SpeedButton2Click(Sender: TObject);
begin
 CIcon:=1;
end;

procedure Tmessagemanager.SpeedButton3Click(Sender: TObject);
begin
 CIcon:=2;
end;

procedure Tmessagemanager.SpeedButton4Click(Sender: TObject);
begin
 CIcon:=3;
end;

procedure Tmessagemanager.SpeedButton5Click(Sender: TObject);
begin
 CIcon:=4;
end;

procedure Tmessagemanager.SpeedButton1Click(Sender: TObject);
begin
 CIcon:=0;
end;

procedure Tmessagemanager.Button2Click(Sender: TObject);
begin
 form1.ClientSocket.Socket.SendText('MW:'+IntToStr(radiogroup1.ItemIndex)+IntToStr(CIcon)+edit1.Text+'ZJXX'+edit2.Text);
 form1.Status.Caption:='sending customized message...';
 hide;
end;

end.
