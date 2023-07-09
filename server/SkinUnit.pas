unit SkinUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSkinForm = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowSkin(Care: Integer);
    { Public declarations }
  end;

var
  SkinForm: TSkinForm;

implementation

uses Unit2, Unit23;

{$R *.DFM}

procedure AddStuff(SubString:String);
var SearchRec:TSearchRec;
    name:string;
    bmp:TBitmap;
begin
 if FindFirst(ExtractFilePath(paramstr(0))+'skins\*.bmp',faAnyFile,SearchRec)=0 then
  repeat
{   if (SearchRec.Attr and faDirectory)<>0 then}
    begin
     name:=SearchRec.Name;
     if UpperCase(copy(name,1,length(SubString)))=UpperCase(SubString) then
      begin
       bmp:=TBitmap.Create;
       bmp.LoadFromFile(ExtractFilePath(paramstr(0))+'skins\'+SearchRec.Name);
       if SkinForm.tag=1 then
        begin
         if (bmp.Height=459) and (bmp.Width=546) then
          SkinForm.ListBox1.Items.Add(Copy(Name,length(SubString)+2,length(name)-8))
         else ShowMessage('error reading ['+SearchRec.Name+']. invalid size. [has to be 546x459]');
        end;
       if SkinForm.tag=2 then
        begin
         if (bmp.Height=280) and (bmp.Width=300) then
          SkinForm.ListBox1.Items.Add(Copy(Name,length(SubString)+2,length(name)-8))
         else ShowMessage('error reading ['+SearchRec.Name+']. invalid size. [has to be 300x280]');
        end;
       bmp.Free;
      end;
    end;
  until FindNext(SearchRec)>0;
end;


procedure TSkinForm.ShowSkin(Care:Integer);
var BMPString:String;
begin
 BMPString:='S7'+IntToStr(Care);
 Tag:=Care;
 ListBox1.Clear;
 AddStuff(BMPString);
 if ListBox1.Items.Count=0 then ListBox1.Items.Add('<no skins found>');
end;

procedure TSkinForm.Button3Click(Sender: TObject);
begin
 ModalResult:=1;
end;

procedure TSkinForm.Button2Click(Sender: TObject);
begin
 if Tag=1 then
 begin
  Form1.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_2');
  Form1.SaveINI('Options','MainBitmap','<default>');
 end else
 begin
  Form3.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_3');
  Form1.SaveINI('Options','FunMBitmap','<default>');
 end;
 ModalResult:=1;
end;

procedure TSkinForm.Button1Click(Sender: TObject);
var filename:string;
begin
  filename:=ExtractFilePath(paramstr(0))+'Skins\S7'+IntToStr(TAG)+'_'+ListBox1.Items[ListBox1.ItemIndex]+'.bmp';
  if TAG=1 then
   try Form1.Image1.Picture.Bitmap.LoadFromFile(filename); Form1.SaveINI('Options','MainBitmap',FileName); except showmessage('error reading: '+filename);end
  else
   try Form3.Image1.Picture.Bitmap.LoadFromFile(filename); Form1.SaveINI('Options','FunMBitmap',FileName); except showmessage('error reading: '+filename);end;
 ModalResult:=1;
end;

end.
