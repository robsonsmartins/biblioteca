�
 TFORM_RELATORIOACERVORET 0�  TPF0Tform_RelatorioAcervoRetform_RelatorioAcervoRetLeft� Top� WidthHeight}Caption!Relat�rio de Acervo mais retiradoColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderScaledOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight 	TQuickReprel_retiradaLeft Top WidthHeightcFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightDataSetretirada_buscaFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style Functions.Strings
PAGENUMBERCOLUMNNUMBERREPORTTITLE Functions.DATA00'' 	OnEndPagerel_retiradaEndPageOptionsFirstPageHeaderLastPageFooter Page.ColumnsPage.Orientation
poPortraitPage.PaperSizeA4Page.Values       �@      ��
@       �@      @�
@       �@       �@           PrinterSettings.CopiesPrinterSettings.DuplexPrinterSettings.FirstPage PrinterSettings.LastPage PrinterSettings.OutputBinFirstPrintIfEmpty	ReportTitle0Relat�rio de Exemplares de Acervo mais Retirados
SnapToGrid	UnitsNativeZoomd TQRBandDetailBand1Left0TopyWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@ XUUUU��	@ BandTyperbDetail 	TQRDBText	QRDBText2Left
TopWidth(HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@��������@ XUUUUU�@��������@ 	AlignmenttaCenterAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFieldTomboFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText3LeftDTopWidth HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@ XUUUUU�@ XUUUUU�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFieldTituloFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText1Left�Top WidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@TUUUUU��	@          UUUUUU��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFieldQTDFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTransparentWordWrap	FontSize   TQRBandPageFooterBand1Left0Top� Width�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@ XUUUU��	@ BandTyperbPageFooter 
TQRSysData
QRSysData2LeftTopWidthPHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@       �@ XUUUUU�@��������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	ColorclWhiteDataqrsPageNumberFont.CharsetANSI_CHARSET
Font.ColorclRedFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTextPage TransparentFontSize   TQRBand
TitleBand1Left0Top0Width�Height(Frame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values��������@ XUUUU��	@ BandTyperbTitle 
TQRSysData
QRSysData1LeftTopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values������*�@      ��@ XUUUUU�@��������@ 	AlignmenttaCenterAlignToBand	AutoSize	ColorclWhiteDataqrsReportTitleFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentFontSize   TQRBandColumnHeaderBand1Left0TopXWidth�Height!Frame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values      ��@ XUUUU��	@ BandTyperbColumnHeader TQRShapeQRShape1Left TopWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.ValuesUUUUUU��@          ��������@UUUUUU��	@ Shape
qrsHorLine  TQRLabelQRLabel4LeftTopWidth-HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@ XUUUUU�@ XUUUUU�@�������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionTomboColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize  TQRLabelQRLabel5LeftDTopWidth&HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@ XUUUUU�@UUUUUU�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionT�tuloColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize  TQRLabelQRLabel1LefttTopWidth?HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@��������	@UUUUUUU�@      ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaption	RetiradasColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize    TADODataSetretirada_busca
Connection&DataModule_Biblio.ADOConnection_Biblio
Parameters LeftXTop  TADOCommandretirada_buscaCCommandText�select A.Titulo, D.Tombo, COUNT(D.TOMBO) AS QTD from ACERVO A, DEVOLUCAO D where D.Tombo = A.Tombo  GROUP BY A.TITULO, D.TOMBO ORDER BY COUNT(D.TOMBO), D.TOMBO
Connection&DataModule_Biblio.ADOConnection_Biblio
Parameters Left8Top   