unit Controller.Principal;

interface

uses
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Classes, System.SysUtils,
  System.JSON,

  Authentication, u_dicionarioDados;

type
  TControllerPrincipal = class
    strict private
      class var FInstance: TControllerPrincipal;
      constructor CreatePrivate;
    private
      FODM          : TConectionAPI;
      FToken        : String;
      FBodyString   : String;
      FServer       : String;
      FVersao       : String;
      FMensagemErro : String;
      FNomeUsuario  : String;
      FVersaoSistema: String;
      FCodigoRetorno: Integer;
      FServico      : Boolean;
    public

      procedure Authentication;

      property  Conexao: TConectionAPI read FODM write FODM;
      property  TOKEN: String read FToken write FToken;
      property  BodyString: String read FBodyString write FBodyString;
      property  Server: String read FServer write FServer;
      property  CodigoRetorno: Integer read FCodigoRetorno write FCodigoRetorno;
      property  Versao: String read FVersao write FVersao;
      property  VersaoSistema: String read FVersaoSistema write FVersaoSistema;
      property  MensagemErro: String read FMensagemErro write FMensagemErro;
      property  Servico: Boolean read FServico write FServico;

      class procedure GetInstanceDados(ABodyString, AServer, AVersao, AVersaoExecutavel: String; APorta: Integer);
      class function  GetInstance: TControllerPrincipal;

      destructor Destroy; override;
  end;

  var
    VBodyString        : String;
    VServer            : String;
    vVersao            : String;
    vVersaoExecutavel  : String;
    VPorta             : Integer;

implementation
{ TControllerPrincipal }


constructor TControllerPrincipal.CreatePrivate;
begin
  inherited Create;
  FODM:= TConectionAPI.Create(nil);
  With FODM do
  begin
    FODM.VersionaAPI:= vVersao;
    FODM.port       := VPorta;
    FODM.Server     := vServer;
  end;

  VersaoSistema:= vVersaoExecutavel;
end;

destructor TControllerPrincipal.Destroy;
begin

  inherited;
end;

procedure TControllerPrincipal.Authentication;
var
  Json: TJSONValue;
begin
  FODM.BodyString:= VBodyString;
  Conexao.Authentication;
  if Conexao.CodigoErro <> 400 then
  begin
    Json             := TJSonObject.ParseJSONValue(Conexao.JsonAcesso);
    if Json <> nil then
    begin
      Token            := Json.GetValue<string>('token');
      CodigoRetorno    := 200;
    end
    else
      CodigoRetorno:= 400;
  end
  else
  begin
    CodigoRetorno:= Conexao.CodigoErro;
    MensagemErro := Conexao.MensagemErro;
  end;

end;

class function TControllerPrincipal.GetInstance: TControllerPrincipal;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TControllerPrincipal.CreatePrivate;
  end;
  Result := FInstance;
end;

class procedure TControllerPrincipal.GetInstanceDados(ABodyString, AServer, AVersao, AVersaoExecutavel: String; APorta: Integer);
begin
  VBodyString:= ABodyString;
  VServer    := AServer;
  VPorta     := APorta;
  vVersao    := AVersao;
  vVersaoExecutavel:= AVersaoExecutavel;
end;


end.

