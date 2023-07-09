unit DIBType;

interface

uses Graphics, Windows;

Const
  NoChange       = High(Integer);
  NilPalette     = nil;

  // Styles de trait prédéfinis :
  DUpsSolid      = $FFFFFFFF; // Motif : <********************************>
  DUpsDot        = $AAAAAAAA; // Motif : <* * * * * * * * * * * * * * * * >
  DUpsDotDot     = $CCCCCCCC; // Motif : <**  **  **  **  **  **  **  **  >
  DUpsDash       = $F0F0F0F0; // Motif : <****    ****    ****    ****    >
  DUpsLongDash   = $FFC0FFC0; // Motif : <**********      **********      >
  DUpsHugeDash   = $FFFF0000; // Motif : <****************                >
  DUpsDoubleDash = $FC30FC30; // Motif : <******    **    ******    **    >
  DUpsDashDot    = $E4E4E4E4; // Motif : <***  *  ***  *  ***  *  ***  *  >
  DUpsDashDotDot = $EAEAEAEA; // Motif : <*** * * *** * * *** * * *** * * >
  DUpsIncDec     = $B77BEF76; // Motif : <* ** *** **** ***** **** *** ** >
  DUpsIncDec2    = $B38F0E32; // Motif : <* **  ***   ****    ***   **  * >
  DUpsClear      = $00000000; // Motif : <                                >
  // A vous ...

Type

// These types are defined for
// 1, 4, 8 Bit(s) per Pixel.

  T2ColorsPalette   = Packed Record
    palVersion   : Word;
    palNumEntries: Word;
    palPalEntry  : array [0..001] of TPaletteEntry;
  end;

  T16ColorsPalette  = Packed Record
    palVersion   : Word;
    palNumEntries: Word;
    palPalEntry  : array [0..015] of TPaletteEntry;
  end;

  T256ColorsPalette = Packed Record
    palVersion   : Word;
    palNumEntries: Word;
    palPalEntry  : array [0..255] of TPaletteEntry;
  end;

  TZone = record
    case Integer of
      0: (Left, Top, Width, Height : Integer);
      1: (Rect : TRect);
  end;

  // ******** Format des pixels de la DIB ********
  // TOUT TYPE ENUMERE OU UNION COMMENCE PAR :
  // "DU" (pour DIB Ultra) en MAJUSCULE
  // puis par le nom du format en minuscule "pf" pour PixelFormat.

  TDUPixelFormat = (DUpf1, DUpf4, DUpf8, DUpf15, DUpf16, DUpf24, DUpf32);

  TColorIndex    = TColor;

  TUnionDIBType  = (DUtTransparent, DUtAlpha, DUtAnimate, DUtLZH, DUtSysPalette);
  TDIBType       = Set of TUnionDIBType;

  TSaveMode      = (DUsmWindows, DUsmDIBUltra); // sm for S(aving) M(ode) : Format d'enregistrement

  // Entête des images compressées *.UDC
  TCompressedDIBFileHeader = Packed Record
    ID  : Word;           // Identifiant d'une DIB TDIBUltra
    Wd  : Word;           // Width (pixels)
    Ht  : Word;           // Height
    StF : TDUPixelFormat; // PixelFormat de l'image stockée
    ExF : TDUPixelFormat; // Pixel Format de l'image générée (préférence)
    Typ : TDIBType;       // Type of DIB : normal, transparent, Alpha, Animate ...
    Trsp: Byte;           // Transparent Color Index
    Col : Byte;
    Res1: Byte;           // Reserved, must be $00 !
    Res2: LongInt;        // Reserved, must be $00000000 !
    Size: LongInt;        // Taille de l'image RLE compressée
  End;

  // Entête informant sur chaque masque
  TMaskInfo = Packed Record
    Periode : Byte;       // 1 période = 1/20 ème de sec = 50 ms
    Size    : Word;       // Taille absolue en bytes
  End;

  // Entête des Masques Alpha
  TAlphaMaskHeader = Packed Record
    NbMask : Word;
    TotalSz: LongInt; // Somme des TMaskInfo.Size
    Info   : Array[1..40] Of TMaskInfo;
  End;

  TAlphaStruct = Packed Record
    Header : TAlphaMaskHeader;
    Field  : Array[0..0] of Word;
  End;

  TAlpha = ^TAlphaStruct;
  
  // ******** Couleurs prédéfinies pour des palettes standards ********
  TDUColor = (Black,Maroon, Green, Olive, Navy,  Purple,
              Teal, Gray,   Silver,Red,   Lime,  Yellow,
              Blue, Fuchsia,Aqua,  LtGray,DkGray,White  );

  TColorIndexArray = array [TDUColor,Ord(DUpf1)..Ord(DUpf32)+1] of TColorIndex;

  RGBArray = array[0..255] of TRGBQuad;

Const

