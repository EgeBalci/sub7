unit ShowImgUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, Jpeg;

type
  TShowImg = class(TForm)
    myShape: TShape;
    CloseButton: TFlatSpeedButton;
    SaveButton: TFlatSpeedButton;
    SaveDialog1: TSaveDialog;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    procedure LoadITFrom(fn: string);
    procedure LoadIT;
    procedure SetTheColors;
  end;

var
  ShowImg: TShowImg;

implementation

uses MainUnit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TShowImg.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with ShowImg,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with ShowImg,msg do begin
  if (Merge(xpos,ypos ,Left         ,top+Corner        ,left+Offset       ,top+height-Corner)) then Result := htLeft;
  if (Merge(xpos,ypos ,Left+width-Offset ,top+Corner        ,left+width   ,top+height-Corner)) then Result := htRight;
  if (Merge(xpos,ypos ,Left+Corner       ,top          ,left+width-Corner ,top+Offset       )) then Result := htTop;
  if (Merge(xpos,ypos ,Left+Corner       ,top+height-Offset ,left+width-Corner ,top+height  )) then Result := htBottom;
  if (Merge(xpos,ypos ,Left,Top,Left+Corner,Top+Corner)) then Result:=htTopLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top,Left+Width,Top+Corner)) then Result:=htTopRight;
  if (Merge(xpos,ypos ,Left,Top+Height-Corner,Left+Corner,Top+Height)) then REsult:=htBottomLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top+Height-Corner,Left+Width,Top+Height)) then Result:=htBottomRight;
{  if (Merge(xpos,ypos ,Left+CaptionLabel.Left,Top+CaptionLabel.Top,Left+CaptionLabel.Left+CaptionLabel.Width,Top+CaptionLabel.Top+CaptionLabel.Height)) then Result:=htCaption;}
 end;
end;

procedure TShowImg.SetTheColors;
begin
 myShape.Brush.Color:=cFormBackground;
 myShape.Pen.Color:=cFormLine;
 with CloseButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
 end;
 with SaveButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
 end;
 Invalidate;
end;

procedure TShowImg.FormCreate(Sender: TObject);
begin
 SetTheColors;
end;

procedure TShowImg.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TShowImg.SaveButtonClick(Sender: TObject);
var jpg:TJpegImage;
begin
 if not SaveDialog1.Execute then exit;
 jpg:=TJpegImage.Create;
 jpg.LoadFromFile(MainForm.DownloadFolder+'desktop.jpg');
 jpg.SaveToFile(SaveDialog1.Filename);
 MainForm.ShowMsg('image saved.');
 jpg.free;
end;

procedure TShowImg.LoadIT;
var jpg:TJpegImage;
begin
 jpg:=TJpegImage.Create;
 jpg.LoadFromFile(MainForm.DownloadFolder+'desktop.jpg');
 if (jpg.Width<=Screen.Width) then ShowImg.Width:=jpg.Width else ShowImg.Width:=Screen.Width;
 if (jpg.Height<=Screen.Height) then ShowImg.Height:=jpg.Height else ShowImg.Height:=Screen.Height;
 ShowImg.Left:=(Screen.Width-ShowImg.Width) div 2;
 ShowImg.Top:=(Screen.Height-ShowImg.Height) div 2;
 Image1.Left:=0;Image1.Top:=0;Image1.Width:=jpg.Width;Image1.Height:=jpg.Height;
 Image1.Picture.Bitmap.Assign(jpg);
 jpg.Free;
end;

procedure TShowImg.LoadITFrom(fn:string);
begin
 {Image1.Width:=0;Image1.Height:=0;}
 try Image1.Picture.LoadFromFile(fn);except end;
 if (Image1.Picture.Width<=Screen.Width) then
  ShowImg.Width:=Image1.Picture.Width+6 else
   begin
    HorzScrollBar.Visible:=True;
    ShowImg.Width:=Screen.Width;
   end;
 if (Image1.Picture.Height<=Screen.Height) then ShowImg.Height:=Image1.Picture.Height+6 else begin VertScrollBar.Visible:=True;ShowImg.Height:=Screen.Height;end;
 ShowImg.Left:=(Screen.Width-ShowImg.Width) div 2;
 ShowImg.Top:=(Screen.Height-ShowImg.Height) div 2;
 Image1.Width:=Image1.Picture.Width;Image1.Height:=Image1.Picture.Height;
{ Image1.Left:=3;Image1.Top:=3;}
end;

procedure TShowImg.Image1DblClick(Sender: TObject);
begin
 hide;
end;

procedure TShowImg.FormHide(Sender: TObject);
begin
 BorderStyle:=bsNone;
 SaveButton.Visible:=True;
 CloseButton.Visible:=True;
 VertScrollBar.Visible:=False;
 HorzScrollBar.Visible:=False;
end;

end.
