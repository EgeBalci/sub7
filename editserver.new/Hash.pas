{Copyright:      Hagen Reddmann  mailto:HaReddmann@AOL.COM
 Author:         Hagen Reddmann
 Remarks:        freeware, but this Copyright must be included
 known Problems: none
 Version:        3.0,  Part I from Delphi Encryption Compendium (DEC Part I)
                 Delphi 2-4, BCB 3-4, designed and testet under D3 and D4
 Description:    Include Objects for calculating various Hash's (fingerprints)
                 used Hash-Algorithm:
                   MD4, MD5, SHA, SHA1, RipeMD (128 - 320),
                   Haval (128 - 256), Snefru, Square, Tiger,
                   Sapphire II (128 - 320)
                 used Checksum-Algo:
                   CRC32, XOR32bit, XOR16bit, CRC16-CCITT, CRC16-Standard

 Comments:       for Designer's, the Buffer from Method Transform must be readonly

 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.        

Digest size, Result from DigestKeySize and Datasize for Digest
   MD4         16 byte   128 bit   4x Integer
   MD5         16 byte   128 bit   4x Integer
   SHA         20 byte   160 bit   5x Integer
   SHA1        20 byte   160 bit   5x Integer
   RMD128      16 byte   128 bit   4x Integer
   RMD160      20 byte   160 bit   5x Integer
   RMD256      32 byte   256 bit   8x Integer
   RMD320      40 byte   320 bit  10x Integer
   Haval256    32 byte   256 bit   8x Integer
   Haval224    28 byte   224 bit   7x Integer
   Haval192    24 byte   192 bit   6x Integer
   Haval160    20 byte   160 bit   5x Integer
   Haval128    16 byte   128 bit   4x Integer
   Sapphire320 40 byte   320 bit  10x Integer
   Sapphire288 36 byte   288 bit   9x Integer
   Sapphire256 32 byte   256 bit   8x Integer
   Sapphire224 28 byte   224 bit   7x Integer
   Sapphire192 24 byte   192 bit   6x Integer
   Sapphire160 20 byte   160 bit   5x Integer
   Sapphire128 16 byte   128 bit   4x Integer
   Snefru      32 byte   256 bit   8x Integer
   Square      16 byte   128 bit   4x Integer
   Tiger       24 byte   192 bit   6x Integer   in D4 used 64bit Arithmetic

   XOR16     2 byte    16 bit   1x Word
   XOR32     4 byte    32 bit   1x Integer
   CRC32     4 byte    32 bit   1x Integer
   CRC16     2 byte    16 bit   1x Word
}

unit Hash;

interface

uses SysUtils, Classes, DECUtil;

{$I VER.INC}

type
{all Hash Classes}
  THash_MD4             = class;
  THash_MD5             = class;


 {the Base-Class of all Hashs}

  THashClass = class of THash;

  THash = class(TProtection)
  protected
    class function TestVector: Pointer; virtual; {must override}
    procedure CodeInit(Action: TPAction); override; {TProtection Methods, You can use a Hash to En/Decode}
    procedure CodeDone(Action: TPAction); override; {TProtection Methods}
    procedure CodeBuf(var Buffer; const BufferSize: Integer; Action: TPAction); override; {TProtection Methods}
    procedure Protect(IsInit: Boolean); {calls any installed Protection}
  public
    destructor Destroy; override;
    procedure Init; virtual;
    procedure Calc(const Data; DataSize: Integer); virtual; {must override}
    procedure Done; virtual;
    function DigestKey: Pointer; virtual; {must override}
    function DigestStr(Format: Integer): String;

    class function DigestKeySize: Integer; virtual; {must override}
{$IFDEF VER_D4H} // new features from D4
    class function CalcBuffer(const Buffer; BufferSize: Integer; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): String; overload;
    class function CalcStream(const Stream: TStream; StreamSize: Integer; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): String; overload;
    class function CalcString(const Data: String; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): String; overload;
    class function CalcFile(const FileName: String; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): String; overload;
{$ELSE}
    class function CalcBuffer(const Buffer; BufferSize: Integer; Protection: TProtection; Format: Integer): String;
    class function CalcStream(const Stream: TStream; StreamSize: Integer; Protection: TProtection; Format: Integer): String;
    class function CalcString(const Data: String; Protection: TProtection; Format: Integer): String;
    class function CalcFile(const FileName: String; Protection: TProtection; Format: Integer): String;
{$ENDIF}    
{test the correct working}
    class function SelfTest: Boolean;
  end;

