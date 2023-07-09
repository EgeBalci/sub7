unit npath;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TGetNewPath = class(TForm)
    ListDrives: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure ListDrivesEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GetNewPath: TGetNewPath;

implementation

uses Unit2;

{$R *.DFM}

procedure TGetNewPath.Button1Click(Sender: TObject);
begin
 form1.path.caption:=copy(ListDrives.Items[ListDrives.ItemIndex],1,2);
 form1.refreshfm;
 close;
end;

procedure TGetNewPath.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ Form1.Enabled:=True;
 GetNewPath.Enabled:=False;
 GetNewPath.Hide;}
end;

procedure TGetNewPath.Button2Click(Sender: TObject);
begin
close;
{ GetNewPath.Enabled:=False;
 GetNewPath.Hide;
 Form1.Enabled:=True;}
end;

procedure TGetNewPath.ListDrivesEnter(Sender: TObject);
begin
{ ListDrives.Clear;
 if Form1.dir.text<>'<default>' then
   ListDrives.Items.LoadFromFile(Form1.dir.text+'\drives.dat')
  else
   ListDrives.Items.LoadFromFile('drives.dat');}
end;

end.
