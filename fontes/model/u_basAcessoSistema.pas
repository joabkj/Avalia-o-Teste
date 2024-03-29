unit u_basAcessoSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList,

  Controller.ConfigBanco,
  Controller.Connection,
  Controller.Usuario,

  u_dicionarioDados,

  System.IniFiles,

  FireDAC.Stan.Async, FireDAC.DApt;

type
  Tbas_AcessoSistema = class(TForm)
    Image1: TImage;
    pnl_usuario: TPanel;
    btn_acessar: TButton;
    btn_acessar_: TPanel;
    pnl_top: TPanel;
    Image7: TImage;
    Image8: TImage;
    edt_usuario: TEdit;
    Image2: TImage;
    pnl_senha: TPanel;
    Image9: TImage;
    Image10: TImage;
    edt_senha: TEdit;
    img_olho: TImage;
    img_olho_fechado: TImage;
    lbl_infor: TLabel;
    btn_configura: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edt_nomeBanco: TEdit;
    Label4: TLabel;
    edt_senhaBanco: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    edt_CriarUsuario: TEdit;
    Label6: TLabel;
    edt_CriarSenha: TEdit;
    pnl_bootom: TPanel;
    lbl_versao: TLabel;
    Image4: TImage;
    lbl_tentativas: TLabel;
    btn_criarBanco: TButton;
    Label7: TLabel;
    edt_CriarNome: TEdit;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_acessar_Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image7Click(Sender: TObject);
    procedure img_olhoClick(Sender: TObject);
    procedure edt_usuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edt_senhaKeyPress(Sender: TObject; var Key: Char);
    procedure btn_criarBancoClick(Sender: TObject);
    procedure btn_configuraClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    Tentativas    : Integer;
    Fchave        : Boolean;
    procedure OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
    function Valida: Boolean;
    function ValidaCriacaoBanco: Boolean;
    function CriaBanco(NomeBanco: String): String;
    function InsereRegistroUsuario: string;
    procedure CarregaINformacaoDados;

  public
    { Public declarations }
  end;

var
  bas_AcessoSistema : Tbas_AcessoSistema;
  _valida           : Boolean;
  VResult           : Boolean;

implementation

{$R *.dfm}


function Tbas_AcessoSistema.InsereRegistroUsuario: string;
begin
  Result:= 'INSERT INTO usuario(nome, usuario, senha) VALUES '+
           '('+ QuotedStr(edt_CriarNome.Text)+','+QuotedStr(UpperCase(edt_CriarUsuario.Text))+','+QuotedStr(edt_CriarSenha.Text)+');'
end;


Function VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F : PFFI;
  Handle : Dword;
  Len : Longint;
  Data : Pchar;
  Buffer : Pointer;
  Tamanho : Dword;
  Parquivo: Pchar;
  Arquivo : String;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data:=StrAlloc(Len+1);
    if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
    begin
      VerQueryValue(Data, '\',Buffer,Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d',
      [HiWord(F^.dwFileVersionMs),
      LoWord(F^.dwFileVersionMs),
      HiWord(F^.dwFileVersionLs),
      Loword(F^.dwFileVersionLs)]
      );
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

function Tbas_AcessoSistema.ValidaCriacaoBanco: Boolean;
begin
  Result:= true;

  if edt_nomeBanco.Text = '' then
  begin
    Showmessage('Informe o nome do Banco');
    edt_nomeBanco.SetFocus;
    exit;
  end;

  if edt_senhaBanco.Text = '' then
  begin
    Showmessage('Informe a senha que voc� criou na instala��o do banco Postgres');
    edt_senhaBanco.SetFocus;
    exit;
  end;

  if edt_CriarUsuario.Text = '' then
  begin
    Showmessage('Informe o nome do Usu�rio');
    edt_CriarUsuario.SetFocus;
    exit;
  end;

    if edt_CriarSenha.Text = '' then
  begin
    Showmessage('Informe a senha do usu�rio');
    edt_CriarSenha.SetFocus;
    exit;
  end;

end;

procedure Tbas_AcessoSistema.btn_configuraClick(Sender: TObject);
begin
  bas_AcessoSistema.Height:= 635;
  edt_nomeBanco.SetFocus;
end;

procedure Tbas_AcessoSistema.btn_criarBancoClick(Sender: TObject);
var
  ArquivoINI: TIniFile;
  ExecutaScripts: TFDQuery;
begin
  if ValidaCriacaoBanco then
  begin
    TServerConfig.GetInstance(edt_senhaBanco.Text, edt_nomeBanco.Text, 'PG', true);
    try
          try
            ExecutaScripts:=  TFDQuery.Create(nil);
            ExecutaScripts.Connection := TConnection.GetInstance.Conexao;



            ExecutaScripts.SQL.clear;
            ExecutaScripts.SQL.Add('DROP DATABASE IF EXISTS '+ edt_nomeBanco.Text);
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.clear;
            ExecutaScripts.SQL.Add(CriaBanco(edt_nomeBanco.Text));
            ExecutaScripts.ExecSQL;

            TServerConfig.GetInstance(edt_senhaBanco.Text, edt_nomeBanco.Text, 'PG');
            TServerConfig.ReconstroiConexao;


          finally

            ExecutaScripts.Connection := TConnection.GetInstance.Conexao;
            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add('DROP TABLE IF EXISTS usuario ');
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(cs_criaUsuario);
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add('DROP TABLE IF EXISTS categoria ');
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(cs_criaCategoria);
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add('DROP TABLE IF EXISTS produtos ');
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(cs_criaProdutos);
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add('DROP TABLE IF EXISTS entradas ');
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(cs_criaProdutoEntrada);
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add('DROP TABLE IF EXISTS saidas ');
            ExecutaScripts.ExecSQL;

            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(cs_criaProdutoSaidas);
            ExecutaScripts.ExecSQL;


            ExecutaScripts.SQL.Clear;
            ExecutaScripts.SQL.Add(InsereRegistroUsuario);
            ExecutaScripts.ExecSQL;


            ArquivoINI := TIniFile.Create(GetCurrentDir+'\Cfg.Ini');
            ArquivoINI.WriteString('Config', 'Database', Trim(edt_nomeBanco.Text));
            ArquivoINI.WriteString('Config', 'Password', Trim(edt_senhaBanco.Text));
            ArquivoINI.Free;

            Showmessage('Etapa da Cria��o do Banco ');

            FreeAndNil(ExecutaScripts);
          end;

    except on E: Exception do
      ShowMessage(E.Message);
    end;
  end;
