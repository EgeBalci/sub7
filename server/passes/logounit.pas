unit logounit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlogoform = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  logoform: Tlogoform;

implementation

{$R *.DFM}

end.
