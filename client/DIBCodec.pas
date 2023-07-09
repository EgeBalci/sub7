//****************************************************************************//
//***** UNITE DIBCODEC UTILISEE PAR DIBULTRA.PAS : ALGO CODAGE/DECODAGE  *****//
//***** SE REPORTER A DIBULTRA.PAS POUR D'AUTRES INFORMATIONS            *****//
//****************************************************************************//
// Version 1.3   Copyright/CopyLeft GPL (C) 1999 LEON Sébastien               //
//                                                                            //
// ## History : ##                                                            //
// Version 1.0 : (1/1999)                                                     //
// Version 1.1 : (4/1999) AlphaChanelBlit support 16 AlphaLevels              //
//               Fix a CreateFromFile Bug for 15, 16, 24 & 32 Bpp             //
// Version 1.2 : (5/1999)LZH for DUc ; AlphaChanelBlit support 33 AlphaLevels //
// Version 1.3 : (5/1999)AlphaBlit effect (support 33 AlphaLevels)            //
//                                                                            //
//****************************************************************************//

unit DIBcodec;

{$A+} { word align }
{$O+}

{################  SEB MESSAGE : ########################################

WARNING : A part of code in this unit is not mine ! See Author's words for licences
restrictions. I dérived the TLZH object from Danny Heijl Tlzrw1 object. This
version is ligther. (You can only process with streams with the LZH algorithm)
The LZHPack & LZHUnpack function are from Douglas Webb (who has translated
them from C versions...) and are untouched here.
Next version of TDIBUltra will provide an ASM optimisation of criticals
functions in LZHUnpack.

ATTENTION : Cette unité utilisée par TDIBUltra ne contient pas que du code dont
je suis l'auteur ! Les autres codes sources sont donc sujets aux conditions
respectivement définies par leurs auteurs ! La prochaine version de TDIBUltra
optimisera certaines fonctions critiques de décompression en assembleur mais
pour l'instant le noyaux de décompression n'a pas été modifié et n'est pas de moi !

Cette unité contient une version très réduite de l'unité LZRW1 de Danny Heijl.
Cette cure d'amaigrissement a supprimé plusieurs fonctionnalités ! On ne
peut donc plus compresser directement des fichiers, ni choisir entre l'algo LZH
ou LZRW1/KH (format moins compact mais plus rapide à traiter). L'objet non
visuel (il était initialement visuel de type TCustomPanel) ne traite que les
streams.
Le but de cette cure est bien sûr de diminuer la taille de cette unité en
ne gardant que ce qui est nécessaire pour DIBUltra.

Pour vérifier le bon fonctionnement de l'objet allégé et pour monter comment
l'utiliser simplement, j'ai crée un petit projet :
(pour le compiler, il faut le sauvegarder en XXX.dpr puis simplement le compiler
sous Delphi)
}

{$IFDEF NEVER_DEFINED}
program Project1;

uses
  Windows, Classes, Dialogs, SysUtils,
  DIBcodec;

const
  Size = 1024*128; // Taille de la zone à tester et à Compresser (128 Ko)

var
  Char1, Char2 : Byte;
  N, Err       : Integer;
  LZ           : TLZH;
  StreamA      : TMemoryStream; // Source
  StreamT      : TMemoryStream; // Test : Decompressed stream
  StreamC      : TMemoryStream; // Compressed result

begin
  LZ := TLZH.Create;
  StreamA := TMemoryStream.Create;
  StreamT := TMemoryStream.Create;
  StreamC := TMemoryStream.Create;
  StreamA.SetSize(Size);
  StreamT.SetSize(Size+Size div 2);
  StreamC.SetSize(Size);

  // Test
  For N := 0 To Size Do Begin Char1 := Random(256); StreamA.WriteBuffer(Char1,1) End;

  // Compression
  MessageDlg('Phase de Compression du stream.', mtInformation, [mbOk], 0);
  StreamA.Position := 0;
  StreamC.Position := 0;
  LZ.InputStream   := StreamA;  // From
  LZ.OutputStream  := StreamC; // To
  LZ.Compress(Size);
  // Décompression
  MessageDlg('Le flux initial (de '+IntToStr(Size div 1024)+' Ko) a été compressé en '+IntToStr(StreamC.Position div 1024)+' Ko !'#10
             +'Passons à la phase de Décompression du flux compressé.', mtInformation, [mbOk], 0);
  StreamC.Position := 0;
  StreamT.Position := 0;
  LZ.InputStream   := StreamC;  // From
  LZ.OutputStream  := StreamT; // To
  LZ.DeCompress;

  // Comparaison
  MessageDlg('Le flux compressé (de '+IntToStr(StreamC.Position div 1024)+' Ko) a été décompressé en '+IntToStr(StreamT.Position div 1024)+' Ko !'#10
             +'Passons à la phase de Comparaison du stream initial et décompressé.', mtInformation, [mbOk], 0);
  Err := 0;
  StreamA.Position := 0;
  StreamT.Position := 0;
  For N := 0 to (Size-1) Do Begin
    StreamA.ReadBuffer(Char1,1);
    StreamT.ReadBuffer(Char2,1);
    If (Char1<>Char2) Then Inc(Err);
  End;
  If (Err=0) Then
    MessageDlg('Tout s''est bien passé !', mtInformation, [mbOk], 0)
  Else
    MessageDlg('Il y a '+intToStr(Err)+' Erreur(s).', mtWarning, [mbOk], 0);
  // Ne vous étonnez pas de n'avoir rien gagné au niveau compression,
  // c'est normal car on a utilisé random pour remplir le tableau et cela
  // prouve surtout que cet algo de random fait bien son travail !
  // (Répétition bien hétérogène / peu de séquences identiques)

  // Libération des flux
  StreamA.Free;
  StreamT.Free;
  StreamC.Free;
  LZ.Free;
end.
{$ENDIF}
{
Par respect pour les auteurs de ce travail sur LZH, vous pouvez lire ci-dessous
l'entête de l'objet initial. Mais vous aurez compris que de nombreuses fonctionnalités
citées n'apparaissent plus dans cette unité qui a intégré l'unit LZRW1 (en y faisant
des coupes sombres) + l'unit LZH (initialement de Douglas Webb, sans aucune modification
syntaxique)!

################ END OF SEB MESSAGE ########################################}

