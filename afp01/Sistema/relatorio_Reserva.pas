{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_Reserva.pas

  Contém a listagem de Reservas

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_reserva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioReserva = class(TForm)
    rel_reserva: TQuickRep;
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
    reserva_busca: TADODataSet;
    reserva_buscaC: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_reservaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioReserva: Tform_RelatorioReserva;

implementation

uses unit_DatabaseClasses;

{$R *.DFM}

procedure Tform_RelatorioReserva.FormCreate(Sender: TObject);
begin
  reserva_busca.RecordSet := reserva_buscaC.Execute;
  reserva_busca.Active := True;
end;

procedure Tform_RelatorioReserva.FormDestroy(Sender: TObject);
begin
  reserva_busca.Active := False;
end;

procedure Tform_RelatorioReserva.rel_reservaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
