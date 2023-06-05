object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 121
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 622
    object edtCentroCusto: TEdit
      Left = 24
      Top = 24
      Width = 121
      Height = 23
      TabOrder = 0
      OnExit = edtCentroCustoExit
    end
    object edtValor: TEdit
      Left = 168
      Top = 24
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object btnAdd: TButton
      Left = 144
      Top = 80
      Width = 75
      Height = 25
      Caption = 'add'
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnConfirma: TButton
      Left = 248
      Top = 80
      Width = 75
      Height = 25
      Caption = 'conf'
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 313
    Width = 628
    Height = 121
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 622
    object btnConsultarOrcamento: TButton
      Left = 386
      Top = 64
      Width = 75
      Height = 25
      Caption = 'conf'
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 121
    Width = 628
    Height = 192
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 622
    object Panel4: TPanel
      Left = 385
      Top = 1
      Width = 192
      Height = 190
      Align = alLeft
      TabOrder = 0
      object grdValorTotal: TStringGrid
        Left = 1
        Top = 1
        Width = 190
        Height = 188
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 193
      Top = 1
      Width = 192
      Height = 190
      Align = alLeft
      TabOrder = 1
      object grdCentroCustoFilho: TStringGrid
        Left = 1
        Top = 1
        Width = 190
        Height = 188
        Align = alClient
        TabOrder = 0
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 192
      Height = 190
      Align = alLeft
      TabOrder = 2
      object grdCentroCustoPai: TStringGrid
        Left = 1
        Top = 1
        Width = 190
        Height = 188
        Align = alClient
        TabOrder = 0
      end
    end
  end
end
