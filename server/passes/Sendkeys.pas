{+--------------------------------------------------------------------------+
 | Class:       TSendKeys
 | Created:     12.98
 | Author:      Steve Seymour
 | Copyright    1998, all rights reserved.
 | Description: A sendkeys unit, I searched the net for a unit like this
 |				but they either required a DLL or cost money - and usually
 |				only nearly worked.
 | Version:     1.0
 | Status:      FreeWare
 | It's provided as is, without a warranty of any kind.
 | You use it at your own risk.
 | E-Mail me at steveseymour@x-stream.co.uk
 | Steve Seymour Software Design
 +--------------------------------------------------------------------------+}
//
// Usage:
//
// example to send a sum to windows calculator
//
//          Sendkey1.Keys:= '22/7=';
//	    SendKey1.TitleText:= 'Calc';     <----  some text from the title
//          SendKey1.execute;                       if TitleText is '' then
//                                                  the keys would go to the window
//  or                                              with focus.
//          Sendkey1.Keys:= '22[divide]7=';  <----  key name between [ and ]
//	    SendKey1.TitleText:= 'ulate';    <----  part of the window title
//          SendKey1.execute;
//
//
//          SendKey1.Keys:= '{^[f4]}';        <---- { group of keys } Ctrl F4
//          SendKey1.Titletext:= 'Calculator';
//          SendKey1.execute;
//
//          { = group start
//          } = group end
//          [ = start keyname
//          ] = end keyname
//          ^ = control in group
//          ! = shift in group
//          & = alt in group
//
//          [control][f4] same as {^[f4]}
//
//
//
//          See below for a complete list of key names
//          not all work with this sendkey method.
//          but you will probably be able to send the combination you want
//          by combining group and names.
//
//
//          experiment by sending keys to Notepad.
//
//
//          have fun, steveseymour@x-stream.co.uk



unit SendKeys;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus;


type
    vk_code_rec= record
              S: string[13];
              B: byte;
              end;

const
     vkcode: array[1..72] of vk_code_rec =
 ((S:'LButton   ';B:$01;),
  (S:'RButton   ';B:$02;), // not all these codes work with this method
  (S:'Cancel    ';B:$03;), // they are just here for completeness
  (S:'MButton   ';B:$04;),
  (S:'Back      ';B:$08;),
  (S:'Tab       ';B:$09;),
  (S:'Clear     ';B:$0C;),
  (S:'Return    ';B:$0D;),
  (S:'Shift     ';B:$10;), // SendKeys implementation
  (S:'Control   ';B:$11;), // By Steve Seymour
  (S:'Menu      ';B:$12;), // steveseymour@x-stream.co.uk
  (S:'Pause     ';B:$13;),
  (S:'Capital   ';B:$14;),
  (S:'Escape    ';B:$1B;),
  (S:'Space     ';B:$20;),
  (S:'Prior     ';B:$21;),
  (S:'Next      ';B:$22;),
  (S:'End       ';B:$23;),
  (S:'Home      ';B:$24;),
  (S:'Left      ';B:$25;),
  (S:'Up        ';B:$26;),
  (S:'Right     ';B:$27;),
  (S:'Down      ';B:$28;),
  (S:'Select    ';B:$29;),
  (S:'Print     ';B:$2A;),
  (S:'Execute   ';B:$2B;),
  (S:'SnapShot  ';B:$2C;),
  (S:'Insert    ';B:$2D;),
  (S:'Delete    ';B:$2E;),
  (S:'Help      ';B:$2F;),
  (S:'NumPad0   ';B:$60;),
  (S:'NumPad1   ';B:$61;),
  (S:'NumPad2   ';B:$62;),
  (S:'NumPad3   ';B:$63;),
  (S:'NumPad4   ';B:$64;),
  (S:'NumPad5   ';B:$65;),
  (S:'NumPad6   ';B:$66;),
  (S:'NumPad7   ';B:$67;),
  (S:'NumPad8   ';B:$68;), 
  (S:'NumPad9   ';B:$69;),
  (S:'Multiply  ';B:$6A;),
  (S:'Add       ';B:$6B;),
  (S:'Separator ';B:$6C;),
  (S:'Subtract  ';B:$6D;),
  (S:'Decimal   ';B:$6E;),
  (S:'Divide    ';B:$6F;), 
  (S:'F1        ';B:$70;),
  (S:'F2        ';B:$71;),
  (S:'F3        ';B:$72;),
  (S:'F4        ';B:$73;),
  (S:'F5        ';B:$74;),
  (S:'F6        ';B:$75;),
  (S:'F7        ';B:$76;),
  (S:'F8        ';B:$77;),
  (S:'F9        ';B:$78;),
  (S:'F10       ';B:$79;),
  (S:'F11       ';B:$7A;),
  (S:'F12       ';B:$7B;),
  (S:'F13       ';B:$7C;),
  (S:'F14       ';B:$7D;),
  (S:'F15       ';B:$7E;),
  (S:'F16       ';B:$7F;),
  (S:'F17       ';B:$80;),
  (S:'F18       ';B:$81;),
  (S:'F19       ';B:$82;),
  (S:'F20       ';B:$83;),
  (S:'F21       ';B:$84;),
  (S:'F22       ';B:$85;),
  (S:'F23       ';B:$86;),
  (S:'F24       ';B:$87;),
  (S:'NumLock   ';B:$90;),
  (S:'Scroll    ';B:$91;));


