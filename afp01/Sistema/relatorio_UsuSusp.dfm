�
 TFORM_RELATORIOUSUSUSP 0l  TPF0Tform_RelatorioUsuSuspform_RelatorioUsuSuspLeft�Top� WidthHeightCaption+Rel�torios - Listagem de Usu�rios SuspensosColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderScaledOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight 	TQuickReprel_retiradaLeft Top WidthHeightcFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightDataSetretirada_buscaFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style Functions.Strings
PAGENUMBERCOLUMNNUMBERREPORTTITLE Functions.DATA00'' 	OnEndPagerel_retiradaEndPageOptionsFirstPageHeaderLastPageFooter Page.ColumnsPage.Orientation
poPortraitPage.PaperSizeA4Page.Values       �@      ��
@       �@      @�
@       �@       �@           PrinterSettings.CopiesPrinterSettings.DuplexPrinterSettings.FirstPage PrinterSettings.LastPage PrinterSettings.OutputBinFirstPrintIfEmpty	ReportTitleRelat�rio de Usu�rios Suspensos
SnapToGrid	UnitsNativeZoomd TQRBandDetailBand1Left0TopyWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values       �@ XUUUU��	@ BandTyperbDetail 	TQRDBText	QRDBText1LeftTopWidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@       �@ XUUUUU�@UUUUUU��@ 	AlignmenttaCenterAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFieldRGAFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText4LeftDTopWidth"HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@ XUUUUU�@�������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFieldNomeFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.Style 
ParentFontTransparentWordWrap	FontSize  	TQRDBText	QRDBText2Left TopWidthXHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@ ������	@ XUUUUU�@ `UUUU��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchColorclWhiteDataSetretirada_busca	DataFielddataexpirasuspFont.CharsetANSI_CHARSET
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
ParentFontTransparentFontSize   TQRBandColumnHeaderBand1Left0TopXWidth�Height!Frame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightAlignToBottomColorclWhiteForceNewColumnForceNewPageSize.Values      ��@ XUUUU��	@ BandTyperbColumnHeader TQRLabelQRLabel1LeftTopWidthHeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@       �@ XUUUUU�@      ��@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionRGAColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize  TQRLabelQRLabel3LeftDTopWidth&HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������@ XUUUUU�@UUUUUU�@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionNomeColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize  TQRShapeQRShape1Left TopWidth�HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.ValuesUUUUUU��@          ��������@UUUUUU��	@ Shape
qrsHorLine  TQRLabelQRLabel2Left TopWidth� HeightFrame.ColorclBlackFrame.DrawTopFrame.DrawBottomFrame.DrawLeftFrame.DrawRightSize.Values�������@�������	@ XUUUUU�@��������@ 	AlignmenttaLeftJustifyAlignToBandAutoSize	AutoStretchCaptionData Expira Suspens�oColorclWhiteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFontTransparentWordWrap	FontSize    TADODataSetretirada_busca
Connection&DataModule_Biblio.ADOConnection_Biblio
Parameters LeftXTop  TADOCommandretirada_buscaCCommandTextVselect RGA, Nome, DATAEXPIRASUSP from USUARIO where SITUACAO = 'S'  ORDER BY RGA, NOME
Connection&DataModule_Biblio.ADOConnection_Biblio
Parameters Left8Top   