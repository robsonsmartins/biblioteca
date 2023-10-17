{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_ContasDialog.pas

  Contém as classes de Interface do Diálogo de Contas/Grupos de Login.

  Data última revisão: 22/11/2001

******************************************************************************}

unit unit_ContasDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, CheckLst, ImgList, ToolWin,
  unit_DatabaseClasses, unit_Comum;

{contém métodos para a Interface com GruposLogin}
type
  TIntGrupoLogins = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FGrupoLogins: TGrupoLogins;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject; UpdateList: Boolean = True);
    {Configura objetos de Interface para modo inserir}
    procedure Insert(Sender: TObject);
    {Configura objetos de Interface para modo leitura / após um Post}
    procedure Post(Sender: TObject);
    {Faz consistência dos dados digitados}
    function ConsisteDados(Sender: TObject): Boolean;
    {Exibe uma mensagem e dá foco ao controle}
    procedure ExibeMensagem(Controle: TWinControl;
                            Mensagem, Caption: String; Flags: Longint);
  end;

{contém métodos para a Interface com ContasLogin}
type
  TIntContaLogins = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FContaLogins: TContaLogins;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject; UpdateList: Boolean = True);
    {Configura objetos de Interface para modo inserir}
    procedure Insert(Sender: TObject);
    {Configura objetos de Interface para modo leitura / após um Post}
    procedure Post(Sender: TObject);
    {Faz consistência dos dados digitados}
    function ConsisteDados(Sender: TObject): Boolean;
    {Exibe uma mensagem e dá foco ao controle}
    procedure ExibeMensagem(Controle: TWinControl;
                            Mensagem, Caption: String; Flags: Longint);
  end;

{Classe do Form}
type
  Tform_ContasDialog = class(TForm)
    Panel_Dialog: TPanel;
    Panel_Botoes: TPanel;
    PageControl_Opcoes: TPageControl;
    TabSheet_Grupos: TTabSheet;
    btn_Ok: TBitBtn;
    TabSheet_Contas: TTabSheet;
    TabSheet_Opcoes: TTabSheet;
    ListView_Grupos: TListView;
    Label_Grupos: TLabel;
    ImageList_Login: TImageList;
    ListView_Contas: TListView;
    Label_Contas: TLabel;
    Panel_Contas: TPanel;
    Label_UserName: TLabel;
    Edit_UserName: TEdit;
    Label_Grupo: TLabel;
    ComboBox_Grupo: TComboBox;
    Edit_Nome: TEdit;
    Label_NomeConta: TLabel;
    Edit_ConfSenha: TEdit;
    Label_Senha: TLabel;
    Edit_Senha: TEdit;
    Label_ConfSenha: TLabel;
    ToolBar_Contas: TToolBar;
    btn_Conta_Novo: TToolButton;
    btn_Conta_Excluir: TToolButton;
    btn_Conta_Gravar: TToolButton;
    Panel_Permissoes: TPanel;
    Label_Permissoes: TLabel;
    ListBox_Permissoes: TCheckListBox;
    ToolBar_Grupo: TToolBar;
    btn_Grupo_Novo: TToolButton;
    btn_Grupo_Excluir: TToolButton;
    btn_Grupo_Gravar: TToolButton;
    Label_Nome: TLabel;
    Edit_Descricao: TEdit;
    GroupBox_Login: TGroupBox;
    RadioButton_Infinito: TRadioButton;
    RadioButton_Maximo: TRadioButton;
    Label_NTentativas: TLabel;
    Edit_NTentativas: TEdit;
    Panel_Logoff: TPanel;
    CheckBox_AutoLogoff: TCheckBox;
    Label_Apos: TLabel;
    Edit_Idle: TEdit;
    Label_Minutos: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ListView_GruposClick(Sender: TObject);
    procedure PageControl_OpcoesChange(Sender: TObject);
    procedure RadioButton_InfinitoClick(Sender: TObject);
    procedure RadioButton_MaximoClick(Sender: TObject);
    procedure CheckBox_AutoLogoffClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure Edit_NumericoChange(Sender: TObject);
  private
    { Private declarations }
    IntGrupoLogins: TIntGrupoLogins;
    IntContaLogins: TIntContaLogins;
    procedure CarregaConfig;
    procedure SalvaConfig;
  public
    { Public declarations }
    procedure ExecutaRecord(Operacao, Cadastro: String);
  end;

var
  form_ContasDialog: Tform_ContasDialog;

implementation

