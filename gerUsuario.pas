unit gerUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuario = class(TForm)
    edt_nome: TEdit;
    lbl_nome: TLabel;
    btn_salvar_cliente: TBitBtn;
    procedure btn_salvar_clienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

uses
  Util;

{$R *.dfm}

procedure TfrmUsuario.btn_salvar_clienteClick(Sender: TObject);
begin
  if String.IsNullOrWhiteSpace(edt_nome.Text) then
  begin
    ShowMessage('Informe o seu nome!');
    Exit;
  end;
  SalvarValorNoRegistro('GERENCIADOR_TS', 'NOME_USUARIO', edt_nome.Text);
  Close();
end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  edt_nome.Text := ObterValorDoRegistro('GERENCIADOR_TS', 'NOME_USUARIO', '');
end;

end.