type
  TSendKey = class(TComponent)
  private
    { Private declarations }
    Fkeys: String;
    FTitleText: string;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    Constructor Create(AOwner : TComponent); Override;
    property Keys: String read Fkeys write Fkeys;
    property TitleText: String read FTitleText write FTitletext;
    Destructor Destroy; Override;
    procedure execute;
  end;

procedure register;

implementation

Procedure SendtoWindow(s: string);    // find a window by a bit of its
var                                   // window text.
  wt: array[0..255] of char;
  count: integer;
  h: hwnd;
begin
     count:= 0;
     h := findWindow( nil, nil);  // look at first window
     GetWindowText(h,wt,255);
     if (pos(lowercase(s),lowercase(wt))>0) then   // not case sensitive
     begin
          setforegroundwindow(h);             // set focus for keys
          exit;
     end;
     while (h <> 0) and (count < 1000) do     // loop through all windows
     begin                                    // with a getout clause
          inc(count);                         // to stop being trapped
          h := GetWindow(h, GW_HWNDNEXT);     // next window
          GetWindowText(h,wt,255);
          if (pos(lowercase(s),lowercase(wt))>0) then // not case sensitive
          begin
               SetForegroundWindow(h);        // set focus for keys
               exit;
          end;
     end;
     // if we get this far we havn't found the window ;-(
     // return an error if you like ?
end;

Constructor TSendKey.Create(AOwner : TComponent);
Begin
     Inherited Create(AOwner);
end;

Destructor TSendKey.Destroy;
Begin
     Inherited Destroy;
end;

function SetBit(Bits: Integer; BitToSet: integer): Integer;
begin
  Result := (Bits or (1 shl BitToSet))
end;


procedure sendkey(s: string); // send a single key or group
const
     UPChars = ['A'..'Z'];
     Shift = '!';   // Shift in a group
     Alt   = '&';   // Alt in a group
     Ctrl  = '^';   // Ctrl in a group
     StartGroup = '{';
     EndGroup = '}';
     StartVk = '[';
     EndVk = ']';
var
   dwExtraInfo: longint;
   vk: byte;
   sk: word;
   pressvk,pressshift,pressalt,pressctrl: boolean;
   p1,p2,z: integer;
