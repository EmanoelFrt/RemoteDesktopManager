unit gerPrincipal;

interface

uses
  ShellAPI, Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.Buttons, Cliente, Acesso;

type
  TfrmGerenciadorTS = class(TForm)
    dbg_cliente: TDBGrid;
    lbl_codigo: TLabel;
    edt_codigo: TEdit;
    lbl_descricao: TLabel;
    edt_descricao: TEdit;
    src_cliente: TDataSource;
    fdq_cliente: TFDQuery;
    dbg_acesso: TDBGrid;
    fdq_acesso: TFDQuery;
    src_acesso: TDataSource;
    lbl_title: TLabel;
    shp: TShape;
    lbl_1: TLabel;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    btn_excluir: TBitBtn;
    btn_editar: TBitBtn;
    btn_novo: TBitBtn;
    btn_conectar: TBitBtn;
    btn_usuario: TBitBtn;
    tmr_atualiza_tela: TTimer;
    procedure btn_novoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure src_clienteDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure src_acessoDataChange(Sender: TObject; Field: TField);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_usuarioClick(Sender: TObject);
    procedure btn_conectarClick(Sender: TObject);
    procedure tmr_atualiza_telaTimer(Sender: TObject);
    procedure dbg_acessoDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbg_clienteDblClick(Sender: TObject);
    procedure edt_codigoChange(Sender: TObject);
    procedure edt_descricaoChange(Sender: TObject);
  private
    Cliente : TCliente;
    Acesso : TAcesso;
    procedure CarregarAcesso;
    procedure PreencherTela;
    procedure DisableEnableAllControls(AContainer: TWinControl; bHabilitaComponents : Boolean = False);
    procedure Conectar;
    procedure FiltrarCliente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerenciadorTS: TfrmGerenciadorTS;
  NomeUsuario : string;

implementation

uses
  gerBanco, gerCadastroCliente, Util, gerUsuario, gerAcessoTS;

{$R *.dfm}

procedure TfrmGerenciadorTS.DisableEnableAllControls(AContainer: TWinControl; bHabilitaComponents : Boolean = False);
var
  I: Integer;
begin
  for I := 0 to AContainer.ControlCount - 1 do
  begin
    if AContainer.Controls[I] is TWinControl then
      DisableEnableAllControls(TWinControl(AContainer.Controls[I]), bHabilitaComponents); // Chamada recursiva para controles dentro de controles

    AContainer.Controls[I].Enabled := bHabilitaComponents; // Desabilita o controle
  end;
end;

procedure TfrmGerenciadorTS.edt_codigoChange(Sender: TObject);
begin
  FiltrarCliente;
end;

procedure TfrmGerenciadorTS.edt_descricaoChange(Sender: TObject);
begin
  FiltrarCliente;
end;

procedure TfrmGerenciadorTS.FiltrarCliente();
begin
  if not (string.IsNullOrWhiteSpace(edt_codigo.Text)) or not (string.IsNullOrWhiteSpace(edt_descricao.Text)) then
  begin
    fdq_cliente.Filtered := False;
    fdq_cliente.Filter   := '';
    if not (string.IsNullOrWhiteSpace(edt_codigo.Text)) and not (string.IsNullOrWhiteSpace(edt_descricao.Text)) then
      fdq_cliente.Filter := 'IDCLIENTE = ' + edt_codigo.Text + ' AND DESCRICAO LIKE ' + QuotedStr(edt_descricao.Text + '%')
    else if not (string.IsNullOrWhiteSpace(edt_codigo.Text)) then
      fdq_cliente.Filter := 'IDCLIENTE = ' + edt_codigo.Text
    else if not (string.IsNullOrWhiteSpace(edt_descricao.Text)) then
      fdq_cliente.Filter := 'DESCRICAO LIKE ' + QuotedStr(edt_descricao.Text + '%');
    fdq_cliente.Filtered := True;
  end
  else
  begin
    fdq_cliente.Filtered := False;
    fdq_cliente.Filter   := '';
  end;
end;

procedure TfrmGerenciadorTS.Conectar();
var
  ExecInfo: TShellExecuteInfo;
  parametros: string;
  Acesso : TAcesso;

  function EncontrarJanelaMSTSC: HWND;
  var
    ClassName: string;
  begin
    ClassName := 'TscShellContainerClass';
    Result := FindWindow(PChar(ClassName), nil);
  end;
  
begin
  tmr_atualiza_tela.Enabled := False;
  frmAcessoTS := TfrmAcessoTS.Create(Self, fdq_acesso.FieldByName('IDACESSO').AsInteger, NomeUsuario);
  try
    if (fdq_acesso.IsEmpty) or (fdq_acesso.FieldByName('IDACESSO').AsInteger = 0) then
    begin
      ShowMessage('Selecione um acesso para conectar!');
      Exit;
    end;

    fdq_acesso.Refresh;

    if fdq_acesso.FieldByName('USUARIO_ACESSANDO').AsString <> '' then
    begin
      ShowMessage('Usuário: ' + fdq_acesso.FieldByName('USUARIO_ACESSANDO').AsString + ' está acessando no momento!');
      Exit;
    end;
  
    DisableEnableAllControls(Self);
    try
      parametros := '/v:' + fdq_acesso.FieldByName('ENDERECO').AsString;

      FillChar(ExecInfo, SizeOf(ExecInfo), 0);
      ExecInfo.cbSize := SizeOf(ExecInfo);
      ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
      ExecInfo.lpFile := 'mstsc.exe';
      ExecInfo.lpParameters := PChar(parametros);
      ExecInfo.nShow := SW_SHOWNORMAL;

      if ShellExecuteEx(@ExecInfo) then
        frmAcessoTS.ShowModal;
    finally
      DisableEnableAllControls(Self, True);
      Application.ProcessMessages;
      dbg_cliente.Refresh;        
      dbg_acesso.Refresh;
    end;
  finally
    frmAcessoTS.Free;
    tmr_atualiza_tela.Enabled := True;
  end;
