object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gerador de Senhas'
  ClientHeight = 373
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 373
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 4474440
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.7.0.2'
    BorderColor = clBlack
    Caption.Color = clWhite
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clNone
    Caption.Font.Height = -11
    Caption.Font.Name = 'Segoe UI'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 4473924
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Segoe UI'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object lblTamSenha: TAdvLabel
      Left = 10
      Top = 119
      Width = 159
      Height = 32
      Text = 
        '{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fchar' +
        'set0 Arial;}}'#13#10'{\colortbl ;\red255\green0\blue0;}'#13#10'{\*\generator' +
        ' Riched20 10.0.26100}\viewkind4\uc1 '#13#10'\pard\fs22\lang1046 Tamanh' +
        'o da senha:\fs16\par'#13#10'\cf1\fs12 O tamanho m\'#39'e1ximo permitido \'#39 +
        'e9 30 caracteres.\cf0\fs16\par'#13#10'}'#13#10#0
      WordWrap = False
      Version = '1.0.0.4'
    end
    object AdvPanel2: TAdvPanel
      Left = 0
      Top = 0
      Width = 694
      Height = 105
      Align = alTop
      Color = clWhite
      TabOrder = 0
      UseDockManager = True
      Version = '2.7.0.2'
      BorderColor = clBlack
      Caption.Color = clWhite
      Caption.ColorTo = clNone
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clNone
      Caption.Font.Height = -11
      Caption.Font.Name = 'Segoe UI'
      Caption.Font.Style = []
      Caption.GradientDirection = gdVertical
      Caption.Indent = 0
      Caption.ShadeLight = 255
      CollapsColor = clNone
      CollapsDelay = 0
      DoubleBuffered = True
      ShadowColor = clBlack
      ShadowOffset = 0
      StatusBar.BorderColor = clNone
      StatusBar.BorderStyle = bsSingle
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = 4473924
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Segoe UI'
      StatusBar.Font.Style = []
      StatusBar.Color = clWhite
      StatusBar.GradientDirection = gdVertical
      Text = ''
      FullHeight = 200
      object AdvLabel1: TAdvLabel
        AlignWithMargins = True
        Left = 10
        Top = 0
        Width = 681
        Height = 102
        Margins.Left = 10
        Margins.Top = 0
        Align = alClient
        Alignment = taCenter
        Text = 
          '{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fchar' +
          'set0 Arial;}}'#13#10'{\*\generator Riched20 10.0.26100}\viewkind4\uc1 ' +
          #13#10'\pard\b\fs32\lang1046 GERADOR DE SENHAS\par'#13#10'\b0\fs16\par'#13#10'\fs' +
          '22 Ferramenta para gerar senhas fortes e seguras.\par'#13#10'O gerador' +
          ' de senhas permite criar uma senha aleat\'#39'f3ria com diversas op\' +
          #39'e7\'#39'f5es.\par'#13#10'Selecione as op\'#39'e7\'#39'f5es desejadas, clique em "' +
          'Gerar Senha" e confira a senha gerada abaixo do bot\'#39'e3o.\par'#13#10'}' +
          #13#10#0
        WordWrap = False
        Version = '1.0.0.4'
        ExplicitLeft = 0
        ExplicitWidth = 706
        ExplicitHeight = 65
      end
    end
    object RzPanel1: TRzPanel
      Left = 240
      Top = 112
      Width = 433
      Height = 97
      BorderOuter = fsFlat
      TabOrder = 2
      object cbMaius: TRzCheckBox
        Left = 18
        Top = 13
        Width = 164
        Height = 19
        AutoSizeWidth = 164
        Caption = 'Incluir Letras Mai'#250'sculas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 0
      end
      object cbMinus: TRzCheckBox
        Left = 18
        Top = 45
        Width = 164
        Height = 19
        AutoSizeWidth = 164
        Caption = 'Incluir Letras Min'#250'sculas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 1
      end
      object cbNums: TRzCheckBox
        Left = 205
        Top = 13
        Width = 115
        Height = 19
        AutoSizeWidth = 115
        Caption = 'Incluir N'#250'meros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 2
      end
      object cbEspecis: TRzCheckBox
        Left = 205
        Top = 45
        Width = 180
        Height = 36
        AutoSizeWidth = 180
        Caption = 'Incluir Caracteres Especiais'#13'(!@#$%&*()-+.,;?{[}]^><:)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 3
      end
    end
    object btnGerar: TAeroButton
      Left = 253
      Top = 274
      Width = 177
      Height = 41
      Version = '1.0.0.2'
      Caption = 'Gerar Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnGerarClick
    end
    object cbHashQuest: TRzCheckBox
      Left = 10
      Top = 157
      Width = 124
      Height = 19
      Cursor = crHandPoint
      Hint = 'Gerar senha com Hash MD5 e Semente.'
      AutoSizeWidth = 124
      Caption = 'Senha com HASH'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbUnchecked
      TabOrder = 4
      OnClick = cbHashQuestClick
    end
    object pnlHash: TRzPanel
      Left = 10
      Top = 179
      Width = 214
      Height = 136
      BorderOuter = fsFlat
      TabOrder = 5
      object RzLabel1: TRzLabel
        Left = 18
        Top = 84
        Width = 53
        Height = 17
        Caption = 'Semente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object RzLabel2: TRzLabel
        Left = 18
        Top = 36
        Width = 38
        Height = 17
        Caption = 'Senha:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object AdvLabel3: TAdvLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 206
        Height = 33
        Align = alTop
        Alignment = taCenter
        Text = 
          '{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fchar' +
          'set0 Arial;}}'#13#10'{\colortbl ;\red255\green0\blue0;}'#13#10'{\*\generator' +
          ' Riched20 10.0.26100}\viewkind4\uc1 '#13#10'\pard\qc\cf1\fs14\lang1046' +
          ' Gera uma HASH MD5 da senha digitada:\cf0\fs16\par'#13#10'}'#13#10#0
        WordWrap = False
        Version = '1.0.0.4'
        ExplicitLeft = 24
        ExplicitTop = -3
        ExplicitWidth = 135
      end
      object edtSemente: TRzEdit
        Left = 18
        Top = 107
        Width = 179
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 1
        OnKeyDown = edtSementeKeyDown
      end
      object edtSenha: TRzEdit
        Left = 18
        Top = 59
        Width = 179
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 0
      end
    end
    object cbTamanhoSenha: TRzComboBox
      Left = 167
      Top = 126
      Width = 57
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      FlatButtons = True
      FocusColor = clMoneyGreen
      FrameHotTrack = True
      FrameHotStyle = fsFlat
      FrameVisible = True
      FramingPreference = fpCustomFraming
      KeepSearchCase = True
      MaxLength = 30
      ParentCtl3D = False
      TabOrder = 1
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2 '
        '3'
        '4'
        '5'
        '6'
        '7'
        '8 '
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24'
        '25'
        '26'
        '27'
        '28'
        '29'
        '30')
      ItemIndex = 0
    end
    object memSenhaGerada: TMemo
      Left = 0
      Top = 336
      Width = 694
      Height = 37
      Align = alBottom
      TabOrder = 6
    end
  end
end
