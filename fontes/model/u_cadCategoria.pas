unit u_cadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_cadBasico, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait;

type
  TcadCategoria = class(TcadBasico)
    qy_dadosid_categoria: TIntegerField;
    qy_dadosnome: TWideStringField;
    function valida: Boolean; override;
    function pesq_complementar: String; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadCategoria: TcadCategoria;

implementation

{$R *.dfm}


{ TcadCategoria }

function TcadCategoria.pesq_complementar: String;
begin
  result:= '';
end;

function TcadCategoria.valida: Boolean;
begin
  result:= true;
  if trim(db_nome.Text) = '' then
  begin
    Showmessage('Nome e obrigatório.');
    result:= False;
    db_nome.SetFocus;
    exit;
  end;

end;

initialization
    RegisterClass(TcadCategoria);

end.
