object admPrincipal: TadmPrincipal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o Teste / Khipo'
  ClientHeight = 585
  ClientWidth = 1124
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 562
    Width = 1124
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
    ExplicitLeft = -24
    ExplicitTop = 355
    ExplicitWidth = 628
  end
  object MainMenu1: TMainMenu
    Left = 576
    Top = 48
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Postos1: TMenuItem
        Action = ac_clientes
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Combustiveis1: TMenuItem
        Action = ac_produtos
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Abastecimento1: TMenuItem
        Action = ac_pedidos
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios '
      object Geralporperodo1: TMenuItem
        Caption = 'Abastecimento por per'#237'odo'
      end
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
    object ac_clientes: TAction
      Caption = 'Clientes'
      Enabled = False
    end
    object ac_produtos: TAction
      Caption = 'Produtos'
      Enabled = False
    end
    object ac_pedidos: TAction
      Caption = 'Pedidos'
      Enabled = False
    end
    object ac_gerar_banco: TAction
      Caption = 'Antes de come'#231'a clique aqui para gerar o Banco de Dados'
    end
    object Action1: TAction
      Caption = 'Action1'
    end
  end
  object tm_DataHora: TTimer
    Left = 576
    Top = 160
  end
end
