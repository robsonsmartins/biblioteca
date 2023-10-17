{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_AcervoRet.pas

  Contém o relatório de Acervo mais retirado

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_AcervoRet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioAcervoRet = class(TForm)
    rel_retirada: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    retirada_busca: TADODataSet;
    retirada_buscaC: TADOCommand;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText1: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_retiradaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioAcervoRet: Tform_RelatorioAcervoRet;

implementation

uses unit_DatabaseClasses;


{$R *.DFM}


procedure Tform_RelatorioAcervoRet.FormCreate(Sender: TObject);
begin
  retirada_busca.RecordSet := retirada_buscaC.Execute;
  retirada_busca.Active := True;
end;

procedure Tform_RelatorioAcervoRet.FormDestroy(Sender: TObject);
begin
  retirada_busca.Active := False;
end;

procedure Tform_RelatorioAcervoRet.rel_retiradaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
