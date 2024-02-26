unit u_admPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus,

  Controller.Usuario,
  Controller.Connection,

  u_funcoes;

type
  TadmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Postos1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Sobre1: TMenuItem;
    Verso101: TMenuItem;
    ac_formularios: TActionList;
    ac_produtos: TAction;
    tm_DataHora: TTimer;
    StatusBar1: TStatusBar;
    asc_categorias: TAction;
    N1: TMenuItem;
    Categorias1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure tm_DataHoraTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ac_produtosExecute(Sender: TObject);
    procedure asc_categoriasExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IDUsuario  : Integer;
    NomeUsuario: String;
  end;

var
  admPrincipal: TadmPrincipal;

implementation

{$R *.dfm}

procedure TadmPrincipal.ac_produtosExecute(Sender: TObject);
begin
   AbriFormularios('cadProdutos', 1);
end;

procedure TadmPrincipal.asc_categoriasExecute(Sender: TObject);
begin
   AbriFormularios('cadCategoria', 1);
end;

procedure TadmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  TControllerUsuario.GetInstance.Destroy;
  TConnection.GetInstance.Destroy;
end;

procedure TadmPrincipal.FormShow(Sender: TObject);
begin
   Statusbar1.Panels [4].Text := 'Usuário: '+ TControllerUsuario.GetInstance.NomeUsuario;
end;

procedure TadmPrincipal.tm_DataHoraTimer(Sender: TObject);
begin
  Statusbar1.Panels [1].Text := ' '+FormatDateTime ('dddd","dd" de "mmmm" de "yyyy',now);// para data
  statusbar1.Panels [3].Text := ' '+FormatDateTime ('hh:mm:ss',now);//para hora
end;

end.
