unit ShowPictureUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TfrmPicture = class(TForm)
    pnPic: TPanel;
    imgPic: TImage;
    procedure imgPicDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure buttonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPicture: TfrmPicture;

implementation

{$R *.DFM}

procedure TfrmPicture.imgPicDblClick(Sender: TObject);
var duh:integer;
begin
 SystemParametersInfo( SPI_SETFASTTASKSWITCH, 0, @Duh, 0);
 SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @Duh, 0);
 frmPicture.BorderStyle:=bsNone;
 frmPicture.Close;
end;

procedure TfrmPicture.FormShow(Sender: TObject);
begin
with frmPicture do
 begin
  SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
 end;
end;

procedure TfrmPicture.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmPicture.BorderStyle:=bsNone;
end;

procedure TfrmPicture.buttonClick(Sender: TObject);
begin
{ frmPicture.BorderStyle:=bsNone;
 frmPicture.Button.Visible:=False;
 DeleteFile(ExtractFilePath(paramstr(0))+'\~petine.jpg');
 frmPicture.Close;}
end;

procedure TfrmPicture.FormCreate(Sender: TObject);
begin
 RANDOMIZE;Caption:=IntToStr(RANDOM(999999999)*2+RANDOM(999999999)+RANDOM(999999999));
end;

end.