end;

procedure TfrmGerenciadorTS.dbg_acessoDblClick(Sender: TObject);
begin
  Conectar();
end;

procedure TfrmGerenciadorTS.dbg_clienteDblClick(Sender: TObject);
begin
  Conectar();
end;

procedure TfrmGerenciadorTS.btn_conectarClick(Sender: TObject);
begin
  Conectar();
end;

procedure TfrmGerenciadorTS.btn_editarClick(Sender: TObject);
begin
  Cliente.GetCliente(fdq_cliente.FieldByName('IDCLIENTE').AsInteger, Cliente);
  frmCadastroCliente := TfrmCadastroCliente.Create(Self, Cliente);
  try
    frmCadastroCliente.ShowModal;
    PreencherTela;
  finally
    frmCadastroCliente.Free;
  end;
end;

procedure TfrmGerenciadorTS.btn_excluirClick(Sender: TObject);
begin
  if fdq_cliente.IsEmpty then
    ShowMessage('Selecione um cliente para excluir!')
  else
  begin
    if MessageDlgX('Tem certeza que deseja excluir o Cliente selecionado ?',
                       mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      Cliente.Deletar(fdq_cliente.FieldByName('IDCLIENTE').AsInteger);  
      fdq_cliente.Delete;
    end;
  end;
end;

procedure TfrmGerenciadorTS.btn_novoClick(Sender: TObject);
var
  ClienteNovo : TCliente;
begin
  ClienteNovo := TCliente.Create;
  frmCadastroCliente := TfrmCadastroCliente.Create(Self, ClienteNovo);
  try
    frmCadastroCliente.ShowModal;
    PreencherTela();
  finally
    ClienteNovo.Free;
    frmCadastroCliente.Free;
  end;
end;

procedure TfrmGerenciadorTS.btn_usuarioClick(Sender: TObject);
begin
  NomeUsuario := '';
  while String.IsNullOrWhiteSpace(NomeUsuario) do
  begin
    frmUsuario := TfrmUsuario.Create(Self);
    try
      frmUsuario.ShowModal;
    finally         
      frmUsuario.Free;
      NomeUsuario := ObterValorDoRegistro('GERENCIADOR_TS', 'NOME_USUARIO', '');
    end;
  end;
end;

procedure TfrmGerenciadorTS.PreencherTela();
begin
  if fdq_cliente.Active then fdq_cliente.Close;  
  fdq_cliente.Active := True;
  CarregarAcesso();
end;

procedure TfrmGerenciadorTS.src_acessoDataChange(Sender: TObject;
  Field: TField);
begin
  btn_conectar.Enabled := fdq_acesso.FieldByName('IDACESSO').AsInteger > 0;  
end;

procedure TfrmGerenciadorTS.src_clienteDataChange(Sender: TObject;
  Field: TField);
begin
  CarregarAcesso();
end;

procedure TfrmGerenciadorTS.tmr_atualiza_telaTimer(Sender: TObject);
begin
  fdq_acesso.Refresh;
end;

procedure TfrmGerenciadorTS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Acesso.LimpaAcessosUsuario(NomeUsuario);
end;

procedure TfrmGerenciadorTS.FormCreate(Sender: TObject);
begin
  Cliente := TCliente.Create;
  Acesso  := TAcesso.Create;
end;

procedure TfrmGerenciadorTS.CarregarAcesso();
begin
  if fdq_acesso.Active then fdq_acesso.Close;
  fdq_acesso.ParamByName('IDCLIENTE').AsInteger := fdq_cliente.FieldByName('IDCLIENTE').AsInteger;
  fdq_acesso.Active := True;  
end;

procedure TfrmGerenciadorTS.FormDestroy(Sender: TObject);
begin
  Acesso.Free;
  Cliente.Free;
end;

procedure TfrmGerenciadorTS.FormShow(Sender: TObject);
begin
  PreencherTela();
  NomeUsuario := ObterValorDoRegistro('GERENCIADOR_TS', 'NOME_USUARIO', '');
  while String.IsNullOrWhiteSpace(NomeUsuario) do
  begin
    frmUsuario := TfrmUsuario.Create(Self);
    try
      frmUsuario.ShowModal;
    finally         
      frmUsuario.Free;
      NomeUsuario := ObterValorDoRegistro('GERENCIADOR_TS', 'NOME_USUARIO', '');
    end;
  end;
  Acesso.LimpaAcessosUsuario(NomeUsuario);
  tmr_atualiza_tela.Enabled := True;
end;

end.
