program Avaliacao;

uses
  Vcl.Forms,
  u_admPrincipal in '..\model\u_admPrincipal.pas' {admPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TadmPrincipal, admPrincipal);
  Application.Run;
end.