// HMAC's - Hash Message Authentication Code's
  TMAC = class(TProtection) // generic MAC, encrypt Password with any AProtection and XOR's with
  protected                 // the Initstate from the Hash (DigestKey)
    FPassword: String;      // final Digest is encrypted with AProtecion
    procedure Init(Hash: THash); virtual;    // Only used in all THash Descends
    procedure Done(Hash: THash); virtual;    // Only used in all THash Descends
  public
    constructor Create(const Password: String; AProtection: TProtection);
    destructor Destroy; override;
  end;

  TMAC_RFC2104 = class(TMAC) // RFC2104 HMAC Protection, these make from any THash_XXX an HMAC-XXXX
  private                    // full compatible with RFC2104 Standard, see Docus\RFC2104 & RFC2202
    function CalcPad(Hash: Thash; XORCode: Byte): String;
  protected
    procedure Init(Hash: THash); override;
    procedure Done(Hash: THash); override;
  end;

  THash_MD4 = class(THash)
  private
    FCount: LongWord;
    FBuffer: array[0..63] of Byte;
    FDigest: array[0..9] of LongWord;
  protected
    class function TestVector: Pointer; override;
    procedure Transform(Buffer: PIntArray); virtual;
  public
    class function DigestKeySize: Integer; override;
    procedure Init; override;
    procedure Done; override;
    procedure Calc(const Data; DataSize: Integer); override;
    function DigestKey: Pointer; override;
  end;

  THash_MD5 = class(THash_MD4)
  protected
    class function TestVector: Pointer; override;
    procedure Transform(Buffer: PIntArray); override;
  end;


function DefaultHashClass: THashClass;
procedure SetDefaultHashClass(HashClass: THashClass);
function RegisterHash(const AHash: THashClass; const AName, ADescription: String): Boolean;
function UnregisterHash(const AHash: THashClass): Boolean;
function HashList: TStrings;
procedure HashNames(List: TStrings);
function GetHashClass(const Name: String): THashClass;
function GetHashName(HashClass: THashClass): String;

implementation


const
// used as default for TCipher in .InitKey(),
// the hashed Password is used as real Key,
// RipeMD256 produce a 256 bit Key (32 Bytes)
// a Key Attack have 2^256 Variants to test, when the
// Cipher all Bit's use, i.E. Blowfish, Gost, SCOP, Twofish
  FDefaultHashClass: THashClass = THash_MD5;
  FHashList: TStringList = nil;

// RFC2104 HMAC Algorithm Parameters
  RFC2104_Size = 64;  // Size of Padding in Bytes
  RFC2104_IPad = $36; // XOR Value from Inner Pad
  RFC2104_OPad = $5C; // XOR Value from outer Pad

function DefaultHashClass: THashClass;
begin
  Result := FDefaultHashClass;
end;

procedure SetDefaultHashClass(HashClass: THashClass);
begin
  if HashClass = nil then FDefaultHashClass := THash_MD5
    else FDefaultHashClass := HashClass;
end;

function RegisterHash(const AHash: THashClass; const AName, ADescription: String): Boolean;
var
  I: Integer;
  S: String;
begin
  Result := False;
  if AHash = nil then Exit;
  S := Trim(AName);
  if S = '' then
  begin
    S := AHash.ClassName;
    if S[1] = 'T' then Delete(S, 1, 1);
    I := Pos('_', S);
    if I > 0 then Delete(S, 1, I);
  end;
  S := S + '=' + ADescription;
  I := HashList.IndexOfObject(Pointer(AHash));
  if I < 0 then HashList.AddObject(S, Pointer(AHash))
    else HashList[I] := S;
  Result := True;
end;

function UnregisterHash(const AHash: THashClass): Boolean;
var
  I: Integer;
begin
  Result := False;
  repeat
    I := HashList.IndexOfObject(Pointer(AHash));
    if I < 0 then Break;
    Result := True;
    HashList.Delete(I);
  until False;
end;

function HashList: TStrings;
begin
  if not IsObject(FHashList, TStringList) then FHashList := TStringList.Create;
  Result := FHashList;
end;

procedure HashNames(List: TStrings);
var
  I: Integer;
begin
  if not IsObject(List, TStrings) then Exit;
  for I := 0 to HashList.Count-1 do
    List.AddObject(FHashList.Names[I], FHashList.Objects[I]);
end;

function GetHashClass(const Name: String): THashClass;
var
  I: Integer;
  N: String;
