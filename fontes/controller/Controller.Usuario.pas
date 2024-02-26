unit Controller.Usuario;

interface

uses
  System.SysUtils, StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Web.HTTPApp,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Rtti, System.Classes,

  Controller.Connection;

 type
   TControllerUsuario = class
 private
   FIDUsuario   : Integer;
   FNomeUsuario : string;
   FAcesso  : Boolean;
   strict private
    class var FInstance: TControllerUsuario;
    constructor CreatePrivate;
 public
    class function GetInstance: TControllerUsuario;
    function  ValidaUsuario(AUsuario, ASenha: String): Boolean;
    property  IDUsuario  : Integer read FIDUsuario write FIDUsuario;
    property  NomeUsuario: String read FNomeUsuario write FNomeUsuario;
    property  Acesso: Boolean read FAcesso write FAcesso;
    constructor Create;
    destructor Destroy; override;

    procedure GetIstance(AIDusuario: Integer; ANomeUsuario: String );
end;

  var
    dsUsuarios  : TDataSource;

implementation

{ TUsuarios }


class function TControllerUsuario.GetInstance: TControllerUsuario;
begin
  if not Assigned(FInstance) then
    FInstance := TControllerUsuario.CreatePrivate;
  Result := FInstance;
end;

constructor TControllerUsuario.Create;
begin
  inherited;
end;

constructor TControllerUsuario.CreatePrivate;
begin
  inherited Create;
end;

destructor TControllerUsuario.Destroy;
begin
   inherited;
end;


procedure TControllerUsuario.GetIstance(AIDusuario: Integer;
  ANomeUsuario: String);
begin
  FIDUsuario  := AIDusuario;
  FNomeUsuario:= ANomeUsuario;
end;

function TControllerUsuario.ValidaUsuario(AUsuario, ASenha: String): Boolean;
var
 ExecutaScripts: TFDQuery;
begin
  result:= false;

  ExecutaScripts:= TFDQuery.create(nil);
  ExecutaScripts.Connection := TConnection.GetInstance.Conexao;
  ExecutaScripts.SQL.Clear;
  ExecutaScripts.SQL.Add('SELECT * FROM usuario WHERE usuario =:usuario and senha =:senha ');
  ExecutaScripts.ParamByName( 'usuario' ).AsString:= AUsuario;
  ExecutaScripts.ParamByName( 'senha' ).AsString  := ASenha;
  ExecutaScripts.open;

  if not ExecutaScripts.IsEmpty then
  begin
    result:= true;
    TControllerUsuario.GetInstance.FIDUsuario := ExecutaScripts.fieldByname('id_usuario').asinteger;
    TControllerUsuario.GetInstance.NomeUsuario:= ExecutaScripts.fieldByname('nome').asstring;
  end;

end;


end.

