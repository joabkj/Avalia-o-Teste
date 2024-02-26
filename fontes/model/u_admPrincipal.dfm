object admPrincipal: TadmPrincipal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o Teste / Khipo'
  ClientHeight = 584
  ClientWidth = 1120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 561
    Width = 1120
    Height = 23
    Panels = <
      item
        Text = ' Data: '
        Width = 35
      end
      item
        Width = 200
      end
      item
        Text = 'Hora: '
        Width = 40
      end
      item
        Width = 55
      end
      item
        Text = 'Usu'#225'rio : ADMINISTRADOR'
        Width = 300
      end
      item
        Text = 'Servidor: LOCAL'
        Width = 150
      end
      item
        Text = 'Banco de dados: POSTO'
        Width = 50
      end>
    ExplicitTop = 560
    ExplicitWidth = 1116
  end
  object MainMenu1: TMainMenu
    Left = 576
    Top = 48
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Postos1: TMenuItem
        Action = ac_produtos
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categorias1: TMenuItem
        Action = asc_categorias
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios '
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
      object Verso101: TMenuItem
        Caption = 'Vers'#227'o 1.0'
      end
    end
  end
  object ac_formularios: TActionList
    Left = 576
    Top = 104
    object ac_produtos: TAction
      Caption = 'Produtos'
      OnExecute = ac_produtosExecute
    end
    object asc_categorias: TAction
      Caption = 'Categorias'
      OnExecute = asc_categoriasExecute
    end
  end
  object tm_DataHora: TTimer
    OnTimer = tm_DataHoraTimer
    Left = 576
    Top = 160
  end
end