begin
  Result := nil;
  N := Name;
  I := Pos('_', N);
  if I > 0 then Delete(N, 1, I);
  for I := 0 to HashList.Count-1 do
    if AnsiCompareText(N, GetShortClassName(TClass(FHashList.Objects[I]))) = 0 then
    begin
      Result := THashClass(FHashList.Objects[I]);
      Exit;
    end;
  I := FHashList.IndexOfName(N);
  if I >= 0 then Result := THashClass(FHashList.Objects[I]);
end;

function GetHashName(HashClass: THashClass): String;
var
  I: Integer;
begin
  I := HashList.IndexOfObject(Pointer(HashClass));
  if I >= 0 then Result := FHashList.Names[I]
    else Result := GetShortClassName(HashClass);
end;

destructor THash.Destroy;
begin
  FillChar(DigestKey^, DigestKeySize, 0);
  inherited Destroy;
end;

procedure THash.Init;
begin
  Protect(True);
end;

procedure THash.Calc(const Data; DataSize: Integer);
begin
end;

procedure THash.Protect(IsInit: Boolean);
begin
  if Protection <> nil then
    if IsObject(Protection, TMAC) then
    begin
      with TMAC(Protection) do
        if IsInit then Init(Self) else Done(Self);
    end else
      if not IsInit then
        Protection.CodeBuffer(DigestKey^, DigestKeySize, paScramble);
end;

procedure THash.Done;
begin
  Protect(False);
end;

function THash.DigestKey: Pointer;
begin
  Result := GetTestVector;
end;

class function THash.DigestKeySize: Integer;
begin
  Result := 0;
end;

function THash.DigestStr(Format: Integer): String;
begin
  Result := StrToFormat(DigestKey, DigestKeySize, Format);
end;

class function THash.TestVector: Pointer;
begin
  Result := GetTestVector;
end;

class function THash.CalcStream(const Stream: TStream; StreamSize: Integer; Protection: TProtection; Format: Integer): String;
const
  maxBufSize = 1024 * 4;  {Buffersize for File, Stream-Access}
var
  Buf: Pointer;
  BufSize: Integer;
  Size: Integer;
  Hash: THash;
begin
  Hash := Create(Protection);
  with Hash do
  try
    Buf := AllocMem(maxBufSize);
    Init;
    if StreamSize < 0 then
 {if Size < 0 then reset the Position, otherwise, calc with the specific
  Size and from the aktual Position in the Stream}
    begin
      Stream.Position := 0;
      StreamSize := Stream.Size;
    end;
    Size := StreamSize;
    DoProgress(Hash, 0, Size);
    repeat
      BufSize := StreamSize;
      if BufSize > maxBufSize then BufSize := maxBufSize;
      BufSize := Stream.Read(Buf^, BufSize);
      if BufSize <= 0 then Break;
      Calc(Buf^, BufSize);
      Dec(StreamSize, BufSize);
      DoProgress(Hash, Size - StreamSize, Size);
    until BufSize <= 0;
    Done;
    Result := StrToFormat(DigestKey, DigestKeySize, Format);
  finally
    DoProgress(Hash, 0, 0);
    Free;
    ReallocMem(Buf, 0);
  end;
end;

class function THash.CalcString(const Data: String; Protection: TProtection; Format: Integer): String;
begin
  with Create(Protection) do
  try
    Init;
    Calc(PChar(Data)^, Length(Data));
    Done;
    Result := StrToFormat(DigestKey, DigestKeySize, Format);
  finally
    Free;
  end;
end;

class function THash.CalcFile(const FileName: String; Protection: TProtection; Format: Integer): String;
var
  S: TFileStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    Result := CalcStream(S, S.Size, Protection, Format);
  finally
    S.Free;
  end;
end;

class function THash.CalcBuffer(const Buffer; BufferSize: Integer; Protection: TProtection; Format: Integer): String;
begin
  with Create(Protection) do {create an Object from my Classtype}
  try
    Init;
    Calc(Buffer, BufferSize);
    Done;
    Result := StrToFormat(DigestKey, DigestKeySize, Format);
  finally
    Free; {destroy it}
  end;
end;

class function THash.SelfTest: Boolean;
var
  Test: String;
begin
  Test := CalcBuffer(GetTestVector^, 32, nil, fmtCOPY);
  Result := InitTestIsOk and (MemCompare(PChar(Test), TestVector, Length(Test)) = 0);
end;

procedure THash.CodeInit(Action: TPAction);
begin
  Init;
  if Action = paWipe then RndXORBuffer(RndTimeSeed, DigestKey^, DigestKeySize);
  inherited CodeInit(Action);
end;

procedure THash.CodeDone(Action: TPAction);
begin
  inherited CodeDone(Action);
  if (Action <> paCalc) then Init else Done;
end;

