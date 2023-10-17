unit unit_PesquisaDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls;

type
  Tform_PesquisaDialog = class(TForm)
    Panel_Pesquisa: TPanel;
    Label_Pesquisa: TLabel;
    Label_Campo: TLabel;
    ComboBox_Campo: TComboBox;
    Edit_Pesquisa: TEdit;
    BitBtn_Procurar: TBitBtn;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_PesquisaDialog: Tform_PesquisaDialog;

implementation

{$R *.DFM}

end.
