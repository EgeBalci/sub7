unit Msgs;

interface

uses Graphics;

const

  Times    = 'Times New Roman';
  Arial    = 'Arial';
  MsgFonte = Arial;


  NbBanner      = 3;
  Type  TBanner = Record FName : String; FSize : Integer ; FStyle : TFontStyles ; Text : String End;
        TBannerArray = array[0..NbBanner-1] of TBanner;
  Const Banner : TBannerArray = (
  { Banner 1 }  ( FName:Arial; FSize:22; FStyle:[fsBold];
                  Text:'——— SubSeven Apocalypse ———'
              ),( FName:Arial; FSize:22; FStyle:[fsBold];
                  Text:' ———— http://come.to/subseven'
              ),( FName:Arial; FSize:22; FStyle:[fsBold];
                  Text:'s7a by mobman © 1999    '
              ));
  AboutMessages = 9; // Messages number
  Type  AboutM = array [1..AboutMessages] of String; {DRYSIM by Seb}
  Const AboutMsg : AboutM = ( // If you modifie then number of messages, don't forget to change the const AboutMessages
       { Message 1 }  ('welcome to sub7apocalypse ... just a small-temporary-client-only version for all the r.a.t. fans out there...'
       { Message 2 }),('——— this version is dedicated to the memory of Dan Sava [from Vacanta Mare] who died recently in a car crash. romanians and especially those from Craiova [including me] will never forget you... rest in peace. ———'
       { Message 3 }),('greets go out in the first place to S_A_R_G_E [thanks for erasing almost half of the sub7 client source]...'
       { Message 4 }),('also to TaUnE, Ady, Oae and everybody in that area... VladyLama [the very first sub7 tester], ThinIce, Alex, Ç®ÎKËT...'
       { Message 5 }),('and most of all... as always... to B.U.G. Mafia - the _best_ hip-hop band out there : '+
       { Assistants : }'["i put my hand on my gun ''cause they got me on the run/ blue dressed motherfuckers wanna get me down" -mafia-9mm]'
       { Message 6 }),('last but not least... to the sub7 crew.. thanks for all the help: The Lamer, Ganja51, fc, cryptic k, Axel Stone, CorpseGrinder, MoFo, HellFireZ, Stoner, rvlation, Demonn and everybody else who i forgot...'+
       { Assistants : }'greets also to Blade [see you _soon_], ^cold^ and cDc [bo2k server kicks ass...but the interface is just _bad_]'
       { Message 7 }),(' ——— sub7apocalypse credits ——— '+
       { Assistants : }'programming: mobman / testing: S_A_R_G_E, rvlation / about screen: Seb''s drysim'
       { Message 8 }),(' ... cya` all in 2.0... stay tooned...   ...l8r ——'
       { Message 9 }),('—————————————————————————————— the end ——————————————————————————————'
//       { Message 8 }),(''
//       { Message 9 }),(''
//       { Message 10}),(''
//       { Message 11}),(''
//       { Message 12}),('** ** ** ** **'
                   )); // Fin des messages

implementation

end.
                  Text:'DRYSIM      version 2.0.2.0      1999      '
              ),( FName:Arial; FSize:22; FStyle:[fsBold];
                  Text:' ———— Simulation & Analyse de Plongée'
              ),( FName:Arial; FSize:22; FStyle:[fsBold,fsItalic];
                  Text:'3D Animation : John Biddiscombe ©1997    '

                  Lamer, Ganja51, fc, cryptic k, Axelstone, Corpsegrinder, 
MoFo, HellfireZ, Blade, Stoner, Jackl, Bogart, Rvlation, Hacka, MasterRat, 
Astro, Lord_midnight, SlimShady, Demonn