begin
     pressshift:= false;
     pressalt:= false;
     pressctrl:= false;
     pressvk:= false;

     if (pos(startgroup,s) >0) and (pos(endgroup,s) >0) then
     begin
          p1:= pos(startgroup,s);
          delete(s,1,p1);  // remove group {
          p2:= pos(endgroup,s);
          delete(s,p2,1);  // remove group }
          if (pos(Shift,s)>0) then
          begin
               p1:= pos(Shift,s);
               pressshift:= true;
               delete(s,p1,1);    // remove !
          end;
          if (pos(Alt,s)>0) then
          begin
               p1:= pos(Alt,s);
               pressalt:= true;
               delete(s,p1,1);   // remove &
          end;
          if (pos(Ctrl,s)>0) then
          begin
               p1:= pos(Ctrl,s);
               pressctrl:= true;
               delete(s,p1,1);
          end;
               end;
     // at this stage we should have a single char or vkcode and info on Shift/Alt/Ctrl
     // now we need to check if we need to set Shift automatically
     if (s[1] in UPChars) then pressshift:= true;


     // Press Shift key;
     if (pressshift) then
     begin
          vk:= VK_SHIFT;
          sk:= mapvirtualkey(vk,0);
          dwExtraInfo:= (sk shl 8) + 1;
          keybd_event(vk,sk,0,dwExtraInfo);
     end;

     // Press Alt key;
     if (pressalt) then
     begin
          vk:= VK_MENU;
          sk:= mapvirtualkey(vk,2);
          dwExtraInfo:= (sk shl 8) + 1;
          keybd_event(vk,sk,0,dwExtraInfo);
     end;

     // Press ctrl key;
     if (pressctrl) then
     begin
          vk:= VK_CONTROL;
          sk:= mapvirtualkey(vk,2);
          dwExtraInfo:= (sk shl 8) + 1;
          keybd_event(vk,sk,0,dwExtraInfo);
     end;

     // deal with two key combos - eg {^[F4]}   ctrl F4
     if (pos(startvk,s) > 0) and (pos(endvk,s) >0) then
     begin
          p1:= pos(startVK,s);
          delete(s,1,p1);  // remove group {
          p2:= pos(endVK,s);
          delete(s,p2,1);  // remove group }
          s:= trim(lowercase(s));
          for z:= 1 to 72 do
          begin
               if (s= trim(lowercase(vkcode[z].S))) then
               begin
                     vk:= vkcode[z].B;
                     sk:= mapvirtualkey(vk,2);
                     dwExtraInfo:= (sk shl 8) + 1;
                     setbit(dwExtraInfo,30);
                     setbit(dwExtraInfo,31);
                     keybd_event(vk,sk,0,dwExtraInfo);  // press key
                     keybd_event(vk,sk,KEYEVENTF_KEYUP,dwExtraInfo);  // release key
               end;
          end;
          pressvk:= true;
     end;


     if (not pressvk) then
     begin
          // press a normal key
          vk:= vkKeyScan(s[1]);
          sk:= mapvirtualkey(vk,0);
          dwExtraInfo:= (sk shl 8) + 1;
          keybd_event(vk,sk,0,dwExtraInfo);  // press key
          keybd_event(vk,sk,KEYEVENTF_KEYUP,dwExtraInfo);  // release key
     end;

     // release shift
     if (pressshift) then
     begin
          vk:= VK_SHIFT;
          sk:= mapvirtualkey(vk,0);
          dwExtraInfo:= sk shl 8;
          setbit(dwExtraInfo,30);
          setbit(dwExtraInfo,31);
          keybd_event(vk,0,KEYEVENTF_KEYUP,dwExtraInfo);
     end;

     // release alt
     if (pressalt) then
     begin
          vk:= VK_MENU;
          sk:= mapvirtualkey(vk,2);
          dwExtraInfo:= sk shl 8;
          setbit(dwExtraInfo,30);
          setbit(dwExtraInfo,31);
          keybd_event(vk,0,KEYEVENTF_KEYUP,dwExtraInfo);
     end;

     // release ctrl
     if (pressctrl) then
     begin
          vk:= VK_CONTROL;
          sk:= mapvirtualkey(vk,2);
          dwExtraInfo:= sk shl 8;
          setbit(dwExtraInfo,30);
          setbit(dwExtraInfo,31);
          keybd_event(vk,0,KEYEVENTF_KEYUP,dwExtraInfo);
     end;
