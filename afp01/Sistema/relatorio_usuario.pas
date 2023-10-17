{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Relatorio_Usuario.pas

  Contém a listagem de Usuários

  Data última revisão: 12/12/2001

******************************************************************************}

unit relatorio_usuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, ADODB;

type
  Tform_RelatorioUsuario = class(TForm)
    rel_usuario: TQuickRep;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    TitleBand1: TQRBand;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRSysData3: TQRSysData;
    user_buscaC: TADOCommand;
    user_busca: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rel_usuarioEndPage(Sender: TCustomQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_RelatorioUsuario: Tform_RelatorioUsuario;

implementation

uses unit_DatabaseClasses;

{$R *.DFM}

procedure Tform_RelatorioUsuario.FormCreate(Sender: TObject);
begin
  user_busca.RecordSet := user_buscaC.Execute;
  user_busca.Active := True;
end;

procedure Tform_RelatorioUsuario.FormDestroy(Sender: TObject);
begin
  user_busca.Active := False;
end;

procedure Tform_RelatorioUsuario.rel_usuarioEndPage(
  Sender: TCustomQuickRep);
begin
  Screen.Cursor := crDefault;
end;

end.
