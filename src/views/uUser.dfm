inherited FormUser: TFormUser
  Caption = 'FormUser'
  ClientHeight = 423
  ClientWidth = 553
  OnShow = FormShow
  ExplicitWidth = 553
  ExplicitHeight = 423
  TextHeight = 15
  inherited pnlBackground: TPanel
    Width = 553
    Height = 423
    ExplicitWidth = 553
    ExplicitHeight = 423
    inherited pnlMarginRight: TPanel
      Left = 552
      Height = 421
      ExplicitLeft = 552
      ExplicitHeight = 421
    end
    inherited pnlMarginBot: TPanel
      Top = 422
      Width = 553
      ExplicitTop = 422
      ExplicitWidth = 553
    end
    inherited pnlMarginLeft: TPanel
      Height = 421
      ExplicitHeight = 421
    end
    inherited pnlMargimTop: TPanel
      Width = 553
      ExplicitWidth = 553
    end
    inherited pnlMain: TPanel
      Width = 551
      Height = 421
      ExplicitWidth = 551
      ExplicitHeight = 421
      inherited btnClose: TSpeedButton
        Left = 522
        ExplicitLeft = 522
      end
      object lblUsername: TLabel
        Left = 32
        Top = 67
        Width = 132
        Height = 23
        Caption = 'Nome de usu'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblPassword: TLabel
        Left = 296
        Top = 67
        Width = 51
        Height = 23
        Caption = 'Senha:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtUsername: TEdit
        Left = 32
        Top = 96
        Width = 225
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtPassword: TEdit
        Left = 296
        Top = 96
        Width = 225
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
      end
      object grdUsers: TStringGrid
        Left = 122
        Top = 176
        Width = 287
        Height = 120
        TabOrder = 2
        OnSelectCell = grdUsersSelectCell
      end
      object btnExcluir: TButton
        Left = 229
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 3
        OnClick = btnExcluirClick
      end
      object btnNovo: TButton
        Left = 310
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Novo'
        TabOrder = 4
        OnClick = btnNovoClick
      end
      object btnAlterar: TButton
        Left = 148
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Alterar'
        TabOrder = 5
        OnClick = btnAlterarClick
      end
    end
  end
end
