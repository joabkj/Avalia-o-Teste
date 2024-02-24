unit u_admPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TadmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Postos1: TMenuItem;
    N1: TMenuItem;
    Combustiveis1: TMenuItem;
    Movimentao1: TMenuItem;
    Abastecimento1: TMenuItem;
    Relatrios1: TMenuItem;
    Geralporperodo1: TMenuItem;
    Sobre1: TMenuItem;
    Verso101: TMenuItem;
    ac_formularios: TActionList;
    ac_clientes: TAction;
    ac_produtos: TAction;
    ac_pedidos: TAction;
    ac_gerar_banco: TAction;
    Action1: TAction;
    tm_DataHora: TTimer;
    StatusBar1: TStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  admPrincipal: TadmPrincipal;

implementation

{$R *.dfm}

end.