{*****************************************************************************
*
*TLZRW1 file compression component.
*----------------------------------
*
*Compresses a file with :
*------------------------
*
*    either the LZRW1/KH or LZH compression algorithm,
*           with code posted by Kurt Haenen on the SWAG (lzrw1).
*    or the Japanese LZH compression algorithm
*           ( LZSS coded by Haruhiko OKUMURA
*             Adaptive Huffman Coding coded by Haruyasu YOSHIZAKI
*             Edited and translated to English by Kenji RIKITAKE
*             Translated from C to Turbo Pascal by Douglas Webb   2/18/91
*             posted by Doug Webb on the SWAG (preskit2\lzh).)
*
*
*Visual feedback on a Panel if so desired.
*
*All VCL code by D. Heijl , may 8-9 1996
*
*The Getblock/PutBlock procedures are based on the code in
*lzhtest.pas by Douglas Webb.
*
*
*The files lzh.pas and lzrw1kh.pas are essentially untouched
*(only some cosmetic changes, also added exceptions)
*
*--------------------------------------------------------------------
* V2.00.00 :
*
* Code for using a Stream  instead of a File added by Stefan Westner
*                          25 May 1997 (stefan.westner@stud.uni-bamberg.de)
* I removed the seeks to the beginning of the stream (except for the auto guess)
* and the Steeam.Clear call, so that you have more freedom using TFileStream.
*                          30 May 1997 (Danny.Heijl@cevi.be)
* I also added a "Threshold" property that dictates the behaviour of Advise.
*--------------------------------------------------------------------
*
* Feel free to use or give away this software as you see fit.
* Just leave the credits in place if you alter the source.
*
* This software is delivered to you "as is",
* no guarantees, it may blow up or trigger World War Three
* for all I know.
*
* If you find any bugs and let me know, I will try to fix them.
*
* I believe in programmers around the world helping each other
* out by distributing free source code.
*
*Danny Heijl, may 10 1996.
*Danny.Heijl@cevi.be
*
*----------------------------------------------------------------
*****************************************************************}

interface

uses SysUtils, Classes, Forms;


