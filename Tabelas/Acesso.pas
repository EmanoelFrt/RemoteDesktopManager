unit Acesso;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Enum;

type
  TAcesso = class
  private
    FIDAcesso: Integer;
    FIDCliente: Integer;
    FDescricao: string;
    FEndereco: string;
    FLogin: string;
    FSenha: string;
    FUsuario_Acessando: string;

    FCliente_Descricao : string;

  public
    property IDAcesso: Integer read FIDAcesso write FIDAcesso;
    property IDCliente: Integer read FIDCliente write FIDCliente;
    property Descricao: string read FDescricao write FDescricao;
    property Endereco: string read FEndereco write FEndereco;
    property Login: string read FLogin write FLogin;
    property Senha: string read FSenha write FSenha;
    property Usuario_Acessando: string read FUsuario_Acessando write FUsuario_Acessando;
    property Cliente_Descricao: string read FCliente_Descricao write FCliente_Descricao;

    procedure Salvar(TipoOperacao : TTipoOperacao);               
    procedure AtualizaUsuarioAcessando(iIdAcesso : Integer; sUsuarioAcessando: string);
    procedure LimpaAcessosUsuario(sNomeUsuario: string);
    procedure Deletar(iIDAcesso : Integer);
    procedure Clear(Acesso : TAcesso);

    procedure GetAcesso(iIDAcesso : Integer; var Acesso : TAcesso);
    function GetAcessos(iIDCliente : Integer) : TFDQuery;
  end;

implementation

uses
  gerBanco;

procedure TAcesso.Salvar(TipoOperacao : TTipoOperacao);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    if TipoOperacao = toInsert then
      qry.SQL.Add('INSERT INTO ACESSO (IDACESSO, IDCLIENTE, DESCRICAO, ENDERECO, LOGIN, SENHA, USUARIO_ACESSANDO) ' +
                              'VALUES (:IDACESSO, :IDCLIENTE, :DESCRICAO, :ENDERECO, :LOGIN, :SENHA, :USUARIO_ACESSANDO)')
    else
      qry.SQL.Add('UPDATE ACESSO ' +
                  'SET IDCLIENTE = :IDCLIENTE, ' +
                  'DESCRICAO = :DESCRICAO, ' +
                  'ENDERECO = :ENDERECO, ' +
                  'LOGIN = :LOGIN, ' +
                  'SENHA = :SENHA, ' +
                  'USUARIO_ACESSANDO = :USUARIO_ACESSANDO ' +
                  'WHERE IDACESSO = :IDACESSO');

    qry.ParamByName('IDACESSO').AsInteger := IDAcesso;
    qry.ParamByName('IDCLIENTE').AsInteger := IDCliente;
    qry.ParamByName('DESCRICAO').AsString := Descricao;
    qry.ParamByName('ENDERECO').AsString := Endereco;
    qry.ParamByName('LOGIN').AsString := Login;
    qry.ParamByName('SENHA').AsString := Senha;  
    qry.ParamByName('USUARIO_ACESSANDO').AsString := Usuario_Acessando;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TAcesso.AtualizaUsuarioAcessando(iIdAcesso : Integer; sUsuarioAcessando : string);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('UPDATE ACESSO ' +
                'SET USUARIO_ACESSANDO = :USUARIO_ACESSANDO ' +
                'WHERE IDACESSO = :IDACESSO');

    qry.ParamByName('IDACESSO').AsInteger := iIdAcesso;
    if String.IsNullOrWhiteSpace(sUsuarioAcessando) then
      qry.ParamByName('USUARIO_ACESSANDO').Clear
    else
      qry.ParamByName('USUARIO_ACESSANDO').AsString := sUsuarioAcessando;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TAcesso.LimpaAcessosUsuario(sNomeUsuario : string);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('UPDATE ACESSO ' +
                'SET USUARIO_ACESSANDO = :USUARIO_ACESSANDO ' +
                'WHERE USUARIO_ACESSANDO = :USUARIO_ACESSANDO_ATUAL');

    qry.ParamByName('USUARIO_ACESSANDO_ATUAL').AsString := sNomeUsuario;
    qry.ParamByName('USUARIO_ACESSANDO').Clear;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TAcesso.Clear(Acesso : TAcesso);
begin
  Acesso.IDAcesso          := 0;
  Acesso.IDCliente         := 0;
  Acesso.Descricao         := '';
  Acesso.Endereco          := '';
  Acesso.Login             := '';
  Acesso.Senha             := '';  
  Acesso.Usuario_Acessando := '';
end;

procedure TAcesso.Deletar(iIDAcesso : Integer);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('DELETE FROM ACESSO ' +
                'WHERE IDACESSO = :IDACESSO');

    qry.ParamByName('IDACESSO').AsInteger := iIDAcesso;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TAcesso.GetAcesso(iIDAcesso : Integer; var Acesso : TAcesso);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  if Acesso = nil then
    Acesso := TAcesso.Create;
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('SELECT ACESSO.*, CLIENTE.DESCRICAO AS CLIENTE_DESCRICAO FROM ACESSO ' +
                'LEFT JOIN CLIENTE ON CLIENTE.IDCLIENTE = ACESSO.IDCLIENTE ' +
                'WHERE IDACESSO = :IDACESSO');

    qry.ParamByName('IDACESSO').AsInteger := iIDAcesso;
    qry.Open;
    if not qry.IsEmpty then
    begin
      Acesso.IDAcesso := qry.FieldByName('IDACESSO').AsInteger;
      Acesso.IDCliente := qry.FieldByName('IDCLIENTE').AsInteger;
      Acesso.Descricao := qry.FieldByName('DESCRICAO').AsString;
      Acesso.Endereco := qry.FieldByName('ENDERECO').AsString;
      Acesso.Login := qry.FieldByName('LOGIN').AsString;
      Acesso.Senha := qry.FieldByName('SENHA').AsString;
      Acesso.Usuario_Acessando := qry.FieldByName('USUARIO_ACESSANDO').AsString;
      Acesso.Cliente_Descricao := qry.FieldByName('CLIENTE_DESCRICAO').AsString;
    end;
  finally
    qry.Free;
  end;
end;

function TAcesso.GetAcessos(iIDCliente : Integer) : TFDQuery;
var
  Field : TField;
begin
  Result := TFDQuery.Create(nil);

  Result.Connection := banco.con_banco;
  Result.SQL.Add('SELECT * FROM ACESSO ' +
                 'WHERE IDCLIENTE = :IDCLIENTE');

  Result.ParamByName('IDCLIENTE').AsInteger := iIDCliente;
  Result.Open;

  for Field in Result.Fields do
    Field.Required := False;
                                  
  Result.UpdateOptions.CheckRequired := False;
  Result.UpdateOptions.AutoCommitUpdates := False;
  Result.CachedUpdates := True;
end;

end.
