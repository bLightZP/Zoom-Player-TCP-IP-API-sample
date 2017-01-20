object MainForm: TMainForm
  Left = 246
  Top = 131
  Width = 561
  Height = 371
  Caption = 'Zoom Player Communication & Control Sample Application v3.00'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    549
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object IncomingGB: TGroupBox
    Left = 6
    Top = 166
    Width = 538
    Height = 168
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Incoming Messages : '
    TabOrder = 0
    DesignSize = (
      538
      168)
    object MSGMemo: TMemo
      Left = 8
      Top = 20
      Width = 521
      Height = 139
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      TabOrder = 0
    end
  end
  object ConnectPanel: TPanel
    Left = 6
    Top = 6
    Width = 538
    Height = 157
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      538
      157)
    object LabelConnectTo: TLabel
      Left = 292
      Top = 13
      Width = 55
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Connect to:'
    end
    object LabelTextEntry: TLabel
      Left = 8
      Top = 43
      Width = 75
      Height = 13
      Caption = 'TCP Text Entry:'
    end
    object SendButton: TSpeedButton
      Left = 429
      Top = 123
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Send Text'
      OnClick = SendButtonClick
    end
    object WinAPIConnectButton: TButton
      Left = 106
      Top = 7
      Width = 172
      Height = 25
      Caption = 'SendMessage (WinAPI) Connect'
      TabOrder = 0
      Visible = False
      OnClick = WinAPIConnectButtonClick
    end
    object TCPConnectButton: TButton
      Left = 8
      Top = 7
      Width = 95
      Height = 25
      Caption = 'TCP Connect'
      TabOrder = 1
      OnClick = TCPConnectButtonClick
    end
    object BrowseButton: TButton
      Left = 8
      Top = 123
      Width = 100
      Height = 25
      Caption = 'Browse for File'
      TabOrder = 2
      OnClick = BrowseButtonClick
    end
    object PlayButton: TButton
      Left = 111
      Top = 123
      Width = 100
      Height = 25
      Caption = 'Play / Pause'
      TabOrder = 3
      OnClick = PlayButtonClick
    end
    object TCPAddress: TEdit
      Left = 354
      Top = 9
      Width = 117
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 4
      Text = '127.0.0.1'
    end
    object PortEdit: TEdit
      Left = 475
      Top = 9
      Width = 55
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 5
      Text = '4769'
    end
    object TCPCommand: TMemo
      Left = 8
      Top = 59
      Width = 521
      Height = 60
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
    end
  end
end
