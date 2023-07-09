//****************************************************************************//
//***** INCLUSION DE DIBFX dans DIBULTRA.PAS : EFFET SPECIAUX OPTIMISES  *****//
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

Const
  MaskVRB = $07E0F81F; // Fichu masque 16 bpp sur 2 pixels
  MaskRB  = $F81F;     // Fichu masque 16 bpp sur 1 pixel

//############################################################
//###########  ALPHA BLIT A 33 NIVEAUX DE DENSITE  ###########
//###########  Sébastien LEON CopyLeft GNU 5/1999  ###########
//############################################################


procedure TDIBUltra.AlphaChanelBlit(Dest : TDIBUltra; x, y, Num : integer);

{$IFDEF NEVER_DEFINED}
  ######### ALPHA BLITTING ROUTINE : COMMON USAGE ##########
  ##                                                      ##
  ## Cette routine fonctionne de la manière suivante :    ##
  ## L'' appel se fait par exemple :                      ##
  ##       Src.AlphaChanelBlit(Dest, x, y, Num)           ##
  ##                                                      ##
  ## Où Src est DIBUltra chargée par une image *.udc      ##
  ##    (une UltraDIB normale à laquelle on a             ##
  ##     ensuite affecté un masque Alpha 32 niveaux)      ##
  ## Où Dest est DIBUltra                                 ##
  ## Où x est la position de départ en x du Blit          ##
  ## Où y est la position de départ en y du Blit          ##
  ## (pour x et y = 0 on se place à la première ligne et  ##
  ##  à la première colonne de la destination.)           ##
  ## Où Num est le numéro de couche Alpha (Animation)     ##
  ##                                                      ##
  ## En fonction des valeurs données par le pilote Alpha  ##
  ## fourni par la Src, les pixels sources vont se mêler  ##
  ## à ceux de l''image destination.                      ##
  ## L''image de Destination DOIT être de TDUPixelFormat  ##
  ## = à DUpf16.                                          ##
  ## Cette version supporte 33 niveaux de transparence.   ##
  ## La transparence 0 restitue entièrement la valeur du  ##
  ## pixel de l''image de Dest tandis qu''une transp. de  ##
  ## 32 affecte à Dest la valeur exacte du pixel de Src.  ##
  ##                                                      ##
  ## Cette implémentation ne gère pas encore le clipping  ##
  ## ni l''animation : on veuilleras donc à ce que Src    ##
  ## placée en x,y tienne dans Dest et que Num = 1.       ##
  ##                                                      ##
  ##########################################################
{$ENDIF}

var
  BorneOK   : Boolean;
  // For ASM Implementation
  AdrDest   : Pointer; // Adresse du début de ligne de l'image destination
  AdrSrc    : Pointer; // Adresse du début de ligne de l'image source
  AdrAlpha  : Pointer; // Adresse du pilote Alpha
  AdrDtInc  : LongInt; // Incrément pour passer d'une ligne n en n+1 (== Width_b) pour l'img Dest
  AdrSrInc  : LongInt; // Incrément pour passer d'une ligne n en n+1 (== Width_b) pour l'img Src
  ESI, EDI  : LongInt; // Sauvegarde Registres
  EBX       : LongInt; // Sauvegarde Registres
  RBGTmp    : LongInt;
  GRBTmp    : LongInt;
  Tmp1      : LongInt;
  MulA, MulB: LongInt;

