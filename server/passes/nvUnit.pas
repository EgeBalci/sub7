unit nvUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ShellApi;

type
  TnvForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    labelVer: TLabel;
    labelDate: TLabel;
    labelLink: TLabel;
    labelSize: TLabel;
    labelWeb: TLabel;
    Label6: TLabel;
    newStuff: TMemo;
    Button1: TButton;
    labelLink2: TLabel;
    labelWeb2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Timer1: TTimer;
    procedure Label6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure labelLinkClick(Sender: TObject);
    procedure labelWebClick(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure labelWebMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure labelLinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  nvForm: TnvForm;

implementation

{$R *.DFM}

procedure TnvForm.Label6Click(Sender: TObject);
begin
 newStuff.Visible:=True;
 button1.Visible:=true;
end;

procedure TnvForm.Button1Click(Sender: TObject);
begin
 newStuff.Visible:=False;
 button1.visible:=false;
end;

procedure TnvForm.Label8Click(Sender: TObject);
begin
 close;
end;

procedure TnvForm.labelLinkClick(Sender: TObject);
var Url:String;
begin
 Url:=labelLink2.caption;
 ShellExecute(handle, 'open', pchar(url), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TnvForm.labelWebClick(Sender: TObject);
var Url:String;
begin
 Url:=labelWeb2.caption;
 ShellExecute(handle, 'open', pchar(url), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TnvForm.Label9Click(Sender: TObject);
begin
 timer1.interval:=300000;
 timer1.enabled:=true;
 close;
end;

procedure TnvForm.Timer1Timer(Sender: TObject);
begin
 show;
 timer1.enabled:=false;
end;

procedure TnvForm.labelWebMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 cursor:=crHandPoint;
end;

procedure TnvForm.labelLinkMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 cursor:=crHandPoint;
end;

procedure TnvForm.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 cursor:=crHandPoint;
end;

procedure TnvForm.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 cursor:=crdefault;
end;

procedure TnvForm.Label8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
end;

procedure TnvForm.Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
end;

end.
