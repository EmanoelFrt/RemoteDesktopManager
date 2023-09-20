unit gerAcessoTS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Acesso,
  Vcl.Buttons;

type
  TfrmAcessoTS = class(TForm)
    lbl_acesso_atual: TLabel;
    shp: TShape;
    edt_login: TEdit;
    lbl_login: TLabel;
    edt_senha: TEdit;
    lbl_senha: TLabel;
    tmr_acesso: TTimer;
    btn_exibir_senha: TBitBtn;
    procedure tmr_acessoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_exibir_senhaClick(Sender: TObject);
  private
    _IdAcesso : Integer;
    _NomeUsuario : string;
    Acesso : TAcesso;
    procedure PreencherTela;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; IdAcesso : Integer; NomeUsuario : string) overload;
    { Public declarations }
  end;

var
  frmAcessoTS: TfrmAcessoTS;

implementation

{$R *.dfm}

procedure TfrmAcessoTS.btn_exibir_senhaClick(Sender: TObject);
begin
  if edt_senha.PasswordChar = '*' then
  begin
    edt_senha.PasswordChar := #0;
    btn_exibir_senha.Caption := 'Ocultar Senha';
  end
  else
  begin
    edt_senha.PasswordChar := '*';
    btn_exibir_senha.Caption := 'Exibir Senha';
  end;
end;

constructor TfrmAcessoTS.Create(AOwner: TComponent; IdAcesso : Integer; NomeUsuario : string);
begin
  inherited Create(AOwner);
  _IdAcesso := IdAcesso;
  _NomeUsuario := NomeUsuario;
end;

procedure TfrmAcessoTS.FormCreate(Sender: TObject);
begin
  Acesso := TAcesso.Create;
end;

procedure TfrmAcessoTS.FormDestroy(Sender: TObject);
begin
  Acesso.AtualizaUsuarioAcessando(_IdAcesso, '');
  Acesso.Free;
end;

procedure TfrmAcessoTS.FormShow(Sender: TObject);
begin
  Acesso.GetAcesso(_IdAcesso, Acesso);
  Acesso.AtualizaUsuarioAcessando(_IdAcesso, _NomeUsuario);

  PreencherTela;

  tmr_acesso.Enabled := True;
end;

procedure TfrmAcessoTS.PreencherTela;
begin
  lbl_acesso_atual.Caption := Acesso.Cliente_Descricao + ' - ' + Acesso.Descricao;
  edt_login.Text := Acesso.Login;
  edt_senha.Text := Acesso.Senha;
end;

procedure TfrmAcessoTS.tmr_acessoTimer(Sender: TObject);
var
  iCont : Integer;
begin
  Application.ProcessMessages;
  if (FindWindow('TscShellContainerClass', nil) = 0) or (Application.Terminated) then // Janela MSTSC.exe foi fechada ou aplicação encerrada, prosseguir com o restante do código
  begin
    tmr_acesso.Enabled := False;
    Close;
  end;
end;

end.
