object banco: Tbanco
  OldCreateOrder = False
  Height = 150
  Width = 215
  object con_banco: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=D:/GerenciadorTS/bd/BANCO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'Protocol=TCPIP'
      'Server=192.168.0.65')
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDefault
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 6
  end
end
