program GerenciadorTS;

uses
  Vcl.Forms,
  gerPrincipal in 'gerPrincipal.pas' {frmGerenciadorTS},
  gerCadastroCliente in 'gerCadastroCliente.pas' {frmCadastroCliente},
  gerCadastroAcesso in 'gerCadastroAcesso.pas' {frmCadastroAcesso},
  gerBanco in 'gerBanco.pas' {banco: TDataModule},
  Cliente in 'Tabelas\Cliente.pas',
  Enum in 'Enum.pas',
  Acesso in 'Tabelas\Acesso.pas',
  Util in 'Util.pas',
  gerUsuario in 'gerUsuario.pas' {frmUsuario},
  gerAcessoTS in 'gerAcessoTS.pas' {frmAcessoTS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tbanco, banco);
  Application.CreateForm(TfrmGerenciadorTS, frmGerenciadorTS);
  Application.Run;
end.
