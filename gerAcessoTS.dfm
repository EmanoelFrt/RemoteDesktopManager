object frmAcessoTS: TfrmAcessoTS
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Acesso Atual'
  ClientHeight = 160
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    407
    160)
  TextHeight = 13
  object lbl_acesso_atual: TLabel
    Left = 8
    Top = 4
    Width = 77
    Height = 17
    Caption = 'Acesso Atual:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object shp: TShape
    Left = 8
    Top = 27
    Width = 391
    Height = 2
    Anchors = [akLeft, akTop, akRight]
    Brush.Color = 14869218
    Pen.Color = 6903103
    Shape = stRoundRect
  end
  object lbl_login: TLabel
    Left = 8
    Top = 32
    Width = 32
    Height = 17
    Alignment = taCenter
    Caption = 'Login'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_senha: TLabel
    Left = 8
    Top = 86
    Width = 35
    Height = 17
    Alignment = taCenter
    Caption = 'Senha'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edt_login: TEdit
    Left = 8
    Top = 55
    Width = 391
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 200
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object edt_senha: TEdit
    Left = 8
    Top = 109
    Width = 249
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 200
    ParentFont = False
    PasswordChar = '*'
    ReadOnly = True
    TabOrder = 1
  end
  object btn_exibir_senha: TBitBtn
    Left = 263
    Top = 104
    Width = 136
    Height = 35
    Caption = 'Exibir Senha'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C0000C40E0000C40E00000000000000000000E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1CAD8DE6DB5D269B4D269B4D269B4D269B4D269B4D269B4
      D269B4D269B4D269B4D269B4D269B4D269B4D269B4D269B4D269B4D269B4D269
      B4D269B4D26DB5D2CBD9DEE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E16AB4D2008CC4008CC4008CC4008CC4008CC4008CC4008C
      C4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC400
      8CC4008CC4008CC46BB5D2E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E165B2D1008CC4008CC4008CC4008CC4008CC4008CC4008C
      C4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC400
      8CC4008CC4008CC465B2D1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E165B2D1008CC4008CC4008CC4008CC4008CC4008CC4008C
      C4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC4008CC400
      8CC4008CC4008CC465B2D1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E16CC1E11BACE21BACE21BACE21BACE21BACE21BACE21BAC
      E21BACE21BACE21BACE21BACE21BACE21BACE21BACE21BACE21BACE21BACE21B
      ACE21BACE21BACE26CC1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E164C0E200A6E300A6E300A6E300A6E300A6E300A6E300A6
      E300A6E300A6E300A6E300A6E300A6E300A6E300A6E300A6E300A6E300A6E300
      A6E300A6E300A6E364C0E2E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E164C0E200A6E300A6E300A6E30996CA01A3DF00A6E300A6
      E3069AD004A0D900A6E300A6E3049FD8069AD100A6E300A6E301A3DF0996CA00
      A6E300A6E300A6E364C0E2E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E16EC4E21FAFE31FAFE3268FB53B3B3B2F697E1FAFE321A6
      D53A3E403650591FAFE31FAFE3364F573A3F4121A6D51FAFE330697D3B3B3B27
      90B61FAFE31FAFE36EC4E2E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E164CEE800BEED00BEED09AAD231535B178AA600BEED02B9
      E72C5C6722718500BEED00BEED2370842C5C6802BAE800BEED188AA630525B09
      ABD300BEED00BEED64CEE8E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E164CEE800BEED00BEED00BEED00BEED00BEED00BEED00BE
      ED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00
      BEED00BEED00BEED64CEE8E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E164CEE800BEED00BEED00BEED00BEED00BEED00BEED00BE
      ED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00BEED00
      BEED00BEED00BEED64CEE8E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E177D5EA38CCED38CCED38CCED38CCED38CCED38CCED38CC
      ED38CCED38CCED38CCED38CCED38CCED38CCED38CCED38CCED38CCED38CCED38
      CCED38CCED38CCED77D5EAE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E165DBEF00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5
      FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00
      D5FA00D5FA00D5FA65DBEFE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E165DBEF00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5
      FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00
      D5FA00D5FA00D5FA65DBEFE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E17DDBEC00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5
      FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00D5FA00
      D5FA00D5FA00D5FA7EDCECE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E0E1E1B8DFE6B4DFE6B4DFE6A1C5C19EC0BBAED7DCB4DF
      E6B4DFE6B4DFE6B4DFE6B4DFE6B4DFE6B4DFE6B4DFE6AED7DC9EC0BBA1C5C1B4
      DFE6B4DFE6B8DFE6E0E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1D8CAB9D6C6B2DFDBD6E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DFDBD6D6C6B2D8CAB9E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1D9CCBCD6C6B2DED9D2E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DED8D2D6C6B2D9CCBCE1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DAD0C4D6C6B2DBD2C6E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DBD1C6D6C6B2DAD0C4E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DEDAD4D6C6B2D6C7B4E0DD
      DAE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E0DDDAD6C7B3D6C6B2DED9D4E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1D9CDBED6C6B2D7C9
      B8DFDCD8E1E1E1E1E1E1E1E1E1E1E1E1DFDCD8D7C9B7D6C6B2D8CDBEE1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E0DEDCD7CAB8D6C6
      B2D6C6B3D9CEBFDCD4CADCD4CAD9CEBFD6C6B3D6C6B2D8CAB9E0DFDDE1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E0DEDDD9CE
      C0D6C6B2D6C6B2D6C6B2D6C6B2D6C6B2D6C6B2D9CEC1E0DFDDE1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1DFDCD8DCD4CADAD0C4DAD0C4DCD4CADFDCD9E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
      E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1}
    ParentFont = False
    TabOrder = 2
    OnClick = btn_exibir_senhaClick
  end
  object tmr_acesso: TTimer
    Enabled = False
    OnTimer = tmr_acessoTimer
    Left = 184
    Top = 80
  end
end
