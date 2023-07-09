unit printUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, RXSpin, Buttons;

type
  TprintForm = class(TForm)
    RichEdit: TRichEdit;
    Button1: TButton;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    RxSpinEdit1: TRxSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  printForm: TprintForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TprintForm.Button2Click(Sender: TObject);
begin
 close;
end;

procedure TprintForm.Button1Click(Sender: TObject);
var sendit:String;
begin
 hide;
 sendit:='';
 if speedbutton1.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if speedbutton2.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if speedbutton3.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if speedbutton4.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 sendit:=sendit+IntToStr(richedit.font.size);
 Form1.ClientSocket.Socket.SendText('PRN'+sendit+richedit.lines.text);
 form1.Status.Caption:='sending text to be printed...';
end;

procedure TprintForm.FormShow(Sender: TObject);
begin
 rxspinedit1.value:=richedit.Font.Size;
 if fsBold in richedit.font.style then speedbutton1.down:=true;
 if fsItalic in richedit.font.style then speedbutton2.down:=true;
 if fsUnderline in richedit.font.style then speedbutton3.down:=true;
 if fsStrikeOut in richedit.font.style then speedbutton4.down:=true;
end;

procedure TprintForm.SpeedButton1Click(Sender: TObject);
begin
 if speedbutton1.down then
  richedit.font.style:=richedit.font.style+[fsBold]
 else
  richedit.font.style:=richedit.font.style-[fsBold];
end;

procedure TprintForm.SpeedButton2Click(Sender: TObject);
begin
 if speedbutton2.down then
  richedit.font.style:=richedit.font.style+[fsItalic]
 else
  richedit.font.style:=richedit.font.style-[fsItalic];
end;

procedure TprintForm.RxSpinEdit1Change(Sender: TObject);
begin
 richedit.font.size:=StrToInt(FloatToStr(rxspinedit1.value));
end;

procedure TprintForm.SpeedButton3Click(Sender: TObject);
begin
 if speedbutton3.down then
  richedit.font.style:=richedit.font.style+[fsUnderline]
 else
  richedit.font.style:=richedit.font.style-[fsUnderline];
end;

procedure TprintForm.SpeedButton4Click(Sender: TObject);
begin
 if speedbutton4.down then
  richedit.font.style:=richedit.font.style+[fsStrikeOut]
 else
  richedit.font.style:=richedit.font.style-[fsStrikeOut];
end;

end.
