inherited cadCategoria: TcadCategoria
  Tag = 2
  Caption = 'cadCategoria'
  ExplicitWidth = 700
  ExplicitHeight = 526
  TextHeight = 13
  inherited pnl_top: TPanel
    ExplicitWidth = 684
  end
  inherited pnl_botoes: TPanel
    ExplicitWidth = 684
    inherited btn_cancelar: TButton
      Left = 4
      ExplicitLeft = 4
    end
    inherited btn_SalvarNovo: TButton
      Left = 108
      ExplicitLeft = 108
    end
    inherited btn_SalvarSair: TButton
      Left = 261
      ExplicitLeft = 261
    end
  end
  inherited pg_principal: TPageControl
    ActivePage = tb_consulta
    ExplicitWidth = 684
    ExplicitHeight = 411
    inherited tb_consulta: TTabSheet
      inherited pnl_consulta: TPanel
        ExplicitWidth = 676
      end
      inherited gdr_principal: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id_categoria'
            Title.Caption = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Descri'#231#227'o'
            Width = 400
            Visible = True
          end>
      end
    end
    inherited tb_dados: TTabSheet
      inherited db_codigo: TDBEdit
        DataField = 'id_categoria'
        DataSource = ds_dados
      end
    end
  end
  inherited qy_dados: TFDQuery
    Tag = 2
    SQL.Strings = (
      'select * from categoria')
    object qy_dadosid_categoria: TIntegerField
      FieldName = 'id_categoria'
      Origin = 'id_categoria'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qy_dadosnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
  end
end
