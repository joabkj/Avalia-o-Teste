unit u_cadHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Controller.Connection;

type
  TcadHistorico = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    lbl_total01: TLabel;
    lbl_total02: TLabel;
    lbl_produto: TLabel;
    lbl_total: TLabel;
    entradas: TFDQuery;
    entradasid_entrada: TIntegerField;
    entradasid_produto: TIntegerField;
    entradasdata: TDateField;
    entradasquantidade: TIntegerField;
    saidas: TFDQuery;
    saidasid_saida: TIntegerField;
    saidasid_produto: TIntegerField;
    saidasdata: TDateField;
    saidasquantidade: TIntegerField;
    ds_entradas: TDataSource;
    ds_saidas: TDataSource;
    DBGrid2: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function inicializa(AIDProduto: Integer; ADescricao: String): boolean;
  end;

var
  cadHistorico: TcadHistorico;
  Fid_produto: Integer;
  FDescricao : String;

implementation

{$R *.dfm}

{ TcadHistorico }

procedure TcadHistorico.FormShow(Sender: TObject);
var
  vEntrada: Integer;
  vSaida  : Integer;
begin
  vEntrada:= 0;
  vSaida  := 0;
  entradas.Connection:= TConnection.GetInstance.Conexao;
  saidas.Connection  := TConnection.GetInstance.Conexao;

  lbl_produto.Caption:= FormatFloat('0000', Fid_produto)+ '-'+FDescricao;

  entradas.Close;
  entradas.ParamByName( 'id_produto' ).asinteger:= Fid_produto;
  entradas.Open;

  entradas.first;

  while not entradas.eof do
  begin
    vEntrada:= vEntrada + entradas.fieldByname('quantidade').asinteger;
    entradas.next;
  end;


  saidas.Close;
  saidas.ParamByName( 'id_produto' ).asinteger:= Fid_produto;
  saidas.Open;

  saidas.first;

  while not saidas.eof do
  begin
    vSaida:= vSaida + saidas.fieldByname('quantidade').asinteger;
    saidas.next;
  end;

  lbl_total01.Caption:= 'TOTAL DE ENTRADAS '+ FormatFloat('0000', ventrada);
  lbl_total02.Caption:= 'TOTAL DE SAIDAS '+ FormatFloat('0000', vSaida);
  lbl_total.Caption  := 'TOTAL DISPONÍVEL: '+ FormatFloat('0000', ventrada - vSaida);
end;

class function TcadHistorico.inicializa(AIDProduto: Integer; ADescricao: String): boolean;
var
  FrmClass : TFormClass;
  Frm      : TForm;
begin
  Fid_produto:=  AIDProduto;
  FDescricao := ADescricao;
  try
    FrmClass   := TFormClass(FindClass('TcadHistorico'));
    Frm        := FrmClass.Create(Application);
    Frm.ShowModal;
  finally
    result:= true;
  end;
end;


initialization
    RegisterClass(TcadHistorico);

end.
