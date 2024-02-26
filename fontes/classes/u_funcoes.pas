unit u_funcoes;

interface
  uses
  Vcl.Forms, System.Classes, Vcl.Dialogs, SysUtils, Data.DB,
  System.Math;

  procedure AbriFormularios(const p_classe: string; p_usuario: integer);
  function PermissaoAcesso: boolean;
  function ValidaCNPJ(p_CNPJ : string) : Boolean;
//  function RetornaValor(Asql, ACampo: String): String;

implementation
var
  wp_classe  : string;
  wp_usuario : integer;


function ValidaCNPJ(p_CNPJ : string) : Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(p_CNPJ[i]);
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;


function PermissaoAcesso: boolean;
begin
  result:= true;
end;

procedure AbriFormularios(const p_classe: string; p_usuario: integer);
var
  FrmClass : TFormClass;
  Frm : TForm;
begin
  try
    wp_classe := 'T'+p_classe;
    wp_usuario:=  p_usuario;
    FrmClass  := TFormClass(FindClass(wp_classe));
    Frm       := FrmClass.Create(Application);
    if PermissaoAcesso then
      Frm.ShowModal
    else
     Showmessage('Voc� n�o tem permiss�o para acessar este formul�rio.');
  except
    on E: EClassNotFound do
      begin
        ShowMessage('Classe n�o encontrada. ' +#13+
                    '- Possivelmente a mesma n�o foi registrada.'+#13+
                    '- Possivelmente a mesma n�o existe no projeto');
        FreeAndNil(Frm);
      end;
  end;
end;

end.
