object Form_GerarWiz0: TForm_GerarWiz0
  Left = 192
  Top = 133
  BorderStyle = bsDialog
  Caption = 'Gerar Estrutura de Diretórios do RevDoc'
  ClientHeight = 138
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 405
    Height = 121
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 20
      Width = 347
      Height = 26
      Caption = 
        'Aguarde enquanto o Assistente de Geração da Estrutura de Diretór' +
        'ios do '#13#10'RevDoc é carregado...'
    end
    object ProgressBar: TProgressBar
      Left = 14
      Top = 60
      Width = 371
      Height = 19
      Min = 0
      Max = 7
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 66
  end
end
