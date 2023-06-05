object FormConsulta: TFormConsulta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 165
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 303
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 297
    object lblDescricao: TLabel
      Left = 8
      Top = 7
      Width = 293
      Height = 23
      Caption = 'Duplo clique para selecionar o  registo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 41
    Width = 303
    Height = 124
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 297
    ExplicitHeight = 115
    object sGridOrcamentos: TStringGrid
      Left = 0
      Top = 0
      Width = 303
      Height = 124
      Align = alClient
      TabOrder = 0
      OnDblClick = sGridOrcamentosDblClick
      ExplicitWidth = 297
      ExplicitHeight = 115
    end
  end
end
