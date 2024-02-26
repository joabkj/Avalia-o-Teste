program Avaliacao;

uses
  Vcl.Forms,
  u_admPrincipal in '..\model\u_admPrincipal.pas' {admPrincipal},
  u_basAcessoSistema in '..\model\u_basAcessoSistema.pas' {bas_AcessoSistema},
  Controller.ConfigBanco in '..\controller\Controller.ConfigBanco.pas',
  Controller.Connection in '..\controller\Controller.Connection.pas',
  Utils.Criptografia in '..\classes\Utils.Criptografia.pas',
  Controller.Usuario in '..\controller\Controller.Usuario.pas',
  u_cadBasico in '..\model\u_cadBasico.pas' {cadBasico},
  u_dicionarioDados in '..\classes\u_dicionarioDados.pas',
  u_funcoes in '..\classes\u_funcoes.pas',
  ucadProdutos in '..\model\ucadProdutos.pas' {cadProdutos},
  u_cadCategoria in '..\model\u_cadCategoria.pas' {cadCategoria},
  u_cadEntrada in '..\model\u_cadEntrada.pas' {cad_entrada},
  u_cadSaida in '..\model\u_cadSaida.pas' {cad_saida},
  u_cadHistorico in '..\model\u_cadHistorico.pas' {cadHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TadmPrincipal, admPrincipal);
  Application.CreateForm(Tbas_AcessoSistema, bas_AcessoSistema);
  bas_AcessoSistema.showmodal;
  Application.Run;
end.
