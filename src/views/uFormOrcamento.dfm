object FormOrcamento: TFormOrcamento
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 480
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlFundoMargimTop: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = 7785472
    ParentBackground = False
    TabOrder = 0
  end
  object pnlFundoMargimLeft: TPanel
    Left = 0
    Top = 1
    Width = 1
    Height = 478
    Align = alLeft
    BevelOuter = bvNone
    Color = 7785472
    ParentBackground = False
    TabOrder = 1
  end
  object pnlFundoMargimRight: TPanel
    Left = 791
    Top = 1
    Width = 1
    Height = 478
    Align = alRight
    BevelOuter = bvNone
    Color = 7785472
    ParentBackground = False
    TabOrder = 2
  end
  object pnlFundoMargimBot: TPanel
    Left = 0
    Top = 479
    Width = 792
    Height = 1
    Align = alBottom
    BevelOuter = bvNone
    Color = 7785472
    ParentBackground = False
    TabOrder = 3
  end
  object pnlFundo: TPanel
    Left = 1
    Top = 1
    Width = 790
    Height = 478
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object pnlButtons: TPanel
      Left = 0
      Top = 416
      Width = 790
      Height = 62
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object btnConfirmar: TButton
        Left = 677
        Top = 21
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnConsultar: TButton
        Left = 499
        Top = 21
        Width = 75
        Height = 25
        Caption = 'Consultar'
        TabOrder = 1
        OnClick = btnConsultarClick
      end
      object btnCancelar: TButton
        Left = 588
        Top = 21
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 2
        OnClick = btnCancelarClick
      end
    end
    object pnlContent: TPanel
      Left = 0
      Top = 97
      Width = 790
      Height = 319
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object pnlPai: TPanel
        Left = 32
        Top = 0
        Width = 225
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object sGridPai: TStringGrid
          Left = 0
          Top = 0
          Width = 225
          Height = 319
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          RowHeights = (
            24
            24
            24
            24
            24)
        end
      end
      object pnlFilho: TPanel
        Left = 289
        Top = 0
        Width = 248
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object sGridFilho: TStringGrid
          Left = 0
          Top = 0
          Width = 248
          Height = 319
          Align = alClient
          TabOrder = 0
        end
      end
      object pnlTotal: TPanel
        Left = 569
        Top = 0
        Width = 184
        Height = 319
        Align = alLeft
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object sGridTotal: TStringGrid
          Left = 1
          Top = 1
          Width = 182
          Height = 317
          Align = alClient
          TabOrder = 0
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 32
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 3
      end
      object Panel4: TPanel
        Left = 257
        Top = 0
        Width = 32
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 4
      end
      object Panel5: TPanel
        Left = 537
        Top = 0
        Width = 32
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 5
      end
      object Panel2: TPanel
        Left = 753
        Top = 0
        Width = 32
        Height = 319
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 6
      end
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 790
      Height = 97
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object btnFechar: TSpeedButton
        Left = 751
        Top = 0
        Width = 39
        Height = 28
        Cursor = crHandPoint
        Caption = 'X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7785472
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnFecharClick
      end
      object lblCentroCusto: TLabel
        Left = 376
        Top = 31
        Width = 83
        Height = 17
        Caption = 'C'#243'digo do CC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblValor: TLabel
        Left = 519
        Top = 31
        Width = 124
        Height = 17
        Caption = 'Valor do Lancamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtCentroCusto: TEdit
        Left = 376
        Top = 54
        Width = 137
        Height = 23
        TabOrder = 0
      end
      object edtLancamento: TEdit
        Left = 519
        Top = 54
        Width = 144
        Height = 23
        TabOrder = 1
      end
      object btnAdicionar: TButton
        Left = 669
        Top = 53
        Width = 83
        Height = 25
        Caption = 'Adicionar'
        TabOrder = 2
        OnClick = btnAdicionarClick
      end
      object btnNovoOrcamento: TButton
        Left = 266
        Top = 53
        Width = 104
        Height = 25
        Caption = 'Novo Or'#231'amento'
        TabOrder = 3
        OnClick = btnNovoOrcamentoClick
      end
    end
  end
end
