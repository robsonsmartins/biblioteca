{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_Acervo.pas

  Contém a listagem de Acervo

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_acervo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioAcervo = class(TForm)
    rel_acervo: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRSysData3: TQRSysData;
    acervo_busca: TADODataSet;
    acervo_buscaC: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_acervoEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioAcervo: Tform_RelatorioAcervo;

implementation

uses unit_DatabaseClasses;

{$R *.DFM}

procedure Tform_RelatorioAcervo.FormCreate(Sender: TObject);
begin
  acervo_busca.RecordSet := acervo_buscaC.Execute;
  acervo_busca.Active := True;
end;

procedure Tform_RelatorioAcervo.FormDestroy(Sender: TObject);
begin
  acervo_busca.Active := False;
end;

procedure Tform_RelatorioAcervo.rel_acervoEndPage(Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
