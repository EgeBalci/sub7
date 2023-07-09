unit nonstopUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ScktComp, ComCtrls, RXSpin;

type
  TnonstopForm = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    ClientSocket1: TClientSocket;
    pro: TProgressBar;
    lab: TLabel;
    RxSpinEdit1: TRxSpinEdit;
    doitnow: TTimer;
    Bevel2: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure CheckBox1Click(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure doitnowTimer(Sender: TObject);
  private
    procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  nonstopForm: TnonstopForm;
  receiving:boolean;
  qual:string;
implementation

uses Unit2;

{$R *.DFM}

procedure TnonstopForm.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;                    { call the inherited message handler }
  if  M.Result = htClient then  { is the click in the client area?   }
    M.Result := htCaption;      { if so, make Windows think it's     }
                                { on the caption bar.                }
end;

procedure TnonstopForm.Button1Click(Sender: TObject);
begin
 hide;
 Form1.FullCapture;
end;

procedure TnonstopForm.Button2Click(Sender: TObject);
begin
 checkbox1.checked:=false;
 ClientSocket1.Active:=False;
 Form1.ClientSocket.Socket.SendText('CL2');
 hide;
end;

procedure TnonstopForm.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var Stream:TMemoryStream;
    nReceived,totalrecv,total,no,i: Integer;
    undesalveaza,StrIn,totalbytes:String;
    evreuna:boolean;
begin
  if receiving then exit;
  if form1.dir.text='<default>' then undesalveaza:='' else undesalveaza:=form1.dir.text+'\';
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)='PRV' then evreuna:=true;
  if not evreuna then exit;
  receiving:=true;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Buffer, 1);
    strIn := Copy (Buffer, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 pro.max:=total;
 pro.min:=0;
 pro.position:=0;
 Stream := TMemoryStream.Create;
 totalrecv:=0;
{ showmessage('receiving...'+totalbytes);}
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
    pro.position:=totalrecv;
   end;
  end;
  Stream.Position := 0;
  Stream.SaveToFile(undesalveaza+'preview.jpg');
  Image1.Picture.LoadFromFile(undesalveaza+'preview.jpg');
 finally
  Stream.Free;
  receiving:=false;
 end;
 pro.position:=0;
 qual:=Form1.ReadIni('Options','PrevQuality');
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 if qual='ERROR' then qual:='040';
 doitnow.enabled:=true;
end;

procedure TnonstopForm.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then begin
 doitnow.interval:=round(rxspinedit1.value*1000);
 Form1.ClientSocket.Socket.SendText('IN2');
 lab.visible:=true;
{ sleep(2000);}
 ClientSocket1.Port:=2772;
 ClientSocket1.Address:=Form1.ClientSocket.Address;
 try ClientSocket1.Active:=True;except lab.visible:=false;showmessage('error connecting for preview');checkbox1.checked:=false;end;
{ sleep(2000);}
{ ClientSocket1.Socket.SendText('DOIT');}
end else begin
 ClientSocket1.Active:=False;
 Form1.ClientSocket.Socket.SendText('CL2');
end;
end;

procedure TnonstopForm.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
var x,y:string;  
begin
 qual:=Form1.ReadIni('Options','PrevQuality');
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 if qual='ERROR' then qual:='040';
 if length(qual)=1 then qual:='00'+qual else
  if length(qual)=2 then qual:='0'+qual;
 x:=IntToStr(Image1.Width);
 y:=IntToStr(Image1.Height);
 if length(x)=1 then x:='000'+x
  else if length(x)=2 then x:='00'+x
   else if length(x)=3 then x:='0'+x;
 if length(y)=1 then y:='000'+y
  else if length(y)=2 then y:='00'+y
   else if length(y)=3 then y:='0'+y;
 ClientSocket1.Socket.SendText('DOIT'+qual);
 lab.visible:=false;
 pro.visible:=true;
end;

procedure TnonstopForm.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
checkbox1.checked:=false;
pro.visible:=false;
end;

procedure TnonstopForm.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
showmessage('error connecting for preview');
checkbox1.checked:=false;
end;

procedure TnonstopForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 checkbox1.checked:=false;
 ClientSocket1.Active:=False;
 Form1.ClientSocket.Socket.SendText('CL2');
{ hide;}
end;

procedure TnonstopForm.RxSpinEdit1Change(Sender: TObject);
begin
 doitnow.interval:=round(rxspinedit1.value*1000);
end;

procedure TnonstopForm.FormCreate(Sender: TObject);
begin
 doitnow.interval:=0;
end;

procedure TnonstopForm.doitnowTimer(Sender: TObject);
var x,y:string;
begin
 if length(qual)=1 then qual:='00'+qual else
  if length(qual)=2 then qual:='0'+qual;
 x:=IntToStr(Image1.Width);
 y:=IntToStr(Image1.Height);
 if length(x)=1 then x:='000'+x
  else if length(x)=2 then x:='00'+x
   else if length(x)=3 then x:='0'+x;
 if length(y)=1 then y:='000'+y
  else if length(y)=2 then y:='00'+y
   else if length(y)=3 then y:='0'+y;
 ClientSocket1.socket.SendText('DOIT'+qual+x+y);
 doitnow.enabled:=false;
end;

end.
  