object banco: Tbanco
  Height = 150
  Width = 215
  object con_banco: TFDConnection
    Params.Strings = (
      'Database=C:\RemoteDesktopManager\bd\BANCO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'Protocol=TCPIP'
      'Server=localhost'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDefault
    LoginPrompt = False
    Left = 16
    Top = 6
  end
end