procedure THash.CodeBuf(var Buffer; const BufferSize: Integer; Action: TPAction);
var
  BPtr: PByte;
  CSize,DSize,BSize: Integer;
begin
  if Action <> paDecode then inherited CodeBuf(Buffer, BufferSize, Action);
  if Action in Actions then
  begin
    BPtr := @Buffer;
    if BPtr = nil then Exit;
    DSize := DigestKeySize;
    CSize := BufferSize;
    if Action = paCalc then
    begin
      Calc(Buffer, BufferSize);
    end else
    begin
      if Action in [paScramble, paWipe] then
      begin
        while CSize > 0 do
        begin
          BSize := CSize;
          if BSize > DSize then BSize := DSize;
          Calc(BPtr^, BSize);
          Done;
          Move(DigestKey^, BPtr^, BSize);
          Dec(CSize, BSize);
          Inc(BPtr, BSize);
        end;
      end else
        while CSize > 0 do
        begin
          BSize := DSize;
          if BSize > CSize then BSize := CSize;
          Calc(DigestKey^, DSize);
          Done;
          XORBuffers(DigestKey, BPtr, BSize, BPtr);
          Dec(CSize, BSize);
          Inc(BPtr, BSize);
        end;
    end;
  end;
  if Action = paDecode then
    inherited CodeBuf(Buffer, BufferSize, Action);
end;

procedure TMAC.Init(Hash: THash);
var
  Key: String;
begin
  if Length(FPassword) > 0 then
  begin
    Key := Hash.CalcString(FPassword, Protection, fmtCOPY);
    XORBuffers(Hash.DigestKey, PChar(Key), Length(Key), Hash.DigestKey);
    FillChar(PChar(Key)^, Length(Key), $AA);
    FillChar(PChar(Key)^, Length(Key), $55);
    FillChar(PChar(Key)^, Length(Key), 0);
  end;
end;

procedure TMAC.Done(Hash: THash);
begin
  if Protection <> nil then
    Protection.CodeBuffer(Hash.DigestKey^, Hash.DigestKeySize, paScramble);
end;

constructor TMAC.Create(const Password: String; AProtection: TProtection);
begin
  inherited Create(AProtection);
  SetLength(FPassword, Length(Password));
  Move(PChar(Password)^, PChar(FPassword)^, Length(Password));
end;

destructor TMAC.Destroy;
var
  I: Integer;
begin
  I := Length(FPassword);
  if I > 0 then
  begin
    FillChar(PChar(FPassword)^, I, $AA);
    FillChar(PChar(FPassword)^, I, $55);
    FillChar(PChar(FPassword)^, I, 0);
  end;
  FPassword := '';
  inherited Destroy;
end;

function TMAC_RFC2104.CalcPad(Hash: THash; XORCode: Byte): String;
var
  I: Integer;
begin
  I := Length(FPassword);
  if I > RFC2104_Size then Result := Hash.CalcString(FPassword, nil, fmtCOPY)
    else Result := FPassword;
  UniqueString(Result);
  for I := 1 to Length(Result) do
    Byte(Result[I]) := Byte(Result[I]) xor XORCode;
  I := Length(Result);
  SetLength(Result, RFC2104_Size);
  FillChar(Result[I +1], RFC2104_Size - I, XORCode);
end;

procedure TMAC_RFC2104.Init(Hash: THash);
var
  IPad: String;
begin
  if Length(FPassword) > 0 then
  begin
    IPad := CalcPad(Hash, RFC2104_IPad);
    Hash.Calc(PChar(IPad)^, Length(IPad));
  end;
end;

procedure TMAC_RFC2104.Done(Hash: THash);
var
  OPad: String;
begin
  if Length(FPassword) > 0 then
  begin
    OPad := CalcPad(Hash, RFC2104_OPad);
    with THashClass(Hash.ClassType).Create(nil) do
    try
      Init;
      Calc(PChar(OPad)^, Length(OPad));
      Calc(Hash.DigestKey^, DigestKeySize);
      Done;
      Move(DigestKey^, Hash.DigestKey^, DigestKeySize);
    finally
      Free;
    end;
  end;
  if Protection <> nil then
    Protection.CodeBuffer(Hash.DigestKey^, Hash.DigestKeySize, paScramble);
end;

class function THash_MD4.TestVector: Pointer; assembler;
asm
         MOV   EAX,OFFSET @Vector
         RET
@Vector: DB    025h,0EAh,0BFh,0CCh,08Ch,0C9h,06Fh,0D9h
         DB    02Dh,0CFh,07Eh,0BDh,07Fh,087h,07Ch,07Ch
