unit unit_Desktop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ExtCtrls, InterfaceComponentes, Menus, ComCtrls, StdCtrls,
  AppEvnts;

type
  Tform_Desktop = class(TForm)
    TaskBar_Desktop: TTaskBar;
    Desktop_Desktop: TDesktop;
    BBStatusBar1: TBBStatusBar;
    ImageList_TaskBar: TImageList;
    ImageList_Desktop: TImageList;
    DesktopLaunch_Desktop: TDesktopLaunch;
    PopupMenu_MenuTaskBar: TPopupMenu;
    mi_Explorar: TMenuItem;
    mi_Cadastros: TMenuItem;
    mi_CadastrosAcervo: TMenuItem;
    mi_CadastrosUsuarios: TMenuItem;
    mi_CadastrosFornecedores: TMenuItem;
    mi_Relatorios: TMenuItem;
    mi_PainelControle: TMenuItem;
    mi_PainelControleAparencia: TMenuItem;
    mi_PainelControleCadastros: TMenuItem;
    mi_PainelControleGrupos: TMenuItem;
    mi_Separator1: TMenuItem;
    mi_BancoDados: TMenuItem;
    mi_Logoff: TMenuItem;
    mi_Sair: TMenuItem;
    mi_BancoDadosBackup: TMenuItem;
    mi_BancoDadosRestore: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure DesktopLaunch_DesktopCommand(Command: String;
      Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure Inicializar;
    procedure ExecutaComando(Command: String);
  public
    { Public declarations }
  end;

var
  form_Desktop: Tform_Desktop;

implementation

uses unit_AparenciaDialog, unit_BibliotecaExplorer, unit_CadastroAcervo,
  unit_CadastroFornecedores, unit_CadastroOpcoesDialog,
  unit_CadastroUsuarios, unit_ContasDialog, unit_EscolhaRelatorios,
  unit_LoginDialog, unit_PainelDeControle, unit_Comum;

{$R *.DFM}

procedure Tform_Desktop.Inicializar;
begin
  {inicialização do sistema}
  with DesktopLaunch_Desktop.FormsList do
  begin
    Clear;
    {entradas dos ícones / menu}
    Add('Explorar Biblioteca',form_BibliotecaExplorer,Tform_BibliotecaExplorer);
    Add('Cadastro de Acervo',form_CadastroAcervo,Tform_CadastroAcervo);
    Add('Cadastro de Usuários',form_CadastroUsuarios,Tform_CadastroUsuarios);
    Add('Cadastro de Fornecedores',form_CadastroFornecedores,
        Tform_CadastroFornecedores);
    Add('Relatórios da Biblioteca',form_EscolhaRelatorios,Tform_EscolhaRelatorios);
    Add('Painel de Controle',form_PainelDeControle,Tform_PainelDeControle);
  end;
end;

procedure Tform_Desktop.ExecutaComando(Command: String);
var UpCommand: String;
begin
  {entradas de menu e ícones que executam funções}
  UpCommand := UpperCase(Command);
  while Pos('.',UpCommand) <> 0 do
    Delete(UpCommand,Pos('.',UpCommand),1);
  if UpCommand = 'SAIR' then
  {Sair da Aplicação}
  begin
    Close;
  end
  else if UpCommand = 'APARêNCIA' then
  {Mostrar diálogo de config. Aparência}
  begin
    form_AparenciaDialog := Tform_AparenciaDialog.Create(Self);
    form_AparenciaDialog.ShowModal;
    FreeAndNil(form_AparenciaDialog);
  end
  else if UpCommand = 'CONFIGURAçãO DOS CADASTROS' then
  {Mostrar diálogo de config. dos Cadastros}
  begin
    form_CadastroOpcoesDialog := Tform_CadastroOpcoesDialog.Create(Self);
    form_CadastroOpcoesDialog.ShowModal;
    FreeAndNil(form_CadastroOpcoesDialog);
  end
  else if UpCommand = 'GRUPOS E CONTAS DE LOGIN' then
  {Mostrar diálogo de config. Grupos/Contas de Login}
  begin
    form_ContasDialog := Tform_ContasDialog.Create(Self);
    form_ContasDialog.ShowModal;
    FreeAndNil(form_ContasDialog);
  end;
end;

procedure Tform_Desktop.FormCreate(Sender: TObject);
begin
  Inicializar;
  {para criar os ícones - deve ser após o login}
  with Desktop_Desktop do
  begin
    ClearIcones;
    CreateIcones;
  end;
//  TaskBar_Desktop.VisibleMenu('Banco de Dados',False);
end;

procedure Tform_Desktop.DesktopLaunch_DesktopCommand(Command: String;
  Sender: TObject);
begin
  {evento OnCommand do DesktopLaunch}
  ExecutaComando(Command);
end;

procedure Tform_Desktop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DesktopLaunch_Desktop.HasFormOpen then
  begin
    with Application do
      MessageBox(MSG_SAIR, CAP_SAIR, MB_OKWARNING);
    Action := caNone;
  end;
end;

end.
