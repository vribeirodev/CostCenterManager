object FormLayout: TFormLayout
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 480
  ClientWidth = 640
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlBackground: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlMarginRight: TPanel
      Left = 639
      Top = 1
      Width = 1
      Height = 478
      Align = alRight
      BevelOuter = bvNone
      Color = 7785472
      ParentBackground = False
      TabOrder = 0
    end
    object pnlMarginBot: TPanel
      Left = 0
      Top = 479
      Width = 640
      Height = 1
      Align = alBottom
      BevelOuter = bvNone
      Color = 7785472
      ParentBackground = False
      TabOrder = 1
    end
    object pnlMarginLeft: TPanel
      Left = 0
      Top = 1
      Width = 1
      Height = 478
      Align = alLeft
      Color = 7785472
      ParentBackground = False
      TabOrder = 2
    end
    object pnlMargimTop: TPanel
      Left = 0
      Top = 0
      Width = 640
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Color = 7785472
      ParentBackground = False
      TabOrder = 3
    end
    object pnlMain: TPanel
      Left = 1
      Top = 1
      Width = 638
      Height = 478
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 4
      object btnClose: TSpeedButton
        Left = 609
        Top = 6
        Width = 23
        Height = 22
        Cursor = crHandPoint
        Caption = 'X'
        Flat = True
        OnClick = btnCloseClick
      end
    end
  end
end
