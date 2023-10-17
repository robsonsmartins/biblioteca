object DataModule_Biblio: TDataModule_Biblio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 38
  Top = 46
  Height = 479
  Width = 741
  object ADOConnection_Biblio: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 46
    Top = 10
  end
  object ADOCommand_Biblio: TADOCommand
    CommandTimeout = 300
    Connection = ADOConnection_Biblio
    Parameters = <>
    ParamCheck = False
    Left = 48
    Top = 60
  end
  object ADODataSet_Biblio: TADODataSet
    Connection = ADOConnection_Biblio
    ParamCheck = False
    Parameters = <>
    Prepared = True
    Left = 48
    Top = 108
  end
end
