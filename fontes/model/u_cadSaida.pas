unit u_cadSaida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_cadEntrada, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  Tcad_saida = class(Tcad_entrada)
  private
    { Private declarations }
  public
    { Public declarations }
    class function inicializa(AIDProduto: Integer; ADescricao, ANomeTabela: String): boolean; override;
  end;

var
  cad_saida: Tcad_saida;

implementation

{$R *.dfm}

{ Tcad_saida }

class function Tcad_saida.inicializa(AIDProduto: Integer; ADescricao,
  ANomeTabela: String): boolean;
var
  FrmClass : TFormClass;
  Frm      : TForm;
begin
  Fid_produto:=  AIDProduto;
  FDescricao := ADescricao;
  FNomeTabela:= ANomeTabela;
  try
    FrmClass   := TFormClass(FindClass('Tcad_saida'));
    Frm        := FrmClass.Create(Application);
    Frm.ShowModal;
  finally
    result:= true;
  end;

end;

initialization
    RegisterClass(Tcad_saida);

end.
