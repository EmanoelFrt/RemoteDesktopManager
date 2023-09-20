unit gerCadastroAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Enum;

type
  TfrmCadastroAcesso = class(TForm)
    edt_codigo: TEdit;
    lbl_codigo: TLabel;
    edt_descricao: TEdit;
    lbl_descricao: TLabel;
    edt_endereco: TEdit;
    lbl_endereco: TLabel;
    edt_login: TEdit;
    lbl_login: TLabel;
    edt_senha: TEdit;
    lbl_senha: TLabel;
    btn_salvar: TBitBtn;
    btn_cancelar: TBitBtn;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _Acesso : TFDQuery;
    _TipoOp : TTipoOperacao;
    procedure PreencherTela;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Acesso : TFDQuery; TipoOp : TTipoOperacao) overload;
    { Public declarations }
  end;

var
  frmCadastroAcesso: TfrmCadastroAcesso;

implementation

{$R *.dfm}

procedure TfrmCadastroAcesso.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroAcesso.btn_salvarClick(Sender: TObject);

  function ValidouDados : Boolean;
  begin
    Result := True;
    if String.IsNullOrWhiteSpace(edt_descricao.Text) then
    begin
      Result := False;
      ShowMessage('Informe a Descrição!');
      edt_descricao.SetFocus;
      Exit;
    end;
    if String.IsNullOrWhiteSpace(edt_endereco.Text) then
    begin
      Result := False;
      ShowMessage('Informe o Endereço!');
      edt_endereco.SetFocus;
      Exit;
    end;
  end;

begin
  if not ValidouDados then
    Exit;

  if not (_Acesso.State in dsEditModes) then
  begin
    if _TipoOp = toInsert then
      _Acesso.Append
    else
      _Acesso.Edit;
  end;
  _Acesso.FieldByName('DESCRICAO').AsString := edt_descricao.Text;
  _Acesso.FieldByName('ENDERECO').AsString  := edt_endereco.Text;
  _Acesso.FieldByName('LOGIN').AsString     := edt_login.Text;
  _Acesso.FieldByName('SENHA').AsString     := edt_senha.Text;
  _Acesso.Post;
  Close;
end;

constructor TfrmCadastroAcesso.Create(AOwner: TComponent; Acesso : TFDQuery; TipoOp : TTipoOperacao);
begin
  inherited Create(AOwner);
  _Acesso := Acesso;
  _TipoOp := TipoOp;
end;

procedure TfrmCadastroAcesso.FormCreate(Sender: TObject);
begin
  if _TipoOp = toUpdate then
    PreencherTela();
end;

procedure TfrmCadastroAcesso.PreencherTela;
begin
  edt_codigo.Text    := _Acesso.FieldByName('IDACESSO').AsString;
  edt_descricao.Text := _Acesso.FieldByName('DESCRICAO').AsString;
  edt_endereco.Text  := _Acesso.FieldByName('ENDERECO').AsString;
  edt_login.Text     := _Acesso.FieldByName('LOGIN').AsString;
  edt_senha.Text     := _Acesso.FieldByName('SENHA').AsString;
end;

end.