uses unit_AparenciaDialog, unit_Desktop;

{$R *.DFM}

{-------------------- TIntGrupoLogins -----------------------}

constructor TIntGrupoLogins.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FGrupoLogins := TGrupoLogins.Create;
  {retorna o primeiro registro}
  FGrupoLogins.Refresh;
end;

destructor TIntGrupoLogins.Destroy;
begin
  {cancela alguma operação pendente}
  FGrupoLogins.Cancel;
  {destrói o objeto da classe de dados}
  FGrupoLogins.Free;
  inherited Destroy;
end;

procedure TIntGrupoLogins.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, idx: Integer;
    Direitos: TDireitos;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_ContasDialog), FGrupoLogins.Registro do
  begin
    if UpdateListBox then
    begin
      with ListView_Grupos do
      begin
        if (Items.Count > 0) and (Selected <> nil) then
          idx := Selected.Index
        else
          idx := -1;
        Items.Clear;
        for i := 1 to FGrupoLogins.RecCount do
        begin
          FGrupoLogins.GotoReg(i);
          with Items.Add do
          begin
            Caption := Descricao;
            ImageIndex := 0;
          end;
        end;
        if (idx > -1) and (idx < Items.Count) then
        begin
          Selected := Items.Item[idx];
          FGrupoLogins.LocateDescricao(Selected.Caption);
        end
        else
        begin
          Selected := Items.Item[0];
          FGrupoLogins.GotoReg(1);
        end;
      end;
    end;
    Edit_Descricao.Text := Descricao;
    Direitos := TDireitos.Create;
    GetPermissoes(Direitos);
    with ListBox_Permissoes do
    begin
      Checked[0] := Direitos.VerCadUsuarios;
      Checked[1] := Direitos.VerCadFornecedores;
      Checked[2] := Direitos.VerCadAcervo;
      Checked[3] := Direitos.VerPainelControle;
      Checked[4] := Direitos.VerExplorer;
      Checked[5] := Direitos.VerRelatorios;
      Checked[6] := Direitos.AlterarCadUsuarios;
      Checked[7] := Direitos.AlterarCadFornecedores;
      Checked[8] := Direitos.AlterarCadAcervo;
      Checked[9] := Direitos.Emprestar;
      Checked[10] := Direitos.Devolver;
      Checked[11] := Direitos.MoverPerdido;
      Checked[12] := Direitos.Reservar;
    end;
    Direitos.Free;
  end;
end;

procedure TIntGrupoLogins.Post(Sender: TObject);
var Direitos: TDireitos;
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_ContasDialog), FGrupoLogins.Registro do
  begin
    Descricao := Edit_Descricao.Text;
    Direitos := TDireitos.Create;
    with ListBox_Permissoes do
    begin
      Direitos.VerCadUsuarios := Checked[0];
      Direitos.VerCadFornecedores := Checked[1];
      Direitos.VerCadAcervo := Checked[2];
      Direitos.VerPainelControle := Checked[3];
      Direitos.VerExplorer := Checked[4];
      Direitos.VerRelatorios := Checked[5];
      Direitos.AlterarCadUsuarios := Checked[6];
      Direitos.AlterarCadFornecedores := Checked[7];
      Direitos.AlterarCadAcervo := Checked[8];
      Direitos.Emprestar := Checked[9];
      Direitos.Devolver := Checked[10];
      Direitos.MoverPerdido := Checked[11];
      Direitos.Reservar := Checked[12];
    end;
    SetPermissoes(Direitos);
    Direitos.Free;
    ListView_Grupos.Selected :=
      ListView_Grupos.FindCaption(0,Edit_Descricao.Text,False,True,False);
  end;
end;

procedure TIntGrupoLogins.Read(Sender: TObject; UpdateList: Boolean = True);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_ContasDialog), FGrupoLogins do
  begin
    Panel_Permissoes.Enabled := (RecCount > 0);
    btn_Grupo_Novo.Enabled := True;
    btn_Grupo_Excluir.Enabled := (RecCount > 0);
    btn_Grupo_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,UpDateList);
end;

procedure TIntGrupoLogins.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_ContasDialog), FGrupoLogins do
  begin
    Panel_Permissoes.Enabled := True;
    btn_Grupo_Novo.Enabled := False;
    btn_Grupo_Excluir.Enabled := False;
    btn_Grupo_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntGrupoLogins.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntGrupoLogins.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_ContasDialog), FGrupoLogins.Registro do
  begin
    {nome}
    Descricao := Edit_Descricao.Text;
    {Descricao}
    if Edit_Descricao.Text = '' then
      ExibeMensagem(Edit_Descricao,MSG_NODESCRICAOG,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- TIntContaLogins -----------------------}

