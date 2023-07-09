unit WavePlay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MMSystem;

type
  TWhereWave = (wwInFile, wwInResource, wwInRAM);
  TPlayerWave = class(TComponent)
  private
    { Private declarations }
    fWaveName: string;
    fWavePointer: pointer;
    fWhereWave: TWhereWave;
    fLoop: boolean;
    fAsync: boolean;
  protected
    { Protected declarations }
  public
    { Public declarations }
    property WavePointer: pointer read fWavePointer write fWavePointer;
    function Play: boolean;
    procedure Stop;
  published
    { Published declarations }
    property WaveName: string read fWaveName write fWaveName;
    property WhereWave: TWhereWave read fWhereWave write fWhereWave default wwInFile;
    property Loop: boolean read fLoop write fLoop;
    property Async: boolean read fAsync write fAsync;
  end;

procedure Register;

implementation

function TPlayerWave.Play;
var d: DWORD;
begin
  case fWhereWave of
    wwInFile: d := SND_FILENAME;
    wwInResource: d := SND_RESOURCE;
    wwInRAM: d := SND_MEMORY;
  end;
  if fLoop then d := d or SND_LOOP;
  if fAsync then d := d or SND_ASYNC else d := d or SND_SYNC;
  if fWhereWave = wwInRAM then
    Result := PlaySound(fWavePointer, 0, d)
  else try Result := PlaySound(PChar(fWaveName), 0, d);except end;   
end;

procedure TPlayerWave.Stop;
var d: DWORD;
begin
  case fWhereWave of
    wwInFile: d := SND_FILENAME;
    wwInResource: d := SND_RESOURCE;
    wwInRAM: d := SND_MEMORY;
  end;
  PlaySound(nil, 0, d);
end;

procedure Register;
begin
  RegisterComponents('Misc', [TPlayerWave]);
end;

end.
 