end;

procedure Tbas_AcessoSistema.edt_senhaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure Tbas_AcessoSistema.edt_usuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure Tbas_AcessoSistema.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure Tbas_AcessoSistema.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= true;
end;

procedure Tbas_AcessoSistema.CarregaINformacaoDados;
var
  LPath: String;
  IniFile : TIniFile;
begin
    LPath               := GetCurrentDir+'\Cfg.Ini';
    IniFile             := TIniFile.Create(LPath);
    edt_nomeBanco.Text  := IniFile.ReadString('Config', 'Database', '');
    edt_senhaBanco.Text := IniFile.ReadString('Config', 'Password', '');
end;

procedure Tbas_AcessoSistema.FormCreate(Sender: TObject);
begin
  bas_AcessoSistema.ClientHeight := 390;
  lbl_versao.Caption             := 'Ver: '+ VersaoExe;
  Tentativas                     := 0;
  Application.OnMessage          := OnMessageOwn;
  CarregaINformacaoDados;
end;

procedure Tbas_AcessoSistema.FormShow(Sender: TObject);
begin
  edt_usuario.SetFocus;
end;

procedure Tbas_AcessoSistema.Image7Click(Sender: TObject);
begin
  Application.Terminate;
end;

function Tbas_AcessoSistema.CriaBanco(NomeBanco: String): String;
begin

  Result:= ' CREATE DATABASE '+ NomeBanco    +
           '    WITH                        '+
           ' OWNER = postgres               '+
           ' ENCODING = '+ QuotedStr('UTF8') +
           ' LC_COLLATE = '+QuotedStr('Portuguese_Brazil.1252')+
           ' LC_CTYPE = '+QuotedStr('Portuguese_Brazil.1252') +
           ' TABLESPACE = pg_default  '+
           ' CONNECTION LIMIT = -1    '+
           ' IS_TEMPLATE = False;     ';
end;

procedure Tbas_AcessoSistema.img_olhoClick(Sender: TObject);
begin
 if edt_senha.PasswordChar = '*' then
 begin
   edt_senha.PasswordChar:= #0;
   img_olho.Visible:= true;
   img_olho_fechado.Visible:= false;
 end
 else
 begin
   edt_senha.PasswordChar:= '*';
   img_olho.Visible:= false;
   img_olho_fechado.Visible:= true;
 end;

end;

//class function Tbas_AcessoSistema.inicializa: Boolean;
//var
//  FrmClass : TFormClass;
//  Frm      : TForm;
//begin
//  try
//    FrmClass     := TFormClass(FindClass('Tbas_AcessoSistema'));
//    Frm          := FrmClass.Create(Application);
//    Frm.ShowModal;
//  finally
//    result       := _Valida;
//  end;
//end;

procedure Tbas_AcessoSistema.OnMessageOwn(var Msg: TMsg; var Handled: Boolean);
var
  KeyState: TKeyboardState;
begin
  GetKeyboardState(KeyState);
  if KeyState[VK_CAPITAL] = 0 then
    lbl_infor.caption:= ''
  else
    lbl_infor.caption:= 'Caps Lock Ativado';
end;


procedure Tbas_AcessoSistema.btn_acessar_Click(Sender: TObject);
begin

  _valida:= False;

  if tentativas = 3 then
  begin
    Application.MessageBox('Voc� excedeu as 3 tentativas de acesso. N�o permitido o acesso.','App G�s',MB_ICONHAND + MB_SYSTEMMODAL);
    Application.terminate;
  end;
  inc(tentativas);
  lbl_tentativas.Caption:= 'Tentativa '+IntToStr(Tentativas)+' de 3';

  if Valida then
  begin

    TServerConfig.GetInstance(edt_senhaBanco.Text, edt_nomeBanco.Text, 'PG');

    if TControllerUsuario.GetInstance.ValidaUsuario(Trim(edt_usuario.Text), Trim(edt_senha.Text)) then
    begin
      _valida:= true;
      Fchave := true;
      close;
    end
    else
      Showmessage('Usuario e senha invalida.');

  end;


end;

function Tbas_AcessoSistema.Valida: Boolean;
begin
  Result:= true;
  if trim(edt_usuario.Text) = '' then
  begin
    Application.MessageBox('Usu�rio e Obrigat�rio!','App G�s',MB_ICONHAND + MB_SYSTEMMODAL);
    edt_usuario.SetFocus;
    Result:= false;
    exit;
  end;
  if trim(edt_senha.Text) = '' then
  begin
    Application.MessageBox('Senha e Obrigat�rio!','App G�s',MB_ICONHAND + MB_SYSTEMMODAL);
    edt_senha.SetFocus;
    Result:= false;
    exit;
  end;
end;

initialization
    RegisterClass(Tbas_AcessoSistema);

end.
