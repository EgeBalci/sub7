(*
  OutBar version 1.01 (03/08/1999)
  Copyright (C) 1999 by Sylvain Frere
  e-mail: fbrother@club-internet.fr

  Description : An OutLook "like" bar control.
  Features :
    - Small and large icons
    - Smooth scrolling
    - Self drag / drop
    - Files shell drop
    - Menu shortcut
    - Keyboard support
    - Items Multi-selection
    - File Input / output in text and binary stream format
    - In place edit for pages and items caption

  Version 1.01 03/08/1999
    Correction for delphi4
      - Remove some unused code of imagelist
      - Fix problems with oleDrop
      - Add WMDestroy to remove OleDragDrop hook

  Version 1.00
    Original release

*)
unit uOutBar;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, DsgnIntf, Inpledt, oleDrop, Menus, StdCtrls, Buttons, ExtCtrls,
  Spin, MainColors, Parole;

type
  TOutBase = class;
  TOutItem = class;
  TOutPage = class;
  TOutPages= class;

  TOutBase = class(TComponent)
  private
    Frc      : TRect;
    FrcText  : TRect;
    FVisible : Boolean;
    FEnabled : Boolean;
    FReadOnly: Boolean;
    function GetInView:Boolean;
  protected
    procedure AnyChange(aItem:TOutBase); virtual;
    procedure SelectionChange(aItem:ToutBase); virtual;
    procedure Notify(aItem:TOutBase; Operation:TOperation); virtual;
    procedure Invalidate; virtual;
    function  PtInText(X,Y:Integer):Boolean; virtual;
    function  FindAtXY(X,Y:Integer):TObject; virtual;
    procedure ClearRC; virtual;
    procedure ClearRC2(aRc:TRect); virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function  GetChildOwner: TComponent; override;
    property  InView:Boolean read GetInView;
  public
    constructor Create(aOwner:Tcomponent); override;
    destructor Destroy; override;
  published
    property ReadOnly:Boolean read FreadOnly write FReadOnly default FALSE;
    property Visible:Boolean read FVisible write FVisible default TRUE;
    property Enabled:Boolean read FEnabled write FEnabled default TRUE;
  end;

  TOutItemType = (itNone,itscMenu,itscFile,itscFolder);
  TOutItem = class(TOutBase)
  private
    FCaption    : string;
    FImageIndex : Integer;
    FItemType   : TOutItemType;
    FSelected   : Boolean;
    function GetPage:TOutPage;
  protected
    procedure DrawItemText(canvas:TCanvas; iBkColor:TColor; dtOptions:Integer; iDrawFocus,iCalcRect:Boolean); virtual;
    procedure DrawItemIcon(canvas:TCanvas; ibkColor:TColor; iImages:TImageList; iHideHotRect:Boolean); virtual;
  public
    procedure Assign(aItem:TOutItem);
    procedure BringToTop;
    property Page : TOutPage read getPage;
    property Selected : Boolean read FSelected write Fselected;
  published
    property Caption    : string read FCaption write FCaption;
    property ImageIndex : Integer read FImageIndex write FImageIndex;
    property ItemType   : ToutItemType read FItemType write FItemType;
  end;

  TOutPage = class(TOutBase)
  private
    FCaption   : string;
    FSelected  : Boolean;
    FFItem     : Integer;
    FColor     : TColor;
    FBkColor   : TColor;
    FFontStyles: TFontStyles;
    FItemselected : TOutItem;

    function getFirstItem:Integer;
    procedure setFirstItem(value:Integer);
    function getCount:Integer;
    function getItem(index:Integer):TOutItem;

    function ScrollUp:Boolean;
    function ScrollDown:Boolean;
    function CanScrollUp:Boolean;
    function CanScrollDown:Boolean;
    procedure setSelected(value:Boolean);
    function GetPages:TOutPages;
    function GetItemIndex:Integer;
    procedure setItemIndex(value:Integer);
    procedure setItemSelected(value:TOutItem);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Constructor Create(aOwner:TComponent); override;
    procedure Assign(aPage:TOutpage);
    Function Add:TOutItem;
    property Pages : TOutPages read getPages;
    property Count : Integer read getCount;
    property Items[index : Integer]:TOutItem read getItem; default;
    property ItemIndex:Integer read getItemIndex write setItemIndex;
    property ItemSelected:ToutItem read FItemSelected write setItemSelected;
  published
    property Caption   : string read FCaption write FCaption;
    property Color     : TColor read FColor write FColor;
    property BkColor   : TColor read FbkColor write FbkColor;
    property FontStyles: TFontStyles read FFontStyles write FFontStyles;
    property Selected  : Boolean read FSelected write setSelected;
    property FirstItem : Integer read getFirstItem write setFirstItem;
  end;

  TOutPages = class(TOutBase)
  private
    FModified : Boolean;
    FFileName : string;
    function getCount:Integer;
    function getPage(index:Integer):TOutPage;
  protected
    procedure AnyChange(aItem:TOutBase); override;
    procedure SelectionChange(aItem:ToutBase); override;
    procedure Notify(aItem:TOutBase; Operation:TOperation); override;
    procedure Invalidate; override;
    Procedure InternalClear; virtual;
  public
    procedure Assign(aPages:TOutpages);

    Function Add:TOutPage;
    Function FindPageAtXY(x,y:Integer):TOutPage;

    function LoadFromFile(const iFilename:string):boolean;
    function SaveToFile(const Filename:string):boolean;

    property FileName:string read FFileName write FFilename;
    property Count : Integer read getCount;
    property Pages[index : Integer]:TOutPage read getPage; default;
  end;

  TOutBarStyle  = (osLargeIcon,osSmallIcon);
  TOutBarOnDeleteItem = procedure(sender:TObject; item:TOutItem; var canDelete:Boolean) of object;
  TCustomOutBar = class(TcustomControl)
  private
    FPages       : TOutPages;
    FSelected    : TOutPage;
    FHotItem     : TOutItem;
    FClipItems   : TList;
    FBorderStyle : TBorderStyle;
    FLImages     : TImageList;
    FSImages     : TImageList;
    FStyle       : TOutBarStyle;
    FdtOptions   : Integer;
    FColor       : TColor;
    FColorText   : TColor;
    // Basic metrics
    FtxtHeight   : Integer;
    FimgHeight   : Integer;
    FimgWidth    : Integer;
    FimgWidth2   : Integer;
    FimgLeft     : Integer;
    FimgInt      : Integer;
    FrcPlotD     : TRect;
    FrcPlotU     : TRect;
    // Inplace editing
    Feditor      : TinPlaceEdit;
    // Drag-Drop
    FOleDrop     : IWCDropTarget;
    FDragItem    : TOutItem;
    FDragPage    : TOutPage;
    FDragDelay   : dword;
    FDragCtn     : Integer;
    FIgnoreNextUp: Boolean;
    // Smooth Scroll
    FModulo      : Integer;
    // Mouse timers
    FClickTime   : Longint;
    // Special image index
    FimgShellFile: Integer;
    // Menu Hook
    FHHook       : HHOOK;
    FTxtHook     : string;
    FImgHook     : Integer;
    // Events
    FOnClick     : TNotifyEvent;
    FOnDblClick  : TNotifyEvent;
    FOnChange    : TNotifyEvent;
    FOnPageChange: TNotifyEvent;
    FOnDeleteItem: TOutBarOnDeleteItem;

    procedure WMDestroy(var Message: TWMSetFocus); message WM_DESTROY;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDBLCLK(var Message: TWMLButtonUp); message WM_LBUTTONDBLCLK;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMGETDLGCODE(var Message: TMessage); message WM_GETDLGCODE;
    procedure WMUSER_DELAY(var Message: TMessage); message WM_USER+1;

    procedure Frame3D(rc:TRect);
    procedure Frame3DPressed(rc:TRect);
    procedure Box3D(rc:TRect);
    procedure Plot3D(rc:TRect; iArrowUp:Boolean; uFlags:Integer);
    procedure DrawUpArrow(rc:TRect; color:TColor);
    procedure DrawDownArrow(rc:TRect; color:TColor);
    procedure setStyle(value:TOutBarStyle);
    procedure setBorderStyle(value:TBorderStyle);
    procedure ItemSelectionChange(value:TOutItem);
    procedure Notify(aItem:TOutBase; Operation:TOperation);
    procedure setSelected(value:TOutPage);
    function  getItemSelected:TOutItem;
    procedure setItemSelected(value:TOutItem);
    procedure setPageIndex(value:Integer);
    function  getPageIndex:Integer;
    procedure setColor(value:TColor);
    procedure setHotItem(value:TOutItem);
    function  getSelCount:Integer;
    function  getSelected(index:Integer):TOutItem;
    procedure setLImages(value:TImageList);
    procedure setSImages(value:TImageList);
    procedure PtOnPlot(pt:TPoint);
    procedure SmoothScroll(iNewPage:TOutPage);
    procedure InplaceEditPageCaption(aPage:TOutPage);
    procedure InplaceEditItem(aItem:TOutItem);
    procedure DrawPageCaption(aPage:TOutPage);
    procedure PaintPageCaption(var rc:TRect; aPage:TOutPage; iSens:Integer);
    procedure PaintPageItemsLarge(var rc:TRect; aPage:TOutPage);
    procedure PaintPageItemsSmall(var rc:TRect; aPage:TOutPage);
    procedure UnHookMenuMsg;
  protected
    procedure Loaded; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function  GetChildOwner: TComponent; override;
    procedure AnyChange(aItem:TOutBase); virtual;
    procedure ProcessDeleteItem(aItem:TOutItem); virtual;
    procedure ProcessDblItemClick(aItem:TOutItem); virtual;
    procedure ProcessItemClick(aItem:TOutItem); virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    procedure ClearSelected;
    procedure HookNextMenuMsg(const iFormat:string; iImgIndex:Integer);

    property BorderStyle:TBorderStyle read FBorderStyle write setBorderStyle;
    property BackGroundColor:TColor read FColor write setColor;
    property LargeImages:TImageList read FLImages write setLImages;
    property SmallImages:TImageList read FSImages write setSImages;
    property Style:ToutBarStyle read FStyle write setStyle default osLargeIcon;
    property Pages:TOutPages read FPages;
    property CurrentPage:TOutPage read FSelected write setSelected;
    property PageIndex:Integer read getPageIndex write setPageIndex;
    property CurrentItem:TOutItem read getItemSelected write setItemSelected;
    property SmoothSpeed:Integer read FModulo write FModulo;
    property imgShellFile:Integer read FimgShellFile write FimgShellFile;
    property SelCount:Integer read getSelCount;
    property Selected[index:Integer]:TOutItem read getSelected;
    //
    property OnClick     : TNotifyEvent read FOnclick write FOnClick;
    property OnDblClick  : TNotifyEvent read FOnDblclick write FOnDblClick;
    property OnChange    : TNotifyEvent read FOnChange write FOnChange;
    property OnPageChange: TNotifyEvent read FOnPageChange write FOnPageChange;
    property OnDeleteItem: TOutBarOnDeleteItem read FOnDeleteItem write FOnDeleteItem;
  end;

  TOutBar = class(TCustomOutBar)
  published
    // TControl
    property Align;
    property DragCursor;
    property DragMode;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Anchors;

    // TWinControl
    property ParentCtl3D;
    property TabOrder;
    property TabStop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    // TCustomOutBar
    property BorderStyle;
    property BackGroundColor;
    property LargeImages;
    property SmallImages;
    property Style;
    property SmoothSpeed;
    property imgShellFile;
    property Pages;
    //
    property OnClick;
    property OnDblClick;
    property OnChange;
    property OnPageChange;
    property OnDeleteItem;
  end;

   TOutPagesDialog = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtCaption: TEdit;
    Panel2: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnAddPage: TSpeedButton;
    Bevel1: TBevel;
    Container: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    EdtItem: TEdit;
    btnAddItem: TSpeedButton;
    chkEnabled: TCheckBox;
    chkReadOnly: TCheckBox;
    Label3: TLabel;
    edtImgIndex: TSpinEdit;
    chkSmall: TCheckBox;
    PopupMenu1: TPopupMenu;
    miDeletePage: TMenuItem;
    miDeleteItem: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAddPageClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure chkSmallClick(Sender: TObject);
    procedure miDeletePageClick(Sender: TObject);
    procedure miDeleteItemClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    private
     FOutBar : TCustomOutBar;
     function getPages:TOutPages;
     procedure setPages(value:TOutPages);
     procedure setOutBar(value:TCustomOutBar);
    public
     property OutBar: TCustomOutBar read FOutBar write setOutBar;
     property Pages : TOutPages read getPages write setPages;
   end;

   TOutPagesEditor = class(TClassProperty)
   public
     procedure Edit;override;
     function GetAttributes: TPropertyAttributes;override;
   end;


