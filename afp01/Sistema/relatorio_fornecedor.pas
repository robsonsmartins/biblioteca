{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_Fornecedor.pas

  Contém a listagem de Fornecedores

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_fornecedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioFornecedor = class(TForm)
    rel_fornecedor: TQuickRep;
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
    fornecedores_busca: TADODataSet;
    fornecedores_buscaC: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_fornecedorEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioFornecedor: Tform_RelatorioFornecedor;

implementation

uses unit_DatabaseClasses;

{$R *.DFM}


procedure Tform_RelatorioFornecedor.FormCreate(Sender: TObject);
begin
  fornecedores_busca.RecordSet := fornecedores_buscaC.Execute;
  fornecedores_busca.Active := True;
end;

procedure Tform_RelatorioFornecedor.FormDestroy(Sender: TObject);
begin
  fornecedores_busca.Active := False;
end;

procedure Tform_RelatorioFornecedor.rel_fornecedorEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
