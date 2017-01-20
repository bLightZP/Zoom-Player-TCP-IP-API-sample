object MainForm: TMainForm
  Left = 433
  Top = 228
  Width = 573
  Height = 576
  Caption = 'Zoom Player Communication & Control Sample Application v3.2'
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
    557
    541)
  PixelsPerInch = 96
  TextHeight = 13
  object IncomingGB: TGroupBox
    Left = 6
    Top = 168
    Width = 546
    Height = 366
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Traffic log : '
    TabOrder = 0
    DesignSize = (
      546
      366)
    object MSGMemo: TMemo
      Left = 8
      Top = 20
      Width = 529
      Height = 307
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object ClearButton: TButton
      Left = 442
      Top = 332
      Width = 95
      Height = 25
      Caption = 'Clear'
      TabOrder = 1
      OnClick = ClearButtonClick
    end
  end
  object ConnectPanel: TPanel
    Left = 6
    Top = 6
    Width = 546
    Height = 157
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      546
      157)
    object LabelConnectTo: TLabel
      Left = 300
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
      Left = 437
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
      Left = 362
      Top = 9
      Width = 117
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 4
      Text = '127.0.0.1'
    end
    object PortEdit: TEdit
      Left = 483
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
      Width = 529
      Height = 60
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
    end
  end
  object XPManifest1: TXPManifest
    Left = 22
    Top = 74
  end
end