procedure Register;

implementation

{$R *.DFM}

const
  MSGTEXT   = '.S7M';
  MSGBINARY = '.S7a';

  // Delayed operations
  //
  WMDELAY = WM_USER+1;
  DELAY_SELECTPAGE = 0;
  DELAY_STARTDRAG  = 1;
  DELAY_SCROLLUP   = 2;
  DELAY_SCROLLDOWN = 3;

Type
  TDelayThread = class(TThread)
  private
    FDelay : Dword;
    FHwnd  : HWND;
    FMsg   : Integer;
    FwParam: Integer;
    FlParam: Integer;
  protected
  public
    constructor Create(iDelay:Dword; iWnd:HWND; iMsg,iwParam,iLParam:Integer);
    procedure Execute; override;
  end;

constructor TDelayThread.Create(iDelay:Dword; iWnd:HWND; iMsg,iwParam,ilParam:Integer);
begin
  FDelay:=iDelay; FHWnd:=iWnd; FMsg:=iMsg;  FwParam:=iwParam; FlParam:=ilParam;
  Inherited Create(FALSE);
  FreeOnTerminate := TRUE;
end;

procedure TDelayThread.Execute;
begin
  sleep(FDelay);
  PostMessage(FHWnd,FMsg,FwParam,FlParam);
end;
{------------------------------------------------------------------------------}
function GetRGBColor(Value: TColor): Integer;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

function _IsDown(vk:Integer):Boolean;
begin
  Result := (GetKeyState(vk)and $8000)<>0;
end;
{------------------------------------------------------------------------------}
constructor TOutBase.Create(aOwner:Tcomponent);
begin
  Inherited Create(aOwner);
  FVisible  := TRUE;
  FEnabled  := TRUE;
  FReadOnly := FALSE;
end;

Destructor TOutBase.Destroy;
begin
  Notify(self,opRemove);
  Inherited Destroy;
end;

procedure TOutBase.GetChildren(Proc: TGetChildProc; Root: TComponent);
var idx:integer;
begin
  for idx:= 0 to ComponentCount-1 do Proc(Components[idx]);
end;

function TOutBase.GetChildOwner: TComponent;
begin
  Result:= self;
end;

procedure TOutBase.AnyChange(aItem:TOutBase);
begin
  if Owner is TOutBase then TOutBase(Owner).AnyChange(aItem);
end;

procedure TOutBase.SelectionChange(aItem:TOutBase);
begin
  if Owner is TOutBase then TOutBase(Owner).SelectionChange(aItem);
end;

procedure TOutBase.Notify(aItem:TOutBase; Operation:TOperation);
begin
  if Owner is TOutBase then TOutBase(Owner).Notify(aItem,Operation);
end;

procedure TOutBase.Invalidate;
begin
  if Owner is TOutBase then TOutBase(Owner).Invalidate;
end;

function TOutBase.GetInView:Boolean;
begin
  Result := (Not FVisible) or (((Frc.Bottom-Frc.Top)>0) and ((Frc.Right-Frc.Left)>0));
end;

procedure TOutBase.ClearRC;
var idx:Integer;
begin
  FrcText := Rect(0,0,0,0);
  Frc     := Rect(0,0,0,0);
  for idx:=0 to ComponentCount-1 do
   if Components[idx] is TOutBase then
    TOutBase(Components[idx]).ClearRC;
end;

procedure TOutBase.ClearRC2(aRC:Trect);
var idx:Integer; xrc:TRect;
begin
  if IntersectRect(xrc, Frc, aRC) then Frc := Rect(0,0,0,0);
  for idx:=0 to ComponentCount-1 do
   if Components[idx] is TOutBase then
    TOutBase(Components[idx]).ClearRC2(aRC);
end;

function TOutBase.PtInText(X,Y:Integer):Boolean;
begin
  Result := PtInRect(FrcText,Point(x,y));
end;

function TOutBase.FindAtXY(X,Y:Integer):TObject;
var idx:Integer;
begin
  if PtInRect(Frc,Point(x,y)) then begin Result:=self;exit;end;

  if PtInRect(FrcText,Point(x,y)) then begin Result:=self;exit;end;

{  if PtInRect(Frc,Point(x,y)) or
     PtInRect(FrcText,Point(x,y)) then begin Result := self; Exit; end;}

  for idx:=0 to ComponentCount-1 do
   if Components[idx] is TOutBase then
    begin
      Result := TOutBase(Components[idx]).FindAtXY(x,y);
      if Result<>NIL then Exit;
    end;
   Result := NIL;
end;
{------------------------------------------------------------------------------}
procedure TOutItem.Assign(aItem:TOutItem);
begin
  Caption  := aItem.Caption;
  ReadOnly := aItem.ReadOnly;
  Enabled  := aItem.Enabled;
  Visible  := aItem.Visible;
  ImageIndex := aItem.ImageIndex;
end;

procedure TOutItem.BringToTop;
begin
  with ToutPage(Owner) do
    FirstItem := self.ComponentIndex;
end;

function TOutItem.GetPage:TOutPage;
begin
  Result := TOutPage(Owner);
end;

procedure TOutItem.DrawItemIcon(canvas:TCanvas; ibkColor:TColor; iImages:TImageList; iHideHotrect:Boolean);
var imgStyle:Integer; rc:TRect;
begin
{  if iHideHotRect then
   begin
     canvas.brush.color := iBkColor;
     rc := Frc;
     InflateRect(rc,+2,+2);
     canvas.FillRect(rc);
   end;}

  if Not Assigned(iImages) then Exit;

{  with iImages do
    begin

      if Not Enabled then imgStyle := ILD_BLEND50 else imgStyle := ILD_TRANSPARENT;
        ImageList_DrawEx(Handle, ImageIndex, canvas.Handle,
                         Frc.Left, Frc.Top, 0, 0,
                         GetRGBColor(BkColor), GetRGBColor(BlendColor),
                         imgStyle);
    end;}