Begin
  If (Alpha=nil) Then Raise Exception.Create('Cette DIBUltra ne supporte pas le traitement Alpha.');
  If (Num<>1) Then Raise Exception.Create('AlphaBlit ne supporte pas encore l''animation. (Num doit être = 1)');
  If (Self.PixelFormat<>DUpf16) Then Raise Exception.Create('La DIBUltra a afficher par filtre Alpha doit être une image à 16 Bpp !');
  If (Dest.PixelFormat<>DUpf16) Then Raise Exception.Create('L''image en Destination doit être une image à 16 Bpp !');
  // Vérification des bornes :
  BorneOK := (x>=0) AND (y>=0) AND ((x+DIBWidth) <= Dest.Width) AND ((y+DIBHeight) <= Dest.Height);
  If (Not BorneOK) Then Raise Exception.Create('Le clipping n''est pas encore supporté.'#13'Le sprite doit tenir entièrement dans l''image de destination.');
  // OK, Initialisation des Adresses
  AdrDest  := P(I(Dest.Scanline[y]) + 2*x);
  AdrSrc   := DIBBits;
  AdrAlpha := P(I(Alpha) + SizeOf(TAlphaMaskHeader));
  AdrDtInc := Dest.ByteWidth;
  AdrSrInc := DIBWidth_b;
  ASM
  MOV  &ESI, ESI         // Save Register
  MOV  &EDI, EDI
  MOV  &EBX, EBX

  MOV  ESI,  AdrSrc      // Initialisation des pointeurs
  MOV  EDI,  AdrDest
  MOV  EBX,  AdrAlpha
  SUB  EBX,  2           // On lira la valeur suivante

  @DoItAgain:            // Boucle globale

  ADD   EBX, 2           // Déplacement du pointeur sur le pilote Alpha
  MOV   AX,  [EBX]       // Lecture du pilote Alpha \ AH = Densité | AL = Répétition
  AND   EAX, $FFFF       // Levée du Zero Flag si AX=0
  JZ    @EOL             // Si Valeur = 0 => Goto @EndOfLine:
  MOV   ECX, EAX         // Initialisation du compteur de répétition
  AND   ECX, $FF         // On ne garde que la valeur de répétition
  SHR   EAX, 8           // D'une pierre deux coups : EAX=Densité et levée du flag Z
  JZ    @TRANSP          // Si Densité = 0 alors transparence totale
  CMP   EAX, $20         // Test de la densité : a-t-on une densité de 32 ?
  JZ    @OPAQUE          // Si Densité = 32 alors opacité totale
  MOV   MulA, EAX        // Stockage du Multiplicateur A
  SUB   EAX, 32          // complément du ...
  NEG   EAX              // ... facteur multiplicateur
  MOV   MulB, EAX        // Stockage du Multiplicateur B


  @NORMAL: // ***** TRAITEMENT DES PIXELS DE DENSITE INCLUSE ENTRE 1 ET 14
  SHR   ECX, 1           // On divise le compteur par deux
  JNC   @NORMALPAIR      // Si il était pair, on traite les pixels 2 par 2

  // RAPPEL : Pixel au format 16Bpp : RRRRRVVV VVVBBBBB ; Masque  : $F800 $07E0 $001F
  // Traitement du pixel source source
    MOV   AX, [ESI]        // Recopie d'un pixel From Source
    MOV   EDX, EAX         // Copie en DX
    AND   EAX, MaskRB      // On garde le rouge et le bleu
    AND   EDX, Not MaskRB  // On garde le vert
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    MOV   RBGTmp, EDX      // Sauvegarde en RBGTmp
    MUL   MulA             // ## MULTIPLICATION ##
    MOV   GRBTmp, EAX      // Sauvegarde en GRBTmp
    MOV   EAX,  RBGTmp     // Rechargement du Vert
    MUL   WORD PTR [MulA]  // ## MULTIPLICATION ##
    MOV   RBGTmp, EAX      // Sauvegarde en RBGTmp
    // Traitement du Pixel Destination
    MOV   EAX, [EDI]       // Recopie d'un pixel From Dest
    MOV   EDX, EAX         // Copie en DX
    AND   EAX, MaskRB      // On garde le rouge et le bleu
    AND   EDX, Not MaskRB  // On garde le vert
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    MOV   Tmp1, EDX        // Sauvegarde en Tmp1
    MUL   MulB             // ## MULTIPLICATION ##
    ADD   GRBTmp, EAX      // Addition avec la valeur sauvegardée en GRBTmp
    MOV   EAX, Tmp1        // Rechargement du Vert
    MUL   WORD PTR [MulB]  // ## MULTIPLICATION ##
    ADD   EAX, RBGTmp      // Addition avec la valeur sauvegardée en RBGTmp
    MOV   EDX, GRBTmp      // Rechargement de la valeur intermédiaire
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    AND   EDX, MaskRB      // On garde le rouge et le bleu
    AND   EAX, Not MaskRB  // On garde le vert
    OR    EAX, EDX         // Assemblage des RVB
    MOV   [EDI], AX        // Recopie du pixel vers la destination

    ADD  ESI, 2            // Déplacement du pointeur Source d'un pixel
    ADD  EDI, 2            // Déplacement du pointeur Destination d'un pixel
    CMP  ECX, 0            // C'est fini ?
    JZ   @DoItAgain        // Oui le compteur est à zéro | Non : on traite 2 par 2

  @NORMALPAIR:             // On traite les pixels deux par deux
  // RAPPEL : Pixel au format 16Bpp : RRRRRVVV VVVBBBBB ; Masque  : $F800 $07E0 $001F
  // Traitement du pixel source source
    MOV   EAX, [ESI]       // Recopie d'un pixel From Source
    MOV   EDX, EAX         // Copie en DX
    AND   EAX, MaskVRB     // On garde le rouge et le bleu
    AND   EDX, Not MaskVRB // On garde le vert
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    MOV   RBGTmp, EDX      // Sauvegarde en RBGTmp
    MUL   MulA             // ## MULTIPLICATION ##
    MOV   GRBTmp, EAX      // Sauvegarde en GRBTmp
    MOV   EAX,  RBGTmp     // Rechargement du Vert
    MUL   MulA             // ## MULTIPLICATION ##
    MOV   RBGTmp, EAX      // Sauvegarde en RBGTmp
    // Traitement du Pixel Destination
    MOV   EAX, [EDI]       // Recopie d'un pixel From Dest
    MOV   EDX, EAX         // Copie en DX
    AND   EAX, MaskVRB     // On garde le rouge et le bleu
    AND   EDX, Not MaskVRB // On garde le vert
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    MOV   Tmp1, EDX        // Sauvegarde en Tmp1
    MUL   MulB             // ## MULTIPLICATION ##
    ADD   GRBTmp, EAX      // Addition avec la valeur sauvegardée en GRBTmp
    MOV   EAX, Tmp1        // Rechargement du Vert
    MUL   MulB             // ## MULTIPLICATION ##
    ADD   EAX, RBGTmp      // Addition avec la valeur sauvegardée en RBGTmp
    MOV   EDX, GRBTmp      // Rechargement de la valeur intermédiaire
    SHR   EDX, 5           // ## DIVISION PAR 32 ##
    AND   EDX, MaskVRB     // On garde le rouge et le bleu
    AND   EAX, Not MaskVRB // On garde le vert
    OR    EAX, EDX         // Assemblage des RVB
    MOV   [EDI], EAX       // Recopie du pixel vers la destination

    ADD  ESI, 4            // Déplacement du pointeur Source de 2 pixels
    ADD  EDI, 4            // Déplacement du pointeur Destination de 2 pixels
    LOOP @NORMALPAIR       // C'est fini ?
  JMP @DoItAgain           // On repart ...

  @TRANSP: // ***** TRAITEMENT DES PIXELS DE DENSITE ZERO
  SHR  ECX, 1           // On divise le compteur par deux
  JNC  @TRANSPAIR       // Si il était pair, on traite les pixels 2 par 2
    ADD  ESI, 2         // Déplacement du pointeur Source
    ADD  EDI, 2         // Déplacement du pointeur Destination
    CMP  ECX, 0         // C'est fini ?
    JZ   @DoItAgain     // Oui le compteur est à zéro
  @TRANSPAIR:           // On traite les pixels deux par deux
    ADD  ESI, 4         // Déplacement du pointeur Source de 2 pixels
    ADD  EDI, 4         // Déplacement du pointeur Destination de 2 pixels
    LOOP @TRANSPAIR     // C'est fini ?
  JMP @DoItAgain        // On repart ...

  @OPAQUE: // ***** TRAITEMENT DES PIXELS DE DENSITE TOTALE
  SHR  ECX, 1           // On divise le compteur par deux
  JNC  @OPAQPAIR        // Si il était pair, on traite les pixels 2 par 2
    MOV  AX, [ESI]      // Recopie d'un pixel From Source
    MOV  [EDI], AX      // Recopie d'un pixel To Dest
    ADD  ESI, 2         // Déplacement du pointeur Source d'1 pixel
    ADD  EDI, 2         // Déplacement du pointeur Destination d'1 pixel
    CMP  ECX, 0         // C'est fini ?
    JZ   @DoItAgain     // Oui le compteur est à zéro
  @OPAQPAIR:            // On traite les pixels deux par deux
    MOV  EAX, [ESI]     // Recopie de 2 pixels From Source
    MOV  [EDI], EAX     // Recopie de 2 pixels To Dest
    ADD  ESI, 4         // Déplacement du pointeur Source de 2 pixels
    ADD  EDI, 4         // Déplacement du pointeur Destination de 2 pixels
    LOOP @OPAQPAIR      // C'est fini ?
  JMP @DoItAgain        // Allez, c'est pas fini !

  @EOL:    // ***** TRAITEMENT D'UN CODE END OF LINE
  MOV  AX,  [EBX+2]     // Lecture du pilote Alpha sans décaler le pointeur
  OR   AX,  AX          // Levée du Zero Flag
  JZ   @END             // Deux CODE END OF LINE = END OF IMG
  MOV  ESI, AdrSrc      // On recharge l'adresse de début de la ligne Source
  MOV  EDI, AdrDest     // On recharge l'adresse de début de la ligne Destination
  ADD  ESI, AdrSrInc    // On y rajoute le nb de bytes/ligne : ligne suivante
  ADD  EDI, AdrDtInc    // On y rajoute le nb de bytes/ligne : ligne suivante
  MOV  AdrSrc,  ESI     // Mise à Jour dans la pile
  MOV  AdrDest, EDI     // Mise à Jour dans la pile
  JMP  @DoItAgain       // C'est reparti

@End:
  MOV  ESI, &ESI        // Restauration des registres
  MOV  EDI, &EDI
  MOV  EBX, &EBX
  End;
End;



//############################################################
//###########     ALPHA BLIT DE DENSITE DEFINIE    ###########
//###########  Sébastien LEON CopyLeft GNU 5/1999  ###########
//############################################################

// Warning : On utilise le tas ! Ne pas placer en pile
var Dens1, Dens2  : LongInt;

procedure TDIBUltra.AlphaBlit(Dest : TDIBUltra; x, y, Dens : integer);

{$IFDEF NEVER_DEFINED}
  ######### ALPHA BLITTING ROUTINE : COMMON USAGE ##########
  ##                                                      ##
  ## Cette routine fonctionne de la manière suivante :    ##
  ## L'' appel se fait par exemple :                      ##
  ##           Src.AlphaBlit(Dest, x, y, Dens)            ##
  ##                                                      ##
  ## Où Src est DIBUltra                                  ##
  ## Où Dest est DIBUltra                                 ##
  ## Où x est la position de départ en x du Blit          ##
  ## Où y est la position de départ en y du Blit          ##
  ## (pour x et y = 0 on se place à la première ligne et  ##
  ##  à la première colonne de la destination.)           ##
  ## Où Dens est la densité du blend appliqué :           ##
  ##   Une densité de 0 indique une transparence complète ##
  ##   de Src sur Dest.                                   ##
  ##   Une densité de 32 indique une transparence nulle   ##
  ##   de Src sur Dest (Opacité complète)                 ##
  ##                                                      ##
  ## Cette implémentation ne gère pas encore le clipping  ##
  ## vrai : on veuillera donc à ce que Src ne dépasse pas ##
  ## de Dest.                                             ##
  ##                                                      ##
  ##########################################################
{$ENDIF}
var
  BorneOK   : Boolean;
  // For ASM Implementation
  AdrDest   : Pointer; // Adresse du début de ligne de l'image destination
  AdrSrc    : Pointer; // Adresse du début de ligne de l'image source
  AdrDtInc  : LongInt; // Incrément pour passer d'une ligne n en n+1 (== Width_b) pour l'img Dest
  AdrSrInc  : LongInt; // Incrément pour passer d'une ligne n en n+1 (== Width_b) pour l'img Src
  NbLignes  : LongInt; // Nombre de lignes à traiter
  NbDWord   : LongInt; // Nombre de paires de pixels
  ESI, EDI  : LongInt; // Sauvegarde Registres
  EBX, ESP  : LongInt; // Sauvegarde Registres

Begin
  If (Dens<=00) Then Exit; // Transparence complète. Self est invisible
  If (Dens>=32) Then Begin Dest.Canvas.CopyRect(ClpRect,Cnv,ClpRect); Exit End; // Transparence nulle. Self est opaque sur Dest
  If (Self.PixelFormat<>DUpf16) Then Raise Exception.Create('La DIBUltra à afficher par filtre Alpha doit être une image à 16 Bpp !');
  If (Dest.PixelFormat<>DUpf16) Then Raise Exception.Create('L''image en Destination doit être une image à 16 Bpp !');
  // Vérification des bornes :
  BorneOK := (x>=0) AND (y>=0) AND ((x+DIBWidth) <= Dest.Width) AND ((y+DIBHeight) <= Dest.Height);
  If (Not BorneOK) Then Raise Exception.Create('Le clipping n''est pas encore supporté.'#13'Dest doit contenir la DIB fournissant le blend.');
  // OK, Initialisation des Adresses
  AdrDest    := P(I(Dest.Scanline[y]) + 2*x);
  AdrSrc     := DIBBits;
  AdrDtInc   := Dest.ByteWidth;
  AdrSrInc   := DIBWidth_b;
  NbDWord    := DIBWidth_b div 4;
  NbLignes   := DIBHeight;
  Dens1      := Dens;
  Dens2      := 32-Dens;
  ASM
  MOV  &ESI, ESI         // Save Register
  MOV  &EDI, EDI
  MOV  &EBX, EBX
  MOV  &ESP, ESP         // NE PAS TRACER : On détourne le pointeur de pile !

  MOV  ESI,  AdrSrc      // Initialisation des pointeurs
  MOV  EDI,  AdrDest

@SUITELIGNE:

  MOV  ECX,  NbDWord // Compteur de pixels initialisé
  @SUITEPIXEL:
  // RAPPEL : Pixel au format 16Bpp : RRRRRVVV VVVBBBBB ; Masque  : $F800 $07E0 $001F
    MOV  EAX, [ESI]       // EAX = RGBRGB (Source)
    MOV  EBX, EAX         // On dédouble
    AND  EAX, MaskVRB     // EAX = _V_R_B (Source)
    AND  EBX, Not MaskVRB // EBX = R_B_V_ (Source)
    SHR  EBX, 5           // EBX = _R_B_V (Source)
    IMUL EAX, Dens1       // * Dens2
    IMUL EBX, Dens1       // * Dens1
    MOV  EDX, [EDI]       // EDX = RGBRGB (Destin)
    MOV  ESP, EDX         // On dédouble
    AND  EDX, MaskVRB     // EDX = _V_R_B (Destin)
    AND  ESP, Not MaskVRB // ESP = R_B_V_ (Destin)
    SHR  ESP, 5           // ESP = _R_B_V (Destin)
    IMUL EDX, Dens2       // * Dens2
    IMUL ESP, Dens2       // * Dens1
    ADD  EAX, EDX         // EAX = VxRxBx (Fusion)
    ADD  EBX, ESP         // EBX = RxVxBx (Fusion)
    SHR  EAX, 5           // EAX = _VxRxB (Fusion)
    AND  EBX, Not MaskVRB // EBX = R_V_B_ (Fusion)
    AND  EAX, MaskVRB     // EAX = _V_R_B (Fusion)
    OR   EAX, EBX         // EAX + EBX : Fusion terminée
    MOV  [EDI], EAX

    ADD  ESI, 4      // Déplacement des pointeurs
    ADD  EDI, 4

  LOOP @SUITEPIXEL

  // Fin de la boucle / Incrémentation des pointeurs
  MOV  ESI, AdrSrc      // On recharge l'adresse de début de la ligne Source
  MOV  EDI, AdrDest     // On recharge l'adresse de début de la ligne Destination
  ADD  ESI, AdrSrInc    // On y rajoute le nb de bytes/ligne : ligne suivante
  ADD  EDI, AdrDtInc    // On y rajoute le nb de bytes/ligne : ligne suivante
  MOV  AdrSrc,  ESI     // Mise à Jour dans la pile
  MOV  AdrDest, EDI     // Mise à Jour dans la pile

  DEC  [NbLignes]       // A-t-on fini ?
  JNZ  @SUITELIGNE      // Non...

  @End:
  MOV  ESP, &ESP        // Restauration des registres
  MOV  ESI, &ESI
  MOV  EDI, &EDI
  MOV  EBX, &EBX
  End;
End;