constructor TIntContaLogins.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FContaLogins := TContaLogins.Create;
  {retorna o primeiro registro}
  FContaLogins.Refresh;
end;

destructor TIntContaLogins.Destroy;
begin
  {cancela alguma operação pendente}
  FContaLogins.Cancel;
  {destrói o objeto da classe de dados}
  FContaLogins.Free;
  inherited Destroy;
end;

procedure TIntContaLogins.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, idx: Integer;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_ContasDialog), FContaLogins.Registro do
  begin
    if UpdateListBox then
    begin
      with ListView_Contas do
      begin
        if (Items.Count > 0) and (Selected <> nil) then
          idx := Selected.Index
        else
          idx := -1;
        Items.Clear;
        for i := 1 to FContaLogins.RecCount do
        begin
          FContaLogins.GotoReg(i);
          with Items.Add do
          begin
            Caption := UserName;
            ImageIndex := 1;
            SubItems.Add(GrupoLogin.Descricao);
            SubItemImages[0] := 0;
          end;
        end;
        if (idx > -1) and (idx < Items.Count) then
        begin
          Selected := Items.Item[idx];
          FContaLogins.LocateUserName(Selected.Caption);
        end
        else
        begin
          Selected := Items.Item[0];
          FContaLogins.GotoReg(1);
        end;
      end;
    end;
    with ComboBox_Grupo do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        if Items[i] = FContaLogins.Registro.GrupoLogin.Descricao then
        begin
          ComboBox_Grupo.ItemIndex := i;
          break;
        end;
      end;
    end;
    Edit_UserName.Text := UserName;
    Edit_Nome.Text := Nome;
    Edit_Senha.Text := GetPassword;
    Edit_ConfSenha.Text := GetPassword;
  end;
end;

procedure TIntContaLogins.Post(Sender: TObject);
var FGrupoLogins: TGrupoLogins;
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_ContasDialog), FContaLogins.Registro do
  begin
    FGrupoLogins := TGrupoLogins.Create;
    UserName := Edit_UserName.Text;
    Nome := Edit_Nome.Text;
    SetPassword(Edit_Senha.Text);

    FGrupoLogins.Refresh;
    with ComboBox_Grupo do
      FGrupoLogins.LocateDescricao(Items[ItemIndex]);
    GrupoLogin.IdGrupo := FGrupoLogins.Registro.IdGrupo;
    FGrupoLogins.Free;

    ListView_Contas.Selected :=
      ListView_Contas.FindCaption(0,Edit_UserName.Text,False,True,False);
  end;
end;

procedure TIntContaLogins.Read(Sender: TObject; UpdateList: Boolean = True);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_ContasDialog), FContaLogins do
  begin
    Panel_Contas.Enabled := (RecCount > 0);
    btn_Conta_Novo.Enabled := True;
    btn_Conta_Excluir.Enabled := (RecCount > 0);
    btn_Conta_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,UpDateList);
end;

