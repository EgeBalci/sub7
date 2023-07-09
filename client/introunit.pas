unit introunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ImgList, StdCtrls;

type
  TIntro = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    procedure Go;
    { Private declarations }
  public
    { Public declarations }
   BackBMP:TBitmap;
  end;

const clickhere='loading...';
var
//  BackBMP:TBitmap;
  Intro: TIntro;
  X:Integer;
  DC:HDC;
  lx,ly:integer;
implementation

uses MainUnit;

{$R *.DFM}

procedure TIntro.FormCreate(Sender: TObject);
begin
// Label1.Caption:='SubSeven '+StringClientVersion;
// Label4.Caption:=Label4.Caption+MainForm.Decrypt2(DedicatedTo);
 try
 with Image1.Canvas do
  begin
   Brush.Color:=clBlack;
   Brush.Style:=bsSolid;
   FillRect(bounds(0,0,intro.width,intro.height));
  end;
 Intro.Height:=357;
 Intro.Width:=405;
 with Image1.Canvas do
  begin
   Brush.Style:=bsSolid;
   Brush.Color:=clBlack;
   Draw(0,0,image2.picture.graphic);
   Draw(202,0,image3.picture.graphic);
  end;
 X:=2;
// Image1.Visible:=True;
 except end;
end;

procedure TIntro.Timer1Timer(Sender: TObject);
begin
if X>=202 then begin
 with Image1.Canvas do
  begin
   Draw(0,0,BackBMP);
   Draw(202-x,0,image2.picture.graphic);
   Draw(x,0,image3.picture.graphic);
  end;end else with Intro.canvas do begin
   Draw(0,0,Image1.Picture.Graphic);
   Label1.Visible:=True;
   Label2.Visible:=True;
   Label3.Visible:=True;
   Label4.Visible:=True;
   timer1.enabled:=false;
   exit;
  end;
 Intro.Canvas.Draw(0,0,Image1.Picture.Graphic);
 inc(x,15);if 220-x<-image2.width then close;
end;

procedure TIntro.Go;
begin
 Label1.Visible:=False;
 Label2.Visible:=False;
 Label3.Visible:=False;
 Label4.Visible:=False;
 MainForm.Show;
 BackBMP.Height:=358;
 BackBMP.Width:=405;
end;

procedure TIntro.FormClick(Sender: TObject);
begin
 if x>=220 then close;
 x:=220;
 Timer1.Interval:=50;
 timer1.enabled:=true;
 Go;
end;

procedure TIntro.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 Hide;
 BackBMP.Free;
 Destroy;
end;

procedure TIntro.Label2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then MainForm.Close;
end;

procedure TIntro.FormShow(Sender: TObject);
begin
 FormCreate(sender);
end;

end.
