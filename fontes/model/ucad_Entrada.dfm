object cad_entrada: Tcad_entrada
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Entrada de Produtos'
  ClientHeight = 122
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lbl_produto: TLabel
    Left = 16
    Top = 16
    Width = 105
    Height = 25
    Caption = 'lbl_produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Quantidade: TLabel
    Left = 16
    Top = 47
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object Label1: TLabel
    Left = 16
    Top = -1
    Width = 110
    Height = 15
    Caption = 'Produto Selecionado'
  end
  object edt_Valor: TEdit
    Left = 16
    Top = 71
    Width = 105
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = '0'
    OnKeyPress = edt_ValorKeyPress
  end
  object btn_cadastrar: TButton
    Left = 136
    Top = 73
    Width = 113
    Height = 33
    Caption = 'Cadastrar'
    TabOrder = 1
    OnClick = btn_cadastrarClick
  end
  object dados: TFDQuery
    Left = 312
    Top = 40
  end
end
