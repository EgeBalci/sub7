unit SetSoundUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TSetSoundForm = class(TForm)
    WaveLabel: TLabel;
    SynthLabel: TLabel;
    CDLabel: TLabel;
    WaveBar: TTrackBar;
    SynthBar: TTrackBar;
    CDBar: TTrackBar;
    Button1: TButton;
    stat: TLabel;
    procedure FormShow(Sender: TObject);
    procedure WaveBarChange(Sender: TObject);
    procedure SynthBarChange(Sender: TObject);
    procedure CDBarChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetSoundForm: TSetSoundForm;

implementation

uses Unit2;

{$R *.DFM}

procedure TSetSoundForm.FormShow(Sender: TObject);
begin
 stat.caption:='reading settings...hold on.';
end;

procedure TSetSoundForm.WaveBarChange(Sender: TObject);
begin
 Stat.Caption:='setting wave volume...';
 Form1.ClientSocket.Socket.SendText('SVT1'+IntToStr(WaveBar.Position));
end;

procedure TSetSoundForm.SynthBarChange(Sender: TObject);
begin
 Stat.Caption:='setting synth volume...';
 Form1.ClientSocket.Socket.SendText('SVT2'+IntToStr(SynthBar.Position));
end;

procedure TSetSoundForm.CDBarChange(Sender: TObject);
begin
 Stat.Caption:='setting CD volume...';
 Form1.ClientSocket.Socket.SendText('SVT3'+IntToStr(CDBar.Position));
end;

procedure TSetSoundForm.Button1Click(Sender: TObject);
begin
 Hide;
end;

end.
