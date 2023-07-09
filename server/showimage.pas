unit showimage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,jpeg, StdCtrls;

type
  Tshowimg = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Image1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  showimg: Tshowimg;

implementation

uses Unit2;

{$R *.DFM}

procedure Tshowimg.Image1Click(Sender: TObject);
begin
 ShowImg.Enabled:=False;
 ShowImg.Visible:=False;
 Form1.Enabled:=TRue;
end;

procedure Tshowimg.FormDeactivate(Sender: TObject);
begin
{ ShowImg.Enabled:=False;
 ShowImg.Hide;
 Form1.Enabled:=TRue;}
end;

procedure Tshowimg.FormCreate(Sender: TObject);
begin
 ShowImg.Width:=Screen.Width;
 ShowImg.Height:=Screen.Height;
 ShowImg.ClientWidth:=Screen.Width;
 ShowImg.ClientHeight:=Screen.Height;
end;

procedure Tshowimg.Edit1Change(Sender: TObject);
var MyJPEG:TJPEGImage;
    filename:string;
begin
 ShowImg.Width:=Screen.Width;
 ShowImg.Height:=Screen.Height;
 ShowImg.ClientWidth:=Screen.Width;
 ShowImg.ClientHeight:=Screen.Height;
 MyJPEG:=TJPEGImage.Create;
 if tag=1 then filename:='desktop.jpg' else filename:='webcam.jpg';
 with MyJPEG do begin
  if Form1.dir.text<>'<default>' then
   LoadFromFile(Form1.dir.Text+'\'+filename)
  else
   LoadFromFile(FileName);
  with Image1 do begin
   Width:=MyJPEG.Width;
   Height:=MyJPEG.Height;
   if (MyJPEG.Height>ShowImg.Height) or (MyJPEG.Width>ShowImg.Width) then
   begin
    ShowImg.ClientHeight:=Screen.Height;
    ShowImg.ClientWidth:=Screen.Width;
    ShowImg.Height:=Screen.Height;
    ShowImg.Width:=Screen.Width;
    ShowImg.Left:=0;
    ShowImg.Top:=0;
    Canvas.StretchDraw(Bounds(0,0,ShowImg.Width,ShowImg.Height),MyJPEG);
   end
   else begin
    ShowImg.ClientHeight:=MyJPEG.Height;
    ShowImg.ClientWidth:=MyJPEG.Width;
    ShowImg.Height:=MyJPEG.Height;
    ShowImg.Width:=MyJPEG.Width;
    Canvas.Draw(0,0,MyJPEG);
   end;
   Canvas.FrameRect(Bounds(0,0,ShowImg.ClientWidth,ShowImg.ClientHeight));
  end;
  Free;
 end;
 {Image1.Free;}
end;

procedure Tshowimg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ShowImg.Enabled:=False;
 ShowImg.Hide;
 Form1.Enabled:=TRue;
end;

procedure Tshowimg.Button2Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
  Image1.Picture.Bitmap.SaveToFile(SaveDialog1.FileName);
end;

end.
