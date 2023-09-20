unit Util;

interface

uses
  Winapi.Windows, Registry, Messages, Forms, Dialogs;

  function ObterValorDoRegistro(const chave, nome,
    valorPadrao: string): string;
  procedure SalvarValorNoRegistro(const chave, nome, valor: string);
  function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: TMsgDlgBtn; iPosX:Integer=-1;iPosY:Integer=-1 ): Integer; overload;
  function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint=0): Integer; overload;
  function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; DefButton: TMsgDlgBtn; iPosX:Integer=-1; iPosY:Integer=-1 ): Integer; overload;

implementation

procedure SalvarValorNoRegistro(const chave, nome, valor: string);
var
  registro: TRegistry;
begin
  registro := TRegistry.Create;
  try
    registro.RootKey := HKEY_CURRENT_USER;

    if registro.OpenKey(chave, True) then
    begin
      registro.WriteString(nome, valor);
      registro.CloseKey;
    end;
  finally
    registro.Free;
  end;
end;

function ObterValorDoRegistro(const chave, nome, valorPadrao: string): string;
var
  registro: TRegistry;
begin
  registro := TRegistry.Create;
  try
    registro.RootKey := HKEY_CURRENT_USER;

    if registro.OpenKeyReadOnly(chave) then
    begin
      if registro.ValueExists(nome) then
        Result := registro.ReadString(nome)
      else
        Result := valorPadrao;

      registro.CloseKey;
    end
    else
      Result := valorPadrao;
  finally
    registro.Free;
  end;
end;

function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: TMsgDlgBtn; iPosX:Integer=-1;iPosY:Integer=-1 ): Integer;
begin
  Result := MessageDlgX(Msg, DlgType, Buttons, 0, DefButton, iPosX, iPosY );
end;

function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint=0): Integer;
Var
  LDefaultButton: TMsgDlgBtn;
begin
  //Fonte copiado do Vcl.Dialogs Delphi para identificar o DefaultButton
  if mbOk in Buttons then
    LDefaultButton := mbOk
  else if mbYes in Buttons then
    LDefaultButton := mbYes
  else
    LDefaultButton := mbRetry;
  Result := MessageDlgX(Msg, DlgType, Buttons, 0, LDefaultButton);
end;

function MessageDlgX(Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; DefButton: TMsgDlgBtn; iPosX:Integer=-1;iPosY:Integer=-1 ): Integer;
begin
 {$IFDEF MSWINDOWS}
  with CreateMessageDialog(Msg, DlgType, Buttons, DefButton ) do
    try
      //Altera��o 06/12/2019 (Andr� Piana)
      //O par�metro HelpCtx foi disponibilizado inicialmente na fun��o MessageDlgX, por�m
      //nunca foi utilizado visto que utilizamos o HelpType = htKeyword e n�o htContext
      //desta forma, caso atribu�do um valor diferente de zero ao par�metro HelpCtx seria gerada
      //uma exce��o, j� que n�o existe o controle de help por Context.
      //Neste sentido foram criadas novas function MessageDlgX (overload) sem o par�metro HelpCtx,
      //as demais function MessageDlgX (overload) foram mantidas para manter compatibilidade
      //visto que o par�metro era obrigat�rio.
      HelpContext:=0;
      HelpFile:= '';
      if (iPosX>-1) and (iPosY>-1) then
      begin
        Left:=iPosX;
        Top:=iPosY;
      end
      else
        Position:= poScreenCenter;
      Result:= ShowModal;
    finally
      Free;
    end;
  {$ENDIF}
  {$IFDEF LINUX}
    Result:=MessageDlg(Msg,Dlgtype,Buttons,HelpCtx,DefButton);
  {$ENDIF}
end;

end.
