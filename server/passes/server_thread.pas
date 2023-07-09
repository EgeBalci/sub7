unit server_thread;

interface

uses
  Classes;

type
  TCursorThread = class(TThread)
  protected
    procedure Execute; override;
  end;

implementation

{ TPainterThread }

uses
  MatrixUnit, Graphics;

procedure TCursorThread.Execute;
begin
 if Matrix.ShowCursor then
   with Matrix,Matrix.Image.Canvas do begin
{    Pen.Color:=clBlack;}
    Font.Color:=clLime;
    {Font.Name:='Courier New';}
    {Font.Style:=[fsBold];
    Font.Size:=13;}
    TextOut(CursorX,CursorY,'_');
    if length(Matrix.KeepKey.Lines.Text)>=2 then
     TextOut(CursorX-LetterX,CursorY,Matrix.KeepKey.Lines.Text[length(Matrix.KeepKey.Lines.Text)]);
   end
  else  with Matrix,Matrix.Image.Canvas do
  begin
   Brush.Color:=clBlack;
   Brush.Style:=bsSolid;
   Pen.Color:=clBlack;
   FillRect(Bounds(CursorX,CursorY,CursorX+LetterX,CursorY+3));
  end;
{ ShowCursor:=not ShowCursor;}
end;

end.
