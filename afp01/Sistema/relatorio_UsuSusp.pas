{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_UsuSusp.pas

  Contém a listagem de Usuários Suspensos

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_UsuSusp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioUsuSusp = class(TForm)
    rel_retirada: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    retirada_busca: TADODataSet;
    retirada_buscaC: TADOCommand;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_retiradaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioUsuSusp: Tform_RelatorioUsuSusp;

implementation

uses unit_DatabaseClasses;


{$R *.DFM}


procedure Tform_RelatorioUsuSusp.FormCreate(Sender: TObject);
begin
  retirada_busca.RecordSet := retirada_buscaC.Execute;
  retirada_busca.Active := True;
end;

procedure Tform_RelatorioUsuSusp.FormDestroy(Sender: TObject);
begin
  retirada_busca.Active := False;
end;

procedure Tform_RelatorioUsuSusp.rel_retiradaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
