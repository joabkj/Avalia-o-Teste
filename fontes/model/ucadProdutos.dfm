inherited cadProdutos: TcadProdutos
  Tag = 1
  Caption = 'cadProdutos'
  ExplicitWidth = 700
  TextHeight = 13
  inherited pnl_top: TPanel
    object Label10: TLabel
      Left = 508
      Top = 9
      Width = 113
      Height = 13
      Caption = 'Controle de Estoque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnl_botoes: TPanel
    inherited btn_cancelar: TButton
      Tag = 1
      Left = 4
      ExplicitLeft = 4
    end
    inherited btn_SalvarNovo: TButton
      Tag = 1
      Left = 108
      ExplicitLeft = 108
    end
    inherited btn_SalvarSair: TButton
      Tag = 1
      Left = 256
      ExplicitLeft = 256
    end
    object Button1: TButton
      Left = 433
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Entrada '
      ImageIndex = 10
      Images = img_geral
      TabOrder = 7
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 512
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Saida'
      ImageIndex = 4
      Images = img_geral
      TabOrder = 8
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 591
      Top = 2
      Width = 88
      Height = 25
      Caption = 'Historico'
      TabOrder = 9
      OnClick = Button3Click
    end
  end
  inherited pg_principal: TPageControl
    ActivePage = tb_consulta
    inherited tb_consulta: TTabSheet
      inherited gdr_principal: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id_produto'
            Title.Caption = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Descri'#231#227'o'
            Width = 261
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco_unitario'
            Title.Caption = 'Valor Unit.'
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome_categoria'
            Title.Caption = 'Categoria'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Title.Caption = 'Estoque'
            Width = 76
            Visible = True
          end>
      end
    end
    inherited tb_dados: TTabSheet
      object Label8: TLabel [2]
        Left = 351
        Top = 41
        Width = 27
        Height = 13
        Caption = 'Pre'#231'o'
        StyleElements = []
      end
      object Label9: TLabel [3]
        Left = 5
        Top = 84
        Width = 47
        Height = 13
        Caption = 'Categoria'
        StyleElements = []
      end
      object db_preco: TDBEdit
        Left = 351
        Top = 56
        Width = 106
        Height = 22
        CharCase = ecUpperCase
        Color = clYellow
        DataField = 'preco_unitario'
        DataSource = ds_dados
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        StyleElements = []
      end
      object db_categoria: TDBLookupComboBox
        Left = 5
        Top = 103
        Width = 340
        Height = 21
        DataField = 'nome_categoria'
        DataSource = ds_dados
        TabOrder = 3
      end
    end
  end
  inherited qy_dados: TFDQuery
    OnCalcFields = qy_dadosCalcFields
    SQL.Strings = (
      'select * from produtos')
    object qy_dadosid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qy_dadosid_categoria: TIntegerField
      FieldName = 'id_categoria'
      Origin = 'id_categoria'
    end
    object qy_dadosnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qy_dadospreco_unitario: TBCDField
      FieldName = 'preco_unitario'
      Origin = 'preco_unitario'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
      Precision = 10
      Size = 2
    end
    object qy_dadosquantidade: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'quantidade'
      Calculated = True
    end
    object qy_dadosnome_categoria: TStringField
      FieldKind = fkLookup
      FieldName = 'nome_categoria'
      LookupDataSet = categoria
      LookupKeyFields = 'id_categoria'
      LookupResultField = 'nome'
      KeyFields = 'id_categoria'
      Lookup = True
    end
  end
  object categoria: TFDQuery
    SQL.Strings = (
      'select * from  categoria')
    Left = 332
    Top = 342
    object categoriaid_categoria: TIntegerField
      FieldName = 'id_categoria'
      Origin = 'id_categoria'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object categorianome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
  end
  object estoque: TFDQuery
    SQL.Strings = (
      'select * FROM ( select '
      
        ' (select id_produto from produtos where id_produto = :id_produto' +
        ' ) as id_produto,'#9#9#9'  '
      
        ' (select coalesce(sum (quantidade),0) from entradas where id_pro' +
        'duto = :id_produto ) -'
      
        ' (select coalesce(sum (quantidade),0) from saidas where id_produ' +
        'to = :id_produto ) as total'#9#9'  '
      ') AS T  ')
    Left = 324
    Top = 406
    ParamData = <
      item
        Name = 'ID_PRODUTO'
        ParamType = ptInput
      end>
    object estoqueid_produto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_produto'
      Origin = 'id_produto'
      ReadOnly = True
    end
    object estoquetotal: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'total'
      Origin = 'total'
      ReadOnly = True
    end
  end
end
