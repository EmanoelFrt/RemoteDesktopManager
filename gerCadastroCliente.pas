unit gerCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Cliente, Acesso,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Enum;

type
  TfrmCadastroCliente = class(TForm)
    edt_codigo_cliente: TEdit;
    lbl_codigo: TLabel;
    edt_descricao_cliente: TEdit;
    lbl_descricao: TLabel;
    btn_salvar_cliente: TBitBtn;
    btn_cancelar_cliente: TBitBtn;
    dbg_acesso_cliente: TDBGrid;
    lbl_1: TLabel;
    shp1: TShape;
    btn_novo_cliente: TBitBtn;
    btn_editar_cliente: TBitBtn;
    btn_excluir_cliente: TBitBtn;
    src_acesso: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_cancelar_clienteClick(Sender: TObject);
    procedure btn_salvar_clienteClick(Sender: TObject);
    procedure btn_novo_clienteClick(Sender: TObject);
    procedure btn_editar_clienteClick(Sender: TObject);
    procedure btn_excluir_clienteClick(Sender: TObject);
  private
    _Cliente : TCliente;
    Acessos : TFDQuery;
    Acesso : TAcesso;
    procedure PreencherTela;
    procedure CarregaAcesso(BuscarBanco : Boolean);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Cliente : TCliente) overload;
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  gerBanco, gerCadastroAcesso, Util;

{$R *.dfm}

constructor TfrmCadastroCliente.Create(AOwner: TComponent; Cliente : TCliente);
begin
  inherited Create(AOwner);
  _Cliente := Cliente;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  Acesso := TAcesso.Create;
  PreencherTela;
end;

procedure TfrmCadastroCliente.FormDestroy(Sender: TObject);
begin
  if Acessos <> nil then
    Acessos.Free;
  Acesso.Free;
end;

procedure TfrmCadastroCliente.btn_cancelar_clienteClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroCliente.btn_editar_clienteClick(Sender: TObject);
begin
  frmCadastroAcesso := TfrmCadastroAcesso.Create(Self, Acessos, toUpdate);
  try
    frmCadastroAcesso.ShowModal;
  finally
    frmCadastroAcesso.Free;
  end;
end;

procedure TfrmCadastroCliente.btn_excluir_clienteClick(Sender: TObject);
begin
  if Acessos.IsEmpty then
    ShowMessage('Selecione um acesso para excluir!')
  else
  begin
    if MessageDlgX('Tem certeza que deseja excluir o Acesso selecionado ?',
                       mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      Acesso.Deletar(Acessos.FieldByName('IDACESSO').AsInteger);
      Acessos.Delete;
    end;
  end;
end;

procedure TfrmCadastroCliente.btn_novo_clienteClick(Sender: TObject);
begin
  frmCadastroAcesso := TfrmCadastroAcesso.Create(Self, Acessos, toInsert);
  try
    frmCadastroAcesso.ShowModal;
  finally
    frmCadastroAcesso.Free;
  end;
end;

procedure TfrmCadastroCliente.btn_salvar_clienteClick(Sender: TObject);
var
  Transaction: TFDTransaction;
  TipoOpCliente, TipoOpAcesso : TTipoOperacao;

  function ValidouDados : Boolean;
  begin
    Result := True;
    if String.IsNullOrWhiteSpace(edt_descricao_cliente.Text) then
    begin
      Result := False;
      ShowMessage('Informe a Descrição!');
      edt_descricao_cliente.SetFocus;
      Exit;
    end;
  end;

begin
  Transaction := TFDTransaction.Create(nil);
  Acessos.DisableControls;
  try
    Transaction.Connection := banco.con_banco;
    Transaction.StartTransaction;
    try
      if not ValidouDados then
        Exit;

      TipoOpCliente := toUpdate;

      if String.IsNullOrWhiteSpace(edt_codigo_cliente.Text) then
      begin
        TipoOpCliente      := toInsert;
        _Cliente.IDCliente := banco.getGenerator('GEN_CLIENTE');
      end
      else
        _Cliente.IDCliente := StrToIntDef(edt_codigo_cliente.Text, 0);

      _Cliente.Descricao := edt_descricao_cliente.Text;

      _Cliente.Salvar(TipoOpCliente);

      Acessos.First;
      while not Acessos.Eof do
      begin
        Acesso.Clear(Acesso);

        TipoOpAcesso := toUpdate;
        if Acessos.FieldByName('IDACESSO').AsInteger = 0 then
        begin
          TipoOpAcesso    := toInsert;
          Acesso.IDAcesso := banco.getGenerator('GEN_ACESSO');
          Acessos.Edit;
          Acessos.FieldByName('IDACESSO').AsInteger := Acesso.IDAcesso;
          Acessos.Post;
        end
        else
          Acesso.IDAcesso := Acessos.FieldByName('IDACESSO').AsInteger;

        Acesso.IDCliente := _Cliente.IDCliente;
        Acesso.Descricao := Acessos.FieldByName('DESCRICAO').AsString;
        Acesso.Endereco  := Acessos.FieldByName('ENDERECO').AsString;
        Acesso.Login     := Acessos.FieldByName('LOGIN').AsString;
        Acesso.Senha     := Acessos.FieldByName('SENHA').AsString;

        Acesso.Salvar(TipoOpAcesso);

        Acessos.Next;
      end;
      Acessos.First;

      Transaction.Commit;
      ShowMessage('Cliente salvo com sucesso !');
      PreencherTela;
    except
      on E : Exception do
      begin
        Transaction.Rollback;
        raise Exception.Create('Erro ao Salvar o Cliente: ' + #13#10 + e.Message);
      end;
    end;
  finally
    Transaction.Free;
    Acessos.EnableControls;
  end;
end;

procedure TfrmCadastroCliente.CarregaAcesso(BuscarBanco : Boolean);
begin
  if BuscarBanco then
    Acessos := Acesso.GetAcessos(_Cliente.IDCliente);
  src_acesso.DataSet := Acessos;
end;

procedure TfrmCadastroCliente.PreencherTela;
begin
  if _Cliente.IDCliente > 0 then
    edt_codigo_cliente.Text    := _Cliente.IDCliente.ToString;
  edt_descricao_cliente.Text := _Cliente.Descricao;
  CarregaAcesso(True);
end;

end.