end;

function StergeAt(ce:string):string;
var keepit:String;
begin
 if (ce[length(ce)-5]='@') and (ce[length(ce)-2]=':') then Result:=Copy(ce,1,length(ce)-6) else Result:=ce;
end;

procedure TOutItem.DrawItemText(canvas:TCanvas; iBkColor:TColor; dtOptions:Integer; iDrawFocus,iCalcRect:Boolean);
var rc:TRect;
begin
  // Draw item Caption
  with canvas do
   begin

     if FSelected
        then Brush.Color := GetSysColor(COLOR_HIGHLIGHT)
        else Brush.Color := iBkColor;
     Font.Color := getSysColor(COLOR_INACTIVECAPTIONTEXT);
     font.color:={StringToColor('$00FF8080')}cMenuItemNormalText;
     if Not enabled{mobman}
        then Font.Style := [fsItalic]
        else Font.Style := [] ;
{     font.name:='arial';
     font.size:=8;}
     if iCalcRect then
       DrawText(Handle, pchar(StergeAt(Caption)), length(StergeAt(Caption)), FrcText, dtOptions+DT_CALCRECT);

     Fillrect(FrcText);
     DrawText(Handle, pchar(StergeAt(Caption)), length(StergeAt(Caption)), FrcText, dtOptions);

     if iDrawFocus and (Page.ItemSelected=Self) then
      begin
       font.color:={StringToColor('$00FEE42E')}cMenuItemSelectedText;
       DrawText(Handle, pchar(StergeAt(Caption)), length(StergeAt(Caption)), FrcText, dtOptions);
      end;
   end;
end;
{------------------------------------------------------------------------------}
Constructor TOutPage.Create(aOwner:TComponent);
begin
  Inherited Create(aOwner);
  FColor   := clWindowText;
  FbkColor := GetSysColor(COLOR_INACTIVEBORDER);
  FFontStyles := [];
end;

procedure TOutPage.Assign(aPage:TOutPage);
var idx:Integer;
begin
  Caption  := aPage.Caption;
  ReadOnly := aPage.ReadOnly;
  Enabled  := aPage.Enabled;
  Visible  := aPage.Visible;
  FColor   := aPage.FColor;
  FBkColor := aPage.FBkColor;
  FFontStyles:= aPage.FFontStyles;

  for idx:=0 to aPage.count-1 do
   TOutItem.Create(self).Assign(aPage.Items[idx]);
end;

Function TOutPage.Add:TOutItem;
begin
  Result := TOutItem.Create(self);
  AnyChange(self);
end;

function TOutPage.getCount:Integer;
begin
  Result := ComponentCount;
end;

function TOutPage.getItem(index:Integer):TOutItem;
begin
  Result := TOutItem(Components[index]);
end;

function TOutPage.getFirstItem:Integer;
begin
  if Count=0 then Result:=-1 else
   begin
     if (FFitem<0)or(FFitem>=Count) then FFItem:=0;
     Result := FFitem;
   end;
end;

procedure TOutPage.setFirstItem(value:Integer);
begin
  if (value>=0)and(value<Count) then FFItem:=value;
end;

function TOutPage.ScrollUp:Boolean;
begin
  Result := FALSE;
  if FFitem=0 then Exit;
  Dec(FFitem);
  Result := TRUE;
end;

function TOutPage.ScrollDown:Boolean;
begin
  Result := FALSE;
  if FFitem>=Count-1 then Exit;
  Inc(FFitem);
  Result := TRUE;
end;

function TOutPage.CanScrollDown:Boolean;
var idx:Integer;
begin

  try if Items[Count-1].InView then begin Result:=FALSE; Exit; end;except Result:=FALSE;exit;end;

  //
  for idx:=Count-1{FFItem} downto 0 do
    if Items[idx].InView then
     begin
       Result := TRUE;
{       Exit; }
     end;
 { Result := TRUE;}
end;

function TOutPage.CanScrollUp:Boolean;
var idx:Integer;
begin
{  if FFitem=Count-1 then begin Result:=FALSE; Exit; end;
  //
  for idx:=Count-1 to 0 do
    if not Items[idx].InView then
     begin
       Result := TRUE;
       Exit;
     end;
  Result := FALSE;}
  Result := (FFitem>0);
end;

procedure TOutPage.setSelected(value:Boolean);
begin
  if FSelected = value then Exit;
  FSelected := value;
end;

function TOutPage.GetPages:TOutPages;
begin
  Result := TOutPages(Owner);
end;

procedure TOutPage.setItemSelected(value:TOutItem);
var oldSelected:TOutItem;
begin
  if (value=NIL)or(value.Page=self)and(value<>FItemselected) then
    begin
      oldSelected   := FItemSelected;

      FItemSelected := value;
      if (Not FItemSelected.InView)and(FSelected) then
        begin
          if FItemSelected.ComponentIndex<FFItem then ScrollDown else ScrollUp;
          Invalidate;
        end;

      if Assigned(oldSelected)   then SelectionChange(oldSelected);
      if Assigned(FItemSelected) then SelectionChange(FItemSelected);
    end;
end;

function TOutPage.GetItemIndex:Integer;
begin
  if Assigned(FItemSelected)
    then Result := FItemSelected.ComponentIndex
    else Result := -1;
end;

procedure TOutPage.setItemIndex(value:Integer);
begin
  if (value=-1) then begin FItemSelected:=NIL; Exit; end;
  if (value>=0)and(value<ComponentCount) then ItemSelected:=Items[value];
end;

procedure TOutPage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) then
   if(aComponent=FItemSelected) then FItemSelected:=NIL;
end;

{------------------------------------------------------------------------------}
procedure TOutPages.Invalidate;
begin
  if Owner is TCustomControl then TCustomControl(Owner).Invalidate;
end;

procedure TOutPages.AnyChange(aItem:TOutBase);
begin
  if Owner is TcustomOutBar then TcustomOutBar(Owner).AnyChange(aItem);
end;

procedure TOutPages.SelectionChange(aItem:ToutBase);
begin
  if (Owner is TcustomOutBar) and
     (aItem is TOutItem)
     then TcustomOutBar(Owner).ItemSelectionChange(TOutItem(aItem));
end;

procedure TOutPages.Notify(aItem:TOutBase; Operation:TOperation);
begin
  if (Owner is TcustomOutBar) and
     ((aItem is TOutItem) or (aItem is TOutPage))
     then TcustomOutBar(Owner).Notify(aItem,Operation);
end;

function TOutPages.LoadFromFile(const iFileName: string): boolean;
var Input, Output: TStream;
    TmpMemo:TStringList;
    pi:integer;
    f:TextFile;
    TmpStr:String;
begin
TmpMemo:=TStringList.Create;
AssignFile(f,iFileName);
Reset(f);TmpMemo.Clear;
while not eof(f) do begin
 ReadLn(f,TmpStr);
 TmpMemo.Add(Decrypt(TmpStr));
end;
CloseFile(f);
{n=16}
pi:=TmpMemo.Count-17;
try
 cMenuBackground:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuPageNormalText:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuPageNormalBorder:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuPageSelectedBorder:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuItemNormalText:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuItemNormalBorder:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuItemSelectedText:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cMenuArrows:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cFormLine:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cFormBackground:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cFormCaption:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cFormText:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cButtonText:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cButtonBorder:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cButtonOverFill:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cButtonClickFill:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
 cFormForeground:=StringToColor(TmpMemo[pi]);TmpMemo.Delete(pi);
except end;
 TmpMemo.SaveToFile(iFileName);
 TmpMemo.Free;
 {}
  result:=false;
  if (pos(MSGTEXT, UpperCase(iFileName))<>0) then
    begin
      Input:= TFileStream.Create(iFileName, fmOpenRead);
      try
        Output:= TMemoryStream.Create;
        try
          ObjectTextToResource(Input, Output);
          Output.Seek(0, soFromBeginning);
          Output.ReadComponentRes(self);
          result:=true;
        except
          result:=false;
        end;
        Output.free;
      except
        result:=false;
      end;
      Input.free;
    end
    else
  if (pos(MSGBINARY, UpperCase(iFileName))<>0) then
    begin
      try
        ReadComponentResFile(iFileName, Self);
        result:=true;
      except
        result:=false;
      end;
    end;
  if Result then FFileName := iFileName;
  AnyChange(self);

TmpMemo:=TStringList.Create;
AssignFile(f,iFileName);
Reset(f);TmpMemo.Clear;
while not eof(f) do begin
 ReadLn(f,TmpStr);
 TmpMemo.Add(Encrypt(TmpStr));
end;
CloseFile(f);
{ultimele n sunt culori}
{16}
with TmpMemo do begin
 Add(Encrypt(ColorToString(cMenuBackground)));
 Add(Encrypt(ColorToString(cMenuPageNormalText)));
 Add(Encrypt(ColorToString(cMenuPageNormalBorder)));
 Add(Encrypt(ColorToString(cMenuPageSelectedBorder)));
 Add(Encrypt(ColorToString(cMenuItemNormalText)));
 Add(Encrypt(ColorToString(cMenuItemNormalBorder)));
 Add(Encrypt(ColorToString(cMenuItemSelectedText)));
 Add(Encrypt(ColorToString(cMenuArrows)));
 Add(Encrypt(ColorToString(cFormLine)));
 Add(Encrypt(ColorToString(cFormBackground)));
 Add(Encrypt(ColorToString(cFormCaption)));
 Add(Encrypt(ColorToString(cFormText)));
 Add(Encrypt(ColorToString(cButtonText)));
 Add(Encrypt(ColorToString(cButtonBorder)));
 Add(Encrypt(ColorToString(cButtonOverFill)));
 Add(Encrypt(ColorToString(cButtonClickFill)));
 Add(Encrypt(ColorToString(cFormForeground)));
