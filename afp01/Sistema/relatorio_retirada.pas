{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_Retirada.pas

  Contém a listagem de Retiradas

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_retirada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioRetirada = class(TForm)
    rel_retirada: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    retirada_busca: TADODataSet;
    retirada_buscaC: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_retiradaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioRetirada: Tform_RelatorioRetirada;

implementation

uses unit_DatabaseClasses;


{$R *.DFM}


procedure Tform_RelatorioRetirada.FormCreate(Sender: TObject);
begin
  retirada_busca.RecordSet := retirada_buscaC.Execute;
  retirada_busca.Active := True;
end;

procedure Tform_RelatorioRetirada.FormDestroy(Sender: TObject);
begin
  retirada_busca.Active := False;
end;

procedure Tform_RelatorioRetirada.rel_retiradaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
