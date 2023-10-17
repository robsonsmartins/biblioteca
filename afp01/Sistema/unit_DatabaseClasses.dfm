object DataModule_Biblio: TDataModule_Biblio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 2
  Top = 71
  Height = 479
  Width = 741
  object ADOConnection_Biblio: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 46
    Top = 10
  end
  object ADOCommand_Usuarios: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 52
    Top = 60
  end
  object ADODataSet_Usuarios: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 48
    Top = 108
  end
  object ADOCommand_TipoUsuarios: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 196
    Top = 60
  end
  object ADODataSet_TipoUsuarios: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 196
    Top = 108
  end
  object ADODataSet_TipoFornecedores: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 356
    Top = 108
  end
  object ADOCommand_TipoFornecedores: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 356
    Top = 60
  end
  object ADODataSet_ClassificacaoAcervos: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 376
    Top = 212
  end
  object ADOCommand_ClassificacaoAcervos: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 384
    Top = 160
  end
  object ADODataSet_TipoAcervos: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 60
    Top = 212
  end
  object ADOCommand_TipoAcervos: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 60
    Top = 160
  end
  object ADODataSet_AreaAcervos: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 216
    Top = 212
  end
  object ADOCommand_AreaAcervos: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 216
    Top = 160
  end
end
