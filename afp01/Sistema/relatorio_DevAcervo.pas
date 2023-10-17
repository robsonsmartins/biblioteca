{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_DevAcervo.pas

  Contém a listagem de Devoluções por Acervo

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_DevAcervo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioDevAcervo = class(TForm)
    rel_retirada: TQuickRep;
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
    QRBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape4: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRShape3: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_retiradaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioDevAcervo: Tform_RelatorioDevAcervo;

implementation

uses unit_DatabaseClasses;


{$R *.DFM}


procedure Tform_RelatorioDevAcervo.FormCreate(Sender: TObject);
begin
  retirada_busca.RecordSet := retirada_buscaC.Execute;
  retirada_busca.Active := True;
end;

procedure Tform_RelatorioDevAcervo.FormDestroy(Sender: TObject);
begin
  retirada_busca.Active := False;
end;

procedure Tform_RelatorioDevAcervo.rel_retiradaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
