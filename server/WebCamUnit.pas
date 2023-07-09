unit WebCamUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ScktComp, ComCtrls, RXSpin;

type
  Twebcamform = class(TForm)
    websock: TClientSocket;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure websockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure websockConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure TrackBar1Change(Sender: TObject);
  private
    capturing:Boolean;
    procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
    procedure ActivateLive;
    procedure DeActivateLive;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  webcamform: Twebcamform;
  receiving:boolean;
implementation

uses Unit2;

{$R *.DFM}

procedure Twebcamform.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;                    { call the inherited message handler }
  if  M.Result = htClient then  { is the click in the client area?   }
    M.Result := htCaption;      { if so, make Windows think it's     }
                                { on the caption bar.                }
end;

procedure Twebcamform.FormShow(Sender: TObject);
begin
 capturing:=false;
end;

procedure TWebCamForm.ActivateLive;
begin
 capturing:=true;
 button1.caption:='stop live capture';
 Form1.ClientSocket.Socket.SendText('IN7');
 websock.port:=2777;
 websock.address:=Form1.ClientSocket.Address;
 try websock.Active:=True;except showmessage('error connecting for preview');DeActivateLive;exit;end;
end;

procedure TWebCamForm.DeActivateLive;
begin
 capturing:=false;
 button1.caption:='start live capture';
 Form1.ClientSocket.Socket.SendText('CL7');
 try websock.Active:=False;except end;
end;

procedure Twebcamform.Button1Click(Sender: TObject);
begin
 if (not capturing) then ActivateLive else DeActivateLive;
end;

procedure Twebcamform.FormHide(Sender: TObject);
begin
 DeActivateLive;
 Hide;
end;

procedure Twebcamform.websockRead(Sender: TObject;
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
  if copy(strin,1,3)='RWC' then evreuna:=true;
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
 if total=0 then begin
  showmessage('webcam or quickcam not found or not operational.');
  DeActivateLive;
  EVreuna:=False;
  Exit;
 end; 
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
   end;
  end;
  Stream.Position := 0;
  Stream.SaveToFile(undesalveaza+'webcam.jpg');
  Image1.Picture.LoadFromFile(undesalveaza+'webcam.jpg');
 finally
  Stream.Free;
  receiving:=false;
 end;
 websock.Socket.SendText('DOWC'+IntToStr(trackbar1.position));
 webcamform.Height:=Image1.Height+85;
 webcamform.Width:=Image1.Width+25;
end;

procedure Twebcamform.websockConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 websock.Socket.SendText('DOWC'+IntToStr(trackbar1.position));
end;

procedure Twebcamform.TrackBar1Change(Sender: TObject);
begin
 label2.caption:=IntToStr(trackbar1.position)+'%';
end;

end.
