object cadHistorico: TcadHistorico
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Historico do Estoque do Produto.'
  ClientHeight = 452
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object lbl_total01: TLabel
    Left = 104
    Top = 381
    Width = 193
    Height = 21
    Alignment = taRightJustify
    Caption = 'TOTAL DE ENTRADAS:  000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_total02: TLabel
    Left = 422
    Top = 383
    Width = 168
    Height = 21
    Alignment = taRightJustify
    Caption = 'TOTAL DE SAIDAS:  000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_produto: TLabel
    Left = 8
    Top = 12
    Width = 193
    Height = 21
    Caption = 'TOTAL DE ENTRADAS:  000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_total: TLabel
    Left = 350
    Top = 415
    Width = 242
    Height = 22
    Alignment = taRightJustify
    Caption = 'TOTAL DISPON'#205'VEL: 0000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 289
    Height = 337
    Caption = '<Entradas>'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 285
      Height = 318
      Align = alClient
      DataSource = ds_entradas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'data'
          Title.Caption = 'Data'
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Caption = 'QTDE.'
          Width = 73
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 303
    Top = 42
    Width = 289
    Height = 337
    Caption = '<Saidas>'
    TabOrder = 1
    object DBGrid2: TDBGrid
      Left = 2
      Top = 17
      Width = 285
      Height = 318
      Align = alClient
      DataSource = ds_saidas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'data'
          Title.Caption = 'Data'
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Caption = 'QTDE.'
          Width = 73
          Visible = True
        end>
    end
  end
  object entradas: TFDQuery
    SQL.Strings = (
      
        'select * from entradas where id_produto =:id_produto order by da' +
        'ta ')
    Left = 168
    Top = 144
    ParamData = <
      item
        Name = 'ID_PRODUTO'
        ParamType = ptInput
        Value = Null
      end>
    object entradasid_entrada: TIntegerField
      FieldName = 'id_entrada'
      Origin = 'id_entrada'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object entradasid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object entradasdata: TDateField
      FieldName = 'data'
      Origin = 'data'
    end
    object entradasquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
  end
  object saidas: TFDQuery
    SQL.Strings = (
      
        'select * from saidas  where id_produto =:id_produto order by dat' +
        'a ')
    Left = 383
    Top = 146
    ParamData = <
      item
        Name = 'ID_PRODUTO'
        ParamType = ptInput
      end>
    object saidasid_saida: TIntegerField
      FieldName = 'id_saida'
      Origin = 'id_saida'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object saidasid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object saidasdata: TDateField
      FieldName = 'data'
      Origin = 'data'
    end
    object saidasquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
  end
  object ds_entradas: TDataSource
    DataSet = entradas
    Left = 168
    Top = 200
  end
  object ds_saidas: TDataSource
    DataSet = saidas
    Left = 384
    Top = 200
  end
end
