{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_AcervoPerdido.pas

  Contém a listagem de Acervo Perdido

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_acervoperdido;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioAcervoPerdido = class(TForm)
    rel_acervoperdido: TQuickRep;
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
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    acervoperdido_busca: TADODataSet;
    acervoperdido_buscaC: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_acervoperdidoEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioAcervoPerdido: Tform_RelatorioAcervoPerdido;

implementation

uses unit_DatabaseClasses;

{$R *.DFM}

procedure Tform_RelatorioAcervoPerdido.FormCreate(Sender: TObject);
begin
  acervoperdido_busca.RecordSet := acervoperdido_buscaC.Execute;
  acervoperdido_busca.Active := True;
end;

procedure Tform_RelatorioAcervoPerdido.FormDestroy(Sender: TObject);
begin
  acervoperdido_busca.Active := False;
end;

procedure Tform_RelatorioAcervoPerdido.rel_acervoperdidoEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
