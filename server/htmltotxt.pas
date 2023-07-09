unit htmltotxt;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;
procedure HTML2TXT(var html,txt:AnsiString);

implementation


procedure sterge(var longs:Ansistring;sp:integer);
var i:integer;
begin
 for i:=sp to length(longs) do
  if longs[i]='>' then
   begin
    Delete(longs,sp,i-sp+1);
    break;
   end;
end;

procedure sterge2(var longs:Ansistring;sp:integer);
var i:integer;keepit:string;
    lp,dp,ll,dl:integer;
begin
 for i:=sp to length(longs) do
  if ((longs[i-2]='/') and (longs[i-1]='A') and (longs[i]='>')) then
   begin
    KeepIT:=copy(longs,sp,i-sp+1);
    Delete(longs,sp,i-sp+1);
    lp:=Pos('="',KeepIT)+2 ;dp:=Pos('">',KeepIT)+2;
    ll:=Pos('">',KeepIT)-lp;dl:=Pos('</',KeepIT)-dp;
    longs:=copy(longs,1,sp)+'-[URL:]['+copy(KeepIT,dp,dl)+']['+copy(KeepIT,lp,ll)+']-'+copy(longs,sp+1,length(longs));
    break;
   end;
end;
// <A href="somevalue">test</A>
procedure HTML2TXT;
var i,l1,l2,p1,p2,keep:integer;
    notfound:bool;
    ce:string;
    htmltext:Ansistring;
begin
 txt:='';
 htmltext:=html;
 repeat
  l1:=length(HTMLTEXT);
  ce:='<BR>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then
   begin
    keep:=Pos(ce,UpperCase(HTMLTEXT));
    Delete(HTMLTEXT,keep,length(ce)-1);
    HTMLTEXT:=copy(HTMLTEXT,1,keep-1)+#13#10+copy(HTMLTEXT,keep+1,length(HTMLTEXT));
   end;
  ce:='<HR>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then
   begin
    keep:=Pos(ce,UpperCase(HTMLTEXT));
    Delete(HTMLTEXT,keep,length(ce)-1);
    HTMLTEXT:=copy(HTMLTEXT,1,keep-1)+#13#10+'----'+#13#10+copy(HTMLTEXT,keep+1,length(HTMLTEXT));
   end;
  ce:='<B>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='</B>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='<U>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='</U>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='<I>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='</I>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='</FONT>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='<HTML>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  ce:='</HTML>';if Pos(ce,UpperCase(HTMLTEXT))<>0 then Delete(HTMLTEXT,pos(ce,UpperCase(HTMLTEXT)),length(ce));
  p1:=0;p2:=0;ce:='<!--';p1:=pos(ce,UpperCase(HTMLTEXT));p2:=Pos('-->',UpperCase(HTMLTEXT));
  if ((p1<>0) and (p2<>0)) then Delete(HTMLTEXT,p1,(p2+3)-p1);
  l2:=length(HTMLTEXT);
 until (l1=l2);

 repeat
  l1:=length(HTMLTEXT);
  ce:='<BODY ';p1:=Pos(ce,UpperCase(HTMLTEXT)); if p1<>0 then Sterge(htmltext,p1);
  ce:='<FONT ';p1:=Pos(ce,UpperCase(HTMLTEXT)); if p1<>0 then Sterge(htmltext,p1);
  ce:='<A HREF';p1:=Pos(ce,UpperCase(HTMLTEXT)); if p1<>0 then Sterge2(htmltext,p1);
  ce:='<P ALIGN';p1:=Pos(ce,UpperCase(HTMLTEXT)); if p1<>0 then Sterge(htmltext,p1);
  l2:=length(HTMLTEXT);
 until (l1=l2);


 TXT:=HTMLTEXT;
end;

end.
