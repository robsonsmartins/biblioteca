object Form1: TForm1
  Left = 200
  Top = 121
  Width = 486
  Height = 311
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 89
    Height = 13
    Caption = 'Serial CD (Serial B)'
  end
  object Label2: TLabel
    Left = 12
    Top = 76
    Width = 28
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 12
    Top = 116
    Width = 20
    Height = 13
    Caption = 'CPF'
  end
  object Label4: TLabel
    Left = 160
    Top = 116
    Width = 28
    Height = 13
    Caption = 'e-Mail'
  end
  object Label5: TLabel
    Left = 12
    Top = 160
    Width = 90
    Height = 13
    Caption = 'Serial HD (Serial A)'
  end
  object Label6: TLabel
    Left = 364
    Top = 36
    Width = 55
    Height = 13
    Caption = 'UnidadeCD'
  end
  object Label8: TLabel
    Left = 12
    Top = 204
    Width = 94
    Height = 13
    Caption = 'Chave de Ativação:'
  end
  object nvg_Protecao: TDBNavigator
    Left = 4
    Top = 4
    Width = 460
    Height = 25
    DataSource = ds_Protecao
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 12
    Top = 52
    Width = 313
    Height = 21
    DataField = 'SerialCD'
    DataSource = ds_Protecao
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 12
    Top = 92
    Width = 313
    Height = 21
    DataField = 'Nome'
    DataSource = ds_Protecao
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 12
    Top = 132
    Width = 133
    Height = 21
    DataField = 'CPF'
    DataSource = ds_Protecao
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 160
    Top = 132
    Width = 165
    Height = 21
    DataField = 'Email'
    DataSource = ds_Protecao
    TabOrder = 4
  end
  object DBEdit5: TDBEdit
    Left = 12
    Top = 176
    Width = 313
    Height = 21
    DataField = 'SerialHD'
    DataSource = ds_Protecao
    TabOrder = 5
  end
  object BitBtn1: TBitBtn
    Left = 328
    Top = 208
    Width = 147
    Height = 25
    Caption = 'Lê CD / Gera Chave'
    TabOrder = 6
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object cbx_Drive: TComboBox
    Left = 364
    Top = 52
    Width = 53
    Height = 24
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 7
    Items.Strings = (
      'A:'
      'B:'
      'C:'
      'D:'
      'E:'
      'F:'
      'G:'
      'H:'
      'I:'
      'J:'
      'K:'
      'L:'
      'M:'
      'N:'
      'O:'
      'P:'
      'Q:'
      'R:'
      'S:'
      'T:'
      'U:'
      'V:'
      'W:'
      'X:'
      'Y:'
      'Z:')
  end
  object Button1: TButton
    Left = 356
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Consiste'
    TabOrder = 8
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 12
    Top = 228
    Width = 309
    Height = 21
    TabOrder = 9
    Text = 'Edit1'
  end
  object tbl_Protecao: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\protecao.mdb;Pers' +
      'ist Security Info=False'
    CursorType = ctStatic
    TableName = 'Protecao'
    Left = 8
    Top = 4
  end
  object ds_Protecao: TDataSource
    DataSet = tbl_Protecao
    Left = 40
    Top = 4
  end
end
