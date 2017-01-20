unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TNTDialogs, Buttons, ScktComp;

Const
  CommCode = WM_APP+444; // The message number used to communicate with Zoom Player
  ZPCode   = WM_APP+49;  // The message number used to tell Zoom Player our window name
  CRLF     = #13#10;

type
  TMainForm = class(TForm)
    IncomingGB: TGroupBox;
    MSGMemo: TMemo;
    ConnectPanel: TPanel;
    WinAPIConnectButton: TButton;
    TCPConnectButton: TButton;
    BrowseButton: TButton;
    PlayButton: TButton;
    LabelConnectTo: TLabel;
    TCPAddress: TEdit;
    PortEdit: TEdit;
    LabelTextEntry: TLabel;
    TCPCommand: TMemo;
    SendButton: TSpeedButton;
    procedure WinAPIConnectButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TCPConnectButtonClick(Sender: TObject);
    procedure PlayButtonClick(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
  private
    // Intercept Zoom Player messages
    procedure zpEvent(var M : TMessage); message CommCode;
  public
    Procedure CreateZPTCPClient;
    Procedure DestroyZPTCPClient;

    procedure ZPTCPClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ZPTCPClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ZPTCPClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ZPTCPClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ZPTCPSendText(S : String);
  end;


var
  MainForm    : TMainForm;
  TCPBuf      : String;
  ZPTCPClient : TClientSocket    = nil;
  ZPTCPSocket : TCustomWinSocket = nil;


implementation

{$R *.dfm}


function StringFromAtom(sATOM : ATOM) : String;
var
  I : Integer;
  S : String;
Begin
  I := 2048;
  SetLength(S,I); // Allocate memory for string
  I := GlobalGetAtomName(sATOM,@S[1],I); // Get string
  SetLength(S,I); // Set string to the current length
  GlobalDeleteAtom(sATOM); // Free memory used by Atom
  Result := S;
End;


procedure TMainForm.zpEvent(var M : TMessage);
var
  S,S1 : String;
  I    : Integer;
begin
  Case M.WParam of
    1000 : Begin // Play State Changed
             S := 'Play state changed: ';
             Case M.LParam of
               0 : S1 := 'Closed';   // Also DVD Stop
               1 : S1 := 'Stopped';  // Media only
               2 : S1 := 'Paused';
               3 : S1 := 'Playing';
             End;
             MSGMemo.Lines.Add(S+S1);
           End;
    1100 : Begin // TimeLine update (once per second)
             MSGMemo.Lines.Add('Timeline: '+StringFromAtom(M.LParam));
           End;
    1200 : Begin // On Screen Display Messages
             MSGMemo.Lines.Add('OSD: '+StringFromAtom(M.LParam));
           End;
    1201 : Begin // On Screen Display Message has been removed
             MSGMemo.Lines.Add('OSD Removed');
           End;
    1300 : Begin // DVD & Media Mode changes
             S := 'Mode change: Entering ';
             Case M.LParam of
               0 : S1 := 'DVD';
               1 : S1 := 'Media';
             End;
             MSGMemo.Lines.Add(S+S1+' mode');
           End;
    1400 : Begin // DVD Title Change
             MSGMemo.Lines.Add('DVD Title: '+IntToStr(M.LParam));
           End;
    1450 : Begin // Current Unique string identifying the DVD disc
             MSGMemo.Lines.Add('DVD Unique String: '+IntToStr(M.LParam));
           End;
    1500 : Begin // DVD Chapter Change
             MSGMemo.Lines.Add('DVD Chapter: '+IntToStr(M.LParam));
           End;
    1600 : Begin // DVD Audio Change
             MSGMemo.Lines.Add('DVD Audio: '+StringFromAtom(M.LParam));
           End;
    1700 : Begin // DVD Subtitle Change
             MSGMemo.Lines.Add('DVD Subtitle: '+StringFromAtom(M.LParam));
           End;
    1800 : Begin // Media File Name
             MSGMemo.Lines.Add('New Media File: '+StringFromAtom(M.LParam));
           End;
    1900 : Begin // Position of Media file in play list
             MSGMemo.Lines.Add('Media File play list track number: '+StringFromAtom(M.LParam));
           End;
    2000 : Begin // Video Resolution
             MSGMemo.Lines.Add('Video Resolution: '+StringFromAtom(M.LParam));
           End;
    2100 : Begin // Video Frame Rate
             MSGMemo.Lines.Add('Video FPS: '+StringFromAtom(M.LParam));
           End;
    2200 : Begin // AR Changed
             MSGMemo.Lines.Add('AR Changed to: '+StringFromAtom(M.LParam));
           End;
  End;
end;


procedure TMainForm.WinAPIConnectButtonClick(Sender: TObject);
var
  I : Integer;
begin
  I := FindWindow(nil,'Zoom Player');
  If I > 0 then SendMessage(I,ZPCode,GlobalAddAtom(PChar(MainForm.Caption)),200);
end;


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If ZPTCPClient <> nil then DestroyZPTCPClient;
end;


procedure TMainForm.TCPConnectButtonClick(Sender: TObject);
begin
  If ZPTCPSocket = nil then CreateZPTCPClient else DestroyZPTCPClient;
end;


procedure TMainForm.PlayButtonClick(Sender: TObject);
begin
  If ZPTCPClient <> nil then ZPTCPSendText('5100 fnPlay');
end;


procedure TMainForm.BrowseButtonClick(Sender: TObject);
var
  Browser : TTNTOpenDialog;
begin
  If ZPTCPClient <> nil then
  Begin
    Browser := TTNTOpenDialog.Create(MainForm);
    If Browser.Execute = True then
    Begin
      ZPTCPSendText('1850 '+UTF8Encode(Browser.FileName));
    End;
    Browser.Free;
  End;
end;


procedure TMainForm.FormShow(Sender: TObject);
begin
  MainForm.SetBounds((MainForm.Monitor.Left+MainForm.Monitor.Width)-MainForm.Width,
                     MainForm.Monitor.Top,
                     MainForm.Width,MainForm.Height);
end;


procedure TMainForm.SendButtonClick(Sender: TObject);
begin
  If ZPTCPClient <> nil then ZPTCPSendText(TCPCommand.Text);
end;


procedure TMainForm.CreateZPTCPClient;
var
  I : Integer;
begin
  If ZPTCPClient = nil then
  Begin
    ZPTCPClient              := TClientSocket.Create(MainForm);
    ZPTCPClient.ClientType   := ctNonBlocking;
    ZPTCPClient.OnConnect    := ZPTCPClientConnect;
    ZPTCPClient.OnDisconnect := ZPTCPClientDisconnect;
    ZPTCPClient.OnRead       := ZPTCPClientRead;
    ZPTCPClient.OnError      := ZPTCPClientError;
  End;
  ZPTCPClient.Port         := StrToInt(PortEdit.Text);
  ZPTCPClient.Address      := TCPAddress.Text;
  Try
    ZPTCPClient.Active := True;
    I := 0;
    While (ZPTCPSocket = nil) and (I < 50) do
    Begin
      Application.ProcessMessages;
      If ZPTCPSocket = nil then Sleep(100);
      Inc(I);
    End;
  Except
    FreeAndNil(ZPTCPClient);
    MSGMemo.Lines.Add('Unable to Connect');
  End;
end;


procedure TMainForm.DestroyZPTCPClient;
begin
  If ZPTCPClient <> nil then
  Begin
    If ZPTCPSocket <> nil then
    Begin
      ZPTCPSocket.Close;
      ZPTCPSocket := nil;
    End;
    ZPTCPClient.Active := False;
    FreeAndNil(ZPTCPClient);
  End;
end;


procedure TMainForm.ZPTCPClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ZPTCPSocket := Socket;
  MSGMemo.Lines.Add('Connected');
  TCPConnectButton.Enabled := True;
  TCPConnectButton.Caption := 'TCP Disconnect';
end;


procedure TMainForm.ZPTCPClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  If ZPTCPClient <> nil then
  Begin
    MSGMemo.Lines.Add('Disconnected');
    TCPConnectButton.Enabled := True;
    TCPConnectButton.Caption := 'TCP Connect';
    ZPTCPSocket := nil;
  End;
end;


procedure TMainForm.ZPTCPClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  S : String;
  I : Integer;
begin
  If Socket.Connected = True then
  Begin
    S := Socket.ReceiveText;
    TCPBuf := TCPBuf+S;

    While Pos(CRLF,TCPBuf) > 0 do
    Begin
      I := Pos(CRLF,TCPBuf);
      S := Copy(TCPBuf,1,I-1);
      Delete(TCPBuf,1,I+1);
      MSGMemo.Lines.Add(S);
    End;
  End;
end;


procedure TMainForm.ZPTCPClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  If ErrorCode = 10061 then
  Begin
    MSGMemo.Lines.Add('Error #10061 - Unable to Connect');
    ErrorCode := 0;
  End;
  If ErrorCode = 10053 then
  Begin
    MSGMemo.Lines.Add('Error #10053 - Server has disconnected/shutdown.');
    ErrorCode := 0;
  End;
end;


procedure TMainForm.ZPTCPSendText(S : String);
var
  I : Integer;
begin
  If ZPTCPSocket <> nil then ZPTCPSocket.SendText(S);
end;



end.