end;

procedure THash_MD4.Transform(Buffer: PIntArray);
{calculate the Digest, fast}
var
  A, B, C, D: LongWord;
begin
  A := FDigest[0];
  B := FDigest[1];
  C := FDigest[2];
  D := FDigest[3];

  Inc(A, Buffer[ 0] + (B and C or not B and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 1] + (A and B or not A and C)); D := D shl  7 or D shr 25;
  Inc(C, Buffer[ 2] + (D and A or not D and B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[ 3] + (C and D or not C and A)); B := B shl 19 or B shr 13;
  Inc(A, Buffer[ 4] + (B and C or not B and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 5] + (A and B or not A and C)); D := D shl  7 or D shr 25;
  Inc(C, Buffer[ 6] + (D and A or not D and B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[ 7] + (C and D or not C and A)); B := B shl 19 or B shr 13;
  Inc(A, Buffer[ 8] + (B and C or not B and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 9] + (A and B or not A and C)); D := D shl  7 or D shr 25;
  Inc(C, Buffer[10] + (D and A or not D and B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[11] + (C and D or not C and A)); B := B shl 19 or B shr 13;
  Inc(A, Buffer[12] + (B and C or not B and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[13] + (A and B or not A and C)); D := D shl  7 or D shr 25;
  Inc(C, Buffer[14] + (D and A or not D and B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[15] + (C and D or not C and A)); B := B shl 19 or B shr 13;

  Inc(A, Buffer[ 0] + $5A827999 + (B and C or B and D or C and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 4] + $5A827999 + (A and B or A and C or B and C)); D := D shl  5 or D shr 27;
  Inc(C, Buffer[ 8] + $5A827999 + (D and A or D and B or A and B)); C := C shl  9 or C shr 23;
  Inc(B, Buffer[12] + $5A827999 + (C and D or C and A or D and A)); B := B shl 13 or B shr 19;
  Inc(A, Buffer[ 1] + $5A827999 + (B and C or B and D or C and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 5] + $5A827999 + (A and B or A and C or B and C)); D := D shl  5 or D shr 27;
  Inc(C, Buffer[ 9] + $5A827999 + (D and A or D and B or A and B)); C := C shl  9 or C shr 23;
  Inc(B, Buffer[13] + $5A827999 + (C and D or C and A or D and A)); B := B shl 13 or B shr 19;
  Inc(A, Buffer[ 2] + $5A827999 + (B and C or B and D or C and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 6] + $5A827999 + (A and B or A and C or B and C)); D := D shl  5 or D shr 27;
  Inc(C, Buffer[10] + $5A827999 + (D and A or D and B or A and B)); C := C shl  9 or C shr 23;
  Inc(B, Buffer[14] + $5A827999 + (C and D or C and A or D and A)); B := B shl 13 or B shr 19;
  Inc(A, Buffer[ 3] + $5A827999 + (B and C or B and D or C and D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 7] + $5A827999 + (A and B or A and C or B and C)); D := D shl  5 or D shr 27;
  Inc(C, Buffer[11] + $5A827999 + (D and A or D and B or A and B)); C := C shl  9 or C shr 23;
  Inc(B, Buffer[15] + $5A827999 + (C and D or C and A or D and A)); B := B shl 13 or B shr 19;

  Inc(A, Buffer[ 0] + $6ED9EBA1 + (B xor C xor D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 8] + $6ED9EBA1 + (A xor B xor C)); D := D shl  9 or D shr 23;
  Inc(C, Buffer[ 4] + $6ED9EBA1 + (D xor A xor B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[12] + $6ED9EBA1 + (C xor D xor A)); B := B shl 15 or B shr 17;
  Inc(A, Buffer[ 2] + $6ED9EBA1 + (B xor C xor D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[10] + $6ED9EBA1 + (A xor B xor C)); D := D shl  9 or D shr 23;
  Inc(C, Buffer[ 6] + $6ED9EBA1 + (D xor A xor B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[14] + $6ED9EBA1 + (C xor D xor A)); B := B shl 15 or B shr 17;
  Inc(A, Buffer[ 1] + $6ED9EBA1 + (B xor C xor D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[ 9] + $6ED9EBA1 + (A xor B xor C)); D := D shl  9 or D shr 23;
  Inc(C, Buffer[ 5] + $6ED9EBA1 + (D xor A xor B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[13] + $6ED9EBA1 + (C xor D xor A)); B := B shl 15 or B shr 17;
  Inc(A, Buffer[ 3] + $6ED9EBA1 + (B xor C xor D)); A := A shl  3 or A shr 29;
  Inc(D, Buffer[11] + $6ED9EBA1 + (A xor B xor C)); D := D shl  9 or D shr 23;
  Inc(C, Buffer[ 7] + $6ED9EBA1 + (D xor A xor B)); C := C shl 11 or C shr 21;
  Inc(B, Buffer[15] + $6ED9EBA1 + (C xor D xor A)); B := B shl 15 or B shr 17;

  Inc(FDigest[0], A);
  Inc(FDigest[1], B);
  Inc(FDigest[2], C);
  Inc(FDigest[3], D);
end;

class function THash_MD4.DigestKeySize: Integer;
begin
  Result := 16;
end;

function THash_MD4.DigestKey: Pointer;
begin
  Result := @FDigest;
end;

procedure THash_MD4.Init;
begin
  FillChar(FBuffer, SizeOf(FBuffer), 0);
{all Descend from MD4 (MD4, SHA1, RipeMD128, RipeMD160, RipeMD256) use this Init-Key}
  FDigest[0] := $67452301;
  FDigest[1] := $EFCDAB89;
  FDigest[2] := $98BADCFE;
  FDigest[3] := $10325476;
  FDigest[4] := $C3D2E1F0;
{for RMD320}
  FDigest[5] := $76543210;
  FDigest[6] := $FEDCBA98;
  FDigest[7] := $89ABCDEF;
  FDigest[8] := $01234567;
  FDigest[9] := $3C2D1E0F;
  FCount := 0;
  Protect(True);
end;

procedure THash_MD4.Done;
var
  I: Integer;
  S: Comp;
begin
  I := FCount and $3F;
  FBuffer[I] := $80;
  Inc(I);
  if I > 64 - 8 then
  begin
    FillChar(FBuffer[I], 64 - I, 0);
    Transform(@FBuffer);
    I := 0;
  end;
  FillChar(FBuffer[I], 64 - I, 0);
  S := FCount * 8;
  Move(S, FBuffer[64 - 8], SizeOf(S));
  Transform(@FBuffer);
  FillChar(FBuffer, SizeOf(FBuffer), 0);
  Protect(False);
end;

procedure THash_MD4.Calc(const Data; DataSize: Integer);
var
  Index: Integer;
  P: PChar;
begin
  if DataSize <= 0 then Exit;
  Index := FCount and $3F;
  Inc(FCount, DataSize);
  if Index > 0 then
  begin
    if DataSize < 64 - Index then
    begin
      Move(Data, FBuffer[Index], DataSize);
      Exit;
    end;
    Move(Data, FBuffer[Index], 64 - Index);
    Transform(@FBuffer);
    Index := 64 - Index;
    Dec(DataSize, Index);
  end;
  P := @TByteArray(Data)[Index];
  Inc(Index, DataSize and not $3F);
  while DataSize >= 64 do
  begin
    Transform(Pointer(P));
    Inc(P, 64);
    Dec(DataSize, 64);
  end;
  Move(TByteArray(Data)[Index], FBuffer, DataSize);
end;

class function THash_MD5.TestVector: Pointer;
asm
         MOV   EAX,OFFSET @Vector
         RET
@Vector: DB    03Eh,0D8h,034h,08Ch,0D2h,0A4h,045h,0D6h
         DB    075h,05Dh,04Bh,0C9h,0FEh,0DCh,0C2h,0C6h
end;

procedure THash_MD5.Transform(Buffer: PIntArray);
var
  A, B, C, D: LongWord;
begin
  A := FDigest[0];
  B := FDigest[1];
  C := FDigest[2];
  D := FDigest[3];

  Inc(A, Buffer[ 0] + $D76AA478 + (D xor (B and (C xor D)))); A := A shl  7 or A shr 25 + B;
  Inc(D, Buffer[ 1] + $E8C7B756 + (C xor (A and (B xor C)))); D := D shl 12 or D shr 20 + A;
  Inc(C, Buffer[ 2] + $242070DB + (B xor (D and (A xor B)))); C := C shl 17 or C shr 15 + D;
  Inc(B, Buffer[ 3] + $C1BDCEEE + (A xor (C and (D xor A)))); B := B shl 22 or B shr 10 + C;
  Inc(A, Buffer[ 4] + $F57C0FAF + (D xor (B and (C xor D)))); A := A shl  7 or A shr 25 + B;
  Inc(D, Buffer[ 5] + $4787C62A + (C xor (A and (B xor C)))); D := D shl 12 or D shr 20 + A;
  Inc(C, Buffer[ 6] + $A8304613 + (B xor (D and (A xor B)))); C := C shl 17 or C shr 15 + D;
  Inc(B, Buffer[ 7] + $FD469501 + (A xor (C and (D xor A)))); B := B shl 22 or B shr 10 + C;
  Inc(A, Buffer[ 8] + $698098D8 + (D xor (B and (C xor D)))); A := A shl  7 or A shr 25 + B;
  Inc(D, Buffer[ 9] + $8B44F7AF + (C xor (A and (B xor C)))); D := D shl 12 or D shr 20 + A;
  Inc(C, Buffer[10] + $FFFF5BB1 + (B xor (D and (A xor B)))); C := C shl 17 or C shr 15 + D;
  Inc(B, Buffer[11] + $895CD7BE + (A xor (C and (D xor A)))); B := B shl 22 or B shr 10 + C;
  Inc(A, Buffer[12] + $6B901122 + (D xor (B and (C xor D)))); A := A shl  7 or A shr 25 + B;
  Inc(D, Buffer[13] + $FD987193 + (C xor (A and (B xor C)))); D := D shl 12 or D shr 20 + A;
  Inc(C, Buffer[14] + $A679438E + (B xor (D and (A xor B)))); C := C shl 17 or C shr 15 + D;
  Inc(B, Buffer[15] + $49B40821 + (A xor (C and (D xor A)))); B := B shl 22 or B shr 10 + C;

  Inc(A, Buffer[ 1] + $F61E2562 + (C xor (D and (B xor C)))); A := A shl  5 or A shr 27 + B;
  Inc(D, Buffer[ 6] + $C040B340 + (B xor (C and (A xor B)))); D := D shl  9 or D shr 23 + A;
  Inc(C, Buffer[11] + $265E5A51 + (A xor (B and (D xor A)))); C := C shl 14 or C shr 18 + D;
  Inc(B, Buffer[ 0] + $E9B6C7AA + (D xor (A and (C xor D)))); B := B shl 20 or B shr 12 + C;
  Inc(A, Buffer[ 5] + $D62F105D + (C xor (D and (B xor C)))); A := A shl  5 or A shr 27 + B;
  Inc(D, Buffer[10] + $02441453 + (B xor (C and (A xor B)))); D := D shl  9 or D shr 23 + A;
  Inc(C, Buffer[15] + $D8A1E681 + (A xor (B and (D xor A)))); C := C shl 14 or C shr 18 + D;
  Inc(B, Buffer[ 4] + $E7D3FBC8 + (D xor (A and (C xor D)))); B := B shl 20 or B shr 12 + C;
  Inc(A, Buffer[ 9] + $21E1CDE6 + (C xor (D and (B xor C)))); A := A shl  5 or A shr 27 + B;
  Inc(D, Buffer[14] + $C33707D6 + (B xor (C and (A xor B)))); D := D shl  9 or D shr 23 + A;
  Inc(C, Buffer[ 3] + $F4D50D87 + (A xor (B and (D xor A)))); C := C shl 14 or C shr 18 + D;
  Inc(B, Buffer[ 8] + $455A14ED + (D xor (A and (C xor D)))); B := B shl 20 or B shr 12 + C;
  Inc(A, Buffer[13] + $A9E3E905 + (C xor (D and (B xor C)))); A := A shl  5 or A shr 27 + B;
  Inc(D, Buffer[ 2] + $FCEFA3F8 + (B xor (C and (A xor B)))); D := D shl  9 or D shr 23 + A;
  Inc(C, Buffer[ 7] + $676F02D9 + (A xor (B and (D xor A)))); C := C shl 14 or C shr 18 + D;
  Inc(B, Buffer[12] + $8D2A4C8A + (D xor (A and (C xor D)))); B := B shl 20 or B shr 12 + C;

  Inc(A, Buffer[ 5] + $FFFA3942 + (B xor C xor D)); A := A shl  4 or A shr 28 + B;
  Inc(D, Buffer[ 8] + $8771F681 + (A xor B xor C)); D := D shl 11 or D shr 21 + A;
  Inc(C, Buffer[11] + $6D9D6122 + (D xor A xor B)); C := C shl 16 or C shr 16 + D;
  Inc(B, Buffer[14] + $FDE5380C + (C xor D xor A)); B := B shl 23 or B shr  9 + C;
  Inc(A, Buffer[ 1] + $A4BEEA44 + (B xor C xor D)); A := A shl  4 or A shr 28 + B;
  Inc(D, Buffer[ 4] + $4BDECFA9 + (A xor B xor C)); D := D shl 11 or D shr 21 + A;
  Inc(C, Buffer[ 7] + $F6BB4B60 + (D xor A xor B)); C := C shl 16 or C shr 16 + D;
  Inc(B, Buffer[10] + $BEBFBC70 + (C xor D xor A)); B := B shl 23 or B shr  9 + C;
  Inc(A, Buffer[13] + $289B7EC6 + (B xor C xor D)); A := A shl  4 or A shr 28 + B;
  Inc(D, Buffer[ 0] + $EAA127FA + (A xor B xor C)); D := D shl 11 or D shr 21 + A;
  Inc(C, Buffer[ 3] + $D4EF3085 + (D xor A xor B)); C := C shl 16 or C shr 16 + D;
  Inc(B, Buffer[ 6] + $04881D05 + (C xor D xor A)); B := B shl 23 or B shr  9 + C;
  Inc(A, Buffer[ 9] + $D9D4D039 + (B xor C xor D)); A := A shl  4 or A shr 28 + B;
  Inc(D, Buffer[12] + $E6DB99E5 + (A xor B xor C)); D := D shl 11 or D shr 21 + A;
  Inc(C, Buffer[15] + $1FA27CF8 + (D xor A xor B)); C := C shl 16 or C shr 16 + D;
  Inc(B, Buffer[ 2] + $C4AC5665 + (C xor D xor A)); B := B shl 23 or B shr  9 + C;

  Inc(A, Buffer[ 0] + $F4292244 + (C xor (B or not D))); A := A shl  6 or A shr 26 + B;
  Inc(D, Buffer[ 7] + $432AFF97 + (B xor (A or not C))); D := D shl 10 or D shr 22 + A;
  Inc(C, Buffer[14] + $AB9423A7 + (A xor (D or not B))); C := C shl 15 or C shr 17 + D;
  Inc(B, Buffer[ 5] + $FC93A039 + (D xor (C or not A))); B := B shl 21 or B shr 11 + C;
  Inc(A, Buffer[12] + $655B59C3 + (C xor (B or not D))); A := A shl  6 or A shr 26 + B;
  Inc(D, Buffer[ 3] + $8F0CCC92 + (B xor (A or not C))); D := D shl 10 or D shr 22 + A;
  Inc(C, Buffer[10] + $FFEFF47D + (A xor (D or not B))); C := C shl 15 or C shr 17 + D;
  Inc(B, Buffer[ 1] + $85845DD1 + (D xor (C or not A))); B := B shl 21 or B shr 11 + C;
  Inc(A, Buffer[ 8] + $6FA87E4F + (C xor (B or not D))); A := A shl  6 or A shr 26 + B;
  Inc(D, Buffer[15] + $FE2CE6E0 + (B xor (A or not C))); D := D shl 10 or D shr 22 + A;
  Inc(C, Buffer[ 6] + $A3014314 + (A xor (D or not B))); C := C shl 15 or C shr 17 + D;
  Inc(B, Buffer[13] + $4E0811A1 + (D xor (C or not A))); B := B shl 21 or B shr 11 + C;
  Inc(A, Buffer[ 4] + $F7537E82 + (C xor (B or not D))); A := A shl  6 or A shr 26 + B;
  Inc(D, Buffer[11] + $BD3AF235 + (B xor (A or not C))); D := D shl 10 or D shr 22 + A;
  Inc(C, Buffer[ 2] + $2AD7D2BB + (A xor (D or not B))); C := C shl 15 or C shr 17 + D;
  Inc(B, Buffer[ 9] + $EB86D391 + (D xor (C or not A))); B := B shl 21 or B shr 11 + C;

  Inc(FDigest[0], A);
  Inc(FDigest[1], B);
  Inc(FDigest[2], C);
  Inc(FDigest[3], D);
end;

{$IFDEF VER_D3H}
procedure ModuleUnload(Module: Integer);
var
  I: Integer;
begin
  if IsObject(FHashList, TStringList) then
    for I := HashList.Count-1 downto 0 do
      if FindClassHInstance(TClass(FHashList.Objects[I])) = Module then
        FHashList.Delete(I);
end;
{$ENDIF}

initialization
{$IFDEF VER_D3H}
  AddModuleUnloadProc(ModuleUnload);
{$ENDIF}
{$IFNDEF ManualRegisterClasses}
  RegisterHash(THash_MD4, 'Message Digest 4', 'Hash');
  RegisterHash(THash_MD5, 'Message Digest 5', 'Hash');
{$ENDIF}
finalization
{$IFDEF VER_D3H}
  RemoveModuleUnloadProc(ModuleUnload);
{$ENDIF}
  FHashList.Free;
  FHashList := nil;
end.

