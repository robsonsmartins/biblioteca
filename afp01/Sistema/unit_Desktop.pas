{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_Desktop.pas

  Tela Principal do Sistema Biblioteca - Desktop.

  Data última revisão: 12/12/2001

*****************************************************************************}

unit unit_Desktop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ExtCtrls, Menus, ComCtrls, StdCtrls, AppEvnts,
  InterfaceComponentes, unit_DatabaseClasses, unit_Comum;

type
  Tform_Desktop = class(TForm)
    TaskBar_Desktop: TTaskBar;
    Desktop_Desktop: TDesktop;
    BBStatusBar_Status: TBBStatusBar;
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
    Timer_Login: TTimer;
    TreeList: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure DesktopLaunch_DesktopCommand(Command: String;
      Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer_LoginTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BBStatusBar_StatusTimeOut;
  private
    { Private declarations }
    FAutoLogoff: Boolean;
    procedure Inicializar;
    procedure ExecutaComando(Command: String);
    procedure EfetuaLogin(Auto: Boolean = False);
  public
    { Public declarations }
    Direitos: TDireitos;
    Conta: TContaLogin;
    AcervoArray: Array of TAcervoArray;
  end;

var
  form_Desktop: Tform_Desktop;

implementation

uses unit_AparenciaDialog, unit_BibliotecaExplorer, unit_CadastroAcervo,
  unit_CadastroFornecedores, unit_CadastroOpcoesDialog,
  unit_CadastroUsuarios, unit_ContasDialog, unit_EscolhaRelatorios,
  unit_LoginDialog, unit_PainelDeControle, unit_BackupDialog,
  unit_RestoreDialog;

{$R *.DFM}

procedure Tform_Desktop.Inicializar;
begin
  {inicialização do sistema}
  Desktop_Desktop.Visible := False;
  with DesktopLaunch_Desktop.FormsList do
  begin
    Clear;
    {entradas dos ícones / menu}
    Add('Explorar Biblioteca',form_BibliotecaExplorer,Tform_BibliotecaExplorer);
    Add('Cadastro de Acervo',form_CadastroAcervo,Tform_CadastroAcervo);
    Add('Cadastro de Usuários',form_CadastroUsuarios,Tform_CadastroUsuarios);
    Add('Cadastro de Fornecedores',form_CadastroFornecedores,
        Tform_CadastroFornecedores);
    Add('Painel de Controle',form_PainelDeControle,Tform_PainelDeControle);
  end;
  {aplica configs}
  form_AparenciaDialog := Tform_AparenciaDialog.Create(Self);
  form_AparenciaDialog.Aplicar(Desktop_Desktop);
  FreeAndNil(form_AparenciaDialog);
  {carrega configs do Explorer}
  SetLength(AcervoArray,0);
  form_BibliotecaExplorer := Tform_BibliotecaExplorer.Create(Self);
  form_BibliotecaExplorer.DataInterface.Read(form_BibliotecaExplorer);
  TreeList.Items.Assign(form_BibliotecaExplorer.TreeView_Classes.Items);
  FreeAndNil(form_BibliotecaExplorer);
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
  else if Trim(UpCommand) = 'EFETUAR LOGOFF' then
  {fazer Logoff}
  begin
    FAutoLogoff := False;
    Timer_Login.Enabled := True;
  end
  else if UpCommand = 'APARêNCIA' then
  {Mostrar diálogo de config. Aparência}
  begin
    form_AparenciaDialog := Tform_AparenciaDialog.Create(Self);
    form_AparenciaDialog.Configura(Desktop_Desktop);
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
  end
  else if UpCommand = 'CRIAR CóPIA DE SEGURANçA' then
  {Mostrar diálogo de Backup}
  begin
    {checar se não há nada aberto...}
    if DesktopLaunch_Desktop.HasFormOpen then
    begin
      with Application do
        MessageBox(MSG_NOBAK, CAP_NOBAK, MB_OKWARNING);
    end
    else
    begin
      DataModule_Biblio.ADOConnection_Biblio.Close;
      form_BackupBDDialog := Tform_BackupBDDialog.Create(Self);
      form_BackupBDDialog.ShowModal;
      FreeAndNil(form_BackupBDDialog);
      DataModule_Biblio.ADOConnection_Biblio.Open;
    end;
  end
  else if UpCommand = 'RESTAURAR CóPIA DE SEGURANçA' then
  {Mostrar diálogo de Restore}
  begin
    {checar se não há nada aberto...}
    if DesktopLaunch_Desktop.HasFormOpen then
    begin
      with Application do
        MessageBox(MSG_NOREST, CAP_NOREST, MB_OKWARNING);
    end
    else
    begin
      DataModule_Biblio.ADOConnection_Biblio.Close;
      form_RestoreBDDialog := Tform_RestoreBDDialog.Create(Self);
      form_RestoreBDDialog.ShowModal;
      FreeAndNil(form_RestoreBDDialog);
      DataModule_Biblio.ADOConnection_Biblio.Open;
    end;
  end
  else if Trim(UpCommand) = 'RELATóRIOS DA BIBLIOTECA' then
  begin
    form_EscolhaRelatorios := Tform_EscolhaRelatorios.Create(Self);
    form_EscolhaRelatorios.FormStyle := fsNormal;
    form_EscolhaRelatorios.ShowModal;
    FreeAndNil(form_EscolhaRelatorios);
  end;
end;

procedure Tform_Desktop.EfetuaLogin(Auto: Boolean = False);
var Configuracao: TConfiguracao;
    TmpStr: String;
begin
  {faz o login}
  if not Auto then
  begin
    if DesktopLaunch_Desktop.HasFormOpen then
    begin
      with Application do
        MessageBox(MSG_LOGOFF, CAP_LOGOFF, MB_OKWARNING);
      exit;
    end;
  end;
  BBStatusBar_Status.Active := False;
  with Desktop_Desktop do
  begin
    Visible := False;
    ClearIcones;
  end;
  form_LoginDialog := Tform_LoginDialog.Create(Self);
  form_LoginDialog.Btn_Cancelar.Enabled := not Auto;
  repeat
    if Auto then
    begin
      TmpStr := MSG_AUTOLOGOFF + Conta.UserName;
      Application.MessageBox(PChar(TmpStr),CAP_AUTOLOGOFF,MB_OKWARNING);
    end;
    with form_LoginDialog do
    begin
      if not Login then
      begin
        FreeAndNil(form_LoginDialog);
        Halt(1);
      end;
    end;
  until (not Auto) or (Conta.UserName = form_LoginDialog.ContaLogin.UserName) or
                      (form_LoginDialog.ContaLogin.UserName = 'ADMIN');
  Conta.Assign(form_LoginDialog.ContaLogin);
  FreeAndNil(form_LoginDialog);
  {configura o AutoLogoff}
  Configuracao := TConfiguracao.Create;
  with Configuracao do
  begin
    Read(True);
    if AutoLogoff = 0 then
      BBStatusBar_Status.IdleTimer := False
    else
    begin
      BBStatusBar_Status.IdleInterval := EncodeTime(0,AutoLogoff,0,0);
      BBStatusBar_Status.IdleTimer := True;
    end;
    Free;
  end;
  {para criar os ícones e menus}
  with Desktop_Desktop do
  begin
    Conta.GrupoLogin.GetPermissoes(Direitos);
    with IconeList, Direitos, TaskBar_Desktop do
    begin
      Items[0].Visible := VerExplorer;
      Items[1].Visible := VerCadAcervo;
      Items[2].Visible := VerCadUsuarios;
      Items[3].Visible := VerCadFornecedores;
      Items[4].Visible := VerRelatorios;
      Items[5].Visible := VerPainelControle;
      VisibleMenu('Explorar Biblioteca',VerExplorer);
      VisibleMenu('Relatórios da Biblioteca',VerRelatorios);
      VisibleMenu('Painel de Controle',VerPainelControle);
      VisibleMenu('Banco de Dados',VerPainelControle);
      VisibleMenu('Cadastro de Acervo',VerCadAcervo);
      VisibleMenu('Cadastro de Usuários',VerCadUsuarios);
      VisibleMenu('Cadastro de Fornecedores',VerCadFornecedores);
      VisibleMenu('Cadastros',VerCadAcervo or VerCadFornecedores or
                  VerCadUsuarios );
    end;
    CreateIcones;
    Visible := True;
  end;
  BBStatusBar_Status.Usuario := Conta.UserName;
  BBStatusBar_Status.Active := True;
end;

procedure Tform_Desktop.FormCreate(Sender: TObject);
begin
  Direitos := TDireitos.Create;
  Conta := TContaLogin.Create;
  Inicializar;
  BBStatusBar_Status.Active := False;
  FAutoLogoff := False;
  {faz o login}
  Timer_Login.Enabled := True;
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
  {evento OnClose do Form}
  if DesktopLaunch_Desktop.HasFormOpen then
  begin
    with Application do
      MessageBox(MSG_SAIR, CAP_SAIR, MB_OKWARNING);
    Action := caNone;
  end;
end;

procedure Tform_Desktop.Timer_LoginTimer(Sender: TObject);
begin
  Timer_Login.Enabled := False;
  EfetuaLogin(FAutoLogoff);
end;

procedure Tform_Desktop.FormDestroy(Sender: TObject);
var i,j: Integer;
begin
  Direitos.Free;
  Conta.Free;
  for i := 0 to Length(AcervoArray) - 1 do
  begin
    for j := 0 to Length(AcervoArray[i]) - 1 do
    begin
      AcervoArray[i][j].Free;
    end;
    SetLength(AcervoArray[i],0);
  end;
  SetLength(AcervoArray,0);
end;

procedure Tform_Desktop.BBStatusBar_StatusTimeOut;
begin
  {faz o login}
  FAutoLogoff := True;
  Timer_Login.Enabled := True;
end;

end.