end;
TmpMemo.SaveToFile(iFileName);
TmpMemo.Free;
end;

function TOutpages.SaveToFile(const FileName: string): boolean;
var Input, Output: TStream;
    f:TextFile;
    TmpStr:String;
    TmpMemo:TStringList;
begin
  result:=false;
  if (pos(MSGTEXT, UpperCase(FileName))<>0) then
    begin
      Input:= TMemoryStream.Create;
      try
        Input.WriteComponentRes(Name, Self);
        Input.Seek(0, soFromBeginning);
        Output:= TFileStream.Create(FileName, fmCreate);
        try
          ObjectResourceToText(Input, Output);
          result:=true;
        except
          result:=false;
          Output.free;
        end;
        Output.free;
      except
        result:=false;
        Input.free;
      end;
      Input.free;
    end
    else
  if (pos(MSGBINARY, UpperCase(FileName))<>0) then
    begin
      try
        WriteComponentResFile(FileName, Self);
        result:=true;
      except
        result:=false;
      end;
    end;

TmpMemo:=TStringList.Create;
AssignFile(f,FileName);
Reset(f);TmpMemo.Clear;
while not eof(f) do begin
 ReadLn(f,TmpStr);
 TmpMemo.Add(Encrypt(TmpStr));
end;
CloseFile(f);
{ultimele n sunt culori}
{16}
with TmpMemo do begin
 Add(Encrypt(ColorToString(cMenuBackground)));
 Add(Encrypt(ColorToString(cMenuPageNormalText)));
 Add(Encrypt(ColorToString(cMenuPageNormalBorder)));
 Add(Encrypt(ColorToString(cMenuPageSelectedBorder)));
 Add(Encrypt(ColorToString(cMenuItemNormalText)));
 Add(Encrypt(ColorToString(cMenuItemNormalBorder)));
 Add(Encrypt(ColorToString(cMenuItemSelectedText)));
 Add(Encrypt(ColorToString(cMenuArrows)));
 Add(Encrypt(ColorToString(cFormLine)));
 Add(Encrypt(ColorToString(cFormBackground)));
 Add(Encrypt(ColorToString(cFormCaption)));
 Add(Encrypt(ColorToString(cFormText)));
 Add(Encrypt(ColorToString(cButtonText)));
 Add(Encrypt(ColorToString(cButtonBorder)));
 Add(Encrypt(ColorToString(cButtonOverFill)));
 Add(Encrypt(ColorToString(cButtonClickFill)));
 Add(Encrypt(ColorToString(cFormForeground)));
end;
TmpMemo.SaveToFile(FileName);
TmpMemo.Free;
end;

Function TOutPages.Add:TOutPage;
begin
  Result := TOutPage.Create(self);
  AnyChange(self);
end;

function TOutPages.getCount:Integer;
begin
  Result := ComponentCount;
end;

function TOutPages.getPage(index:Integer):TOutPage;
begin
  Result := TOutPage(Components[index]);
end;

Function TOutPages.FindPageAtXY(x,y:Integer):TOutPage;
var idx:Integer; SomeThing2:TOutBase;
begin
  something2 := TOutBase(FindAtXY(x,y));
  if Something2=NIL then
   begin
     Result := NIL;
     for idx:=0 to Count-1 do
      begin
        if Pages[idx].Selected then
          begin
            Result := Pages[idx];
            break;
          end;
      end;
   end
   else
  if something2 is TOutPage then Result := ToutPage(Something2) else
  if something2 is TOutItem then Result := ToutPage(Something2.Owner) else Result:=NIL;
end;

procedure TOutPages.InternalClear;
var idx:Integer;
begin
  for idx:=ComponentCount-1 downto 0 do
    Components[idx].Free;
end;

procedure TOutPages.Assign(aPages:TOutpages);
var idx:Integer;
begin
  InternalClear;
  for idx:=0 to aPages.Count-1 do
    TOutPage.Create(self).Assign(aPages[idx]);
  Invalidate;
end;
{------------------------------------------------------------------------------}

constructor TCustomOutBar.Create(aOwner:TComponent);
begin
  Inherited Create(aOwner);
  Align          := alLeft;
  FPages         := TOutPages.Create(self);
  FSelected      := NIL;
  FBorderStyle   := bsSingle;
  FColor         := GetSysColor(COLOR_INACTIVECAPTION);
  FColorText     := GetSysColor(COLOR_INACTIVECAPTIONTEXT);
  FModulo        := 24;
  FDragDelay     := 500;
  FImgShellFile  := -1;
  TabStop        := TRUE;
  FStyle         := osLargeIcon;
  FClipItems     := TList.Create;
  setBounds(0,0,150,8*321);
end;

destructor TCustomOutBar.Destroy;
begin
  if Assigned(FClipItems) then FClipItems.Free;
  Inherited ;
end;

procedure TCustomOutBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      if FBorderStyle = bsSingle then
        if NewStyleControls and Ctl3D then
          ExStyle := ExStyle or WS_EX_CLIENTEDGE
        else
          Style := Style or WS_BORDER;
    end;
end;

procedure TCustomOutBar.CreateWnd;
begin
  inherited CreateWnd;
  ControlStyle := ControlStyle+[csOpaque];
end;

procedure TCustomOutBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var idx:Integer;
begin
  // Save out "TOutPages" in the objects stream
  for idx:= 0 to ComponentCount-1 do Proc(Components[idx]);
end;

function  TCustomOutBar.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TCustomOutBar.Loaded;
var idx,idp:Integer; aPages:TOutPages; aPage:TOutPage; ls:TList;
begin
  Inherited ;
  // Saved pages had been reloaded in another "TOutPages" container ,
  // transfert these pages in our FPages and delete the unused container
  for idx:=ComponentCount-1 downto 0 do
   if (Components[idx] is TOutPages) and (Components[idx]<>FPages) then
    begin
      aPages := TOutPages(Components[idx]);

      // Need a list to insert pages in correct order.
      ls := TList.Create;
      for idp:=aPages.Count-1 downto 0 do
        begin
          aPage := aPages.Pages[idp];
          aPages.RemoveComponent(aPage);
          ls.Add(aPage);
        end;
      for idp:=ls.count-1 downto 0 do
        FPages.InsertComponent(TOutpage(ls[idp]));
      ls.Free;

      aPages.Free;
    end;
end;

procedure TCustomOutBar.Clear;
begin
  BeginUpdate;
  FSelected := NIL;
  FHotItem  := NIL;
  FDragItem := NIL;
  FDragPage := NIL;
  FPages.InternalClear;
  EndUpdate;
  Invalidate;
end;

procedure TCustomOutBar.setLImages(value:TImageList);
begin
  FLImages := value;
  if Assigned(FLImages) then
   begin
     FLimages.BkColor    := FColor;
     FLimages.BlendColor := FColor;
   end;
end;

procedure TCustomOutBar.setSImages(value:TImageList);
begin
  FSImages := value;
  if Assigned(FSImages) then
   begin
     FSimages.BkColor    := FColor;
     FSimages.BlendColor := FColor;
   end;
end;

procedure TCustomOutBar.AnyChange(aItem:TOutBase);
begin
  if Assigned(FOnChange) then FOnChange(self);
  Invalidate;
end;

procedure TCustomOutBar.setBorderStyle(value:TBorderStyle);
begin
  FBorderStyle := value;
  ReCreateWnd;
end;

procedure TCustomOutBar.setStyle(value:TOutBarStyle);
begin
  if FStyle=value then Exit;
  FStyle := value;
  Invalidate;
end;

procedure TCustomOutBar.setColor(value:TColor);
begin
  FColor := cMenuBackground;
  if Assigned(FLimages) then
   begin
     FLimages.BkColor    := value;
     FLimages.BlendColor := value;
   end;
  if Assigned(FSimages) then
   begin
     FSimages.BkColor    := value;
     FSimages.BlendColor := value;
   end;
  Invalidate;
end;

procedure TCustomOutBar.Frame3D(rc:TRect);
begin
  with rc, Canvas do
   begin
     pen.Color := GetSysColor(COLOR_3DHILIGHT);
     MoveTo(Left,Bottom);
     LineTo(Left,Top);
     LineTo(Right,Top);
     pen.Color := GetSysColor(COLOR_3DDKSHADOW);
     LineTo(Right,Bottom);
     LineTo(Left,Bottom);
   end;
end;

procedure TCustomOutBar.Frame3DPressed(rc:TRect);
begin
  with rc, Canvas do
   begin
     pen.Color := GetSysColor(COLOR_3DDKSHADOW);
     MoveTo(Left,Bottom);
     LineTo(Left,Top);
     LineTo(Right,Top);
     pen.Color := GetSysColor(COLOR_3DDKSHADOW);
     LineTo(Right,Bottom);
     LineTo(Left,Bottom);
   end;
end;

