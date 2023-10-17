object Form_Alteracoes: TForm_Alteracoes
  Left = 204
  Top = 133
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Alterações'
  ClientHeight = 271
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 2
    Top = 232
    Width = 351
    Height = 39
  end
  object Memo: TMemo
    Left = 4
    Top = 4
    Width = 349
    Height = 225
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button_Fechar: TBitBtn
    Left = 128
    Top = 238
    Width = 98
    Height = 25
    Cursor = crHandPoint
    Caption = '&Fechar'
    TabOrder = 1
    Kind = bkOK
  end
end
