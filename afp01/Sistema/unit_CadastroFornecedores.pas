unit unit_CadastroFornecedores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables;

type
  Tform_CadastroFornecedores = class(TForm)
    ScrollBox_Formulario: TScrollBox;
    Label_TipoUsuario: TLabel;
    Label_Nome: TLabel;
    Label_Endereco: TLabel;
    Label_Bairro: TLabel;
    Label_Cidade: TLabel;
    Label_Estado: TLabel;
    Label_CEP: TLabel;
    Label_Telefone: TLabel;
    Label_DataCadastro: TLabel;
    ToolBar_Principal: TToolBar;
    ToolButton_Primeiro: TToolButton;
    ToolButton_Anterior: TToolButton;
    ToolButton_Proximo: TToolButton;
    ToolButton_Ultimo: TToolButton;
    ToolButton_Separator1: TToolButton;
    ToolButton_Pesquisar: TToolButton;
    ToolButton_Separator2: TToolButton;
    ToolButton_Novo: TToolButton;
    ToolButton_Editar: TToolButton;
    ToolButton_Excluir: TToolButton;
    ToolButton_Separator3: TToolButton;
    ToolButton_Gravar: TToolButton;
    ToolButton_Cancelar: TToolButton;
    ToolButton_Separator4: TToolButton;
    ToolButton_Fechar: TToolButton;
    ImageList_ToolBarIcons: TImageList;
    Memo_Telefone: TMemo;
    Edit_Nome: TEdit;
    Edit_Endereco: TEdit;
    Edit_Bairro: TEdit;
    Edit_Cidade: TEdit;
    ComboBox_Estado: TComboBox;
    Edit_CEP: TEdit;
    Edit_DataCadastro: TEdit;
    ComboBox_TipoUsuario: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_CadastroFornecedores: Tform_CadastroFornecedores;

implementation

{$R *.DFM}

end.