procedure TCustomOutBar.Box3D(rc:TRect);
begin
  with rc, Canvas do
   begin
     pen.Color := GetSysColor(COLOR_3DHILIGHT);
     MoveTo(Left,Bottom);
     LineTo(Left,Top);
     LineTo(Right-1,Top);
     pen.Color := GetSysColor(COLOR_3DDKSHADOW);
     LineTo(Right-1,Bottom);
     LineTo(Left-1,Bottom);
     //
     MoveTo(Right-2,Top+1);
     pen.Color := GetSysColor(COLOR_3DSHADOW);
     LineTo(Right-2,Bottom-1);
     LineTo(Left,Bottom-1);
   end;
end;

procedure TCustomOutBar.DrawDownArrow(rc:TRect; color:TColor);
var x,y,len,idx:Integer;
begin
  // x,y point left,top
  with Canvas do
   begin
     InflateRect(rc,-2,-2);
     x   := rc.Left-1;
     y   := rc.Top + ((rc.Bottom-rc.Top) div 2) -3; //Don't known why 3 instead of 1 !
     len := (rc.Right-rc.Left);

     for idx:=0 to len-1 do
       setPixel(handle,x+idx,y,cMenuArrows);
     dec(len,2); Inc(x); Inc(y);

     while len>0 do
       begin
         for idx:=0 to len-1 do
           if idx=0     then setPixel(handle,x+idx,y,cMenuArrows) else
           if idx=len-1 then setPixel(handle,x+idx,y,cMenuArrows)  else
             setPixel(handle,x+idx,y,color);
         dec(len,2); Inc(x); Inc(y);
       end;
   end;
end;

procedure TCustomOutBar.DrawUpArrow(rc:TRect; color:TColor);
var x,y,len,idx:Integer;
begin
  // x,y point left,bottom
  with canvas do
   begin
     InflateRect(rc,-2,-2);
     x   := rc.Left-1;
     y   := rc.Bottom - ((rc.Bottom-rc.Top) div 2) +1;
     len := (rc.Right-rc.Left);

     for idx:=0 to len-1 do
       setPixel(handle,x+idx,y,cMenuArrows);
{       setPixel(handle,x+idx,y,GetSysColor(COLOR_3DSHADOW));}
     dec(len,2); Inc(x); dec(y);

     while len>0 do
       begin
         for idx:=0 to len-1 do
           if idx=0     then setPixel(handle,x+idx,y,cMenuArrows) else
           if idx=len-1 then setPixel(handle,x+idx,y,cMenuArrows)  else
{           if idx=0     then setPixel(handle,x+idx,y,GetSysColor(COLOR_3DHILIGHT)) else
           if idx=len-1 then setPixel(handle,x+idx,y,GetSysColor(COLOR_3DSHADOW))  else}
              setPixel(handle,x+idx,y,color);
{              setPixel(handle,x+idx,y,color);}
         dec(len,2); Inc(x); Dec(y);
       end;
   end;
end;

procedure TCustomOutBar.Plot3D(rc:TRect; iArrowUp:Boolean; uFlags:Integer);
var col:TColor;
begin
  // uFlags : 0 or DFCS_PUSHED
{  DrawFrameControl(canvas.Handle,rc,DFC_BUTTON, DFCS_BUTTONPUSH+uFlags);}
{  canvas.brush.style:=bsFill;}
  canvas.Brush.Color:=FColor;
  canvas.fillrect(rc);
  col:=FColor;
  if uFlags=DFCS_PUSHED then
   col:=cMenuArrows;
{  if iArrowUp
    then DrawUpArrow(rc,clLime)
    else DrawDownArrow(rc,clLime);}

{  OffsetRect(rc,2,1);}
  if iArrowUp
    then DrawUpArrow(rc,col)
    else DrawDownArrow(rc,col);
end;

procedure TCustomOutBar.BeginUpdate;
begin
  SendMessage(Handle,WM_SETREDRAW,0,0);
end;

procedure TCustomOutBar.EndUpdate;
begin
  SendMessage(Handle,WM_SETREDRAW,1,0);
end;

procedure TCustomOutBar.WMUSER_DELAY(var Message: TMessage);
var pt:TPoint;
begin
  case Message.wParam of
    DELAY_SELECTPAGE :
      if Integer(FDragPage)=Message.lParam then
        begin
{          MessageBeep(0);}
          CurrentPage := FDragPage;
          FDragPage:= NIL;
        end;
    DELAY_STARTDRAG  :
      if (csLButtonDown in ControlState) and (Integer(FHotItem)=Message.lParam) then
        begin
          FDragItem := FHotItem;
          FIgnoreNextUp := TRUE;
          BeginDrag(TRUE);
        end;
    DELAY_SCROLLUP   :
      if FdragCtn = Message.lParam then
        begin
          if FSelected.ScrollUp then Invalidate;
          GetCursorPos(pt);
          PtOnPlot(ScreenToClient(pt));
        end;
    DELAY_SCROLLDOWN :
      if FdragCtn = Message.lParam then
        begin
          if FSelected.ScrollDown then Invalidate;
          GetCursorPos(pt);
          PtOnPlot(ScreenToClient(pt));
        end;
  end;
end;

procedure TCustomOutBar.PtOnPlot(pt:TPoint);
begin
  if PtInRect(FrcPlotU,pt) then
    begin
      Inc(FDragCtn);
      TDelayThread.Create(FDragDelay,Handle,WMDELAY,DELAY_SCROLLUP,FDragCtn);
    end
    else
  if PtInRect(FrcPlotD,pt) then
    begin
      Inc(FDragCtn);
      TDelayThread.Create(FDragDelay,Handle,WMDELAY,DELAY_SCROLLDOWN,FDragCtn);
    end
    else FDragCtn:=0;
end;

procedure TCustomOutBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var aPage:Toutpage;
begin
  Inherited ;

  if ((Source is TOleDragObject)and(FimgShellFile<>-1)) or
      (Source is TCustomOutBar) then Accept := TRUE;

  // Select the page where the user try to drag.
  // Use a delay to avoid crazy scrolling.
  //
  aPage := FPages.FindPageAtXY(x,y);
  if (aPage<>CurrentPage) then
    begin
      TDelayThread.Create(FDragDelay,Handle,WMDELAY,DELAY_SELECTPAGE,Integer(aPage));
      FDragPage := aPage;
    end
    else PtOnPlot(Point(x,y));
end;

procedure TCustomOutBar.DragDrop(Source: TObject; X, Y: Integer);
var aPage:TOutPage; SomeThing:TObject; idx:Integer;
begin
  Inherited ;
  if (Source = self) and Assigned(FDragItem) then
    begin
      // Drag items between pages.
      //
      aPage := FPages.FindPageAtXY(x,y);
      if aPage<>TOutPage(FDragItem.Owner) then
        begin
          // Move item from one page to an other
          TOutPage(FDragItem.Owner).RemoveComponent(FDragItem);
          SomeThing := aPage.FindAtXY(x,y);
          aPage.InsertComponent(FDragItem);

          if SomeThing is TOutItem then
            begin
              // The user drop over an existing item.
              FDragItem.ComponentIndex := TOutItem(SomeThing).ComponentIndex;
            end
            else FDragItem.BringToTop;

          CurrentPage := aPage;
          Invalidate;
        end
        else
        begin
          // Move in same page
          //
          SomeThing := aPage.FindAtXY(x,y);
          if (Something is TOutItem)and(Something<>FDragItem) then
            begin
              FDragItem.ComponentIndex := TOutItem(SomeThing).ComponentIndex;
              Invalidate;
            end;
        end;
      FDragItem := NIL;
    end
    else
  if Source is TOleDragObject then
    begin
      aPage := FPages.FindPageAtXY(X,Y);
      if Assigned(aPage) then
        begin
          for idx:=0 to TOleDragObject(Source).FileList.count-1 do
            with aPage.Add do
              begin
                Caption := TOleDragObject(Source).FileList[idx];
                Imageindex := FimgShellFile;
              end;
          CurrentPage := aPage;
          Invalidate;
        end;
    end;
end;

procedure TCustomOutBar.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN:
      begin
        if GetMessageTime - FClickTime < GetDoubleClickTime then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TCustomOutBar.WMDestroy(var Message: TWMSetFocus);
begin
  if Assigned(FOleDrop) then
    begin
      FOleDrop.UnRegisterAndFree;
      Integer(FOleDrop):=0;
    end;
  Inherited ;
end;

procedure TCustomOutBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited ;
  if Assigned(FSelected) then DrawPageCaption(FSelected);
end;

procedure TCustomOutBar.WMKillFocus(var Message: TWMSetFocus);
begin
  Inherited ;
  if Assigned(FSelected) then DrawPageCaption(FSelected);
end;

procedure TCustomOutBar.WMMouseMove(var Message: TWMMouseMove);
var SomeThing:TObject;
begin
  Inherited;
  if Assigned(FEditor) then Exit;

  Something := FPages.FindAtXY(Message.XPos,Message.YPos);
  if Something = NIL then  begin setHotItem(NIL); Exit; end;

  if (Something is TOutItem)and(TOutItem(Something).Enabled)
     then setHotItem(TOutItem(Something))
     else setHotItem(NIL);
end;