StdClIdxArray : TColorIndexArray = (                     // Color Value
         { Black   } (0,$0,$00,$0000,$0000,$000000,$000000,$000000),
         { Maroon  } (0,$1,$01,$4000,$8000,$800000,$800000,$000080),
         { Green   } (0,$2,$02,$0200,$0400,$008000,$008000,$008000),
         { Olive   } (0,$3,$03,$4200,$8400,$808000,$808000,$008080),
         { Navy    } (0,$4,$04,$0010,$0010,$000080,$000080,$800000),
         { Purple  } (0,$5,$05,$4010,$8010,$800080,$800080,$800080),
         { Teal    } (0,$6,$06,$0210,$0410,$008080,$008080,$808000),
         { Gray    } (1,$7,$F8,$4210,$8410,$808080,$808080,$808080),
         { Silver  } (1,$8,$07,$6318,$C618,$C0C0C0,$C0C0C0,$C0C0C0),
         { Red     } (0,$9,$F9,$7C00,$F800,$FF0000,$FF0000,$0000FF),
         { Lime    } (0,$A,$FA,$03E0,$07E0,$00FF00,$00FF00,$00FF00),
         { Yellow  } (1,$B,$FB,$7FE0,$FFE0,$FFFF00,$FFFF00,$00FFFF),
         { Blue    } (0,$C,$FC,$001F,$001F,$0000FF,$0000FF,$FF0000),
         { Fuchsia } (1,$D,$FD,$7C1F,$F81F,$FF00FF,$FF00FF,$FF00FF),
         { Aqua    } (1,$E,$FE,$03FF,$07FF,$00FFFF,$00FFFF,$FFFF00),
         { LtGray  } (1,$8,$07,$6318,$C618,$C0C0C0,$C0C0C0,$C0C0C0),
         { DkGray  } (1,$7,$F8,$4210,$8410,$808080,$808080,$808080),
         { White   } (1,$F,$F5,$7FFF,$FFFF,$FFFFFF,$FFFFFF,$FFFFFF)
           );

TPaletteNil : TLogPalette = ( // May not Be Useful, But...
  palVersion    : $300;
  palNumEntries : 0;
  ); { End of this palette }

PaletteSystem1Bits : T2ColorsPalette = (
  palVersion    : $300;
  palNumEntries : 2;
  palPalEntry   : (
    (peRed:  0 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   0 }
    (peRed:255 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 )  { Entry   1 }
    )  { End of color table }
  ); { End of this palette }

PaletteSystem4Bits : T16ColorsPalette = (
  palVersion    : $300;
  palNumEntries : 16;
  palPalEntry   : (
    (peRed:  0 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   0 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   1 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   2 }
    (peRed:128 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   3 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   4 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   5 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry   6 }
    (peRed:128 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry   7 }
    (peRed:192 ;   peGreen:192 ;   peBlue:192 ; peFlags : 0 ), { Entry   8 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   9 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  10 }
    (peRed:255 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  11 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry  12 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry  13 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry  14 }
    (peRed:255 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 )  { Entry  15 }
    )  { End of color table }
  ); { End of this palette }

