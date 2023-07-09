unit PopKeyHookUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPopKeyHook = class(TForm)
    KeyHook: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PopKeyHook: TPopKeyHook;

implementation

{$R *.DFM}

end.