end;

procedure TSendKey.execute; // send a string to window 
var
   s,tmp,key: string;
   j,p2,p1,z: integer;
begin
     if (TitleText <> '') then SendtoWindow(TitleText); // set window focus
     s:= Keys;
     z:= 1;
     while z <= length(s) do     // some auto shifted keys
     begin                       // Setup for my UK keyboard layout
          case s[z] of
          '¬': begin
                    delete(s,z,1);
                    insert('{!`}',s,z);
               end;
          '!': begin
                    if (s[z-1]<> '{') then
                    begin
                         delete(s,z,1);
                         insert('{!1}',s,z);
                    end;
               end;
          '"': begin
                    delete(s,z,1);
                    insert('{!2}',s,z);
               end;
          '£': begin
                    delete(s,z,1);
                    insert('{!3}',s,z);
               end;
          '$': begin
                    delete(s,z,1);
                    insert('{!4}',s,z);
               end;
          '%': begin
                    delete(s,z,1);
                    insert('{!5}',s,z);
               end;
          '^': begin
                    if (s[z-1]<> '{') then
                    begin
                         delete(s,z,1);
                         insert('{!6}',s,z);
                    end;
               end;
          '&': begin
                    if (s[z-1]<> '{') then
                    begin
                         delete(s,z,1);
                         insert('{!7}',s,z);
                    end;
               end;
          '*': begin
                    delete(s,z,1);
                    insert('{!8}',s,z);
               end;
          '(': begin
                    delete(s,z,1);
                    insert('{!9}',s,z);
               end;
          ')': begin
                    delete(s,z,1);
                    insert('{!0}',s,z);
               end;
          '_': begin
                    delete(s,z,1);
                    insert('{!-}',s,z);
               end;
          '+': begin
                    delete(s,z,1);
                    insert('{!=}',s,z);
               end;
          '~': begin
                    delete(s,z,1);
                    insert('{!#}',s,z);
               end;
          '@': begin
                    delete(s,z,1);
                    insert('{!''}',s,z);
               end;
          ':': begin
                    delete(s,z,1);
                    insert('{!;}',s,z);
               end;
          '<': begin
                    delete(s,z,1);
                    insert('{!,}',s,z);
               end;
          '>': begin
                    delete(s,z,1);
                    insert('{!.}',s,z);
               end;
          '?': begin
                    delete(s,z,1);
                    insert('{!/}',s,z);
               end;
          '|': begin
                    delete(s,z,1);
                    insert('{!\}',s,z);
               end;
          end; //case
          inc(z);
     end;
     z:= 1;
     while (z <= length(s)) do
     begin
          p1:= z;
          case s[z] of
          '{': begin
                    p1:= pos('}',s);
                    key:= copy(s,z,p1-(z-1));
                    p2:= pos('{',s);
                    s[p2]:= '*';              // remove the start group flag
                    s[p1]:= '*';
                    tmp:= key;
                    for j:= 1 to length(key) do
                    if (key[j] = '[') or (key[j] = ']') then s[j]:= '*';
               end;
          '[': begin
                    p1:= pos(']',s);
                    key:= copy(s,z,p1-(z-1));
                    p2:= pos('[',s);
                    s[p2]:= '*';             // remove the start vk flag
                    s[p1]:= '*';
               end;
          else key:= s[z];
          end; // case
          sendkey(key);
          z:= p1+1;
     end;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TSendKey]);
end;

end.
