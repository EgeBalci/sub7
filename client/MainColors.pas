unit MainColors;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

 var cMenuBackground,
     cMenuPageNormalText,
     cMenuPageNormalBorder,
     cMenuPageSelectedBorder,
     cMenuItemNormalText,
     cMenuItemNormalBorder,
     cMenuItemSelectedText,
     cMenuArrows,
     cFormLine,
     cFormBackground,
     cFormForeground,
     cFormCaption,
     cFormText,
     cButtonText,
     cButtonBorder,
     cButtonOverFill,
     cButtonClickFill
     :TColor;
     ArataHinturi:boolean;
     
procedure SetDefaultColors;

implementation

procedure SetDefaultColors;
begin
 cMenuBackground:=clBlack;
 cMenuPageNormalText:=$00FF8000;
 cMenuPageNormalBorder:=$00C08000;
 cMenuPageSelectedBorder:=clWhite;
 cMenuItemNormalText:=$00C08080;
 cMenuItemNormalBorder:=$00FF8080;
 cMenuItemSelectedText:=clWhite;
 cMenuArrows:=clWhite;
 cFormLine:=clGray;
 cFormBackGround:=clBlack;
 cFormCaption:=$00FF8080;
 cFormText:=clWhite;
 cButtonText:=clWhite;
 cButtonBorder:={clNavy}$00FF8080;
 cButtonOverFill:=clNavy;
 cButtonClickFill:=$00FF8080;
 cFormForeGround:=$00804000;
end;

begin
 SetDefaultColors;
 ArataHinturi:=True;
end.

