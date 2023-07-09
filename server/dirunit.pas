unit dirunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, INIFiles;

type
  TGetFol = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DirectoryListBox1: TDirectoryListBox;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  GetFol: TGetFol;

implementation

uses Unit2, OptionsUnit;

{$R *.DFM}
Procedure SaveIni(INISection,INIVar,INIVal:String);
var MyIni: TIniFile;
begin;
 MyIni := TIniFile.Create('subseven.ini');
 with MyIni do WriteString(INISection,INIVar,INIVal);
 MyIni.Free;
end;

procedure TGetFol.Button2Click(Sender: TObject);
begin
 GetFol.Hide;
 Form1.Enabled:=True;
 GetFol.Enabled:=False;
 Form1.dir.Text:=DirectoryListBox1.Directory;
 OptionsForm.dir2.caption:=form1.dir.text;
 SaveINI('Options','SaveToDir',DirectoryListBox1.Directory);
end;

procedure TGetFol.Button1Click(Sender: TObject);
begin
 GetFol.Hide;
 Form1.Enabled:=True;
 GetFol.Enabled:=False;
end;

procedure TGetFol.Button3Click(Sender: TObject);
begin
 GetFol.Hide;
 Form1.Enabled:=True;
 GetFol.Enabled:=False;
 Form1.dir.Text:=ExtractFilePath(ParamStr(0));
 OptionsForm.dir2.caption:=form1.dir.text;
 SaveINI('Options','SaveToDir',form1.dir.text);
end;

procedure TGetFol.Button4Click(Sender: TObject);
var str:string;
begin
 if InputQuery('create new folder', 'folder name: ', Str) then
  begin
   MkDir(str);
   DirectoryListBox1.Update;
  end;
end;

end.
