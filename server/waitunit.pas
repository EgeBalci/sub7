unit waitunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls, ExtCtrls;

type
  Twaitform = class(TForm)
    Label1: TLabel;
    progr1: TGauge;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  waitform: Twaitform;

implementation

{$R *.DFM}

end.
