unit unit_CadastroAcervo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables;

type
  Tform_CadastroAcervo = class(TForm)
    MainMenu_MenuPrincipal: TMainMenu;
    MenuItem_Cadastro: TMenuItem;
    MenuItem_Fechar: TMenuItem;
    MenuItem_Acervo: TMenuItem;
    MenuItem_Novo: TMenuItem;
    MenuItem_Excluir: TMenuItem;
    MenuItem_Gravar: TMenuItem;
    MenuItem_Cancelar: TMenuItem;
    ToolBar_Principal: TToolBar;
    ToolButton_Primeiro: TToolButton;
    ImageList_ToolBarIcons: TImageList;
    ToolButton_Anterior: TToolButton;
    ToolButton_Proximo: TToolButton;
    ToolButton_Ultimo: TToolButton;
    ToolButton_Separator1: TToolButton;
    ToolButton_Novo: TToolButton;
    ToolButton_Excluir: TToolButton;
    ToolButton_Gravar: TToolButton;
    ToolButton_Cancelar: TToolButton;
    MenuItem_Registro: TMenuItem;
    MenuItem_Primeiro: TMenuItem;
    MenuItem_Anterior: TMenuItem;
    MenuItem_Proximo: TMenuItem;
    MenuItem_Ultimo: TMenuItem;
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
    ToolButton_Separator2: TToolButton;
    ToolButton_Fechar: TToolButton;
    Panel_Pesquisa: TPanel;
    Label_Pesquisa: TLabel;
    ComboBox_Campo: TComboBox;
    Edit_Pesquisa: TEdit;
    Label_Campo: TLabel;
    BitBtn_Procurar: TBitBtn;
    RadioGroup_Pesquisa: TRadioGroup;
    MenuItem_Exibir: TMenuItem;
    MenuItem_ModoFormulario: TMenuItem;
    MenuItem_ModoPlanilha: TMenuItem;
    ScrollBox_Planilha: TScrollBox;
    DBGrid_Planilha: TDBGrid;
    Query_Cadastro: TQuery;
    DataSource_Cadastro: TDataSource;
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
    Exemplar1: TMenuItem;
    Adicionar1: TMenuItem;
    Remover1: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    procedure MenuItem_FecharClick(Sender: TObject);
    procedure MenuItem_ModoFormularioClick(Sender: TObject);
    procedure MenuItem_ModoPlanilhaClick(Sender: TObject);
    procedure MenuItem_PrimeiroClick(Sender: TObject);
    procedure MenuItem_AnteriorClick(Sender: TObject);
    procedure MenuItem_ProximoClick(Sender: TObject);
    procedure MenuItem_UltimoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_CadastroAcervo: Tform_CadastroAcervo;

implementation

{$R *.DFM}

procedure Tform_CadastroAcervo.MenuItem_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_CadastroAcervo.MenuItem_ModoFormularioClick(
  Sender: TObject);
begin
  MenuItem_ModoFormulario.Checked := True;
  ScrollBox_Planilha.Visible := False;
  ScrollBox_Formulario.Visible := True;
end;

procedure Tform_CadastroAcervo.MenuItem_ModoPlanilhaClick(
  Sender: TObject);
begin
  MenuItem_ModoPlanilha.Checked := True;
  ScrollBox_Formulario.Visible := False;
  ScrollBox_Planilha.Visible := True;
end;

procedure Tform_CadastroAcervo.MenuItem_PrimeiroClick(Sender: TObject);
begin
//  Query_Cadastro.First;
  MenuItem_Primeiro.Enabled := False;
  MenuItem_Anterior.Enabled := False;
  MenuItem_Proximo.Enabled := True;
  MenuItem_Ultimo.Enabled := True;

  ToolButton_Primeiro.Enabled := False;
  ToolButton_Anterior.Enabled := False;
  ToolButton_Proximo.Enabled := True;
  ToolButton_Ultimo.Enabled := True;
end;

procedure Tform_CadastroAcervo.MenuItem_AnteriorClick(Sender: TObject);
begin
//  Query_Cadastro.Prior;
  MenuItem_Proximo.Enabled := True;
  MenuItem_Ultimo.Enabled := True;

  ToolButton_Proximo.Enabled := True;
  ToolButton_Ultimo.Enabled := True;
{  if Query_Cadastro.Bof then
  begin
    MenuItem_Primeiro.Enabled := False;
    MenuItem_Anterior.Enabled := False;

    ToolButton_Primeiro.Enabled := False;
    ToolButton_Anterior.Enabled := False;
  end;}
end;

procedure Tform_CadastroAcervo.MenuItem_ProximoClick(Sender: TObject);
begin
//  Query_Cadastro.Next;
  MenuItem_Primeiro.Enabled := True;
  MenuItem_Anterior.Enabled := True;

  ToolButton_Primeiro.Enabled := True;
  ToolButton_Anterior.Enabled := True;
{  if Query_Cadastro.Eof then
  begin
    MenuItem_Proximo.Enabled := False;
    MenuItem_Ultimo.Enabled := False;

    ToolButton_Proximo.Enabled := False;
    ToolButton_Ultimo.Enabled := False;
  end;}
end;

procedure Tform_CadastroAcervo.MenuItem_UltimoClick(Sender: TObject);
begin
//  Query_Cadastro.Last;
  MenuItem_Primeiro.Enabled := True;
  MenuItem_Anterior.Enabled := True;
  MenuItem_Proximo.Enabled := False;
  MenuItem_Ultimo.Enabled := False;

  ToolButton_Primeiro.Enabled := True;
  ToolButton_Anterior.Enabled := True;
  ToolButton_Proximo.Enabled := False;
  ToolButton_Ultimo.Enabled := False;
end;

end.