PaletteSystem8Bits : T256ColorsPalette = (
  palVersion    : $300;
  palNumEntries : 256;
  palPalEntry   : (
    (peRed:  0 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   0 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   1 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   2 }
    (peRed:128 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   3 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   4 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   5 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry   6 }
    (peRed:192 ;   peGreen:192 ;   peBlue:192 ; peFlags : 0 ), { Entry   7 }
    (peRed:192 ;   peGreen:220 ;   peBlue:192 ; peFlags : 0 ), { Entry   8 }
    (peRed:166 ;   peGreen:202 ;   peBlue:240 ; peFlags : 0 ), { Entry   9 }
    (peRed:  4 ;   peGreen:  4 ;   peBlue:  4 ; peFlags : 0 ), { Entry  10 }
    (peRed:  8 ;   peGreen:  8 ;   peBlue:  8 ; peFlags : 0 ), { Entry  11 }
    (peRed: 12 ;   peGreen: 12 ;   peBlue: 12 ; peFlags : 0 ), { Entry  12 }
    (peRed: 17 ;   peGreen: 17 ;   peBlue: 17 ; peFlags : 0 ), { Entry  13 }
    (peRed: 22 ;   peGreen: 22 ;   peBlue: 22 ; peFlags : 0 ), { Entry  14 }
    (peRed: 28 ;   peGreen: 28 ;   peBlue: 28 ; peFlags : 0 ), { Entry  15 }
    (peRed: 34 ;   peGreen: 34 ;   peBlue: 34 ; peFlags : 0 ), { Entry  16 }
    (peRed: 41 ;   peGreen: 41 ;   peBlue: 41 ; peFlags : 0 ), { Entry  17 }
    (peRed: 85 ;   peGreen: 85 ;   peBlue: 85 ; peFlags : 0 ), { Entry  18 }
    (peRed: 77 ;   peGreen: 77 ;   peBlue: 77 ; peFlags : 0 ), { Entry  19 }
    (peRed: 66 ;   peGreen: 66 ;   peBlue: 66 ; peFlags : 0 ), { Entry  20 }
    (peRed: 57 ;   peGreen: 57 ;   peBlue: 57 ; peFlags : 0 ), { Entry  21 }
    (peRed:255 ;   peGreen:124 ;   peBlue:128 ; peFlags : 0 ), { Entry  22 }
    (peRed:255 ;   peGreen: 80 ;   peBlue: 80 ; peFlags : 0 ), { Entry  23 }
    (peRed:214 ;   peGreen:  0 ;   peBlue:147 ; peFlags : 0 ), { Entry  24 }
    (peRed:204 ;   peGreen:236 ;   peBlue:255 ; peFlags : 0 ), { Entry  25 }
    (peRed:239 ;   peGreen:214 ;   peBlue:198 ; peFlags : 0 ), { Entry  26 }
    (peRed:231 ;   peGreen:231 ;   peBlue:214 ; peFlags : 0 ), { Entry  27 }
    (peRed:173 ;   peGreen:169 ;   peBlue:144 ; peFlags : 0 ), { Entry  28 }
    (peRed: 51 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry  29 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry  30 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry  31 }
    (peRed:204 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry  32 }
    (peRed:  0 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  33 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  34 }
    (peRed:102 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  35 }
    (peRed:153 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  36 }
    (peRed:204 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  37 }
    (peRed:255 ;   peGreen: 51 ;   peBlue:  0 ; peFlags : 0 ), { Entry  38 }
    (peRed:  0 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  39 }
    (peRed: 51 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  40 }
    (peRed:102 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  41 }
    (peRed:153 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  42 }
    (peRed:204 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  43 }
    (peRed:255 ;   peGreen:102 ;   peBlue:  0 ; peFlags : 0 ), { Entry  44 }
    (peRed:  0 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  45 }
    (peRed: 51 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  46 }
    (peRed:102 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  47 }
    (peRed:153 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  48 }
    (peRed:204 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  49 }
    (peRed:255 ;   peGreen:153 ;   peBlue:  0 ; peFlags : 0 ), { Entry  50 }
    (peRed:  0 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  51 }
    (peRed: 51 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  52 }
    (peRed:102 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  53 }
    (peRed:153 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  54 }
    (peRed:204 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  55 }
    (peRed:255 ;   peGreen:204 ;   peBlue:  0 ; peFlags : 0 ), { Entry  56 }
    (peRed:102 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  57 }
    (peRed:153 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  58 }
    (peRed:204 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  59 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  60 }
    (peRed: 51 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  61 }
    (peRed:102 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  62 }
    (peRed:153 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  63 }
    (peRed:204 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  64 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 51 ; peFlags : 0 ), { Entry  65 }
    (peRed:  0 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  66 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  67 }
    (peRed:102 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  68 }
    (peRed:153 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  69 }
    (peRed:204 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  70 }
    (peRed:255 ;   peGreen: 51 ;   peBlue: 51 ; peFlags : 0 ), { Entry  71 }
    (peRed:  0 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  72 }
    (peRed: 51 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  73 }
    (peRed:102 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  74 }
    (peRed:153 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  75 }
    (peRed:204 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  76 }
    (peRed:255 ;   peGreen:102 ;   peBlue: 51 ; peFlags : 0 ), { Entry  77 }
    (peRed:  0 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  78 }
    (peRed: 51 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  79 }
    (peRed:102 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  80 }
    (peRed:153 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  81 }
    (peRed:204 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  82 }
    (peRed:255 ;   peGreen:153 ;   peBlue: 51 ; peFlags : 0 ), { Entry  83 }
    (peRed:  0 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  84 }
    (peRed: 51 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  85 }
    (peRed:102 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  86 }
    (peRed:153 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  87 }
    (peRed:204 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  88 }
    (peRed:255 ;   peGreen:204 ;   peBlue: 51 ; peFlags : 0 ), { Entry  89 }
    (peRed: 51 ;   peGreen:255 ;   peBlue: 51 ; peFlags : 0 ), { Entry  90 }
    (peRed:102 ;   peGreen:255 ;   peBlue: 51 ; peFlags : 0 ), { Entry  91 }
    (peRed:153 ;   peGreen:255 ;   peBlue: 51 ; peFlags : 0 ), { Entry  92 }
    (peRed:204 ;   peGreen:255 ;   peBlue: 51 ; peFlags : 0 ), { Entry  93 }
    (peRed:255 ;   peGreen:255 ;   peBlue: 51 ; peFlags : 0 ), { Entry  94 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry  95 }
    (peRed: 51 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry  96 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry  97 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry  98 }
    (peRed:204 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry  99 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:102 ; peFlags : 0 ), { Entry 100 }
    (peRed:  0 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 101 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 102 }
    (peRed:102 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 103 }
    (peRed:153 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 104 }
    (peRed:204 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 105 }
    (peRed:255 ;   peGreen: 51 ;   peBlue:102 ; peFlags : 0 ), { Entry 106 }
    (peRed:  0 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 107 }
    (peRed: 51 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 108 }
    (peRed:102 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 109 }
    (peRed:153 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 110 }
    (peRed:204 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 111 }
    (peRed:  0 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 112 }
    (peRed: 51 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 113 }
    (peRed:102 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 114 }
    (peRed:153 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 115 }
    (peRed:204 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 116 }
    (peRed:255 ;   peGreen:153 ;   peBlue:102 ; peFlags : 0 ), { Entry 117 }
    (peRed:  0 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 118 }
    (peRed: 51 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 119 }
    (peRed:153 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 120 }
    (peRed:204 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 121 }
    (peRed:255 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 122 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 123 }
    (peRed: 51 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 124 }
    (peRed:153 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 125 }
    (peRed:204 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 126 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 127 }
    (peRed:204 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 128 }
    (peRed:  0 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 129 }
    (peRed:153 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 130 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 131 }
    (peRed:204 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 132 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 133 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 134 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 135 }
    (peRed:204 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 136 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 137 }
    (peRed:  0 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 138 }
    (peRed: 51 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 139 }
    (peRed:102 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 140 }
    (peRed:153 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 141 }
    (peRed:204 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 142 }
    (peRed:255 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 143 }
    (peRed: 51 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 144 }
    (peRed:102 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 145 }
    (peRed:153 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 146 }
    (peRed:204 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 147 }
    (peRed:255 ;   peGreen:153 ;   peBlue:153 ; peFlags : 0 ), { Entry 148 }
    (peRed:  0 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 149 }
    (peRed: 51 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 150 }
    (peRed:102 ;   peGreen:204 ;   peBlue:102 ; peFlags : 0 ), { Entry 151 }
    (peRed:153 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 152 }
    (peRed:204 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 153 }
    (peRed:255 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 154 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 155 }
    (peRed: 51 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 156 }
    (peRed:102 ;   peGreen:204 ;   peBlue:153 ; peFlags : 0 ), { Entry 157 }
    (peRed:153 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 158 }
    (peRed:204 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 159 }
    (peRed:255 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 160 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 161 }
    (peRed: 51 ;   peGreen:  0 ;   peBlue:153 ; peFlags : 0 ), { Entry 162 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 163 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 164 }
    (peRed:204 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 165 }
    (peRed:  0 ;   peGreen: 51 ;   peBlue:153 ; peFlags : 0 ), { Entry 166 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 167 }
    (peRed:102 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 168 }
    (peRed:153 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 169 }
    (peRed:204 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 170 }
    (peRed:255 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 171 }
    (peRed:  0 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 172 }
    (peRed: 51 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 173 }
    (peRed:102 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 174 }
    (peRed:153 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 175 }
    (peRed:204 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 176 }
    (peRed:255 ;   peGreen:102 ;   peBlue:153 ; peFlags : 0 ), { Entry 177 }
    (peRed:  0 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 178 }
    (peRed: 51 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 179 }
    (peRed:102 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 180 }
    (peRed:153 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 181 }
    (peRed:204 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 182 }
    (peRed:255 ;   peGreen:153 ;   peBlue:204 ; peFlags : 0 ), { Entry 183 }
    (peRed:  0 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 184 }
    (peRed: 51 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 185 }
    (peRed:102 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 186 }
    (peRed:153 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 187 }
    (peRed:204 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 188 }
    (peRed:255 ;   peGreen:204 ;   peBlue:204 ; peFlags : 0 ), { Entry 189 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 190 }
    (peRed: 51 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 191 }
    (peRed:102 ;   peGreen:255 ;   peBlue:153 ; peFlags : 0 ), { Entry 192 }
    (peRed:153 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 193 }
    (peRed:204 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 194 }
    (peRed:255 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 195 }
    (peRed: 51 ;   peGreen:  0 ;   peBlue:204 ; peFlags : 0 ), { Entry 196 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 197 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 198 }
    (peRed:  0 ;   peGreen: 51 ;   peBlue:204 ; peFlags : 0 ), { Entry 199 }
    (peRed: 51 ;   peGreen: 51 ;   peBlue:255 ; peFlags : 0 ), { Entry 200 }
    (peRed:102 ;   peGreen: 51 ;   peBlue:255 ; peFlags : 0 ), { Entry 201 }
    (peRed:153 ;   peGreen: 51 ;   peBlue:255 ; peFlags : 0 ), { Entry 202 }
    (peRed:204 ;   peGreen: 51 ;   peBlue:255 ; peFlags : 0 ), { Entry 203 }
    (peRed:255 ;   peGreen: 51 ;   peBlue:255 ; peFlags : 0 ), { Entry 204 }
    (peRed:  0 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 205 }
    (peRed: 51 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 206 }
    (peRed:102 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 207 }
    (peRed:153 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 208 }
    (peRed:204 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 209 }
    (peRed:255 ;   peGreen:102 ;   peBlue:204 ; peFlags : 0 ), { Entry 210 }
    (peRed:  0 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 211 }
    (peRed: 51 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 212 }
    (peRed:102 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 213 }
    (peRed:153 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 214 }
    (peRed:204 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 215 }
    (peRed:255 ;   peGreen:153 ;   peBlue:255 ; peFlags : 0 ), { Entry 216 }
    (peRed:  0 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 217 }
    (peRed: 51 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 218 }
    (peRed:102 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 219 }
    (peRed:153 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 220 }
    (peRed:204 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 221 }
    (peRed:255 ;   peGreen:204 ;   peBlue:255 ; peFlags : 0 ), { Entry 222 }
    (peRed: 51 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 223 }
    (peRed:102 ;   peGreen:255 ;   peBlue:204 ; peFlags : 0 ), { Entry 224 }
    (peRed:153 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 225 }
    (peRed:204 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 226 }
    (peRed:255 ;   peGreen:102 ;   peBlue:102 ; peFlags : 0 ), { Entry 227 }
    (peRed:102 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 228 }
    (peRed:255 ;   peGreen:255 ;   peBlue:102 ; peFlags : 0 ), { Entry 229 }
    (peRed:102 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 230 }
    (peRed:255 ;   peGreen:102 ;   peBlue:255 ; peFlags : 0 ), { Entry 231 }
    (peRed:102 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 232 }
    (peRed:165 ;   peGreen:  0 ;   peBlue: 33 ; peFlags : 0 ), { Entry 233 }
    (peRed: 95 ;   peGreen: 95 ;   peBlue: 95 ; peFlags : 0 ), { Entry 234 }
    (peRed:119 ;   peGreen:119 ;   peBlue:119 ; peFlags : 0 ), { Entry 235 }
    (peRed:134 ;   peGreen:134 ;   peBlue:134 ; peFlags : 0 ), { Entry 236 }
    (peRed:150 ;   peGreen:150 ;   peBlue:150 ; peFlags : 0 ), { Entry 237 }
    (peRed:203 ;   peGreen:203 ;   peBlue:203 ; peFlags : 0 ), { Entry 238 }
    (peRed:178 ;   peGreen:178 ;   peBlue:178 ; peFlags : 0 ), { Entry 239 }
    (peRed:215 ;   peGreen:215 ;   peBlue:215 ; peFlags : 0 ), { Entry 240 }
    (peRed:221 ;   peGreen:221 ;   peBlue:221 ; peFlags : 0 ), { Entry 241 }
    (peRed:227 ;   peGreen:227 ;   peBlue:227 ; peFlags : 0 ), { Entry 242 }
    (peRed:234 ;   peGreen:234 ;   peBlue:234 ; peFlags : 0 ), { Entry 243 }
    (peRed:241 ;   peGreen:241 ;   peBlue:241 ; peFlags : 0 ), { Entry 244 }
    (peRed:248 ;   peGreen:248 ;   peBlue:248 ; peFlags : 0 ), { Entry 245 }
    (peRed:255 ;   peGreen:251 ;   peBlue:240 ; peFlags : 0 ), { Entry 246 }
    (peRed:160 ;   peGreen:160 ;   peBlue:164 ; peFlags : 0 ), { Entry 247 }
    (peRed:128 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry 248 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry 249 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry 250 }
    (peRed:255 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry 251 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 252 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 253 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 254 }
    (peRed: 72 ;   peGreen:249 ;   peBlue:102 ; peFlags : 0 )  { Entry 255 }
    )  { End of color table }
  ); { End of this palette }

