unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TDesktop = class(TForm)
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Desktop: TDesktop;

implementation

{$R *.DFM}

procedure TDesktop.FormClick(Sender: TObject);
begin
 Desktop.Enabled:=False;
 Desktop.Visible:=False;
end;

end.
