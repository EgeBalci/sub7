unit DECConst;

interface

{$I VER.INC}

{$IFDEF VER_D3H}
resourcestring
{$ELSE}
const
{$ENDIF}
// DECUTils.pas (all parts)
  sProtectionCircular  = 'Circular Protection detected, Protection Object is invalid.';
  sStringFormatExists  = 'String Format "%d" not exists.';
  sInvalidStringFormat = 'Input is not an valid %s Format.';
  sInvalidFormatString = 'Input can not be convert to %s Format.';
  sFMT_COPY            = 'copy Input to Output';
  sFMT_HEX             = 'Hexadecimal';
  sFMT_HEXL            = 'Hexadecimal lowercase';
  sFMT_MIME64          = 'MIME Base 64';
  sFMT_UU              = 'UU Coding';
  sFMT_XX              = 'XX Coding';

// Cipher.pas (Part I)
  sInvalidKey          = 'Encryptionkey is invalid';
  sInvalidCRC          = 'Encrypted Data is corrupt, invalid Checksum';
  sInvalidKeySize      = 'Length from Encryptionkey is invalid.'#13#10+
                         'Keysize for %s must be to %d-%d bytes';
  sNotInitialized      = '%s is not initialized call Init() or InitKey() before.';
  sInvalidMACMode      = 'Invalid Ciphermode selected to produce a MAC.'#13#10 +
                         'Please use Modes cmCBC, cmCTS, cmCFB, cmCBCMAC, cmCFBMAC or cmCTSMAC for CalcMAC.';
  sCantCalc            = 'Invalid Ciphermode selected.';

implementation

end.