procedure TCustomOutBar.WMLButtonDown(var Message: TWMLButtonDown);
begin
  Inherited;
  if Assigned(FEditor) then Exit;
  if (Not Focused)and(TabStop) then setFocus;

  if Assigned(FHotItem) then
     TDelayThread.Create(FDragDelay,Handle,WMDELAY,DELAY_STARTDRAG,Integer(FHotItem));

  if PtInRect(FrcPlotU,Point(Message.XPos,Message.YPos)) then
    begin
      Plot3d(FrcPlotU,TRUE,DFCS_PUSHED);
    end
    else
  if PtInRect(FrcPlotD,Point(Message.XPos,Message.YPos)) then
    begin
      Plot3d(FrcPlotD,FALSE,DFCS_PUSHED);
    end;
end;

procedure TCustomOutBar.WMRButtonUp(var Message: TWMLButtonUp);
begin
  Inherited;
end;

procedure TCustomOutBar.InplaceEditPageCaption(aPage:TOutPage);
begin
 // Inplae edit page caption
 //
 with aPage do
  begin
    FEditor := TinPlaceEdit.Create(self,Frc,Caption);
    FEditor.SelectAll; FEditor.SetFocus;
    Repeat
      Application.ProcessMessages;
    Until FEditor.ModalResult<>mrNone;
    if FEditor.ModalResult = mrOK then Caption := FEditor.Text;
    FEditor.Free;
    FEditor := NIL;
    Invalidate;
  end;
end;

procedure TCustomOutBar.InplaceEditItem(aItem:TOutItem);
begin
  // Inplace editing an item
  //
  with aItem do
   begin
     FEditor := TinPlaceEdit.Create(self,FrcText,Caption);
     FEditor.SelectAll; FEditor.SetFocus;
     Repeat
       Application.ProcessMessages;
     Until FEditor.ModalResult<>mrNone;
     if FEditor.ModalResult = mrOK then Caption := FEditor.Text;
     FEditor.Free; FEditor := NIL;
     Invalidate;
   end;
end;

procedure TCustomOutBar.WMLButtonDBLCLK(var Message: TWMLButtonUp);
var SomeThing:TObject;
begin
  Inherited;
  if Assigned(FEditor) then Exit;

  Something := FPages.FindAtXY(Message.XPos,Message.YPos);
  if Something = NIL then Exit;

