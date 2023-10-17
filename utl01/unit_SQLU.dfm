object form_Principal: Tform_Principal
  Left = 192
  Top = 133
  Width = 343
  Height = 397
  Caption = 'SQLU - SQL Utility'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 212
    Width = 335
    Height = 120
    Align = alBottom
    DataSource = dtsrc
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 335
    Height = 139
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object sb: TStatusBar
    Left = 0
    Top = 332
    Width = 335
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 180
    Width = 335
    Height = 32
    Align = alBottom
    TabOrder = 3
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 310
      Height = 30
      Cursor = crHandPoint
      DataSource = dtsrc
      Align = alLeft
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 139
    Width = 335
    Height = 41
    Align = alBottom
    TabOrder = 4
    object btn_Abrir: TBitBtn
      Left = 12
      Top = 8
      Width = 121
      Height = 25
      Cursor = crHandPoint
      Caption = '&Abrir Consulta'
      Default = True
      TabOrder = 0
      OnClick = btn_AbrirClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object btn_Exec: TBitBtn
      Left = 172
      Top = 8
      Width = 121
      Height = 25
      Cursor = crHandPoint
      Caption = '&Executar Consulta'
      TabOrder = 1
      OnClick = btn_ExecClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object qry: TADOQuery
    ConnectionString = 
      'FILE NAME=C:\Arquivos de programas\Arquivos comuns\System\Ole DB' +
      '\Data Links\DBDEMOS.udl'
    Parameters = <>
    Left = 8
  end
  object dtsrc: TDataSource
    DataSet = qry
    Left = 40
  end
  object MainMenu1: TMainMenu
    Left = 136
    object Arquivo1: TMenuItem
      Caption = 'Arquivo'
      object Conectar1: TMenuItem
        Caption = 'Conectar'
        OnClick = Conectar1Click
      end
      object Abrir1: TMenuItem
        Caption = 'Abrir'
        OnClick = Abrir1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object od: TOpenDialog
    Filter = 'Arquivos de Consulta (*.sql)|*.sql|Todos os arquivos (*.*)|*.*'
    FilterIndex = 0
    Title = 'Abrir arquivo SQL'
    Left = 72
  end
  object odudl: TOpenDialog
    Filter = 'Arquivos de Data Link (*.udl)|*.udl|Todos os arquivos (*.*)|*.*'
    FilterIndex = 0
    Title = 'Abrir arquivo UDL'
    Left = 104
  end
end