PaletteToAnimate8Bits : T256ColorsPalette = ( // A nice animation palette (from ZRing Project)
  palVersion    : $300;
  palNumEntries : 256;
  palPalEntry   : (
    (peRed:  0 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   0 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry   1 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   2 }
    (peRed:128 ;   peGreen:128 ;   peBlue:  0 ; peFlags : 0 ), { Entry   3 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   4 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:128 ; peFlags : 0 ), { Entry   5 }
    (peRed:  0 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry   6 }
    (peRed:192 ;   peGreen:192 ;   peBlue:192 ; peFlags : 0 ), { Entry   7 }
    (peRed:192 ;   peGreen:220 ;   peBlue:192 ; peFlags : 0 ), { Entry   8 }
    (peRed:166 ;   peGreen:202 ;   peBlue:240 ; peFlags : 0 ), { Entry   9 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry  10 }
    (peRed:255 ;   peGreen:  6 ;   peBlue:  0 ; peFlags : 0 ), { Entry  11 }
    (peRed:255 ;   peGreen: 13 ;   peBlue:  0 ; peFlags : 0 ), { Entry  12 }
    (peRed:255 ;   peGreen: 19 ;   peBlue:  0 ; peFlags : 0 ), { Entry  13 }
    (peRed:255 ;   peGreen: 26 ;   peBlue:  0 ; peFlags : 0 ), { Entry  14 }
    (peRed:255 ;   peGreen: 32 ;   peBlue:  0 ; peFlags : 0 ), { Entry  15 }
    (peRed:255 ;   peGreen: 39 ;   peBlue:  0 ; peFlags : 0 ), { Entry  16 }
    (peRed:255 ;   peGreen: 45 ;   peBlue:  0 ; peFlags : 0 ), { Entry  17 }
    (peRed:255 ;   peGreen: 52 ;   peBlue:  0 ; peFlags : 0 ), { Entry  18 }
    (peRed:255 ;   peGreen: 58 ;   peBlue:  0 ; peFlags : 0 ), { Entry  19 }
    (peRed:255 ;   peGreen: 65 ;   peBlue:  0 ; peFlags : 0 ), { Entry  20 }
    (peRed:255 ;   peGreen: 71 ;   peBlue:  0 ; peFlags : 0 ), { Entry  21 }
    (peRed:255 ;   peGreen: 78 ;   peBlue:  0 ; peFlags : 0 ), { Entry  22 }
    (peRed:255 ;   peGreen: 84 ;   peBlue:  0 ; peFlags : 0 ), { Entry  23 }
    (peRed:255 ;   peGreen: 91 ;   peBlue:  0 ; peFlags : 0 ), { Entry  24 }
    (peRed:255 ;   peGreen: 97 ;   peBlue:  0 ; peFlags : 0 ), { Entry  25 }
    (peRed:255 ;   peGreen:104 ;   peBlue:  0 ; peFlags : 0 ), { Entry  26 }
    (peRed:255 ;   peGreen:110 ;   peBlue:  0 ; peFlags : 0 ), { Entry  27 }
    (peRed:255 ;   peGreen:117 ;   peBlue:  0 ; peFlags : 0 ), { Entry  28 }
    (peRed:255 ;   peGreen:123 ;   peBlue:  0 ; peFlags : 0 ), { Entry  29 }
    (peRed:255 ;   peGreen:130 ;   peBlue:  0 ; peFlags : 0 ), { Entry  30 }
    (peRed:255 ;   peGreen:136 ;   peBlue:  0 ; peFlags : 0 ), { Entry  31 }
    (peRed:255 ;   peGreen:143 ;   peBlue:  0 ; peFlags : 0 ), { Entry  32 }
    (peRed:255 ;   peGreen:149 ;   peBlue:  0 ; peFlags : 0 ), { Entry  33 }
    (peRed:255 ;   peGreen:156 ;   peBlue:  0 ; peFlags : 0 ), { Entry  34 }
    (peRed:255 ;   peGreen:162 ;   peBlue:  0 ; peFlags : 0 ), { Entry  35 }
    (peRed:255 ;   peGreen:169 ;   peBlue:  0 ; peFlags : 0 ), { Entry  36 }
    (peRed:255 ;   peGreen:175 ;   peBlue:  0 ; peFlags : 0 ), { Entry  37 }
    (peRed:255 ;   peGreen:182 ;   peBlue:  0 ; peFlags : 0 ), { Entry  38 }
    (peRed:255 ;   peGreen:188 ;   peBlue:  0 ; peFlags : 0 ), { Entry  39 }
    (peRed:255 ;   peGreen:194 ;   peBlue:  0 ; peFlags : 0 ), { Entry  40 }
    (peRed:255 ;   peGreen:201 ;   peBlue:  0 ; peFlags : 0 ), { Entry  41 }
    (peRed:255 ;   peGreen:207 ;   peBlue:  0 ; peFlags : 0 ), { Entry  42 }
    (peRed:255 ;   peGreen:214 ;   peBlue:  0 ; peFlags : 0 ), { Entry  43 }
    (peRed:255 ;   peGreen:220 ;   peBlue:  0 ; peFlags : 0 ), { Entry  44 }
    (peRed:255 ;   peGreen:227 ;   peBlue:  0 ; peFlags : 0 ), { Entry  45 }
    (peRed:255 ;   peGreen:233 ;   peBlue:  0 ; peFlags : 0 ), { Entry  46 }
    (peRed:255 ;   peGreen:240 ;   peBlue:  0 ; peFlags : 0 ), { Entry  47 }
    (peRed:255 ;   peGreen:246 ;   peBlue:  0 ; peFlags : 0 ), { Entry  48 }
    (peRed:255 ;   peGreen:253 ;   peBlue:  0 ; peFlags : 0 ), { Entry  49 }
    (peRed:251 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  50 }
    (peRed:244 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  51 }
    (peRed:238 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  52 }
    (peRed:231 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  53 }
    (peRed:225 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  54 }
    (peRed:218 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  55 }
    (peRed:212 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  56 }
    (peRed:205 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  57 }
    (peRed:199 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  58 }
    (peRed:192 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  59 }
    (peRed:186 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  60 }
    (peRed:179 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  61 }
    (peRed:173 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  62 }
    (peRed:166 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  63 }
    (peRed:160 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  64 }
    (peRed:153 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  65 }
    (peRed:147 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  66 }
    (peRed:140 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  67 }
    (peRed:134 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  68 }
    (peRed:128 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  69 }
    (peRed:121 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  70 }
    (peRed:115 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  71 }
    (peRed:108 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  72 }
    (peRed:102 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  73 }
    (peRed: 95 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  74 }
    (peRed: 89 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  75 }
    (peRed: 82 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  76 }
    (peRed: 76 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  77 }
    (peRed: 69 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  78 }
    (peRed: 63 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  79 }
    (peRed: 56 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  80 }
    (peRed: 50 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  81 }
    (peRed: 43 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  82 }
    (peRed: 37 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  83 }
    (peRed: 30 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  84 }
    (peRed: 24 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  85 }
    (peRed: 17 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  86 }
    (peRed: 11 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  87 }
    (peRed:  4 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry  88 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:  2 ; peFlags : 0 ), { Entry  89 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:  9 ; peFlags : 0 ), { Entry  90 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 15 ; peFlags : 0 ), { Entry  91 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 22 ; peFlags : 0 ), { Entry  92 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 28 ; peFlags : 0 ), { Entry  93 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 35 ; peFlags : 0 ), { Entry  94 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 41 ; peFlags : 0 ), { Entry  95 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 48 ; peFlags : 0 ), { Entry  96 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 54 ; peFlags : 0 ), { Entry  97 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 61 ; peFlags : 0 ), { Entry  98 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 67 ; peFlags : 0 ), { Entry  99 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 73 ; peFlags : 0 ), { Entry 100 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 80 ; peFlags : 0 ), { Entry 101 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 86 ; peFlags : 0 ), { Entry 102 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 93 ; peFlags : 0 ), { Entry 103 }
    (peRed:  0 ;   peGreen:255 ;   peBlue: 99 ; peFlags : 0 ), { Entry 104 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:106 ; peFlags : 0 ), { Entry 105 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:112 ; peFlags : 0 ), { Entry 106 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:119 ; peFlags : 0 ), { Entry 107 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:125 ; peFlags : 0 ), { Entry 108 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:132 ; peFlags : 0 ), { Entry 109 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:138 ; peFlags : 0 ), { Entry 110 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:145 ; peFlags : 0 ), { Entry 111 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:151 ; peFlags : 0 ), { Entry 112 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:158 ; peFlags : 0 ), { Entry 113 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:164 ; peFlags : 0 ), { Entry 114 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:171 ; peFlags : 0 ), { Entry 115 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:177 ; peFlags : 0 ), { Entry 116 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:184 ; peFlags : 0 ), { Entry 117 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:190 ; peFlags : 0 ), { Entry 118 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:197 ; peFlags : 0 ), { Entry 119 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:203 ; peFlags : 0 ), { Entry 120 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:210 ; peFlags : 0 ), { Entry 121 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:216 ; peFlags : 0 ), { Entry 122 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:223 ; peFlags : 0 ), { Entry 123 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:229 ; peFlags : 0 ), { Entry 124 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:236 ; peFlags : 0 ), { Entry 125 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:242 ; peFlags : 0 ), { Entry 126 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:249 ; peFlags : 0 ), { Entry 127 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 128 }
    (peRed:  0 ;   peGreen:249 ;   peBlue:255 ; peFlags : 0 ), { Entry 129 }
    (peRed:  0 ;   peGreen:242 ;   peBlue:255 ; peFlags : 0 ), { Entry 130 }
    (peRed:  0 ;   peGreen:236 ;   peBlue:255 ; peFlags : 0 ), { Entry 131 }
    (peRed:  0 ;   peGreen:229 ;   peBlue:255 ; peFlags : 0 ), { Entry 132 }
    (peRed:  0 ;   peGreen:223 ;   peBlue:255 ; peFlags : 0 ), { Entry 133 }
    (peRed:  0 ;   peGreen:216 ;   peBlue:255 ; peFlags : 0 ), { Entry 134 }
    (peRed:  0 ;   peGreen:210 ;   peBlue:255 ; peFlags : 0 ), { Entry 135 }
    (peRed:  0 ;   peGreen:203 ;   peBlue:255 ; peFlags : 0 ), { Entry 136 }
    (peRed:  0 ;   peGreen:197 ;   peBlue:255 ; peFlags : 0 ), { Entry 137 }
    (peRed:  0 ;   peGreen:190 ;   peBlue:255 ; peFlags : 0 ), { Entry 138 }
    (peRed:  0 ;   peGreen:184 ;   peBlue:255 ; peFlags : 0 ), { Entry 139 }
    (peRed:  0 ;   peGreen:177 ;   peBlue:255 ; peFlags : 0 ), { Entry 140 }
    (peRed:  0 ;   peGreen:171 ;   peBlue:255 ; peFlags : 0 ), { Entry 141 }
    (peRed:  0 ;   peGreen:164 ;   peBlue:255 ; peFlags : 0 ), { Entry 142 }
    (peRed:  0 ;   peGreen:158 ;   peBlue:255 ; peFlags : 0 ), { Entry 143 }
    (peRed:  0 ;   peGreen:151 ;   peBlue:255 ; peFlags : 0 ), { Entry 144 }
    (peRed:  0 ;   peGreen:145 ;   peBlue:255 ; peFlags : 0 ), { Entry 145 }
    (peRed:  0 ;   peGreen:138 ;   peBlue:255 ; peFlags : 0 ), { Entry 146 }
    (peRed:  0 ;   peGreen:132 ;   peBlue:255 ; peFlags : 0 ), { Entry 147 }
    (peRed:  0 ;   peGreen:125 ;   peBlue:255 ; peFlags : 0 ), { Entry 148 }
    (peRed:  0 ;   peGreen:119 ;   peBlue:255 ; peFlags : 0 ), { Entry 149 }
    (peRed:  0 ;   peGreen:112 ;   peBlue:255 ; peFlags : 0 ), { Entry 150 }
    (peRed:  0 ;   peGreen:106 ;   peBlue:255 ; peFlags : 0 ), { Entry 151 }
    (peRed:  0 ;   peGreen: 99 ;   peBlue:255 ; peFlags : 0 ), { Entry 152 }
    (peRed:  0 ;   peGreen: 93 ;   peBlue:255 ; peFlags : 0 ), { Entry 153 }
    (peRed:  0 ;   peGreen: 86 ;   peBlue:255 ; peFlags : 0 ), { Entry 154 }
    (peRed:  0 ;   peGreen: 80 ;   peBlue:255 ; peFlags : 0 ), { Entry 155 }
    (peRed:  0 ;   peGreen: 73 ;   peBlue:255 ; peFlags : 0 ), { Entry 156 }
    (peRed:  0 ;   peGreen: 67 ;   peBlue:255 ; peFlags : 0 ), { Entry 157 }
    (peRed:  0 ;   peGreen: 61 ;   peBlue:255 ; peFlags : 0 ), { Entry 158 }
    (peRed:  0 ;   peGreen: 54 ;   peBlue:255 ; peFlags : 0 ), { Entry 159 }
    (peRed:  0 ;   peGreen: 48 ;   peBlue:255 ; peFlags : 0 ), { Entry 160 }
    (peRed:  0 ;   peGreen: 41 ;   peBlue:255 ; peFlags : 0 ), { Entry 161 }
    (peRed:  0 ;   peGreen: 35 ;   peBlue:255 ; peFlags : 0 ), { Entry 162 }
    (peRed:  0 ;   peGreen: 28 ;   peBlue:255 ; peFlags : 0 ), { Entry 163 }
    (peRed:  0 ;   peGreen: 22 ;   peBlue:255 ; peFlags : 0 ), { Entry 164 }
    (peRed:  0 ;   peGreen: 15 ;   peBlue:255 ; peFlags : 0 ), { Entry 165 }
    (peRed:  0 ;   peGreen:  9 ;   peBlue:255 ; peFlags : 0 ), { Entry 166 }
    (peRed:  0 ;   peGreen:  2 ;   peBlue:255 ; peFlags : 0 ), { Entry 167 }
    (peRed:  4 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 168 }
    (peRed: 11 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 169 }
    (peRed: 17 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 170 }
    (peRed: 24 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 171 }
    (peRed: 30 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 172 }
    (peRed: 37 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 173 }
    (peRed: 43 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 174 }
    (peRed: 50 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 175 }
    (peRed: 56 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 176 }
    (peRed: 63 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 177 }
    (peRed: 69 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 178 }
    (peRed: 76 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 179 }
    (peRed: 82 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 180 }
    (peRed: 89 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 181 }
    (peRed: 95 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 182 }
    (peRed:102 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 183 }
    (peRed:108 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 184 }
    (peRed:115 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 185 }
    (peRed:121 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 186 }
    (peRed:128 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 187 }
    (peRed:134 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 188 }
    (peRed:140 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 189 }
    (peRed:147 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 190 }
    (peRed:153 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 191 }
    (peRed:160 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 192 }
    (peRed:166 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 193 }
    (peRed:173 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 194 }
    (peRed:179 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 195 }
    (peRed:186 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 196 }
    (peRed:192 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 197 }
    (peRed:199 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 198 }
    (peRed:205 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 199 }
    (peRed:212 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 200 }
    (peRed:218 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 201 }
    (peRed:225 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 202 }
    (peRed:231 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 203 }
    (peRed:238 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 204 }
    (peRed:244 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 205 }
    (peRed:251 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 206 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:253 ; peFlags : 0 ), { Entry 207 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:246 ; peFlags : 0 ), { Entry 208 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:240 ; peFlags : 0 ), { Entry 209 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:233 ; peFlags : 0 ), { Entry 210 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:227 ; peFlags : 0 ), { Entry 211 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:220 ; peFlags : 0 ), { Entry 212 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:214 ; peFlags : 0 ), { Entry 213 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:207 ; peFlags : 0 ), { Entry 214 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:201 ; peFlags : 0 ), { Entry 215 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:194 ; peFlags : 0 ), { Entry 216 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:188 ; peFlags : 0 ), { Entry 217 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:182 ; peFlags : 0 ), { Entry 218 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:175 ; peFlags : 0 ), { Entry 219 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:169 ; peFlags : 0 ), { Entry 220 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:162 ; peFlags : 0 ), { Entry 221 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:156 ; peFlags : 0 ), { Entry 222 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:149 ; peFlags : 0 ), { Entry 223 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:143 ; peFlags : 0 ), { Entry 224 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:136 ; peFlags : 0 ), { Entry 225 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:130 ; peFlags : 0 ), { Entry 226 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:123 ; peFlags : 0 ), { Entry 227 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:117 ; peFlags : 0 ), { Entry 228 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:110 ; peFlags : 0 ), { Entry 229 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:104 ; peFlags : 0 ), { Entry 230 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 97 ; peFlags : 0 ), { Entry 231 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 91 ; peFlags : 0 ), { Entry 232 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 84 ; peFlags : 0 ), { Entry 233 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 78 ; peFlags : 0 ), { Entry 234 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 71 ; peFlags : 0 ), { Entry 235 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 65 ; peFlags : 0 ), { Entry 236 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 58 ; peFlags : 0 ), { Entry 237 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 52 ; peFlags : 0 ), { Entry 238 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 45 ; peFlags : 0 ), { Entry 239 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 39 ; peFlags : 0 ), { Entry 240 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 32 ; peFlags : 0 ), { Entry 241 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 26 ; peFlags : 0 ), { Entry 242 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 19 ; peFlags : 0 ), { Entry 243 }
    (peRed:255 ;   peGreen:  0 ;   peBlue: 13 ; peFlags : 0 ), { Entry 244 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:  6 ; peFlags : 0 ), { Entry 245 }
    (peRed:255 ;   peGreen:251 ;   peBlue:240 ; peFlags : 0 ), { Entry 246 }
    (peRed:160 ;   peGreen:160 ;   peBlue:164 ; peFlags : 0 ), { Entry 247 }
    (peRed:128 ;   peGreen:128 ;   peBlue:128 ; peFlags : 0 ), { Entry 248 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:  0 ; peFlags : 0 ), { Entry 249 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry 250 }
    (peRed:255 ;   peGreen:255 ;   peBlue:  0 ; peFlags : 0 ), { Entry 251 }
    (peRed:  0 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 252 }
    (peRed:255 ;   peGreen:  0 ;   peBlue:255 ; peFlags : 0 ), { Entry 253 }
    (peRed:  0 ;   peGreen:255 ;   peBlue:255 ; peFlags : 0 ), { Entry 254 }
    (peRed: 72 ;   peGreen:249 ;   peBlue:102 ; peFlags : 0 )  { Entry 255 }
    )  { End of color table }
  ); { End of this palette }

implementation
end.



