unit Cliente;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Enum;

type
  TCliente = class
  private
    FIDCliente: Integer;
    FDescricao: string;

  public
    property IDCliente: Integer read FIDCliente write FIDCliente;
    property Descricao: string read FDescricao write FDescricao;

    procedure Salvar(TipoOperacao : TTipoOperacao);
    procedure Deletar(iIDCliente : Integer);

    procedure GetCliente(iIDCliente : Integer; var Cliente : TCliente);
  end;

implementation

uses
  gerBanco;

procedure TCliente.Salvar(TipoOperacao : TTipoOperacao);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    if TipoOperacao = toInsert then
      qry.SQL.Add('INSERT INTO CLIENTE (IDCLIENTE, DESCRICAO) ' +
                              'VALUES (:IDCLIENTE, :DESCRICAO)')
    else
      qry.SQL.Add('UPDATE CLIENTE ' +
                  'SET DESCRICAO = :DESCRICAO ' +
                  'WHERE IDCLIENTE = :IDCLIENTE');

    qry.ParamByName('IDCLIENTE').AsInteger := IDCliente;
    qry.ParamByName('DESCRICAO').AsString := Descricao;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TCliente.Deletar(iIDCliente : Integer);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('DELETE FROM CLIENTE ' +
                'WHERE IDCLIENTE = :IDCLIENTE');

    qry.ParamByName('IDCLIENTE').AsInteger := iIDCliente;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TCliente.GetCliente(iIDCliente : Integer; var Cliente : TCliente);
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  if Cliente = nil then
    Cliente := TCliente.Create;
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('SELECT * FROM CLIENTE ' +
                'WHERE IDCLIENTE = :IDCLIENTE');

    qry.ParamByName('IDCLIENTE').AsInteger := iIDCliente;
    qry.Open;
    if not qry.IsEmpty then
    begin
      Cliente.IDCliente := qry.FieldByName('IDCLIENTE').AsInteger;
      Cliente.Descricao := qry.FieldByName('DESCRICAO').AsString;
    end;
  finally
    qry.Free;
  end;
end;

end.
