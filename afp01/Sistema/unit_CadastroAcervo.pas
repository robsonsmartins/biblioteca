unit unit_CadastroAcervo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables;

type
  Tform_CadastroAcervo = class(TForm)
    ScrollBox_Formulario: TScrollBox;
    Label_TipoUsuario: TLabel;
    Label_Nome: TLabel;
    DBEdit_Nome: TDBEdit;
    Label_CPF: TLabel;
    DBEdit_CPF: TDBEdit;
    Label_RG: TLabel;
    DBEdit_RG: TDBEdit;
    Label_Endereco: TLabel;
    DBEdit_Endereco: TDBEdit;
    Label_Bairro: TLabel;
    DBEdit_Bairro: TDBEdit;
    Label_Cidade: TLabel;
    DBEdit_Cidade: TDBEdit;
    Label_CEP: TLabel;
    DBEdit_CEP: TDBEdit;
    DBComboBox_TipoUsuario: TDBComboBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit5: TDBEdit;
    Label11: TLabel;
    DBComboBox3: TDBComboBox;
    ListView1: TListView;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
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
    Edit1: TEdit;
    Label13: TLabel;
    Panel: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_CadastroAcervo: Tform_CadastroAcervo;

implementation

{$R *.DFM}

end.