procedure TIntContaLogins.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_ContasDialog), FContaLogins do
  begin
    Panel_Contas.Enabled := True;
    btn_Conta_Novo.Enabled := False;
    btn_Conta_Excluir.Enabled := False;
    btn_Conta_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntContaLogins.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntContaLogins.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_ContasDialog), FContaLogins.Registro do
  begin
    {nome}
    UserName := Edit_Descricao.Text;
    {Descricao}
    if Edit_UserName.Text = '' then
      ExibeMensagem(Edit_UserName,MSG_NODESCRICAOC,CAP_NOALL,MB_OKWARNING)
    {senha}
    else if Edit_Senha.Text <> Edit_ConfSenha.Text then
      ExibeMensagem(Edit_UserName,MSG_NOSENHAC,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

procedure Tform_ContasDialog.FormCreate(Sender: TObject);
begin
  {Evento OnCreate do Form}
  {Cria o objeto da classe de Interface}
  IntContaLogins := TIntContaLogins.Create;
  IntContaLogins.Read(Self);
  IntGrupoLogins := TIntGrupoLogins.Create;
  IntGrupoLogins.Read(Self);
  CarregaConfig;
end;

procedure Tform_ContasDialog.FormDestroy(Sender: TObject);
begin
  {Evento OnDestroy do Form}
  {destrói o objeto da classe de interface}
  IntContaLogins.Free;
  IntGrupoLogins.Free;
end;

procedure Tform_ContasDialog.ButtonClick(Sender: TObject);
var NomeBotao: String;
begin
  {OnClick de todos os botões do ToolBar}
  {Executa a operação conforme o nome do botão}
  NomeBotao := (Sender as TToolButton).Name;
  if NomeBotao = 'btn_Grupo_Novo' then
    ExecutaRecord('Insert','Grupo')
  else if NomeBotao = 'btn_Grupo_Excluir' then
    ExecutaRecord('Delete','Grupo')
  else if NomeBotao = 'btn_Grupo_Gravar' then
    ExecutaRecord('Post','Grupo')

  else if NomeBotao = 'btn_Conta_Novo' then
    ExecutaRecord('Insert','Conta')
  else if NomeBotao = 'btn_Conta_Excluir' then
    ExecutaRecord('Delete','Conta')
  else if NomeBotao = 'btn_Conta_Gravar' then
    ExecutaRecord('Post','Conta');
end;

procedure Tform_ContasDialog.ExecutaRecord(Operacao, Cadastro: String);
begin
  {Executa operações com os registros}
  if Cadastro = 'Grupo' then
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntGrupoLogins, Application do
      begin
        FGrupoLogins.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntGrupoLogins, Application do
      begin
        if (UpperCase(FGrupoLogins.Registro.Descricao) = 'ADMINISTRADORES') or
           (UpperCase(FGrupoLogins.Registro.Descricao) = 'ALUNOS') or
           (UpperCase(FGrupoLogins.Registro.Descricao) = 'BIBLIOTECÁRIOS') then
        begin
          MessageBox(MSG_NOEXCLUIRGRUPO,CAP_NOEXCLUIRGRUPO,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRGRUPO,CAP_EXCLUIRGRUPO,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FGrupoLogins.Delete;
          FGrupoLogins.GotoReg(1);
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntGrupoLogins, IntGrupoLogins.FGrupoLogins.Registro do
      begin
        if (FGrupoLogins.State <> stInsert) and
           ((UpperCase(Descricao) = 'ADMINISTRADORES') or
           ((UpperCase(Descricao) = 'ALUNOS') and
           (Descricao <> Edit_Descricao.Text)) or
           ((UpperCase(Descricao) = 'BIBLIOTECÁRIOS') and
           (Descricao <> Edit_Descricao.Text))) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRGRUPO,CAP_NOEXCLUIRGRUPO,
                        MB_OKWARNING);
          exit;
        end;
        if (FGrupoLogins.State = stInsert) and
           (ListView_Grupos.FindCaption(0,Edit_Descricao.Text,
                                        False,True,False) <> nil) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOGRUPO,CAP_ADESCRICAOGRUPO,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FGrupoLogins.State <> stInsert then
            FGrupoLogins.Edit;
          Post(Self);
          FGrupoLogins.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntGrupoLogins do
      begin
        FGrupoLogins.Cancel;
        Read(Self);
      end;
    end;
  end;
  if Cadastro = 'Conta' then
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntContaLogins, Application do
      begin
        FContaLogins.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntContaLogins, Application do
      begin
        if (UpperCase(FContaLogins.Registro.UserName) = 'ADMIN') or
           (UpperCase(FContaLogins.Registro.UserName) = 'ALUNO') then
        begin
          MessageBox(MSG_NOEXCLUIRConta,CAP_NOEXCLUIRConta,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRConta,CAP_EXCLUIRConta,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FContaLogins.Delete;
          FContaLogins.GotoReg(1);
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntContaLogins, IntContaLogins.FContaLogins.Registro do
      begin
        if (FContaLogins.State <> stInsert) and
           ((UpperCase(UserName) = 'ADMIN') or
           (UpperCase(UserName) = 'ALUNO')) and
           (UserName <> Edit_UserName.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRConta,CAP_NOEXCLUIRConta,
                        MB_OKWARNING);
          exit;
        end;
        if (FContaLogins.State = stInsert) and
           (ListView_Contas.FindCaption(0,Edit_UserName.Text,
                                        False,True,False) <> nil) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOConta,CAP_ADESCRICAOConta,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FContaLogins.State <> stInsert then
            FContaLogins.Edit;
          Post(Self);
          FContaLogins.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntContaLogins do
      begin
        FContaLogins.Cancel;
        Read(Self);
      end;
    end;
  end;
end;

procedure Tform_ContasDialog.CarregaConfig;
var Config: TConfiguracao;
begin
  Config := TConfiguracao.Create;
  with Config do
  begin
    Read(True);
    Edit_NTentativas.Text := IntToStr(NTentativas);
    if NTentativas = 0 then
    begin
      RadioButton_Infinito.Checked := True;
      RadioButton_Maximo.Checked := False;
    end
    else
    begin
      RadioButton_Infinito.Checked := False;
      RadioButton_Maximo.Checked := True;
    end;
    Edit_Idle.Text := IntToStr(AutoLogoff);
    CheckBox_AutoLogoff.Checked := AutoLogoff <> 0;
    Free;
  end;
end;

procedure Tform_ContasDialog.SalvaConfig;
var Config: TConfiguracao;
begin
  Config := TConfiguracao.Create;
  with Config do
  begin
    if (RadioButton_Infinito.Checked) or
       (Edit_NTentativas.Text = '')  then
      NTentativas := 0
    else
      NTentativas := StrToInt(Edit_NTentativas.Text);
    if (not CheckBox_AutoLogoff.Checked) or
       (Edit_Idle.Text = '') then
      AutoLogoff := 0
    else
      AutoLogoff := StrToInt(Edit_Idle.Text);
    Write;
    form_Desktop.BBStatusBar_Status.Active := False;
    if AutoLogoff = 0 then
      form_Desktop.BBStatusBar_Status.IdleTimer := False
    else
    begin
      form_Desktop.BBStatusBar_Status.IdleInterval :=
        EncodeTime(0,AutoLogoff,0,0);
      form_Desktop.BBStatusBar_Status.IdleTimer := True;
    end;
    form_Desktop.BBStatusBar_Status.Active := True;
    Free;
  end;
end;

procedure Tform_ContasDialog.ListView_GruposClick(Sender: TObject);
var id: Integer;
begin
  {Evento OnClick do ListBox}
  if (Sender as TListView).Name = 'ListView_Grupos' then
  begin
    if (ListView_Grupos.Items.Count = 0) or
       (ListView_Grupos.Selected = nil) then
      exit;
    with IntGrupoLogins.FGrupoLogins do
    begin
      Cancel;
      id := ListView_Grupos.Selected.Index;
      LocateDescricao(ListView_Grupos.Selected.Caption);
      IntGrupoLogins.Read(Self,False);
      ListView_Grupos.Selected := ListView_Grupos.Items.Item[id];
    end;
  end;
  if (Sender as TListView).Name = 'ListView_Contas' then
  begin
    if (ListView_Contas.Items.Count = 0) or
       (ListView_Contas.Selected = nil) then
      exit;
    with IntContaLogins.FContaLogins do
    begin
      Cancel;
      id := ListView_Contas.Selected.Index;
      LocateUserName(ListView_Contas.Selected.Caption);
      IntContaLogins.Read(Self,False);
      ListView_Contas.Selected := ListView_Contas.Items.Item[id];
    end;
  end;
end;

procedure Tform_ContasDialog.PageControl_OpcoesChange(Sender: TObject);
var i: Integer;
begin
  if PageControl_Opcoes.ActivePage <> TabSheet_Contas then
    exit;
  {atualiza o ComboBox}
  with IntGrupoLogins do
  begin
    FGrupoLogins.Refresh;
    with ComboBox_Grupo do
    begin
      Items.Clear;
      for i := 1 to FGrupoLogins.RecCount do
      begin
        FGrupoLogins.GotoReg(i);
        Items.Add(FGrupoLogins.Registro.Descricao);
      end;
      ItemIndex := 0;
    end;
  end;
end;

procedure Tform_ContasDialog.RadioButton_InfinitoClick(Sender: TObject);
begin
  RadioButton_Maximo.Checked := False;
  Edit_NTentativas.Enabled := False;
end;

procedure Tform_ContasDialog.RadioButton_MaximoClick(Sender: TObject);
begin
  RadioButton_Infinito.Checked := False;
  Edit_NTentativas.Enabled := True;
end;

procedure Tform_ContasDialog.CheckBox_AutoLogoffClick(Sender: TObject);
begin
  Edit_Idle.Enabled := CheckBox_AutoLogoff.Checked;
end;

procedure Tform_ContasDialog.btn_OkClick(Sender: TObject);
begin
  SalvaConfig;
  ModalResult := mrOK;
end;

procedure Tform_ContasDialog.Edit_NumericoChange(Sender: TObject);
begin
  ConsisteNumerico(Sender);
end;

end.

