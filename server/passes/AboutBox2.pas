unit AboutBox2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox2 = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
   procedure MakeSplash;
    { Public declarations }
  end;

var
  SplashAbout: TAboutBox2;

implementation

{$R *.DFM}

procedure TAboutBox2.MakeSplash;
begin
  BorderStyle := bsNone;
{  BitBtn1.Visible := False;}
  {Panel1.BorderWidth := 3;}
  Show;
  Update;
  Timer1.Enabled:=False;
  Timer1.Interval:=3000;
end;

procedure TAboutBox2.Timer1Timer(Sender: TObject);
begin
 Close;
 Release;
end;

end.
 
