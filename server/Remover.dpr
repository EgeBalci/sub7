program Whatever;

uses Windows,ShellApi;

{$R *.RES}


begin
 ShellExecute(handle, 'open', pchar(ParamStr(0)), Nil, Nil, SW_HIDE);
end.
