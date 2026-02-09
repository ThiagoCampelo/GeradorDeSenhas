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
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object AdvPanel1: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 373
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblTamSenha: TcxLabel
      Left = 10
      Top = 119
      Width = 210
      Height = 40
      AutoSize = False
      Caption = 'Tamanho da senha:' + #13#10 + 'O tamanho máximo permitido é de 30 caracteres.'
      Properties.WordWrap = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object AdvPanel2: TPanel
      Left = 0
      Top = 0
      Width = 694
      Height = 105
      Align = alTop
      Color = clWhite
      ParentBackground = False
      BevelOuter = bvNone
      TabOrder = 0
      object AdvLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 0
        AutoSize = False
        Margins.Left = 10
        Margins.Top = 0
        Align = alClient
        Caption = 'GERADOR DE SENHAS' + #13#10 + 'Ferramenta para gerar senhas fortes e seguras.' + #13#10 +
          'Selecione as opções desejadas, clique em "Gerar Senha" e confira a senha gerada.'
        Properties.Alignment.Horz = taCenter
        Properties.WordWrap = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -14
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
    end
    object RzPanel1: TRzPanel
      Left = 240
      Top = 112
      Width = 433
      Height = 240
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
        OnClick = cbOpcoesClick
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
        OnClick = cbOpcoesClick
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
        OnClick = cbOpcoesClick
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
        OnClick = cbOpcoesClick
      end
      object cbEvitarAmbiguos: TRzCheckBox
        Left = 18
        Top = 74
        Width = 179
        Height = 19
        AutoSizeWidth = 179
        Caption = 'Evitar Caracteres Amb'#237'guos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 4
        OnClick = cbEvitarAmbiguosClick
      end
      object cbCopiarAuto: TRzCheckBox
        Left = 205
        Top = 74
        Width = 164
        Height = 19
        AutoSizeWidth = 164
        Caption = 'Copiar automaticamente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 5
        OnClick = cbOpcoesClick
      end
      object cbRegistrarHistorico: TRzCheckBox
        Left = 205
        Top = 98
        Width = 150
        Height = 19
        AutoSizeWidth = 150
        Caption = 'Registrar histórico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 6
        OnClick = cbOpcoesClick
      end
      object lblMaxSenha: TRzLabel
        Left = 18
        Top = 102
        Width = 100
        Height = 17
        Caption = 'Tamanho m'#225'ximo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtMaxSenha: TRzEdit
        Left = 124
        Top = 100
        Width = 60
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 7
        OnExit = edtMaxSenhaExit
      end
      object lblAmbiguos: TRzLabel
        Left = 18
        Top = 126
        Width = 164
        Height = 17
        Caption = 'Caracteres amb'#237'guos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtAmbiguos: TRzEdit
        Left = 18
        Top = 147
        Width = 155
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 8
      end
      object lblQuantidade: TRzLabel
        Left = 205
        Top = 126
        Width = 73
        Height = 17
        Caption = 'Quantidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtQuantidade: TRzEdit
        Left = 304
        Top = 124
        Width = 60
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 9
      end
      object lblMinimo: TRzLabel
        Left = 205
        Top = 150
        Width = 105
        Height = 17
        Caption = 'Tamanho mínimo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtMinimo: TRzEdit
        Left = 320
        Top = 148
        Width = 60
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 10
      end
      object cbReqMaius: TRzCheckBox
        Left = 18
        Top = 176
        Width = 128
        Height = 19
        AutoSizeWidth = 128
        Caption = 'Exigir Maiúsculas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 11
        OnClick = cbOpcoesClick
      end
      object cbReqMinus: TRzCheckBox
        Left = 18
        Top = 198
        Width = 128
        Height = 19
        AutoSizeWidth = 128
        Caption = 'Exigir Minúsculas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 12
        OnClick = cbOpcoesClick
      end
      object cbReqNums: TRzCheckBox
        Left = 205
        Top = 176
        Width = 104
        Height = 19
        AutoSizeWidth = 104
        Caption = 'Exigir Números'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 13
        OnClick = cbOpcoesClick
      end
      object cbReqEspecis: TRzCheckBox
        Left = 205
        Top = 198
        Width = 136
        Height = 19
        AutoSizeWidth = 136
        Caption = 'Exigir Especiais'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 14
        OnClick = cbOpcoesClick
      end
    end
    object btnGerar: TButton
      Left = 253
      Top = 285
      Width = 177
      Height = 41
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
      Top = 152
      Width = 124
      Height = 19
      Cursor = crHandPoint
      Hint = 'Gerar hash da senha com semente e algoritmo selecionado.'
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
      Top = 174
      Width = 214
      Height = 150
      BorderOuter = fsFlat
      TabOrder = 5
      object RzLabel1: TRzLabel
        Left = 18
        Top = 96
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
        Top = 46
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
      object AdvLabel3: TcxLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Height = 36
        AutoSize = False
        Align = alTop
        Caption = 'Gera uma hash da senha digitada com semente.'
        Properties.Alignment.Horz = taCenter
        Properties.WordWrap = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object edtSemente: TRzEdit
        Left = 18
        Top = 118
        Width = 179
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 2
        OnKeyDown = edtSementeKeyDown
        OnChange = cbOpcoesClick
      end
      object edtSenha: TRzEdit
        Left = 18
        Top = 68
        Width = 179
        Height = 21
        Text = ''
        FocusColor = clMoneyGreen
        PasswordChar = '*'
        FrameHotTrack = True
        FrameHotStyle = fsFlat
        FrameVisible = True
        FramingPreference = fpCustomFraming
        TabOrder = 1
        OnChange = cbOpcoesClick
      end
      object cbMostrarSenha: TRzCheckBox
        Left = 18
        Top = 94
        Width = 120
        Height = 17
        AutoSizeWidth = 120
        Caption = 'Mostrar senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 3
        OnClick = cbMostrarSenhaClick
      end
      object lblHashAlg: TRzLabel
        Left = 18
        Top = 28
        Width = 73
        Height = 17
        Caption = 'Algoritmo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object cbHashAlg: TcxComboBox
        Left = 96
        Top = 26
        Width = 101
        Height = 23
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'MD5'
          'SHA-1'
          'SHA-256'
          'SHA-512')
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
    object lblForca: TRzLabel
      Left = 445
      Top = 258
      Width = 86
      Height = 17
      Caption = 'For'#231'a: -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pbForca: TProgressBar
      Left = 445
      Top = 276
      Width = 228
      Height = 16
      TabOrder = 7
    end
    object lblForcaDetalhe: TRzLabel
      Left = 445
      Top = 296
      Width = 228
      Height = 38
      Caption = ''
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnExportar: TButton
      Left = 253
      Top = 308
      Width = 84
      Height = 23
      Caption = 'Exportar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = btnExportarClick
    end
    object btnLimparHistorico: TButton
      Left = 346
      Top = 308
      Width = 124
      Height = 23
      Caption = 'Limpar hist'#243'rico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = btnLimparHistoricoClick
    end
    object btnCopiarHistorico: TButton
      Left = 480
      Top = 308
      Width = 110
      Height = 23
      Caption = 'Copiar último'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = btnCopiarHistoricoClick
    end
    object lblAviso: TcxLabel
      Left = 10
      Top = 258
      Width = 230
      Height = 60
      AutoSize = False
      Caption = ''
      Properties.WordWrap = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Visible = False
    end
  end
  object tmrClipboard: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = tmrClipboardTimer
    Left = 632
    Top = 16
  end
  object dlgSalvarHistorico: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Texto (*.txt)|*.txt|CSV (*.csv)|*.csv|JSON (*.json)|*.json|Todos os arquivos (*.*)|*.*'
    Left = 632
    Top = 56
  end
end
