unit fakeUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, ExtCtrls, StdCtrls, RxGIF;

type
  TfakeForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    Gauge1: TGauge;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fakeForm: TfakeForm;

implementation

uses Unit1;

{$R *.DFM}

procedure Delay(msecs:integer);
var
   FirstTickCount:longint;
begin
     FirstTickCount:=GetTickCount;
     repeat
     until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;
procedure TfakeForm.Timer1Timer(Sender: TObject);
var i:integer;
begin
 gauge1.maxvalue:=100;
 gauge1.minvalue:=0;
 gauge1.progress:=0;
 for i:=1 to 70 do
  begin
   delay(30);
   gauge1.progress:=i;
  end;
timer1.enabled:=false;
try
form1.ShowCustomizedMessage('03ErrorZJXXError reading package.',nil);
finally
 fakeform.close;
 fakeform.hide;
end; 
end;
end.