{  if Something is TOutItem then
    begin
      // On Item dblclick
      //
{      if (Not TOutItem(Something).ReadOnly) and (TOutItem(Something).Enabled) and TOutItem(Something).PtInText(Message.XPos,Message.YPos)
         then InPlaceEditItem(TOutItem(Something))
         else
      if TOutItem(Something).Enabled then
         ProcessDblItemClick(TOutItem(Something));
    end
    else
  if Something is TOutPage then
    begin
      if (Not TOutPage(Something).ReadOnly) and (TOutPage(Something).Enabled) then
         InplaceEditpageCaption(TOutPage(Something));
    end;}
end;

procedure TCustomOutBar.ProcessDeleteItem(aItem:TOutItem);
var canDelete:Boolean;
begin
  if aItem.ReadOnly then Exit;
  if Assigned(FOnDeleteItem) then
   begin
     canDelete := TRUE;
     FOnDeleteItem(self, aItem, canDelete);
     if not canDelete then Exit;
   end;
  aItem.Free;
end;

procedure TCustomOutBar.ProcessDblItemClick(aItem:TOutItem);
begin
  if Not aItem.Enabled then Exit;

  aItem.Page.ItemSelected := aItem;
  if Assigned(FOnDblClick) then FOnDblClick(self);
end;

procedure TCustomOutBar.ProcessItemClick(aItem:TOutItem);
begin
  if Not aItem.Enabled then Exit;

  aItem.Page.ItemSelected := aItem;
  if Assigned(FOnClick) then FOnClick(self);

  if aItem.ItemType = itscMenu then
    begin
      PostMessage(Application.MainForm.Handle,WM_COMMAND,aItem.Tag,0);
    end;
end;

procedure TCustomOutBar.WMLButtonUp(var Message: TWMLButtonUp);
var SomeThing,st2:TObject; ptinText:Boolean;
begin
  Inherited;
  if FIgnoreNextUp then begin FIgnoreNextUp:=FALSE; Exit; end;
  if Assigned(FEditor) then Exit;

  Something := FPages.FindAtXY(Message.XPos,Message.YPos);
  St2 := FPages.FindAtXY(Left+Width-10,Message.YPos);
  if Something = NIL then
   begin
     if PtInRect(FrcPlotU,Point(Message.XPos,Message.YPos)) then
       begin
         Plot3d(FrcPlotU,TRUE,0);
         if FSelected.ScrollUp then Invalidate;
       end
       else
     if PtInRect(FrcPlotD,Point(Message.XPos,Message.YPos)) then
       begin
         Plot3d(FrcPlotD,FALSE,0);
         if FSelected.ScrollDown then Invalidate;
       end;
     Exit;
   end;

  if (Something is TOutPage) then
    begin
      // On Page click
      if TOutPage(Something).Enabled then
         PageIndex := TOutPage(Something).ComponentIndex;
    end else
  if (St2 is TOutPage) then
    begin
      // On Page click
      if TOutPage(St2).Enabled then
         PageIndex := TOutPage(St2).ComponentIndex;
    end else
  if Something is TOutItem then
    begin
      if (TOutItem(Something).Enabled) then
        begin
          ptinText := TOutItem(Something).PtInText(Message.XPos,Message.YPos);

          if _IsDown(VK_CONTROL)and(ptinText) then
           with TOutItem(Something) do
            begin
              // had to copied items.
              Selected := TRUE;
              DrawItemText(canvas, FColor, FdtOptions, Focused, FALSE);
              FclipItems.Add(TOutItem(Something));
            end
            else
          case FStyle of
            osLargeIcon :
              if not ptInText
                 then ProcessItemClick(TOutItem(Something))
                 else FSelected.ItemSelected := TOutItem(Something);
            osSmallIcon : ProcessItemClick(TOutItem(Something));
          end;
        end;
    end;
end;

procedure TCustomOutBar.WMKeyDown(var Message: TWMKeyDown);
var it:TOutItem; idx,index:Integer;
begin
  Inherited;
  if Assigned(FEditor) then Exit;
  case Message.CharCode of
    VK_PRIOR :
      if PageIndex>0 then PageIndex := PageIndex-1;
    VK_NEXT  :
      if PageIndex<FPages.Count-1 then PageIndex := PageIndex+1;
    VK_DOWN  :
      if Assigned(FSelected) then
       with FSelected do
        if (ItemIndex<Count-1) then ItemIndex := ItemIndex+1;
    VK_UP    :
      if Assigned(FSelected) then
       with FSelected do
        if (ItemIndex>0) then ItemIndex := ItemIndex-1;
    VK_RETURN:
      if Assigned(FSelected) then
       with FSelected do
        if (ItemIndex<>-1) then
         if _IsDown(VK_CONTROL)
            then InPlaceEditItem(Items[ItemIndex])
            else ProcessItemClick(Items[ItemIndex]);
    VK_DELETE:
      if Assigned(FSelected) then
       with FSelected do
        if (ItemIndex<>-1) then ProcessDeleteItem(Items[ItemIndex]);
    VK_INSERT:
      if Assigned(FSelected) then
        begin
          // Copy
          with FSelected do
            if _IsDown(VK_CONTROL) and (ItemIndex<>-1) then
              begin
                it := Items[Itemindex];
                it.Selected := TRUE;
                it.DrawItemText(canvas, FColor, FdtOptions, Focused, FALSE);
                FclipItems.Add(it);
              end;

          // Paste
          if _IsDown(VK_SHIFT) and (FClipItems.Count<>0) then
            begin
              if Assigned(FSelected.ItemSelected)
                 then index := FSelected.ItemSelected.ComponentIndex
                 else index := -1;

              for idx:=0 to FClipItems.count-1 do
                begin
                  it := TOutItem(FClipItems[idx]);
                  it.Selected := FALSE;
                  it.Page.RemoveComponent(it);
                  FSelected.InsertComponent(it);
                  if index<>-1 then begin it.ComponentIndex:=index; inc(index); end;
                end;

              FClipItems.Clear;
              Invalidate;
            end;
        end;
    VK_ESCAPE :
     begin
       // Clear selected.
       ClearSelected;
     end;
  end;
end;

procedure TCustomOutBar.WMKeyUp(var Message: TWMKeyUp);
begin
  inherited;
  if Assigned(FEditor) then Exit;
  with Message do
    begin
      case CharCode of
        VK_DOWN : ;
        VK_UP   : ;
      end;
    end;
end;

procedure TCustomOutBar.WMGETDLGCODE(var Message: TMessage);
begin
  Message.result:= DLGC_WANTARROWS;
end;

procedure TCustomOutBar.setSelected(value:TOutPage);
begin
  if value=FSelected then Exit;
  SmoothScroll(value);
  if Assigned(FSelected) then FSelected.FSelected := FALSE;
  FSelected := value;
  if Assigned(FSelected) then FSelected.FSelected := TRUE;
  if Assigned(FOnPageChange) then FOnPageChange(self);
  Invalidate;
end;

function TCustomOutBar.getItemSelected:TOutItem;
begin
  Result := NIL;
  if Assigned(FSelected) then Result := FSelected.ItemSelected;
end;

procedure TCustomOutBar.Notify(aItem:TOutBase; Operation:TOperation);
begin
  // something has been created or deleted
  if Operation = opRemove then
   begin
     if FHotItem = aItem  then FHotItem := NIL;
     FClipItems.Remove(aItem);
     if FSelected = aItem then FSelected := NIl;
   end;
  Invalidate;
end;

procedure TCustomOutBar.ItemSelectionChange(value:TOutItem);
begin
  if value.InView then
    value.DrawItemText(canvas, FColor, FdtOptions, Focused, FALSE);
end;

procedure TCustomOutBar.setItemSelected(value:TOutItem);
begin
  if Assigned(value) and (value.Page <> FSelected) then CurrentPage := value.Page;
  FSelected.ItemSelected := value
end;

function  TCustomOutBar.getPageIndex:Integer;
begin
  if Assigned(FSelected)
     then Result := FSelected.ComponentIndex
     else Result := -1;
end;

procedure TCustomOutBar.setPageindex(value:Integer);
begin
  if (value<0)or(value>=FPages.count)
    then setSelected(NIL)
    else setSelected(FPages[value]);
end;

procedure TCustomOutBar.setHotItem(value:TOutItem);
var rc:TRect;
begin
  if value = FHotItem then Exit;

  if Assigned(FHotItem) then
    begin

     rc := FHotItem.Frc;
     with canvas do
     rc.right:=rc.right+textwidth(StergeAt(FHotItem.FCaption))-16;
     dec(rc.bottom,2);dec(rc.left,2);inc(rc.right,2);
     canvas.brush.style:= bsclear;
     canvas.brush.color:=canvas.pixels[rc.left,rc.top];
     dec(rc.left);dec(rc.top);inc(rc.right);inc(rc.bottom);
     canvas.framerect(rc);inc(rc.right);inc(rc.bottom);canvas.framerect(rc);
      case FStyle of
       osLargeIcon : FHotItem.DrawItemIcon(canvas,FColor,FLImages,TRUE);
       osSmallIcon : FHotItem.DrawItemIcon(canvas,FColor,FSImages,TRUE);
      end;
    end;

  FHotItem := value;

  if Assigned(FHotItem) then
    begin
     rc := FHotItem.Frc;

  with canvas do
     rc.right:=rc.right+textwidth(StergeAt(FHotItem.FCaption))-16;
     dec(rc.bottom,2);dec(rc.left,2);inc(rc.right,2);
     canvas.pen.color:={StringToColor('$00FFB5B5')}cMenuItemNormalBorder;
     canvas.brush.color:=cMenuItemNormalBorder;
     dec(rc.left,1);dec(rc.top,1);inc(rc.right,1);inc(rc.bottom,1);Canvas.FrameRect(rc);
    end;
end;

procedure TCustomOutBar.ClearSelected;
var idx:Integer;
begin
  // Clear selected.
  for idx:=0 to FClipItems.count-1 do
   with TOutItem(FClipItems[idx]) do
    begin
      Selected := FALSE;
      DrawItemText(canvas, FColor, FdtOptions, Focused, FALSE);
    end;
  FClipItems.Clear;
end;

function  TCustomOutBar.getSelCount:Integer;
begin
  Result := FClipItems.Count;
end;

function  TCustomOutBar.getSelected(index:Integer):TOutItem;
begin
  if (index>=0)and(index<FclipItems.count)
     then Result := TOutItem(FClipItems[index])
     else Result := NIL;
end;

procedure TCustomOutBar.SmoothScroll(iNewPage:TOutPage);
const SCROLLSTEP=1; DELAY=1;
var idos,idns,xx,ee,ctn:Integer; rcScr,rcClip,rcFill:Trect;
begin
  //
  if (FSelected=NIL)or(FModulo=0) then Exit;
  //
  idos := PageIndex;
  idns := iNewPage.ComponentIndex;
  if idns>idos then
    begin
      // rect to scroll
      rcClip := Rect(iNewPage.Frc.Left, CurrentPage.Frc.Bottom, iNewPage.Frc.Right, iNewPage.Frc.Bottom);
      rcScr  := rcClip;
      ee     := iNewPage.Frc.Bottom - FPages[idos+1].Frc.Top;
      ctn    := 0;
      canvas.brush.Color := FColor;
      while (rcScr.Bottom-rcScr.Top>ee) do
       begin
         ScrollWindowEx(Handle, 0, -SCROLLSTEP, @rcScr, @rcCLip, 0, @rcFill, 0);
         canvas.Fillrect(rcFill);
         Dec(rcScr.Bottom,SCROLLSTEP);
         inc(ctn); if (ctn mod FModulo=0) then Sleep(DELAY);
       end;
    end
    else
    begin
      // rect to scroll
      if idos<Fpages.Count-1 then xx := FPages[idos+1].Frc.Top else xx := Height;
      rcClip := Rect(iNewPage.Frc.Left, iNewPage.Frc.Bottom, iNewPage.Frc.Right, xx);
      rcScr  := rcClip;
      ee     := FSelected.Frc.Bottom - FPages[idns+1].Frc.Top;
      ctn    := 0;
      canvas.brush.Color := FColor;
      while (rcScr.Bottom-rcScr.Top>ee) do
       begin
         ScrollWindowEx(Handle, 0, SCROLLSTEP, @rcScr, @rcCLip, 0, @rcFill, 0);
         canvas.Fillrect(rcFill);
         Inc(rcScr.Top,SCROLLSTEP);
         inc(ctn); if (ctn mod FModulo=0) then Sleep(DELAY);
       end;
    end;
end;

procedure TCustomOutBar.DrawPageCaption(aPage:TOutPage);
var idx,x,y:Integer; rcp:TRect;
begin
  //
  with canvas do
   begin
     Font.Color  := aPage.Color;
     Font.Style  := aPage.FontStyles;
{     font.name:='arial';
     font.size:=8;}
     brush.Color := aPage.BkColor;rcp := aPage.Frc; dec(rcp.Bottom,2);{mobman}
     brush.color:=FColor;dec(rcp.top,2);inc(rcp.bottom,2);
     FillRect(rcp);canvas.brush.style:= bsclear;
     brush.color:=cMenuPageNormalBorder;
     inc(rcp.left,3);inc(rcp.top,3);
     dec(rcp.right,3);dec(rcp.bottom,3);framerect(rcp);
     brush.color:=FColor;
     font.color:=cMenuPageNormalText;
     inc(rcp.top,1);
     DrawText(canvas.Handle, pchar(aPage.Caption), length(aPage.Caption), rcp, DT_CENTER);

     canvas.pen.color:=cMenuPageNormalText;
     x:=rcp.Right-3;
     y:=rcp.top+4;

     if (Focused) and (FSelected=aPage) then
      begin
       brush.color:=cMenuPageSelectedBorder;
       dec(rcp.top,1);
       framerect(rcp);
       x:=rcp.Right-4;
       y:=rcp.top+3;
       canvas.brush.color:=cMenuBackground;canvas.brush.style:=bsSolid;canvas.fillrect(bounds(rcp.right-1,rcp.top+1,-8,8));
       canvas.moveto(x,y);lineto(x,y+8);lineto(x-4,y+4);lineto(x,y);
      end else
       begin
        canvas.brush.color:=cMenuBackground;canvas.brush.style:=bsSolid;canvas.fillrect(bounds(rcp.right-1,rcp.top+1,-8,8));
        canvas.moveto(x,y);lineto(x-8,y);lineto(x-4,y+4);lineto(x,y);
       end; 
   end;
end;

procedure TCustomOutBar.PaintPageCaption(var rc:TRect; aPage:TOutPage; iSens:Integer);
begin
  // Paint only page caption
  //
  with canvas, rc do
   begin
     aPage.Frc := Rect(Left,Top,Right,Top+FTxtHeight+6);
     DrawPageCaption(aPage);
   end;

  rc.Top    := rc.Top+(iSens)*(FtxtHeight+6);
end;

procedure TCustomOutBar.PaintPageItemsSmall(var rc:TRect; aPage:TOutPage);
var idx:Integer;
begin
  // Paint selected page items
  //
  if aPage.count=0 then Exit;
  //
  rc.Top := rc.Top+FImgInt;
  for idx:=aPage.FirstItem to aPage.Count-1 do
   if APage.Items[idx].Visible then
    with aPage.Items[idx] do
     begin
       if rc.Top>rc.Bottom then break;

       Frc := Rect(Fimgleft, rc.Top, FimgLeft+FimgWidth, rc.Top+FimgHeight);
       DrawItemIcon(canvas,FColor,FSImages,FALSE);

       // Item caption
       //
       FrcText := Rect(Frc.Left{FimgWidth+2}, rc.Top, rc.Right, rc.Bottom);
       if FrcText.Left<rc.Left then FrcText.Left := rc.Left;

       DrawItemText(canvas, FColor, FdtOptions, Focused, TRUE);

       rc.Top := rc.Top + FimgHeight+2;
     end;
end;

procedure TCustomOutBar.PaintPageItemsLarge(var rc:TRect; aPage:TOutPage);
var idx:Integer;
begin
  // Paint selected page items
  //
  if aPage.count=0 then Exit;
  //
  rc.Top := rc.Top+FImgInt;
  for idx:=aPage.FirstItem to aPage.Count-1 do
   if APage.Items[idx].Visible then
    with aPage.Items[idx] do
     begin
       if rc.Top>rc.Bottom then break;
       Frc := Rect(Fimgleft, rc.Top, FimgLeft+FimgWidth, rc.Top+FimgHeight);

       DrawItemIcon(canvas,FColor,FLImages,FALSE);

       rc.Top := rc.Top + FimgHeight+2;
       if rc.Top>rc.Bottom then break;

       // Item caption
       //
       FrcText := Rect(Frc.Left-FimgWidth2,rc.Top,Frc.Right+FimgWidth2,rc.Bottom);
       if FrcText.Left<rc.Left then FrcText.Left := rc.Left;
       if FrcText.Right>rc.Right then FrcText.Right := rc.Right;

       DrawItemText(canvas, FColor, FdtOptions, Focused, TRUE);

       rc.Top := FrcText.Bottom+FImgInt;
     end;
end;

procedure TCustomOutBar.Paint;
var rc:TRect; idx,ids:Integer;
begin
  Inherited;
  // Must be create when parent is assigned
  if Not Assigned(FOleDrop) then FOleDrop := IWCDropTarget.Create(self);
  setHotItem(NIL);
  FPages.ClearRC;

  with canvas do
    begin
      rc := GetClientRect;

      case FStyle of
       osLargeIcon : FdtOptions := DT_CENTER+DT_WORDBREAK;
       osSmallIcon : FdtOptions := DT_LEFT;
      end;
      FtxtHeight := canvas.TextHeight('A');
      case FStyle of
       osLargeIcon :
         if assigned(FLImages)
            then begin FimgHeight := Abs(FLImages.Height); FimgWidth  := Abs(FLImages.width); end
            else begin FimgHeight := 32; FimgWidth  := 32; end;
       osSmallIcon :
         if assigned(FSImages)
            then begin FimgHeight := Abs(FSImages.Height); FimgWidth  := Abs(FSImages.width); end
            else begin FimgHeight := 16; FimgWidth  := 16; end
      end;
      FimgWidth2 := FimgWidth div 2;
      case FStyle of
        osLargeIcon : FimgLeft   := ((rc.Left+rc.Right) div 2) - FimgWidth2;
        osSmallIcon : FimgLeft   := FimgWidth2;
      end;
      FimgInt    := FimgHeight div 3;

      brush.Color := FColor;
      FillRect(rc);

      // Pages before selected
      if Not Assigned(FSelected) then
        begin
          // All pages are closed
          for idx:=0 to FPages.Count-1 do
            begin
              PaintPageCaption(rc, FPages[idx], 1);
              if rc.Top>rc.Bottom then break;
            end;
          FrcPlotU := Rect(0,0,0,0);
          FrcPlotD := Rect(0,0,0,0);
        end
        else
        begin
          // Pages before selected
          ids := PageIndex;
          for idx:=0 to ids-1 do
            begin
              PaintPageCaption(rc, FPages[idx], 1);
              if rc.Top>rc.Bottom then break;
            end;

          // Scroll plot up
          with rc do
            FrcPlotU := Rect(Right-20,top+FtxtHeight+8,Right-4,top+FTxtHeight+24);

          // Selected page
          PaintPageCaption(rc, FSelected, 1);
          case Fstyle of
           osLargeIcon : PaintPageItemsLarge(rc, FSelected);
           osSmallIcon : PaintPageItemsSmall(rc, FSelected);
          end;

          // Page after selected
          rc.Top := rc.Bottom - FtxtHeight - 6;
          for idx:=FPages.count-1 downto ids+1 do
            begin
              FSelected.ClearRC2(Rect(rc.Left,rc.Top,rc.Right,rc.Top+FtxtHeight));
              PaintPageCaption(rc, FPages[idx], -1);
            end;

          // Scroll plot down
          with rc do
            FrcPlotD := Rect(Right-20,top+FtxtHeight-18,Right-4,top+FtxtHeight-2);

          if FSelected.CanScrollUp then
            begin
              Plot3D(FrcPlotU,TRUE,0);
            end else FrcPlotU := Rect(0,0,0,0);

          if FSelected.CanScrollDown then
            begin
              Plot3D(FrcPlotD,FALSE,0);
            end else FrcPlotD := Rect(0,0,0,0);
        end;
    end;
end;

{------------------------------------------------------------------------------}
var
  Hooker  : TcustomOutBar;

function GetMsgHook(code: integer; wp: WParam; lp: LPARAM): LResult; stdcall;
var buffer:Array[0..128] of char;
begin
  if Code=HC_ACTION then
   with TMSG(Pointer(lp)^) do
    begin
      if Message = WM_COMMAND then
        begin
          // GetMenuItemInfo merde ?
          if GetMenuString(Getmenu(hwnd), LOWORD(wParam), @buffer[0], sizeof(buffer),MF_BYCOMMAND)>0 then
            begin
{              MessageBeep(0);}
              with Hooker.CurrentPage.Add do
               begin
                 Caption    := Format(Hooker.FTxtHook,[strPas(Buffer)]);
                 tag        := LOWORD(wParam);
                 ImageIndex := Hooker.FimgHook;
                 ItemType   := itscMenu;
               end;
              wParam := HIWORD(wParam)+$7FFF;
            end;
          Hooker.UnHookMenuMsg;
        end;
      Result := 0;
    end
    else Result := CallNextHookEx(Hooker.FHHook, code, wp, lp);
end;

procedure TcustomOutBar.HookNextMenuMsg(const iFormat:string; iImgIndex:Integer);
begin
  Hooker   := self;
  FimgHook := iImgIndex;
  FTxtHook := iFormat;
  if FtxtHook='' then FtxtHook := '%s';
  FHHook := SetWindowsHookEx(WH_GETMESSAGE,GetMsgHook,0,0);
end;

procedure TcustomOutBar.UnHookMenuMsg;
begin
  if FHHook<>0 then
    begin
      UnhookWindowsHookEx(FHHook);
      FHHook:=0;
    end;
end;

{------------------------------------------------------------------------------}

procedure TOutPagesDialog.FormCreate(Sender: TObject);
begin
  FOutBar := TCustomOutBar.Create(self);
  FOutBar.Parent := Container;
  FOutBar.Align  := alClient;
  FOutBar.PopupMenu := PopupMenu1;
end;

procedure TOutPagesDialog.setOutBar(value:TCustomOutBar);
begin
  if Assigned(FOutBar) and Assigned(value) then
   begin
     FOutBar.LargeImages := value.LargeImages;
     FOutBar.SmallImages := value.SmallImages;
     FOutBar.Pages.Assign(value.Pages);
   end;
end;

function TOutPagesDialog.getPages:TOutPages;
begin
  Result := FOutBar.Pages;
end;

procedure TOutPagesDialog.setPages(value:TOutPages);
begin
  if Assigned(FOutBar) then
    FOutBar.Pages.Assign(value);
end;

procedure TOutPagesDialog.btnAddPageClick(Sender: TObject);
var aPage:TOutPage;
begin
  if edtCaption.Text='' then Exit;

  aPage := OutBar.Pages.Add;
  with aPage do
   begin
     Caption := edtCaption.Text;
     edtCaption.Text := '';
   end;
  OutBar.CurrentPage := aPage;
end;

procedure TOutPagesDialog.btnAddItemClick(Sender: TObject);
begin
  if Assigned(OutBar.CurrentPage)and(edtItem.Text<>'') then
    with OutBar.CurrentPage.add do
     begin
       Caption    := edtItem.Text;
       ImageIndex := edtImgIndex.Value;
       ReadOnly   := chkReadOnly.Checked;
       Enabled    := chkenabled.Checked;

       edtItem.Text := '';
     end;
end;

procedure TOutPagesDialog.chkSmallClick(Sender: TObject);
begin
  if chkSmall.Checked
     then FOutBar.Style := osSmallIcon
     else FOutBar.Style := osLargeIcon;
end;

procedure TOutPagesDialog.PopupMenu1Popup(Sender: TObject);
begin
  miDeletePage.Enabled := Assigned(FOutBar.CurrentPage);
  miDeleteItem.Enabled := Assigned(FOutBar.CurrentPage.ItemSelected);
end;

procedure TOutPagesDialog.miDeletePageClick(Sender: TObject);
begin
  if Assigned(FOutBar.CurrentPage) then
   FOutBar.CurrentPage.Free;
end;

procedure TOutPagesDialog.miDeleteItemClick(Sender: TObject);
begin
  if Assigned(FOutBar.CurrentPage.ItemSelected) then
   FOutBar.CurrentPage.ItemSelected.Free;
end;

{------------------------------------------------------------------------------}

procedure TOutPagesEditor.Edit;
var dlg:TOutPagesDialog;
begin
  dlg := TOutPagesDialog.Create(Application);
  try
    //dlg.Pages  := TOutPages(GetOrdValue);

    if TOutPages(GetOrdValue).Owner is TCustomOutBar
       then dlg.OutBar := TCustomOutBar(TOutPages(GetOrdValue).Owner)
       else dlg.Pages  := TOutPages(GetOrdValue);

    if dlg.ShowModal=mrOK then TOutPages(GetOrdValue).Assign(dlg.Pages);
  finally
  dlg.Free;
  end;
end;

function TOutPagesEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('Standard',[TOutBar]);
  RegisterPropertyEditor(TypeInfo(TOutPages), TOutBar, '', TOutPagesEditor);
end;

Initialization
  RegisterClasses([TOutPages,TOutPage,TOutItem]);
end.
