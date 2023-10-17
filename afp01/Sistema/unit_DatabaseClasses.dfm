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
  object ADODataSet_GrupoLogins: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 60
    Top = 312
  end
  object ADOCommand_GrupoLogins: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 60
    Top = 264
  end
  object ADOCommand_ContaLogins: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 208
    Top = 264
  end
  object ADODataSet_ContaLogins: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 208
    Top = 312
  end
  object ADOCommand_RegLogin: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 376
    Top = 264
  end
  object ADODataSet_RegLogin: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 372
    Top = 316
  end
  object ADOCommand_Fornecedores: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 184
    Top = 8
  end
  object ADODataSet_Fornecedores: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 336
    Top = 8
  end
  object ADOCommand_Acervos: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 56
    Top = 361
  end
  object ADODataSet_Acervos: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 200
    Top = 361
  end
  object ADODataSet_Exemplares: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 328
    Top = 365
  end
  object ADOCommand_Exemplares: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 452
    Top = 357
  end
  object ADODataSet_Explorer: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 456
    Top = 33
  end
  object ADOCommand_Explorer: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 456
    Top = 89
  end
end
