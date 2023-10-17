object Form_About: TForm_About
  Left = 192
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Sobre o RevDoc'
  ClientHeight = 240
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 361
    Height = 193
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 216
      Top = 16
      Width = 74
      Height = 24
      Caption = 'RevDoc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 216
      Top = 48
      Width = 88
      Height = 20
      Caption = 'Versão 1.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 216
      Top = 96
      Width = 86
      Height = 13
      Caption = 'Desenvolvido por:'
    end
    object Label4: TLabel
      Left = 216
      Top = 128
      Width = 127
      Height = 16
      Caption = 'Robson S. Martins'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 160
      Width = 199
      Height = 20
      Caption = 'FBAI - Projeto Biblioteca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Animate: TAnimate
      Left = 16
      Top = 10
      Width = 180
      Height = 135
      Active = False
      FileName = 'C:\Meus documentos\REVDOC\about.avi'
      StopFrame = 329
    end
  end
  object BitBtn1: TBitBtn
    Left = 136
    Top = 208
    Width = 105
    Height = 25
    Cursor = crHandPoint
    Caption = '&Fechar'
    TabOrder = 1
    Kind = bkOK
  end
end
