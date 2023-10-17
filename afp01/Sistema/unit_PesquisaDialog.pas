{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_PesquisaDialog.pas

  Diálogo de Pesquisa.

  Data última revisão: 06/11/2001

******************************************************************************}

unit unit_PesquisaDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, Db, DBGrids, ADODB;

type
  Tform_PesquisaDialog = class(TForm)
    Panel_Pesquisa: TPanel;
    Label_Pesquisa: TLabel;
    Label_Campo: TLabel;
    ComboBox_Campo: TComboBox;
    Edit_Pesquisa: TEdit;
    btn_Procurar: TBitBtn;
    Panel_Botoes: TPanel;
    btn_Fechar: TBitBtn;
    StringGrid_Resultado: TDBGrid;
    DataSource_Resultado: TDataSource;
    ADODataSet_Resultado: TADODataSet;
    procedure StringGrid_ResultadoDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Search: Integer;
  end;

var
  form_PesquisaDialog: Tform_PesquisaDialog;

implementation

{$R *.DFM}

procedure Tform_PesquisaDialog.StringGrid_ResultadoDblClick(
  Sender: TObject);
begin
  {duplo click no grid}
  ModalResult := mrOK;
end;

function Tform_PesquisaDialog.Search: Integer;
begin
  {exibe o form e retorna o valor do último campo do registro clicado}
  Result := -1;
  with StringGrid_Resultado do
  begin
    if ShowModal = mrOK then
      Result := Fields[FieldCount - 1].AsInteger;
  end;
  ADODataSet_Resultado.Close;
end;

end.
