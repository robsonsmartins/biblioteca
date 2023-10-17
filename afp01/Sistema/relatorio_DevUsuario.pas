{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_DevUsuario.pas

  Contém a listagem de Devoluções por Usuário

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_DevUsuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioDevUsuario = class(TForm)
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
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape3: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRShape4: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_retiradaEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioDevUsuario: Tform_RelatorioDevUsuario;

implementation

uses unit_DatabaseClasses;


{$R *.DFM}


procedure Tform_RelatorioDevUsuario.FormCreate(Sender: TObject);
begin
  retirada_busca.RecordSet := retirada_buscaC.Execute;
  retirada_busca.Active := True;
end;

procedure Tform_RelatorioDevUsuario.FormDestroy(Sender: TObject);
begin
  retirada_busca.Active := False;
end;

procedure Tform_RelatorioDevUsuario.rel_retiradaEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