// HERE IS THE INTERFACE OF THE LZH UNIT BY DOUGLAS WEBB (1991)
Type
(*
 * LZHUF.C English version 1.0
 * Based on Japanese version 29-NOV-1988
 * LZSS coded by Haruhiko OKUMURA
 * Adaptive Huffman Coding coded by Haruyasu YOSHIZAKI
 * Edited and translated to English by Kenji RIKITAKE
 * Translated from C to Turbo Pascal by Douglas Webb   2/18/91
 *    Update and bug correction of TP version 4/29/91 (Sorry!!)
 *    Added Delphi exception handling may 09 1996 Danny Heijl
 *                                                Danny.Heijl@cevi.be
 *)
{
     This unit allows the user to compress data using a combination of
   LZSS compression and adaptive Huffman coding, or conversely to decompress
   data that was previously compressed by this unit.

     There are a number of options as to where the data being compressed/
   decompressed is coming from/going to.

   In fact it requires that you pass the "LZHPack" procedure 2 procedural
  parameter of type 'GetProcType' and 'PutProcType' (declared below) which
  will accept 3 parameters and act in every way like a 'BlockRead'/
  'BlockWrite' procedure call. Your 'GetBytesProc' procedure should return
  the data to be compressed, and Your 'PutBytesProc' procedure should do
  something with the compressed data (ie., put it in a file).  In case you
  need to know (and you do if you want to decompress this data again) the
  number of bytes in the compressed data (original, not compressed size)
  is returned in 'Bytes_Written'.

  GetBytesProc = PROCEDURE(VAR DTA; NBytes:WORD; VAR Bytes_Got : WORD);

  DTA is the start of a memory location where the information returned
  should be.  NBytes is the number of bytes requested.  The actual number
  of bytes returned must be passed in Bytes_Got (if there is no more data
  then 0 should be returned).

  PutBytesProc = PROCEDURE(VAR DTA; NBytes:WORD; VAR Bytes_Got : WORD);

  As above except instead of asking for data the procedure is dumping out
  compressed data, do somthing with it.


   "LZHUnPack" is basically the same thing in reverse.  It requires
  procedural parameters of type 'PutProcType'/'GetProcType' which
  will act as above.  'GetProcType' must retrieve data compressed using
  "LZHPack" (above) and feed it to the unpacking routine as requested.
  'PutProcType' must accept the decompressed data and do something
  withit.  You must also pass in the original size of the decompressed data,
  failure to do so will have adverse results.


   Don't forget that as procedural parameters the 'GetProcType'/'PutProcType'
  procedures must be compiled in the 'F+' state to avoid a catastrophe.

}
{ Note: All the large data structures for these routines are allocated when
  needed from the heap, and deallocated when finished.  So when not in use
  memory requirements are minimal.  However, this unit uses about 34K of
  heap space, and 400 bytes of stack when in use. }
{$R-} { NO range checking !! }

  Int16 = SmallInt;
  ElzhException = Class(Exception);
  TWriteProc = procedure(VAR DTA; NBytes:WORD; VAR Bytes_Put : WORD) of object;
  PutBytesProc = TwriteProc;
  {
   Your 'PutBytesProc' procedure should do something with the compressed
   data (ie., put it in a file).

   DTA is the start of a memory location where the information returned
   should be.  NBytes is the number of bytes requested.  The actual number
   of bytes put should be returned in Bytes_Got.

   Don't forget that as procedural parameters the 'GetProcType'/'PutProcType'
  procedures must be compiled in the 'F+' state to avoid a catastrophe.
  }

  TReadProc = procedure(VAR DTA; NBytes:WORD; VAR Bytes_Got : WORD) of object;
  GetBytesProc = TReadProc;
  {
   Your 'GetBytesProc' procedure should return the data to be compressed.
   In case you need to know (and you do if you want to decompress this
   data again) the number of bytes in the compressed data (original, not
   compressed size) is returned in 'Bytes_Written'.

   DTA is the start of a memory location where the information returned
   should be.  NBytes is the number of bytes requested.  The actual number
   of bytes returned must be passed in Bytes_Got (if there is no more data
   then 0 should be returned).

   Don't forget that as procedural parameters the 'GetProcType'/'PutProcType'
  procedures must be compiled in the 'F+' state to avoid a catastrophe.
  }

  Procedure LZHPack(VAR Bytes_Written:LongInt; GetBytes:GetBytesProc; PutBytes:PutBytesProc);
  {#XLZHUnPack}
  {
     This procedure allows the user to compress data using a combination of
   LZSS compression and adaptive Huffman coding.

     There are a number of options as to where the data being compressed
  is coming from.

   In fact it requires that you pass the "LZHPack" procedure 2 procedural
  parameter of type 'GetProcType' and 'PutProcType' (declared below) which
  will accept 3 parameters and act in every way like a 'BlockRead'/
  'BlockWrite' procedure call. Your 'GetBytesProc' procedure should return
  the data to be compressed, and Your 'PutBytesProc' procedure should do
  something with the compressed data (ie., put it in a file).  In case you
  need to know (and you do if you want to decompress this data again) the
  number of bytes in the compressed data (original, not compressed size)
  is returned in 'Bytes_Written'.

  DTA is the start of a memory location where the information returned
  should be.  NBytes is the number of bytes requested.  The actual number
  of bytes returned must be passed in Bytes_Got (if there is no more data
  then 0 should be returned).

  As above except instead of asking for data the procedure is dumping out
  compressed data, do somthing with it.
  }

  Procedure LZHUnpack(TextSize : Longint; GetBytes:GetBytesProc; PutBytes: PutBytesProc);
  {#X LZHPack}
  {
    "LZHUnPack" is basically the same as LZHPack in reverse.  It requires
  procedural parameters of type 'PutProcType'/'GetProcType' which
  will act as above.  'GetProcType' must retrieve data compressed using
  "LZHPack" (above) and feed it to the unpacking routine as requested.
  'PutProcType' must accept the decompressed data and do something
  withit.  You must also pass in the original size of the decompressed data,
  failure to do so will have adverse results.
  }

//###################################################################################

// THIS IS THE INTERFACE OF MY "RLE" (DE)COMPRESSION ROUTINES
procedure SebRLECompress  (Src : Pointer ; BytesToCompress   : Integer ; Dest : TStream);
procedure SebRLEDecompress(Src : TStream ; BytesToDeCompress : Integer ; Dest : Pointer);
// BytesToDeCompress is only useful if the Src Stream is not a TMemoryStream (you can set 0 elsewhere)
// BytesToDeCompress est utile seulement quand Src n'est pas un flux mémoire (Autrement on peut passer 0)

//###################################################################################

// THIS IS THE INTERFACE OF "LIGHT" VERSION OF LZRW1 UNIT BY DANNY HEIJL
Const
  ChunkSize       = 32768;
  IOBufSize       = (ChunkSize + 16);
  BufferMaxSize   = 32768;
  BufferMax       = BufferMaxSize-1;

Type
  LZHBuf  = Array[1..ChunkSize] OF BYTE;
  PLZHBuf = ^LZHBuf;
  BufferIndex    = 0..BufferMax + 15;
  BufferArray    = ARRAY [BufferIndex] OF BYTE;
  BufferPtr      = ^BufferArray;
  ELzrw1Exception = class(Exception);

  TLZH = class
  private
    LZHInBuf       : PLZHBuf;
    LZHOutBuf      : PLZHBuf;
    SRCBuf,DSTBuf  : BufferPtr;
    SrcFh, DstFh   : Integer;
    Tmp            : Longint;
    InSize,OutSize : LONGINT;
    Buf            : Longint;  { getblock }
    PosnR          : Word;     { getblock }
    PosnW          : Word;     { putblock }
    ReadProc       : TreadProc;    { must be passed to LZHPACK/UNPACK }
    WriteProc      : TWriteProc;   { must be passed to LZHPACK/UNPACK }
    FInputStream   : TStream;
    FOutputStream  : TStream;
    procedure GetBlock(VAR Target; NoBytes:Word; VAR Actual_Bytes:Word);
    procedure PutBlock(VAR Source; NoBytes:Word; VAR Actual_Bytes:Word);
  protected
    Function LZHStream (Size : Integer) : Longint;
  public
    property InputStream  : TStream read FInputStream  write FInputStream;
    property OutputStream : TStream read FOutputStream write FOutputStream;
    Function Compress(Size : Integer) : LongInt;
    Function Decompress               : Longint;

// ########## END OF INTERFACE ###########################################

end;

implementation

// HERE IS THE INTERFACE OF THE LZH UNIT BY DOUGLAS WEBB (1991)

CONST
  EXIT_OK = 0;
  EXIT_FAILED = 1;
{ LZSS Parameters }
  N	    = 4096; { Size of string buffer }
  F	    = 60;   { Size of look-ahead buffer }
  THRESHOLD = 2;
  NUL       = N;    { End of tree's node  }

{ Huffman coding parameters }
  N_CHAR    =	(256 - THRESHOLD + F);
		                         { character code (:= 0..N_CHAR-1) }
  T 	    =	(N_CHAR * 2 - 1);	 { Size of table }
  R 	    =	(T - 1);		       { root position }
  MAX_FREQ  =	$8000;
					               { update when cumulative frequency }
					               { reaches to this value }
{
 * Tables FOR encoding/decoding upper 6 bits of
 * sliding dictionary pointer
 }
{ encoder table }
  p_len : Array[0..63] of BYTE =
       ($03, $04, $04, $04, $05, $05, $05, $05, $05, $05, $05, $05, $06, $06, $06, $06,
	$06, $06, $06, $06, $06, $06, $06, $06, $07, $07, $07, $07, $07, $07, $07, $07,
	$07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07,
	$08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08);

  p_code : Array [0..63] OF BYTE =
       ($00, $20, $30, $40, $50, $58, $60, $68,	$70, $78, $80, $88, $90, $94, $98, $9C,
	$A0, $A4, $A8, $AC, $B0, $B4, $B8, $BC,	$C0, $C2, $C4, $C6, $C8, $CA, $CC, $CE,
	$D0, $D2, $D4, $D6, $D8, $DA, $DC, $DE,	$E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE,
	$F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7,	$F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF);

{ decoder table }
  d_code: Array [0..255] OF BYTE =
       ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
	$01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
	$02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02,
	$03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03,
	$04, $04, $04, $04, $04, $04, $04, $04, $05, $05, $05, $05, $05, $05, $05, $05,
	$06, $06, $06, $06, $06, $06, $06, $06, $07, $07, $07, $07, $07, $07, $07, $07,
	$08, $08, $08, $08, $08, $08, $08, $08, $09, $09, $09, $09, $09, $09, $09, $09,
	$0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B,
	$0C, $0C, $0C, $0C, $0D, $0D, $0D, $0D, $0E, $0E, $0E, $0E, $0F, $0F, $0F, $0F,
	$10, $10, $10, $10, $11, $11, $11, $11, $12, $12, $12, $12, $13, $13, $13, $13,
	$14, $14, $14, $14, $15, $15, $15, $15, $16, $16, $16, $16, $17, $17, $17, $17,
	$18, $18, $19, $19, $1A, $1A, $1B, $1B, $1C, $1C, $1D, $1D, $1E, $1E, $1F, $1F,
	$20, $20, $21, $21, $22, $22, $23, $23, $24, $24, $25, $25, $26, $26, $27, $27,
	$28, $28, $29, $29, $2A, $2A, $2B, $2B, $2C, $2C, $2D, $2D, $2E, $2E, $2F, $2F,
	$30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F);

 d_len: Array[0..255] of BYTE =
       ($03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03,
	$03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03,
	$04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04,
	$04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04,
	$04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04,
	$05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05,
	$05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05,
	$05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05,
	$05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05,
	$06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06,
	$06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06,
	$06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06,
	$07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07,
	$07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07,
	$07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07,
	$08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08);


TYPE
  Freqtype = Array[0..T] OF WORD;
  FreqPtr = ^freqtype;
  PntrType = Array[0..PRED(T+N_Char)] OF Int16;
  pntrPtr = ^pntrType;
  SonType = Array[0..PRED(T)] OF Int16;
  SonPtr = ^SonType;


  TextBufType = Array[0..N+F-2] OF BYTE;
  TBufPtr = ^TextBufType;
  WordRay = Array[0..N] OF Int16;
  WordRayPtr = ^WordRay;
  BWordRay = Array[0..N+256] OF Int16;
  BWordRayPtr = ^BWordRay;

VAR
  getbuf : WORD;
  getlen : BYTE;
  putlen : BYTE;
  putbuf : WORD;
  textsize : longint;
  codesize : longINT;
  printcount : longint ;
  match_position : Int16 ;
  match_length : Int16;

  text_buf : TBufPtr;
  lson,dad : WordRayPtr;
  rson : BWordRayPtr;
  freq : FreqPtr;	{ cumulative freq table }

{
 * pointing parent nodes.
 * area [T..(T + N_CHAR - 1)] are pointers FOR leaves
 }
  prnt : PntrPtr;

{ pointing children nodes (son[], son[] + 1)}
  son : SonPtr;



Procedure InitTree;  { Initializing tree }
VAR
  i : Int16;
BEGIN
  FOR i := N + 1 TO N + 256  DO rson^[i] := NUL;	{ root }
  FOR i := 0 TO N DO dad^[i] := NUL;			{ node }
END;

Procedure InsertNode(r : Int16);  { Inserting node to the tree }
VAR
  tmp,i, p, cmp : Int16;
  key : TBufPtr;
  c : WORD;
BEGIN
  cmp := 1;
  key := @text_buf^[r];
  p := SUCC(N) + key^[0];
  rson^[r] := NUL;
  lson^[r] := NUL;
  match_length := 0;
  WHILE match_length < F DO BEGIN
    IF (cmp >= 0) THEN BEGIN
	    IF (rson^[p] <> NUL) THEN begin
        p := rson^[p]
      end
	    ELSE BEGIN
	      rson^[p] := r;
		    dad^[r] := p;
		    exit;
      END;
    END
    ELSE BEGIN
      IF (lson^[p] <> NUL) THEN  begin
	       p := lson^[p]
      end
      ELSE BEGIN
        lson^[p] := r;
		    dad^[r] := p;
		    exit;
      END;
    END;
    i := 0;
    cmp := 0;
	  While (i < F) AND (cmp = 0) DO BEGIN
      inc(i);
      cmp := key^[i] - text_buf^[p + i];
    END;
    IF (i > THRESHOLD) THEN BEGIN
      tmp := PRED((r - p) AND PRED(N));
	    IF (i > match_length) THEN BEGIN
        match_position := tmp;
        match_length := i;
      END;
	    IF (match_length < F) AND (i = match_length) THEN BEGIN
        c := tmp;
		    IF (c < match_position) THEN begin
          match_position := c;
        end;
      END;
    END; { if i > threshold }
  END; { WHILE match_length < F }
  dad^[r] := dad^[p];
  lson^[r] := lson^[p];
  rson^[r] := rson^[p];
  dad^[lson^[p]] := r;
  dad^[rson^[p]] := r;
  IF (rson^[dad^[p]] = p) THEN begin
       rson^[dad^[p]] := r;
  end
  ELSE begin
    lson^[dad^[p]] := r;
  end;
  dad^[p] := NUL;  { remove p }
END;

Procedure DeleteNode(p: Int16);  { Deleting node from the tree }
VAR
  q : Int16;
BEGIN
  IF (dad^[p] = NUL) THEN exit;			{ unregistered }
  IF (rson^[p] = NUL) THEN begin
   q := lson^[p];
  end
  ELSE begin
    IF (lson^[p] = NUL) THEN begin
      q := rson^[p];
    end
    ELSE BEGIN
      q := lson^[p];
      IF (rson^[q] <> NUL) THEN BEGIN
        REPEAT
          q := rson^[q];
        UNTIL (rson^[q] = NUL);
        rson^[dad^[q]] := lson^[q];
        dad^[lson^[q]] := dad^[q];
        lson^[q] := lson^[p];
        dad^[lson^[p]] := q;
      END;
      rson^[q] := rson^[p];
      dad^[rson^[p]] := q;
    END;
  end;
  dad^[q] := dad^[p];

  IF (rson^[dad^[p]] = p) THEN
    rson^[dad^[p]] := q
  ELSE
    lson^[dad^[p]] := q;
  dad^[p] := NUL;
END;

{ Huffman coding parameters }
Function GetBit(GetBytes:GetBytesProc): Int16;	{ get one bit }
VAR
  i: BYTE;
  i2 : Int16;
  Wresult : Word;
BEGIN
  WHILE (getlen <= 8) DO BEGIN
    GetBytes(i,1,Wresult);
    If Wresult = 1 THEN
      i2 := i
    ELSE
      i2 := 0;
    getbuf := getbuf OR (i2 SHL (8 - getlen));
    INC(getlen,8);
  END;
  i2 := getbuf;
  getbuf := getbuf SHL 1;
  DEC(getlen);
  getbit := Int16((i2 < 0));
END;

Function GetByte(GetBytes:GetBytesProc): Int16;	{ get a byte }
VAR
  j : BYTE;
  i,Wresult : WORD;
BEGIN
  WHILE (getlen <= 8) DO BEGIN
    GetBytes(j,1,Wresult);
    If Wresult = 1 THEN
      i := j
    ELSE
      i := 0;
    getbuf := getbuf OR (i SHL (8 - getlen));
    INC(getlen,8);
  END;
  i := getbuf;
  getbuf := getbuf SHL 8;
  DEC(getlen,8);
  getbyte := Int16(i SHR 8);
END;

PROCEDURE Putcode(l : Int16; c: WORD;PutBytes:PutBytesProc);		{ output c bits }
VAR
  Temp : BYTE;
  Got : WORD;
BEGIN
  putbuf := putbuf OR (c SHR putlen);
  inc(putlen,l);
  IF (putlen >= 8) THEN BEGIN
    Temp := putbuf SHR 8;
    PutBytes(Temp,1,Got);
    DEC(putlen,8);
    IF (putlen  >= 8) THEN BEGIN
      Temp := Lo(PutBuf);
      PutBytes(Temp,1,Got);
      INC(codesize,2);
      DEC(putlen,8);
      putbuf := c SHL (l - putlen);
    END
    ELSE BEGIN
	    putbuf := putbuf SHL 8;
	    INC(codesize);
    END;
  END;
END;

{ initialize freq tree }
Procedure StartHuff;
VAR
  i, j : Int16;
BEGIN
  FOR i := 0 to PRED(N_CHAR) DO BEGIN
    freq^[i] := 1;
    son^[i] := i + T;
    prnt^[i + T] := i;
  END;
  i := 0;
  j := N_CHAR;
  WHILE (j <= R) DO BEGIN
    freq^[j] := freq^[i] + freq^[i + 1];
    son^[j] := i;
    prnt^[i] := j;
    prnt^[i + 1] := j;
    INC(i,2);
    INC(j);
  END;
  freq^[T] := $ffff;
  prnt^[R] := 0;
END;

{ reconstruct freq tree }
PROCEDURE reconst;
VAR
 i, j, k, tmp : Int16;
 f, l : WORD;
BEGIN
 { halven cumulative freq FOR leaf nodes }
  j := 0;
  FOR i := 0 to PRED(T) DO BEGIN
    IF (son^[i] >= T) THEN BEGIN
      freq^[j] := SUCC(freq^[i]) DIV 2;    {@@ Bug Fix MOD -> DIV @@}
      son^[j] := son^[i];
      INC(j);
    END;
  END;
  { make a tree : first, connect children nodes }
  i := 0;
  j := N_CHAR;
  WHILE (j < T) DO BEGIN
    k := SUCC(i);
    f := freq^[i] + freq^[k];
    freq^[j] := f;
    k := PRED(j);
    WHILE f < freq^[k] DO DEC(K);
    INC(k);
    l := (j - k) SHL 1;
    tmp := SUCC(k);
    move(freq^[k], freq^[tmp], l);
    freq^[k] := f;
    move(son^[k], son^[tmp], l);
    son^[k] := i;
    INC(i,2);
    INC(j);
  END;
    	{ connect parent nodes }
  FOR i := 0 to PRED(T) DO BEGIN
    k := son^[i];
    IF (k >= T) THEN BEGIN
	    prnt^[k] := i;
    END
    ELSE BEGIN
	    prnt^[k] := i;
      prnt^[SUCC(k)] := i;
	  END;
  END;
END;

{ update freq tree }
Procedure update(c : Int16);
VAR
  i, j, k, l : Int16;
BEGIN
  IF (freq^[R] = MAX_FREQ) THEN BEGIN
    reconst;
  END;
  c := prnt^[c + T];
  REPEAT
   INC(freq^[c]);
   k := freq^[c];
	{ swap nodes to keep the tree freq-ordered }
   l := SUCC(C);
   IF (k > freq^[l]) THEN BEGIN
     WHILE (k > freq^[l]) DO INC(l);
     DEC(l);
     freq^[c] := freq^[l];
     freq^[l] := k;

     i := son^[c];
     prnt^[i] := l;
     IF (i < T) THEN prnt^[SUCC(i)] := l;

     j := son^[l];
     son^[l] := i;

     prnt^[j] := c;
     IF (j < T) THEN prnt^[SUCC(j)] := c;
     son^[c] := j;

     c := l;
   END;
   c := prnt^[c];
 UNTIL (c = 0);	{ REPEAT it until reaching the root }
END;

VAR code, len : WORD;

PROCEDURE EncodeChar(c: WORD;PutBytes:PutBytesProc);
VAR
  i : WORD;
  j, k : Int16;
BEGIN
  i := 0;
  j := 0;
  k := prnt^[c + T];
	{ search connections from leaf node to the root }
  REPEAT
    i := i SHR 1;
	{ IF node's address is odd, output 1 ELSE output 0 }
    IF BOOLEAN(k AND 1) THEN INC(i,$8000);
    INC(j);
    k := prnt^[k];
  UNTIL (k = R);
  Putcode(j, i,PutBytes);
  code := i;
  len := j;
  update(c);
END;

Procedure EncodePosition(c : WORD;PutBytes:PutBytesProc);
VAR
  i,j : WORD;
BEGIN
	{ output upper 6 bits with encoding }
  i := c SHR 6;
  j := p_code[i];
  Putcode(p_len[i],j SHL 8,PutBytes);
	{ output lower 6 bits directly }
  Putcode(6, (c AND $3f) SHL 10,PutBytes);
END;

Procedure EncodeEnd(PutBytes:PutBytesProc);
VAR
  Temp : BYTE;
  Got : WORD;
BEGIN
  IF BOOLEAN(putlen) THEN BEGIN
    Temp := Lo(putbuf SHR 8);
    PutBytes(Temp,1,Got);
    INC(codesize);
  END;
END;

FUNCTION DecodeChar(GetBytes:GetBytesProc): Int16;
VAR
  c : WORD;
BEGIN
  c := son^[R];
    {* start searching tree from the root to leaves.
     * choose node #(son[]) IF input bit = 0
     * ELSE choose #(son[]+1) (input bit = 1)}
  WHILE (c < T) DO BEGIN
    c := c + GetBit(GetBytes);
    c := son^[c];
  END;
  c := c - T;
  update(c);
  Decodechar := Int16(c);
END;

Function DecodePosition(GetBytes:GetBytesProc) : WORD;
VAR
  i, j, c : WORD;
BEGIN
     { decode upper 6 bits from given table }
  i := GetByte(GetBytes);
  c := WORD(d_code[i] SHL 6);
  j := d_len[i];
	{ input lower 6 bits directly }
  DEC(j,2);
  While j <> 0 DO BEGIN
    i := (i SHL 1) + GetBit(GetBytes);
    DEC(J);
  END;
  DecodePosition := c OR i AND $3f;
END;

{ Compression }
Procedure InitLZH;
BEGIN
  getbuf         := 0;
  getlen         := 0;
  putlen         := 0;
  putbuf         := 0;
  textsize       := 0;
  codesize       := 0;
  printcount     := 0;
  match_position := 0;
  match_length   := 0;
  try
    New(lson);
    New(dad);
    New(rson);
    New(text_buf);
    New(freq);
    New(prnt);
    New(son);
  except
    Raise ElzhException.Create('LZH : Cannot get memory for dictionary tables');
  end;
END;

Procedure EndLZH;
BEGIN
  try
    Dispose(son);
    Dispose(prnt);
    Dispose(freq);
    Dispose(text_buf);
    Dispose(rson);
    Dispose(dad);
    Dispose(lson);
  except
    Raise ElzhException.Create('LZH : Error freeing memory for dictionary tables');
  end;
END;

Procedure LZHPack(VAR Bytes_Written:LongInt; GetBytes:GetBytesProc; PutBytes:PutBytesProc);
VAR
   ct : BYTE;
   i, len, r, s, last_match_length : Int16;
   Got : WORD;
BEGIN
  InitLZH;
  try
    textsize := 0;			{ rewind and rescan }
    StartHuff;
    InitTree;
    s := 0;
    r := N - F;
    FillChar(Text_buf^[0],r,' ');
    len := 0;
    Got := 1;
    While (len < F) AND (Got <> 0) DO BEGIN
      GetBytes(ct,1,Got);
      IF Got <> 0 THEN BEGIN
        text_buf^[r + len] := ct;
        INC(len);
      END;
    END;
    textsize := len;
    FOR i := 1 to F DO begin
      InsertNode(r - i);
    end;
    InsertNode(r);
    REPEAT
      IF (match_length > len) THEN begin
        match_length := len;
      end;
      IF (match_length <= THRESHOLD) THEN BEGIN
        match_length := 1;
              EncodeChar(text_buf^[r],PutBytes);
      END
      ELSE BEGIN
        EncodeChar(255 - THRESHOLD + match_length,PutBytes);
              EncodePosition(match_position,PutBytes);
      END;
      last_match_length := match_length;
      i := 0;
      Got := 1;
      While (i < last_match_length) AND (Got <> 0) DO BEGIN
        GetBytes(ct,1,Got);
        IF Got <> 0 THEN BEGIN
          DeleteNode(s);
          text_buf^[s] := ct;
          IF (s < PRED(F)) THEN begin
            text_buf^[s + N] := ct;
          end;
          s := SUCC(s) AND PRED(N);
          r := SUCC(r) AND PRED(N);
          InsertNode(r);
          inc(i);
        END;
      END; { endwhile }
      INC(textsize,i);
      While (i < last_match_length) DO BEGIN
        INC(i);
        DeleteNode(s);
        s := SUCC(s) AND PRED(N);
        r := SUCC(r) AND PRED(N);
        DEC(len);
        IF BOOLEAN(len) THEN InsertNode(r);
      END; { endwhile }
    UNTIL (len <= 0);  { end repeat }
    EncodeEnd(PutBytes);
  finally
    EndLZH;
  end;
  Bytes_Written := TextSize;
END;

Procedure LZHUnpack(TextSize : Longint; GetBytes:GetBytesProc; PutBytes: PutBytesProc);
VAR
  c, i, j, k, r : Int16;
  c2            : Byte;
  count         : Longint;
  Put           : Word;
BEGIN
  InitLZH;
  try
    StartHuff;
    r := N - F;
    FillChar(text_buf^[0],r,' ');
    Count := 0;
    While count < textsize DO BEGIN
      c := DecodeChar(GetBytes);
      IF (c < 256) THEN BEGIN
        c2 := Lo(c);
              PutBytes(c2,1,Put);
              text_buf^[r] := c;
        INC(r);
              r := r AND PRED(N);
              INC(count);
      END
      ELSE BEGIN                {c >= 256 }
              i := (r - SUCC(DecodePosition(GetBytes))) AND PRED(N);
              j := c - 255 + THRESHOLD;
              FOR k := 0 TO PRED(j) DO BEGIN
                c := text_buf^[(i + k) AND PRED(N)];
          c2 := Lo(c);
                PutBytes(c2,1,Put);
                text_buf^[r] := c;
          INC(r);
                r := r AND PRED(N);
                INC(count);
        END;  { for }
      END;  { if c < 256 }
    END; {endwhile count < textsize }
  finally
    ENDLZH;
  end;
END;



// THIS IS THE IMPLEMENTATION OF "LIGHT" VERSION OF LZRW1 UNIT BY DANNY HEIJL

const
  STITLE          = 'LZH ';
  SCOMMON         = STITLE +'(de)compression : Failed to ';
  SNOMEMORY       = SCOMMON+'get memory for I/O buffers !';
  SNOSIZESTREAM   = SCOMMON+'obtain the size of the input stream !';
  SNOSIZEFILE     = SCOMMON+'obtain the size of : ';
  SINSTREAMERR    = SCOMMON+'initialize input stream !';
  SOUTSTREAMERR   = SCOMMON+'initialize output stream !';
  SINFILEERR      = SCOMMON+'open input file : ';
  SOUTFILEERR     = SCOMMON+'open output file : ';
  SLZRW1FILERIO   = STITLE +': Error reading from input file : ';
  SLZRW1STREAMRIO = STITLE +': Error reading from input stream !';
  SLZRW1FILEWIO   = STITLE +': Error writing to output file : ';
  SLZRW1STREAMWIO = STITLE +': Error writing to output stream !';
  SLZHSIZEEXC     = STITLE +': Original and compressed sizes do not match !';

     { the 2 execute methods : compress and decompress }
     {-------------------------------------------------}

function TLZH.Compress(Size : Integer) : Longint;
begin
  If (Size=0) Then Begin result:=0; Exit End;
  Result := LZHStream(Size);    { compress stream/file }
end;

function TLZH.DeCompress : Longint;
begin
  Result := LZHStream(0); { decompress stream/file }
end;

    { the reader : GetBlock }

Procedure TLZH.GetBlock(VAR Target; NoBytes:Word; VAR Actual_Bytes:Word);
begin
  if (PosnR > Buf) or (PosnR + NoBytes > SUCC(Buf)) then begin
    if PosnR > Buf then begin
       Buf := FInputStream.Read(LZHInBuf^,ChunkSize);
       if (Buf < 0) then Raise ELzrw1Exception.Create(SLZRW1STREAMRIO + ' (LZH)');
       INC(InSize,Buf);
//       Application.ProcessMessages;
    end else begin
      Move(LZHInBuf^[PosnR],LZHInBuf^[1],Buf - PosnR);
      Tmp := FInputStream.Read(LZHInBuf^[Buf-PosnR],ChunkSize - (Buf - PosnR));
      if (Tmp < 0) then Raise ELzrw1Exception.Create(SLZRW1STREAMRIO + ' (LZH)');
//      Application.ProcessMessages;
      INC(InSize,Tmp);
      Buf := Buf - PosnR + Tmp;
    end;

    if Buf = 0 then begin
       Actual_Bytes := 0;
       Exit;
    end;
    PosnR := 1;
  end;

  Move(LZHInBuf^[PosnR],Target,NoBytes);
  INC(PosnR,NoBytes);
  Actual_Bytes := NoBytes;
  if PosnR > SUCC(Buf) then Inc(Actual_Bytes, (SUCC(Buf) - PosnR));
end;

    { and the writer : PutBlock }

Procedure TLZH.PutBlock(VAR Source; NoBytes:Word; VAR Actual_Bytes:Word);

begin
  If NoBytes = 0 then begin   { Flush condition }
    Tmp := FOutputStream.Write(LZHOutBuf^,PRED(PosnW));
    Inc(OutSize, Tmp);
    EXIT;
  end;
  if (PosnW > ChunkSize) or (PosnW + NoBytes > SUCC(ChunkSize)) then begin
    Tmp := FOutputStream.Write(LZHOutBuf^,PRED(PosnW));
    Inc(OutSize, Tmp);
    PosnW := 1;
  end;
  Move(Source,LZHOUTBuf^[PosnW],NoBytes);
  Inc(PosnW,NoBytes);
  Actual_Bytes := NoBytes;
end;

    { the main code common to both (de)compression methods  with LZH }
    {----------------------------------------------------------------}

function TLZH.LZHStream(Size : Integer) : Longint;
var
  NbByte : Longint;
  Tmp    : Word;
begin
  try
    Getmem(SRCBuf, IOBufSize);
    Getmem(DSTBuf, IOBufSize);
    LZHInBuf := PLZHBuf(SRCBuf);
    LZHOutBuf := PLZHBuf(DSTBuf);
  except
    Raise ELzrw1Exception.Create(SNOMEMORY);
  end;
  try
    SrcFh := 0; DstFh := 0;
    if FInputStream.Seek(0, soFromCurrent) < 0 then Raise ELzrw1Exception.Create(SINSTREAMERR);
    if FOutputStream.Seek(0, soFromCurrent) < 0 then Raise ELzrw1Exception.Create(SOUTSTREAMERR);
    OutSize   := 0;
    InSize    := 0;
    ReadProc  := GetBlock;
    WriteProc := PutBlock;
    Buf       := 0;       { initialize put/getblock variables }
    PosnR     := 1;
    PosnW     := 1;
    If (Size>0) Then Begin
      FOutputStream.Write(Size, sizeof(Longint)); Inc(OutSize, SizeOf(LongInt));
      LZHPack(NbByte, ReadProc, WriteProc)
    End Else Begin
      FInputStream.Read(NbByte, sizeof(Longint)); Inc(InSize, SizeOf(LongInt));
      LZHUnPack(NbByte, ReadProc, WriteProc)
    End;
    PutBlock(NbByte, 0, Tmp); { flush last buffer }
  finally
    Freemem(SRCBuf,IOBufSize);
    Freemem(DSTBuf,IOBufSize);
  end;
  Result := OutSize;
end;

// ####################################### SEB CODEC ##########################
// This is my code ; you can use it in terms of my licence.
// Ce code source m'appartient, vous pouvez vous en servir
// dans les termes de ma licence habituelle.

Const
  ESCCode = $FF;   // Code d'échappement dans les séquences compressées
Type
  I = Integer;
  P = Pointer;

procedure SebRLECompress (Src : Pointer ; BytesToCompress : Integer ; Dest : TStream);
var // For 1, 4, 8 Bits per Pixels !
  EndField  : Pointer; // Pointer to the end of the DIB
  LastComp  : Integer; // Pointer to the last compressed byte
  LastCpVal : Byte;    // Last Compressed value
  OUT0      : Byte;    // Byte to Write
  NEXTOUT   : Byte;
  ESCCodeV  : Byte;    // Version variable de la constante
  N         : Integer; // Current Position

Const MaskNbNL : array[0..2] of Byte = ($00, $40, $80);

  procedure ChangeStreamedValue(O : Integer ; V : Byte);
  Begin Dest.Seek(O,soFromCurrent); Dest.Write(V,1); Dest.Seek(-O-1,soFromCurrent) End;

  Function ReadByte : Byte;
  Begin Result := Byte(Src^); Inc(I(Src)) End;

  Procedure WriteCompressedByte; // Ecrit un byte compressé en tenant compte du dernier
  Begin
    If (LastComp<3) Then ChangeStreamedValue(-(2+LastComp),LastCpVal OR MaskNbNL[LastComp])
                    Else Dest.Write(ESCCodeV,1); // Trop vieux, on doit remettre un ESCCode
    LastComp  := 0; // On devra revenir de 2 pour modifier le Nb de répétitions
    LastCpVal := N; // Nb (de répétitions) non modifié
    N         := N OR $C0;
    Dest.Write(N,1); Dest.Write(OUT0,1)
  End;

Begin // Stream.Read give the first byte to read !
  ESCCodeV    := ESCCode;
  I(EndField) := I(Src) + BytesToCompress - 1;
  LastComp    := 10; // Trop loin pour modifier
  OUT0        := ReadByte;
  While (I(Src) <= I(EndField)) Do Begin
    NEXTOUT := ReadByte; N := 1; // Pour l'instant il n'est apparu qu'une fois
    While ((NEXTOUT=OUT0) AND (N<=60) AND (I(Src)<I(EndField))) Do
      Begin NEXTOUT := ReadByte; Inc(N) End;
    If (OUT0=ESCCode) Then // Code d'échappement !
      If (N=1) Then Begin  // Echo du ESCCode
        Dest.Write(ESCCodeV,1); // Code
        If (LastComp>2) Then Dest.Write(ESCCodeV,1); // Doublé
        Inc(LastComp,1);   // On s'éloigne
      End Else WriteCompressedByte // Compression du ESCCode à partir de 2 répétitions !
    Else Case N Of
      1  : Begin Dest.Write(OUT0,1); Inc(LastComp,1) End;
      2  : Begin Dest.Write(OUT0,1); Dest.Write(OUT0,1); Inc(LastComp,2) End;
      else WriteCompressedByte;
    End;
    OUT0 := NEXTOUT;
  End;
  // Déclaration de la fin de l'image
  If (LastComp<3) Then ChangeStreamedValue(-(2+LastComp),LastCpVal OR MaskNbNL[LastComp])
                  Else Dest.Write(ESCCodeV,1); // => On sort toujours par un code d'échappement
  N := 0; Dest.Write(N,1); // Code de fin de ligne
End;

procedure SebRLEDecompress(Src : TStream ; BytesToDeCompress : Integer ; Dest : Pointer );
// BytesToDeCompress is only useful if the Src Stream is not a TMemoryStream (you can set 0 elsewhere)
// BytesToDeCompress est utile seulement quand Src n'est pas un flux mémoire (Autrement on peut passer 0)

var // Optimized For 4 & 8 Bits per Pixels ! Not good for others resolutions.
  {$IFDEF ASM_IMPLEMENTATION} // Allocation ASM, Allocation d'un tampon si besoin et lecture dedans
  Sour    : Pointer;
  EDI, ESI: Integer;
  {$ELSE}
  INBit   : Byte;    // Byte read
  NbNL    : Integer; // Number of Normals pixels after this one
  NbCP    : Integer; // Number of compacted pixel groups
  Expand  : Integer; // Number of times the compressed byte will be written to ToField
Label CompressedMode, NormalMode;
  {$ENDIF}
Begin
  {$IFDEF ASM_IMPLEMENTATION} // Allocation ASM, Allocation d'un tampon si besoin et lecture dedans
  If (Src Is TMemoryStream) Then Sour := P(I(TMemoryStream(Src).Memory) + I(Src.Position))
                                Else GetMem(Sour, BytesToDeCompress);
  Try // We must free the allocated memory zone, whatever happens !
    If Not (Src Is TMemoryStream) Then Src.Read(Sour^,SrcSize);
    ASM
    MOV &EDI, EDI // Sauvegarde
    MOV &ESI, ESI
    // Initialisation des pointeurs
    MOV EDI, [Dest] // Pointe sur le champs de bits de la DIB
    MOV ESI, [Sour] // Pointe sur la source compressée
    // On rentre dans l'automate de Moore : ASM Décompression en cours !
    @NormalMode:
      MOV   AL, [ESI] ; INC ESI // Lecture d'un octet
      CMP   AL, ESCCode
      JZ    @PrepareCompressedMode
      @DoubleESCCode: // En cas de 2 x ESCCode, retour ici
      MOV   [EDI], AL ; INC EDI // Transfert d'un octet
      JMP   @NormalMode

    @PrepareCompressedMode:
      MOV   AL, [ESI] ; INC ESI // Lecture d'un octet
      CMP   AL, ESCCode
      JZ    @DoubleESCCode // Sinon on passe en CompressMode

    @CompressedMode: // (en entrée : AL contient le code de compactage)

      MOVZX EDX, AL  // Copie dans EDX <= AL
      MOV   ECX, EDX // Copie dans ECX
      SHR   EDX, 6   // DL = NbNL
      AND   ECX, $3F // CL = NbCP => ZF est levé si ECX=0 après ce masque !
      JZ @END        // Fin de la DIB Si NbCP=0

      MOV   AL, [ESI] ; INC ESI         // Lecture de l'octet à transférer
      @EXPAND:
        MOV [EDI], AL                   // Affectation du bit à l'image de destination
        INC EDI                         // Déplacement du pointeur Destination
        DEC ECX                         // Décrémentation du compteur
      JNZ @EXPAND                       // Encore d'autre bits à répliquer ?

      MOV   AL, [ESI] ; INC ESI         // Lecture d'un octet => AL
      CMP   EDX, 1
      JB    @CompressedMode
      JZ    @UnOctet
      CMP   EDX, 2
      JZ    @DeuxOctets

    @GoToNormalModeAfter3Bytes:  // Lecture de 2 nouveaux octets et Transfert de 3 octets
      MOV   [EDI], AL ;
      MOV   AX, [ESI];
      MOV   [EDI+1], AX;
      ADD   ESI, 2
      ADD   EDI, 3
      JMP   @NormalMode

    @DeuxOctets:
      MOV   [EDI], AL ; INC EDI // Transfert d'un octet
      MOV   AL, [ESI] ; INC ESI // Lecture d'un octet
    @UnOctet:
      MOV   [EDI], AL ; INC EDI // Transfert d'un octet
      MOV   AL, [ESI] ; INC ESI // Lecture d'un octet
      JMP   @CompressedMode   // On repart en mode compressé

    @END:
    MOV ESI, &ESI // Restauration
    MOV EDI, &EDI
    END;
  Finally
    If (Src Is TMemoryStream) Then Src.Position := Src.Position + SrcSize
                                  Else FreeMem(Sour);
  End;
  {$ELSE} // Implémentation Pascale : lecture du Stream Bit à Bit ~~~~~
  // Stream.Read give the first byte to read !

  // AUTOMATE NORMAL STATE
     NormalMode     : // Mode de lecture Normale (automate de MOORE)
       Src.Read(INBit,1);
       If (INBit=ESCCode) Then Begin
         Src.Read(INBit,1);
         If (INBit<>ESCCode) Then Goto CompressedMode;
       End;
       Byte(Dest^) := INBit; Inc(I(Dest)); // Transfert d'un octet
       Goto NormalMode;

  // AUTOMATE COMPRESSION STATE
     CompressedMode : // Mode de lecture Compressée (automate de MOORE)
     // INBit contient le code de compactage
       NbNL := INBit SHR 6;
       NbCP := INBit AND $3F;
       If (NbCp=0) Then Exit; // Fin de la DIB
       Src.Read(INBit,1);  // Lecture du byte à décompresser
       For Expand := 1 To NbCP Do
         Begin Byte(Dest^) := INBit; Inc(I(Dest)) End; // Transfert de NbCP Octets !
       Src.Read(INBit,1);  // Lecture du suivant : Code ou Pixel ?
       Case NbNL Of
         0 : Goto CompressedMode; // INBit est un code
         1 : Begin // Transfert d'un octet simple avant de continuer en Mode Compressé
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Src.Read(INBit,1); Goto CompressedMode; // INBit est un code
             End;
         2 : Begin // Transfert de deux octets simples avant de continuer en Mode Compressé
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Src.Read(INBit,1);
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Src.Read(INBit,1); Goto CompressedMode; // INBit est un code
             End;
         3 : Begin // Transfert de trois octets simples avant de continuer en Mode Normal
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Src.Read(INBit,1);
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Src.Read(INBit,1);
               Byte(Dest^) := INBit; Inc(I(Dest));  // INBit est un pixel
               Goto NormalMode;
             End;
       End;
  {$ENDIF}
End;

end.
