unit ucadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_cadBasico, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,

  Controller.Connection, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,

  u_cadEntrada,
  u_cadSaida,
  u_cadHistorico;

type
  TcadProdutos = class(TcadBasico)
    Label8: TLabel;
    db_preco: TDBEdit;
    Label9: TLabel;
    categoria: TFDQuery;
    db_categoria: TDBLookupComboBox;
    qy_dadosid_produto: TIntegerField;
    qy_dadosid_categoria: TIntegerField;
    qy_dadosnome: TWideStringField;
    qy_dadospreco_unitario: TBCDField;
    categoriaid_categoria: TIntegerField;
    categorianome: TWideStringField;
    qy_dadosquantidade: TIntegerField;
    qy_dadosnome_categoria: TStringField;
    estoque: TFDQuery;
    estoqueid_produto: TIntegerField;
    estoquetotal: TLargeintField;
    Button1: TButton;
    Button2: TButton;
    Label10: TLabel;
    Button3: TButton;
    function valida: Boolean; override;
    function pesq_complementar: String; override;
    procedure FormShow(Sender: TObject);
    procedure qy_dadosCalcFields(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadProdutos: TcadProdutos;

implementation

{$R *.dfm}

{ TcadProdutos }

procedure TcadProdutos.Button1Click(Sender: TObject);
begin
  inherited;
  if not (qy_dados.state in [dsEdit, dsInsert]) then
  begin
        try
          Tcad_entrada.inicializa(qy_dados.fieldByname('id_produto').asinteger, qy_dados.fieldByname('nome').asstring, 'entradas');
        finally
          qy_dados.REFRESH;
        end;
  end;
end;

procedure TcadProdutos.Button2Click(Sender: TObject);
begin
  inherited;
  if not (qy_dados.state in [dsEdit, dsInsert]) and (qy_dados.fieldByName('quantidade').asinteger > 0) then
  begin
        try
          Tcad_saida.inicializa(qy_dados.fieldByname('id_produto').asinteger, qy_dados.fieldByname('nome').asstring, 'saidas');
        finally
          qy_dados.REFRESH;
        end;
  end
  else
  begin
    if qy_dados.fieldByName('quantidade').asinteger = 0 then
      Showmessage('Estoque est� zerado. N�o e permitido da saida de produtos que n�o est�o n�o estoque.')
  end;
end;

procedure TcadProdutos.Button3Click(Sender: TObject);
begin
  inherited;
  if not (qy_dados.state in [dsEdit, dsInsert]) then
  begin
        try
          TcadHistorico.inicializa(qy_dados.fieldByname('id_produto').asinteger, qy_dados.fieldByname('nome').asstring);
        finally
          qy_dados.REFRESH;
        end;
  end;
end;

procedure TcadProdutos.FormShow(Sender: TObject);
begin
  categoria.Connection:= TConnection.GetInstance.Conexao;
  estoque.Connection  := TConnection.GetInstance.Conexao;
  categoria.Open;
  inherited;
end;

function TcadProdutos.pesq_complementar: String;
begin
  result:= '';
end;

procedure TcadProdutos.qy_dadosCalcFields(DataSet: TDataSet);
begin
  inherited;


  if not (DataSet.state in [dsEdit, dsInsert]) then
  begin

        if DataSet.FieldByName('id_produto').AsInteger > 0 then
        begin
          estoque.close;
          estoque.ParamByName( 'id_produto' ).asinteger:= DataSet.FieldByName('id_produto').AsInteger;
          estoque.open;

          DataSet.FieldByName('quantidade').AsInteger:=   estoque.FieldByName( 'total' ).asinteger;
        end;
  end;


end;

function TcadProdutos.valida: Boolean;
begin
  result:= true;
  if trim(db_nome.Text) = '' then
  begin
    Showmessage('Nome e obrigat�rio.');
    result:= False;
    db_nome.SetFocus;
    exit;
  end;
  if trim(db_preco.Text) = '' then
  begin
    Showmessage('Valor Unit�rio e obrigat�rio.');
    result:= False;
    db_preco.SetFocus;
    exit;
  end;
  if trim(db_categoria.Text) = '' then
  begin
    Showmessage('Categoria e obrigat�rio.');
    result:= False;
    db_categoria.SetFocus;
    exit;
  end;

end;

initialization
    RegisterClass(TcadProdutos);

end.
