unit OutlookBtn;

(*
  TOutlookButton - freeware button component for Inprise Delphi 2,3, and 4

  by Jury Gerasimov
  jury@gera.irk.ru
  http://gera.irk.ru
 
This is a button that can have different looks:
	- as Outlook Bar button
	- as Microsoft Office toolbar button
	- as fully transparent button

The TOutlookButton component was developed for the Chameleon Clock. This is a 
digital desktop clock that changes its skin using Winamp skins and digit styles.
Its features include MP3 alarms, time synchronization with Internet Time 
Servers, random change of skins, and more. If you like TOutlookButton component 
- please support the author and download Chameleon Clock from 
http://gera.irk.ru/cham

*)

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, ExtCtrls, MainColors;

type
  BStyle = (bsNone,bsNormal,bsMSOffice,bsOutlook);
  TOutlookBtn = class(TGraphicControl)
  private
    FBitmap : TBitmap;
    fMouseOver : Boolean;
    Pushed : boolean;
    fStyle : BStyle;
    BRect : Trect;
    fChecked : boolean;
    fCaption : string;
    procedure SetChecked(Value : boolean);
    procedure SetBitmap(Value : TBitmap);
    procedure SetCaption(Value : string);
    procedure WMLButtonDown(var msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function OnGlyphP(X, Y: integer): boolean;
    procedure mouseleave(var msg : tmessage); message cm_mouseleave;
    procedure mousein(var msg : tmessage); message cm_mouseenter;
    procedure setStylestyle(value:Bstyle);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure DrawTransparentBitmap (ahdc: HDC; Image: TBitmap; xStart, yStart: Word; TrCol : Tcolor);
    property Bitmap : TBitmap read FBitmap write SetBitmap;
    Property OnClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property Visible;
    property PopUpMenu;
    Property Hint;
    Property ShowHint;
    property Checked : boolean read fChecked write SetChecked;
    Property Style : BStyle read fStyle write SetStyleStyle;
    Property Caption : string read fCaption write SetCaption;
    Property Font;
    Property Anchors;
  end;

procedure Register;

implementation
uses mainunit;
constructor TOutlookBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 30;
  Height := 30;
  FBitmap := TBitmap.Create;
  ControlStyle := ControlStyle - [csOpaque];
  Pushed := false;
  Font.name := 'MS Sans Serif';
  Font.size := 8;
  fStyle := bsNormal;
  fCaption := Name;
end;

destructor TOutlookBtn.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TOutlookBtn.SetChecked(Value : boolean);
begin
  if fChecked <> value then
  begin
    fChecked := value;
    invalidate;
  end;
end;

procedure TOutlookBtn.SetBitmap(Value : TBitmap);
begin
  FBitmap.Assign(Value);
  invalidate;
end;

{this routine come from unit XparBmp of Michael Vincze (vincze@ti.com), I think it can be
optimized more. Will find time to check it again}
procedure TOutlookBtn.DrawTransparentBitmap (ahdc: HDC; Image: TBitmap; xStart, yStart: Word; TrCol : Tcolor);
var
  TransparentColor: TColor;
  cColor          : TColorRef;
  bmAndBack,
  bmAndObject,
  bmAndMem,
  bmSave,
  bmBackOld,
  bmObjectOld,
  bmMemOld,
  bmSaveOld       : HBitmap;
  hdcMem,
  hdcBack,
  hdcObject,
  hdcTemp,
  hdcSave         : HDC;
  ptSize          : TPoint;
begin
TransparentColor := TrCol;
TransparentColor := TransparentColor or $02000000;

hdcTemp := CreateCompatibleDC (ahdc);
SelectObject (hdcTemp, Image.Handle); { select the Bitmap }
ptSize.x := Image.Width;
ptSize.y := Image.Height;
DPtoLP (hdcTemp, ptSize, 1);  { convert from device logical points }
hdcBack   := CreateCompatibleDC(ahdc);
hdcObject := CreateCompatibleDC(ahdc);
hdcMem    := CreateCompatibleDC(ahdc);
hdcSave   := CreateCompatibleDC(ahdc);

bmAndBack   := CreateBitmap (ptSize.x, ptSize.y, 1, 1, nil);
bmAndObject := CreateBitmap (ptSize.x, ptSize.y, 1, 1, nil);

bmAndMem    := CreateCompatibleBitmap (ahdc, ptSize.x, ptSize.y);
bmSave      := CreateCompatibleBitmap (ahdc, ptSize.x, ptSize.y);

bmBackOld   := SelectObject (hdcBack, bmAndBack);
bmObjectOld := SelectObject (hdcObject, bmAndObject);
bmMemOld    := SelectObject (hdcMem, bmAndMem);
bmSaveOld   := SelectObject (hdcSave, bmSave);

SetMapMode (hdcTemp, GetMapMode (ahdc));
BitBlt (hdcSave, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY);
cColor := SetBkColor (hdcTemp, TransparentColor);
BitBlt (hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY);

SetBkColor (hdcTemp, cColor);
BitBlt (hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY);

BitBlt (hdcMem, 0, 0, ptSize.x, ptSize.y, ahdc, xStart, yStart, SRCCOPY);
BitBlt (hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND);
BitBlt (hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcBack, 0, 0, SRCAND);
BitBlt (hdcMem, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCPAINT);
BitBlt (ahdc, xStart, yStart, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY);
BitBlt (hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcSave, 0, 0, SRCCOPY);
DeleteObject (SelectObject (hdcBack, bmBackOld));
DeleteObject (SelectObject (hdcObject, bmObjectOld));
DeleteObject (SelectObject (hdcMem, bmMemOld));
DeleteObject (SelectObject (hdcSave, bmSaveOld));
DeleteDC (hdcMem);
DeleteDC (hdcBack);
DeleteDC (hdcObject);
DeleteDC (hdcSave);
DeleteDC (hdcTemp);
end;

procedure TOutlookBtn.setStylestyle(value:Bstyle);
begin
if fStyle <> value then
 begin
  fStyle := value;
  Invalidate;
 end;
end;

procedure TOutlookBtn.SetCaption(Value : string);
begin
if FCaption <> value then
 begin
  FCaption := value;
  Invalidate;
 end;
end;

procedure TOutlookBtn.Paint;
var
  ARect: TRect;
  Tmp : TBitmap;
  x,y : integer;
  text : array[0..40] of char;
  Fontheight : integer;
  i,j:integer;
begin
ARect := Rect(0,0,Width,Height);
{if fMouseOver and (fStyle = bsOutlook) then
begin
  canvas.brush.color := clBtnFace;
  canvas.FillRect(ARect);
end;}

Canvas.font := font;

if MainForm.ButtonFontName<>'' then Canvas.font.Name := MainForm.ButtonFontName;
if MainForm.ButtonFontSize<>0 then Canvas.font.Size := MainForm.ButtonFontSize;
if MainForm.ButtonFontAttr<>'' then
 begin
  if MainForm.ButtonFontAttr[1]='1' then Canvas.font.Style := Canvas.font.Style+[fsBold];
  if MainForm.ButtonFontAttr[2]='1' then Canvas.font.Style := Canvas.font.Style+[fsItalic];
  if MainForm.ButtonFontAttr[3]='1' then Canvas.font.Style := Canvas.font.Style+[fsUnderline];
  if MainForm.ButtonFontAttr[4]='1' then Canvas.font.Style := Canvas.font.Style+[fsStrikeout];
 end;
if fMouseOver and (fStyle = bsOutlook) then
  Canvas.font.color := clBtnText;

FontHeight := Canvas.TextHeight('W');
if not FBitmap.empty then
  begin
  x := (width - FBitmap.width) div 2;
  if caption <> '' then
    y := ((Height - FBitmap.Height- FontHeight) div 2)
  else
   y := ((Height - FBitmap.Height) div 2);
     BRect := rect(x, y, x + FBitmap.width, y + FBitmap.height);
     Tmp := TBitmap.Create;
     Tmp.Height := FBitmap.Height;
     Tmp.Width := FBitmap.Width;
     Tmp.Canvas.CopyRect(ARect, FBitmap.Canvas, ARect);
     if pushed then
      DrawTransparentBitmap( Canvas.Handle, Tmp, x +1, y+1, FBitmap.TransparentColor )
     else
      DrawTransparentBitmap( Canvas.Handle, Tmp, x, y, FBitmap.TransparentColor );
     Tmp.Free;
  end;


 ARect := getclientrect;
 with ARect do begin Inc(Left);Inc(Top);Dec(Right);Dec(Bottom);end;
{            Canvas.Brush.Color:=clNavy;}
  canvas.Pen.Color:=cButtonBorder;
  canvas.Brush.Style:=bsClear;
  canvas.Brush.Color:=cButtonBorder;

  (*canvas.FrameRect(ARect);*)

 for j:=1 to (Height div 10)+2 do
  for i:=1 to (Width div 10)+1 do
   if pushed then Canvas.CopyRect(bounds((i-1)*10,(j-1)*10,10,10),MainForm.bit_btn_fill.canvas,bounds(23,1,10,10))
    else if fMouseOver then Canvas.CopyRect(bounds((i-1)*10,(j-1)*10,10,10),MainForm.bit_btn_fill.canvas,bounds(12,1,10,10))
     else Canvas.CopyRect(bounds((i-1)*10,(j-1)*10,10,10),MainForm.bit_btn_fill.canvas,bounds(1,1,10,10));


  canvas.CopyRect(bounds(0,0,5,5),MainForm.bit_button.Canvas,bounds(1,1,5,5));
  canvas.CopyRect(bounds(Width-5,0,5,5),MainForm.bit_button.Canvas,bounds(9,1,5,5));

  canvas.CopyRect(bounds(0,Height-5,5,5),MainForm.bit_button.Canvas,bounds(1,9,5,5));
  canvas.CopyRect(bounds(Width-5,Height-5,5,5),MainForm.bit_button.Canvas,bounds(9,9,5,5));

  for i:=5 to Width-5 do
  begin
   Canvas.CopyRect(bounds(i,0,1,5),MainForm.bit_button.Canvas,bounds(7,1,1,5));
   Canvas.CopyRect(bounds(i,height-5,1,5),MainForm.bit_button.Canvas,bounds(7,9,1,5));
  end;
  for i:=5 to Height-5 do
  begin
   Canvas.CopyRect(bounds(0,i,5,1),MainForm.bit_button.Canvas,bounds(1,7,5,1));
   Canvas.CopyRect(bounds(width-5,i,5,1),MainForm.bit_button.Canvas,bounds(9,7,5,1));
  end;

 with ARect do begin Inc(Left);Inc(Top);Dec(Right);Dec(Bottom);end;
 with ARect do begin Inc(Left);Inc(Top);Dec(Right);Dec(Bottom);end;
{ with ARect do begin Dec(Left);Dec(Top);Inc(Right);Inc(Bottom);end;}
 canvas.Brush.Style:=bsSolid;
(* case fStyle of
 bsMSOffice :  Begin

         if pushed then
         begin
            Canvas.Brush.Color:={StringToColor('$00FF8080')}cButtonClickFill;
            canvas.FillRect(ARect);
         end
         else
          if fMouseOver then
         begin
            Canvas.Brush.Color:=cButtonOverFill;
            canvas.FillRect(ARect);
         end
         end;
 end; { case}

  *)
  if caption <> '' then
  with Canvas do
  begin
   if fChecked then
   begin
     Brush.Style := bsSolid;
     Brush.Color := clBtnFace;
     Font.Color := cButtonText;
   end
   else
     Brush.Style := bsClear;
   with ARect do
    begin
     if FBitmap.empty then
       Top := ((Bottom + Top) - FontHeight) shr 1
     else
       top := Brect. bottom+3;
      Bottom := Top + FontHeight;
      if pushed then
        begin
         top := top + 1;
         left := 2;
        end;
    end;
    StrPCopy(Text, Caption);
    Pen.Color:=cButtonText;
    {Brush.Color:=cButtonText;}
    Font.Color:=cButtonText;
    DrawText(Handle, Text, StrLen(Text), ARect, (DT_EXPANDTABS or DT_center));
   end;

end;


function TOutlookBtn.OnGlyphP(X, Y: integer): boolean;
begin
  Result := PtInRect({ClientRect} BRect, Point(X, Y)) and
            (FBitmap.Canvas.Pixels[X, Y] <> FBitmap.TransparentColor);
end;

procedure TOutlookBtn.MouseMove(Shift: TShiftState; X, Y: Integer);

begin
  fMouseOver := (fStyle = bsNormal) or (fStyle = bsMSOffice) or (fStyle = bsOutlook) or  OnGlyphP(X, Y);
  Inherited MouseMove(Shift, X, Y);
end;

procedure TOutlookBtn.mouseleave(var msg : tmessage);
var  rc : Trect;
BEGIN
  fMouseOver := false;
  rc := getclientrect;
  if (fStyle = bsMSOffice) or (fStyle = bsOutlook) then
    INVALIDATE;
END;

procedure TOutlookBtn.mousein(var msg : tmessage);
var  rc : Trect;
BEGIN
  fMouseOver := true;
  rc := getclientrect;
  if (fStyle = bsMSOffice) or (fStyle = bsOutlook) then
    INVALIDATE;
END;

procedure TOutlookBtn.WMLButtonDown;
begin
 inherited;
  Pushed := True;

  if pushed then
     invalidate;
end;

procedure TOutlookBtn.WMLButtonUp;
var
 p : TPoint;
begin
 inherited;

 GetCursorPos(p);
 fMouseOver := PtInRect(BoundsRect, ScreenToClient(p));

 Pushed := false;
 if Pushed = false then
   invalidate;
end;

procedure Register;
begin
  RegisterComponents('Custom', [TOutlookBtn]);
end;

end.
