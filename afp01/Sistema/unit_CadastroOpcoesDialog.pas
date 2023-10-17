{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_CadastroOpcoesDialog.pas

  Contém as classes de Interface do Diálogo de Opções dos Cadastros.

  Data última revisão: 06/11/2001

******************************************************************************}

unit unit_CadastroOpcoesDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, CheckLst, ImgList, ToolWin,
  unit_DatabaseClasses, unit_Comum;

{Classes de Interface}

{contém métodos para a Interface com TipoUsuarios}
type
  TIntTipoUsuarios = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FTipoUsuarios: TTipoUsuarios;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
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

{contém métodos para a Interface com TipoFornecedores}
type
  TIntTipoFornecedores = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FTipoFornecedores: TTipoFornecedores;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
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

{contém métodos para a Interface com TipoAcervos}
type
  TIntTipoAcervos = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FTipoAcervos: TTipoAcervos;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
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

{contém métodos para a Interface com AreaAcervos}
type
  TIntAreaAcervos = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FAreaAcervos: TAreaAcervos;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
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

{contém métodos para a Interface com ClassificacaoAcervos}
type
  TIntClassificacaoAcervos = class
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FClassificacaoAcervos: TClassificacaoAcervos;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject; UpdateListBox: Boolean = False);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
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
  Tform_CadastroOpcoesDialog = class(TForm)
    Panel_Dialog: TPanel;
    Panel_Botoes: TPanel;
    PageControl_Opcoes: TPageControl;
    TabSheet_PapelDeParede: TTabSheet;
    btn_Ok: TBitBtn;
    TabSheet_Fornecedores: TTabSheet;
    TabSheet_Usuarios: TTabSheet;
    ImageList_Botoes: TImageList;
    GroupBox_TAcervo: TGroupBox;
    ToolBar_TA: TToolBar;
    btn_TA_Novo: TToolButton;
    btn_TA_Excluir: TToolButton;
    btn_TA_Gravar: TToolButton;
    ListBox_TiposTA: TListBox;
    Label_TiposTA: TLabel;
    GroupBox_AAcervo: TGroupBox;
    Label_TiposAA: TLabel;
    ToolBar_AA: TToolBar;
    btn_AA_Novo: TToolButton;
    btn_AA_Excluir: TToolButton;
    btn_AA_Gravar: TToolButton;
    ListBox_TiposAA: TListBox;
    GroupBox_CAcervo: TGroupBox;
    Label_TiposCA: TLabel;
    ToolBar_CA: TToolBar;
    btn_CA_Novo: TToolButton;
    btn_CA_Excluir: TToolButton;
    btn_CA_Gravar: TToolButton;
    ListBox_TiposCA: TListBox;
    GroupBox_Fornecedores: TGroupBox;
    Label_TiposF: TLabel;
    ListBox_TiposF: TListBox;
    GroupBox_Usuarios: TGroupBox;
    Label_Tipos: TLabel;
    ToolBar_Usuarios: TToolBar;
    btn_Usuarios_Novo: TToolButton;
    btn_Usuarios_Excluir: TToolButton;
    btn_Usuarios_Gravar: TToolButton;
    ListBox_Tipos: TListBox;
    Panel_Usuarios: TPanel;
    Label_Descricao: TLabel;
    Edit_Descricao: TEdit;
    Label_MaxExemplares: TLabel;
    Edit_MaxExemplares: TEdit;
    Edit_TempoEmprestimo: TEdit;
    Edit_TempoSusp: TEdit;
    Label_TempoEmprestimo: TLabel;
    Label_TempoSusp: TLabel;
    Panel_Fornecedores: TPanel;
    Label_DescricaoF: TLabel;
    Edit_DescricaoF: TEdit;
    ToolBar_Forneceores: TToolBar;
    btn_Fornecedores_Novo: TToolButton;
    btn_Fornecedores_Excluir: TToolButton;
    btn_Fornecedores_Gravar: TToolButton;
    Panel_TA: TPanel;
    Edit_DescricaoTA: TEdit;
    Label_DescricaoTA: TLabel;
    Panel_AA: TPanel;
    Edit_DescricaoAA: TEdit;
    Label_DescricaoAA: TLabel;
    Panel_CA: TPanel;
    Label_DescricaoCA: TLabel;
    Edit_DescricaoCA: TEdit;
    CheckBox_PodeEmprestar: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditNumericoChange(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure PageControl_OpcoesChange(Sender: TObject);
  private
    { Private declarations }
    IntTipoUsuarios: TIntTipoUsuarios;
    IntTipoFornecedores: TIntTipoFornecedores;
    IntTipoAcervos: TIntTipoAcervos;
    IntAreaAcervos: TIntAreaAcervos;
    IntClassificacaoAcervos: TIntClassificacaoAcervos;
//    procedure ExecutaRecord(Operacao, Cadastro: String);
  public
    { Public declarations }
    procedure ExecutaRecord(Operacao, Cadastro: String);
  end;

var
  form_CadastroOpcoesDialog: Tform_CadastroOpcoesDialog;

implementation

{$R *.DFM}

{-------------------- TIntTipoUsuarios -----------------------}

constructor TIntTipoUsuarios.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FTipoUsuarios := TTipoUsuarios.Create;
  {retorna o primeiro registro}
  FTipoUsuarios.Refresh;
end;

destructor TIntTipoUsuarios.Destroy;
begin
  {cancela alguma operação pendente}
  FTipoUsuarios.Cancel;
  {destrói o objeto da classe de dados}
  FTipoUsuarios.Free;
  inherited Destroy;
end;

procedure TIntTipoUsuarios.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, dbidx, idx: Integer;
    TmpStr: String;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoUsuarios.Registro do
  begin
    if UpdateListBox then
    begin
      with ListBox_Tipos do
      begin
        TmpStr := '';
        if (Items.Count > 0) and (ItemIndex > -1) then
          TmpStr := Items[ItemIndex];
        Items.Clear;
        idx := -1;
        dbidx := -1;
        for i := 1 to FTipoUsuarios.RecCount do
        begin
          FTipoUsuarios.GotoReg(i);
          Items.Add(Descricao);
          if Descricao = TmpStr then
          begin
            idx := Items.IndexOf(Descricao);
            dbidx := i;
          end;
        end;
        if idx > -1 then
        begin
          ItemIndex := idx;
          FTipoUsuarios.GotoReg(dbidx);
        end
        else
        begin
          ItemIndex := 0;
          FTipoUsuarios.GotoReg(1);
        end;
      end;
    end;
    Edit_Descricao.Text := Descricao;
    Edit_MaxExemplares.Text := IntToStr(MaxExemplares);
    Edit_TempoEmprestimo.Text := IntToStr(TempoEmprestimo);
    Edit_TempoSusp.Text := IntToStr(TempoSusp);
  end;
end;

procedure TIntTipoUsuarios.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoUsuarios.Registro do
  begin
    Descricao := Edit_Descricao.Text;
    MaxExemplares := StrToInt(Edit_MaxExemplares.Text);
    TempoEmprestimo := StrToInt(Edit_TempoEmprestimo.Text);
    TempoSusp := StrToInt(Edit_TempoSusp.Text);
  end;
end;

procedure TIntTipoUsuarios.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoUsuarios do
  begin
    Panel_Usuarios.Enabled := (RecCount > 0);
    btn_Usuarios_Novo.Enabled := True;
    btn_Usuarios_Excluir.Enabled := (RecCount > 0);
    btn_Usuarios_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,True);
end;

procedure TIntTipoUsuarios.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoUsuarios do
  begin
    Panel_Usuarios.Enabled := True;
    btn_Usuarios_Novo.Enabled := False;
    btn_Usuarios_Excluir.Enabled := False;
    btn_Usuarios_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntTipoUsuarios.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntTipoUsuarios.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroOpcoesDialog), FTipoUsuarios.Registro do
  begin
    {nome}
    Descricao := Edit_Descricao.Text;
    MaxExemplares := StrToInt(Edit_MaxExemplares.Text);
    TempoEmprestimo := StrToInt(Edit_TempoEmprestimo.Text);
    TempoSusp := StrToInt(Edit_TempoSusp.Text);
    {Descricao}
    if Edit_Descricao.Text = '' then
      ExibeMensagem(Edit_Descricao,MSG_NODESCRICAO,CAP_NOALL,MB_OKWARNING)
    {MaxExemplares}
    else if Edit_MaxExemplares.Text = '' then
      ExibeMensagem(Edit_MaxExemplares,MSG_NOMAXEXEMPLARES,
                    CAP_NOALL,MB_OKWARNING)
    {TempoEmprestimo}
    else if Edit_TempoEmprestimo.Text = '' then
      ExibeMensagem(Edit_TempoEmprestimo,MSG_NOTEMPOEMPRESTIMO,
                    CAP_NOALL,MB_OKWARNING)
    {TempoSusp}
    else if Edit_TempoSusp.Text = '' then
      ExibeMensagem(Edit_TempoSusp,MSG_NOTEMPOSUSP,
                    CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- TIntTipoFornecedores -----------------------}

constructor TIntTipoFornecedores.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FTipoFornecedores := TTipoFornecedores.Create;
  {retorna o primeiro registro}
  FTipoFornecedores.Refresh;
end;

destructor TIntTipoFornecedores.Destroy;
begin
  {cancela alguma operação pendente}
  FTipoFornecedores.Cancel;
  {destrói o objeto da classe de dados}
  FTipoFornecedores.Free;
  inherited Destroy;
end;

procedure TIntTipoFornecedores.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, dbidx, idx: Integer;
    TmpStr: String;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoFornecedores.Registro do
  begin
    if UpdateListBox then
    begin
      with ListBox_TiposF do
      begin
        TmpStr := '';
        if (Items.Count > 0) and (ItemIndex > -1) then
          TmpStr := Items[ItemIndex];
        Items.Clear;
        idx := -1;
        dbidx := -1;
        for i := 1 to FTipoFornecedores.RecCount do
        begin
          FTipoFornecedores.GotoReg(i);
          Items.Add(Descricao);
          if Descricao = TmpStr then
          begin
            idx := Items.IndexOf(Descricao);
            dbidx := i;
          end;
        end;
        if idx > -1 then
        begin
          ItemIndex := idx;
          FTipoFornecedores.GotoReg(dbidx);
        end
        else
        begin
          ItemIndex := 0;
          FTipoFornecedores.GotoReg(1);
        end;
      end;
    end;
    Edit_DescricaoF.Text := Descricao;
  end;
end;

procedure TIntTipoFornecedores.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoFornecedores.Registro do
  begin
    Descricao := Edit_DescricaoF.Text;
  end;
end;

procedure TIntTipoFornecedores.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoFornecedores do
  begin
    Panel_Fornecedores.Enabled := (RecCount > 0);
    btn_Fornecedores_Novo.Enabled := True;
    btn_Fornecedores_Excluir.Enabled := (RecCount > 0);
    btn_Fornecedores_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,True);
end;

procedure TIntTipoFornecedores.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoFornecedores do
  begin
    Panel_Fornecedores.Enabled := True;
    btn_Fornecedores_Novo.Enabled := False;
    btn_Fornecedores_Excluir.Enabled := False;
    btn_Fornecedores_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntTipoFornecedores.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntTipoFornecedores.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroOpcoesDialog), FTipoFornecedores.Registro do
  begin
    {nome}
    Descricao := Edit_DescricaoF.Text;
    {Descricao}
    if Edit_DescricaoF.Text = '' then
      ExibeMensagem(Edit_DescricaoF,MSG_NODESCRICAOF,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- TIntTipoAcervos -----------------------}

constructor TIntTipoAcervos.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FTipoAcervos := TTipoAcervos.Create;
  {retorna o primeiro registro}
  FTipoAcervos.Refresh;
end;

destructor TIntTipoAcervos.Destroy;
begin
  {cancela alguma operação pendente}
  FTipoAcervos.Cancel;
  {destrói o objeto da classe de dados}
  FTipoAcervos.Free;
  inherited Destroy;
end;

procedure TIntTipoAcervos.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, dbidx, idx: Integer;
    TmpStr: String;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoAcervos.Registro do
  begin
    if UpdateListBox then
    begin
      with ListBox_TiposTA do
      begin
        TmpStr := '';
        if (Items.Count > 0) and (ItemIndex > -1) then
          TmpStr := Items[ItemIndex];
        Items.Clear;
        idx := -1;
        dbidx := -1;
        for i := 1 to FTipoAcervos.RecCount do
        begin
          FTipoAcervos.GotoReg(i);
          Items.Add(Descricao);
          if Descricao = TmpStr then
          begin
            idx := Items.IndexOf(Descricao);
            dbidx := i;
          end;
        end;
        if idx > -1 then
        begin
          ItemIndex := idx;
          FTipoAcervos.GotoReg(dbidx);
        end
        else
        begin
          ItemIndex := 0;
          FTipoAcervos.GotoReg(1);
        end;
      end;
    end;
    Edit_DescricaoTA.Text := Descricao;
    CheckBox_PodeEmprestar.Checked := PodeEmprestar;
  end;
end;

procedure TIntTipoAcervos.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoAcervos.Registro do
  begin
    Descricao := Edit_DescricaoTA.Text;
    PodeEmprestar := CheckBox_PodeEmprestar.Checked;
  end;
end;

procedure TIntTipoAcervos.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoAcervos do
  begin
    Panel_TA.Enabled := (RecCount > 0);
    btn_TA_Novo.Enabled := True;
    btn_TA_Excluir.Enabled := (RecCount > 0);
    btn_TA_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,True);
end;

procedure TIntTipoAcervos.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroOpcoesDialog), FTipoAcervos do
  begin
    Panel_TA.Enabled := True;
    btn_TA_Novo.Enabled := False;
    btn_TA_Excluir.Enabled := False;
    btn_TA_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntTipoAcervos.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntTipoAcervos.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroOpcoesDialog), FTipoAcervos.Registro do
  begin
    {nome}
    Descricao := Edit_DescricaoTA.Text;
    {Descricao}
    if Edit_DescricaoTA.Text = '' then
      ExibeMensagem(Edit_DescricaoTA,MSG_NODESCRICAOTA,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- TIntAreaAcervos -----------------------}

constructor TIntAreaAcervos.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FAreaAcervos := TAreaAcervos.Create;
  {retorna o primeiro registro}
  FAreaAcervos.Refresh;
end;

destructor TIntAreaAcervos.Destroy;
begin
  {cancela alguma operação pendente}
  FAreaAcervos.Cancel;
  {destrói o objeto da classe de dados}
  FAreaAcervos.Free;
  inherited Destroy;
end;

procedure TIntAreaAcervos.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, dbidx, idx: Integer;
    TmpStr: String;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroOpcoesDialog), FAreaAcervos.Registro do
  begin
    if UpdateListBox then
    begin
      with ListBox_TiposAA do
      begin
        TmpStr := '';
        if (Items.Count > 0) and (ItemIndex > -1) then
          TmpStr := Items[ItemIndex];
        Items.Clear;
        idx := -1;
        dbidx := -1;
        for i := 1 to FAreaAcervos.RecCount do
        begin
          FAreaAcervos.GotoReg(i);
          Items.Add(Descricao);
          if Descricao = TmpStr then
          begin
            idx := Items.IndexOf(Descricao);
            dbidx := i;
          end;
        end;
        if idx > -1 then
        begin
          ItemIndex := idx;
          FAreaAcervos.GotoReg(dbidx);
        end
        else
        begin
          ItemIndex := 0;
          FAreaAcervos.GotoReg(1);
        end;
      end;
    end;
    Edit_DescricaoAA.Text := Descricao;
  end;
end;

procedure TIntAreaAcervos.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroOpcoesDialog), FAreaAcervos.Registro do
  begin
    Descricao := Edit_DescricaoAA.Text;
  end;
end;

procedure TIntAreaAcervos.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroOpcoesDialog), FAreaAcervos do
  begin
    Panel_AA.Enabled := (RecCount > 0);
    btn_AA_Novo.Enabled := True;
    btn_AA_Excluir.Enabled := (RecCount > 0);
    btn_AA_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,True);
end;

procedure TIntAreaAcervos.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroOpcoesDialog), FAreaAcervos do
  begin
    Panel_AA.Enabled := True;
    btn_AA_Novo.Enabled := False;
    btn_AA_Excluir.Enabled := False;
    btn_AA_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntAreaAcervos.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntAreaAcervos.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroOpcoesDialog), FAreaAcervos.Registro do
  begin
    {nome}
    Descricao := Edit_DescricaoAA.Text;
    {Descricao}
    if Edit_DescricaoAA.Text = '' then
      ExibeMensagem(Edit_DescricaoAA,MSG_NODESCRICAOAA,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- TIntClassificacaoAcervos -----------------------}

constructor TIntClassificacaoAcervos.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FClassificacaoAcervos := TClassificacaoAcervos.Create;
  {retorna o primeiro registro}
  FClassificacaoAcervos.Refresh;
end;

destructor TIntClassificacaoAcervos.Destroy;
begin
  {cancela alguma operação pendente}
  FClassificacaoAcervos.Cancel;
  {destrói o objeto da classe de dados}
  FClassificacaoAcervos.Free;
  inherited Destroy;
end;

procedure TIntClassificacaoAcervos.LeRegistros(Sender: TObject;
                                     UpdateListBox: Boolean = False);
var i, dbidx, idx: Integer;
    TmpStr: String;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroOpcoesDialog), FClassificacaoAcervos.Registro do
  begin
    if UpdateListBox then
    begin
      with ListBox_TiposCA do
      begin
        TmpStr := '';
        if (Items.Count > 0) and (ItemIndex > -1) then
          TmpStr := Items[ItemIndex];
        Items.Clear;
        idx := -1;
        dbidx := -1;
        for i := 1 to FClassificacaoAcervos.RecCount do
        begin
          FClassificacaoAcervos.GotoReg(i);
          Items.Add(Descricao);
          if Descricao = TmpStr then
          begin
            idx := Items.IndexOf(Descricao);
            dbidx := i;
          end;
        end;
        if idx > -1 then
        begin
          ItemIndex := idx;
          FClassificacaoAcervos.GotoReg(dbidx);
        end
        else
        begin
          ItemIndex := 0;
          FClassificacaoAcervos.GotoReg(1);
        end;
      end;
    end;
    Edit_DescricaoCA.Text := Descricao;
  end;
end;

procedure TIntClassificacaoAcervos.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroOpcoesDialog), FClassificacaoAcervos.Registro do
  begin
    Descricao := Edit_DescricaoCA.Text;
  end;
end;

procedure TIntClassificacaoAcervos.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroOpcoesDialog), FClassificacaoAcervos do
  begin
    Panel_CA.Enabled := (RecCount > 0);
    btn_CA_Novo.Enabled := True;
    btn_CA_Excluir.Enabled := (RecCount > 0);
    btn_CA_Gravar.Enabled := (RecCount > 0);
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender,True);
end;

procedure TIntClassificacaoAcervos.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroOpcoesDialog), FClassificacaoAcervos do
  begin
    Panel_CA.Enabled := True;
    btn_CA_Novo.Enabled := False;
    btn_CA_Excluir.Enabled := False;
    btn_CA_Gravar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TIntClassificacaoAcervos.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TIntClassificacaoAcervos.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroOpcoesDialog), FClassificacaoAcervos.Registro do
  begin
    {nome}
    Descricao := Edit_DescricaoCA.Text;
    {Descricao}
    if Edit_DescricaoCA.Text = '' then
      ExibeMensagem(Edit_DescricaoCA,MSG_NODESCRICAOCA,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- Tform_CadastroUsuarios -----------------------}

{** Tratadores de Evento ***}

procedure Tform_CadastroOpcoesDialog.FormCreate(Sender: TObject);
begin
  {Evento OnCreate do Form}
  {Cria o objeto da classe de Interface}
  IntTipoUsuarios := TIntTipoUsuarios.Create;
  IntTipoUsuarios.Read(Self);
  IntTipoFornecedores := TIntTipoFornecedores.Create;
  IntTipoFornecedores.Read(Self);
  IntTipoAcervos := TIntTipoAcervos.Create;
  IntTipoAcervos.Read(Self);
  IntAreaAcervos := TIntAreaAcervos.Create;
  IntAreaAcervos.Read(Self);
  IntClassificacaoAcervos := TIntClassificacaoAcervos.Create;
  IntClassificacaoAcervos.Read(Self);
end;

procedure Tform_CadastroOpcoesDialog.FormDestroy(Sender: TObject);
begin
  {Evento OnDestroy do Form}
  {destrói o objeto da classe de interface}
  IntTipoUsuarios.Free;
  IntTipoFornecedores.Free;
  IntTipoAcervos.Free;
  IntAreaAcervos.Free;
  IntClassificacaoAcervos.Free;
end;

procedure Tform_CadastroOpcoesDialog.EditNumericoChange(Sender: TObject);
begin
  {Evento OnChange dos TEdit numéricos}
  {chama rotina (unit_Comum) que faz consistência on-line do campo}
  ConsisteNumerico(Sender);
end;

procedure Tform_CadastroOpcoesDialog.ButtonClick(Sender: TObject);
var NomeBotao: String;
begin
  {OnClick de todos os botões do ToolBar}
  {Executa a operação conforme o nome do botão}
  NomeBotao := (Sender as TToolButton).Name;
  if NomeBotao = 'btn_Usuarios_Novo' then
    ExecutaRecord('Insert','Usuarios')
  else if NomeBotao = 'btn_Usuarios_Excluir' then
    ExecutaRecord('Delete','Usuarios')
  else if NomeBotao = 'btn_Usuarios_Gravar' then
    ExecutaRecord('Post','Usuarios')

  else if NomeBotao = 'btn_Fornecedores_Novo' then
    ExecutaRecord('Insert','Fornecedores')
  else if NomeBotao = 'btn_Fornecedores_Excluir' then
    ExecutaRecord('Delete','Fornecedores')
  else if NomeBotao = 'btn_Fornecedores_Gravar' then
    ExecutaRecord('Post','Fornecedores')

  else if NomeBotao = 'btn_TA_Novo' then
    ExecutaRecord('Insert','TA')
  else if NomeBotao = 'btn_TA_Excluir' then
    ExecutaRecord('Delete','TA')
  else if NomeBotao = 'btn_TA_Gravar' then
    ExecutaRecord('Post','TA')

  else if NomeBotao = 'btn_AA_Novo' then
    ExecutaRecord('Insert','AA')
  else if NomeBotao = 'btn_AA_Excluir' then
    ExecutaRecord('Delete','AA')
  else if NomeBotao = 'btn_AA_Gravar' then
    ExecutaRecord('Post','AA')

  else if NomeBotao = 'btn_CA_Novo' then
    ExecutaRecord('Insert','CA')
  else if NomeBotao = 'btn_CA_Excluir' then
    ExecutaRecord('Delete','CA')
  else if NomeBotao = 'btn_CA_Gravar' then
    ExecutaRecord('Post','CA');
end;

procedure Tform_CadastroOpcoesDialog.ListBoxClick(Sender: TObject);
var i: Integer;
begin
  {Evento OnClick do ListBox}
  if (Sender as TListBox).Name = 'ListBox_Tipos' then
  begin
    if (ListBox_Tipos.Items.Count = 0) or (ListBox_Tipos.ItemIndex < 0) then
      exit;
    with IntTipoUsuarios.FTipoUsuarios do
    begin
      Cancel;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        with ListBox_Tipos do
        begin
          if Registro.Descricao = Items[ItemIndex] then
            break;
        end;
      end;
      IntTipoUsuarios.Read(Self);
    end;
  end;

  if (Sender as TListBox).Name = 'ListBox_TiposF' then
  begin
    if (ListBox_TiposF.Items.Count = 0) or (ListBox_TiposF.ItemIndex < 0) then
      exit;
    with IntTipoFornecedores.FTipoFornecedores do
    begin
      Cancel;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        with ListBox_TiposF do
        begin
          if Registro.Descricao = Items[ItemIndex] then
            break;
        end;
      end;
      IntTipoFornecedores.Read(Self);
    end;
  end;

  if (Sender as TListBox).Name = 'ListBox_TiposTA' then
  begin
    if (ListBox_TiposTA.Items.Count = 0) or (ListBox_TiposTA.ItemIndex < 0) then
      exit;
    with IntTipoAcervos.FTipoAcervos do
    begin
      Cancel;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        with ListBox_TiposTA do
        begin
          if Registro.Descricao = Items[ItemIndex] then
            break;
        end;
      end;
      IntTipoAcervos.Read(Self);
    end;
  end;

  if (Sender as TListBox).Name = 'ListBox_TiposAA' then
  begin
    if (ListBox_TiposAA.Items.Count = 0) or (ListBox_TiposAA.ItemIndex < 0) then
      exit;
    with IntAreaAcervos.FAreaAcervos do
    begin
      Cancel;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        with ListBox_TiposAA do
        begin
          if Registro.Descricao = Items[ItemIndex] then
            break;
        end;
      end;
      IntAreaAcervos.Read(Self);
    end;
  end;

  if (Sender as TListBox).Name = 'ListBox_TiposCA' then
  begin
    if (ListBox_TiposCA.Items.Count = 0) or (ListBox_TiposCA.ItemIndex < 0) then
      exit;
    with IntClassificacaoAcervos.FClassificacaoAcervos do
    begin
      Cancel;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        with ListBox_TiposCA do
        begin
          if Registro.Descricao = Items[ItemIndex] then
            break;
        end;
      end;
      IntClassificacaoAcervos.Read(Self);
    end;
  end;
end;

procedure Tform_CadastroOpcoesDialog.PageControl_OpcoesChange(
  Sender: TObject);
begin
  {evento OnChange do PageControl_Opcoes}
  case PageControl_Opcoes.ActivePageIndex of
    0: begin
         GroupBox_Usuarios.Enabled := False;
         GroupBox_Fornecedores.Enabled := False;
         GroupBox_TAcervo.Enabled := True;
         GroupBox_AAcervo.Enabled := True;
         GroupBox_CAcervo.Enabled := True;
       end;
    1: begin
         GroupBox_Usuarios.Enabled := False;
         GroupBox_Fornecedores.Enabled := True;
         GroupBox_TAcervo.Enabled := False;
         GroupBox_AAcervo.Enabled := False;
         GroupBox_CAcervo.Enabled := False;
       end;
    2: begin
         GroupBox_Usuarios.Enabled := True;
         GroupBox_Fornecedores.Enabled := False;
         GroupBox_TAcervo.Enabled := False;
         GroupBox_AAcervo.Enabled := False;
         GroupBox_CAcervo.Enabled := False;
       end;
  end;
end;

{** Métodos ***}

procedure Tform_CadastroOpcoesDialog.ExecutaRecord(Operacao, Cadastro: String);
begin
  {Executa operações com os registros}
  if Cadastro = 'Usuarios' then {Tipos de Usuário}
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntTipoUsuarios, Application do
      begin
        if FTipoUsuarios.RecCount = 20 then {maximo de 20 tipos de usuários}
        begin
          MessageBox(MSG_MUITOSTIPOUSUARIO,CAP_MUITOSTIPOUSUARIO,
                      MB_OKWARNING);
          exit;
        end;
        FTipoUsuarios.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntTipoUsuarios, Application do
      begin
        if (UpperCase(FTipoUsuarios.Registro.Descricao) = 'ALUNO') or
           (UpperCase(FTipoUsuarios.Registro.Descricao) = 'PROFESSOR') or
           (UpperCase(FTipoUsuarios.Registro.Descricao) = 'BIBLIOTECÁRIO') or
           (UpperCase(FTipoUsuarios.Registro.Descricao) = 'FUNCIONÁRIO') then
        begin
          MessageBox(MSG_NOEXCLUIRTIPOUSUARIO,CAP_NOEXCLUIRTIPOUSUARIO,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRTIPOUSUARIO,CAP_EXCLUIRTIPOUSUARIO,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FTipoUsuarios.Delete;
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntTipoUsuarios, IntTipoUsuarios.FTipoUsuarios.Registro do
      begin
        if (FTipoUsuarios.State <> stInsert) and
           ((UpperCase(Descricao) = 'ALUNO') or
           (UpperCase(Descricao) = 'PROFESSOR') or
           (UpperCase(Descricao) = 'BIBLIOTECÁRIO') or
           (UpperCase(Descricao) = 'FUNCIONÁRIO')) and
           (Descricao <> Edit_Descricao.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRTIPOUSUARIO,CAP_NOEXCLUIRTIPOUSUARIO,
                        MB_OKWARNING);
          exit;
        end;
        if (FTipoUsuarios.State = stInsert) and
           (ListBox_Tipos.Items.IndexOf(Edit_Descricao.Text) > -1) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOTIPOUSUARIO,CAP_ADESCRICAOTIPOUSUARIO,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FTipoUsuarios.State <> stInsert then
            FTipoUsuarios.Edit;
          Post(Self);
          FTipoUsuarios.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntTipoUsuarios do
      begin
        FTipoUsuarios.Cancel;
        Read(Self);
      end;
    end;
  end;

  if Cadastro = 'Fornecedores' then {Tipos de Fornecedores}
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntTipoFornecedores, Application do
      begin
        if FTipoFornecedores.RecCount = 10 then {maximo de 10 tipos de forneced.}
        begin
          MessageBox(MSG_MUITOSTIPOFORNECEDORES,CAP_MUITOSTIPOFORNECEDORES,
                      MB_OKWARNING);
          exit;
        end;
        FTipoFornecedores.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntTipoFornecedores, Application do
      begin
        if (UpperCase(FTipoFornecedores.Registro.Descricao) = 'LIVRARIA') or
           (UpperCase(FTipoFornecedores.Registro.Descricao) = 'EDITORA') then
        begin
          MessageBox(MSG_NOEXCLUIRTIPOFORNECEDOR,CAP_NOEXCLUIRTIPOFORNECEDOR,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRTIPOFORNECEDOR,CAP_EXCLUIRTIPOFORNECEDOR,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FTipoFornecedores.Delete;
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntTipoFornecedores,
           IntTipoFornecedores.FTipoFornecedores.Registro do
      begin
        if (FTipoFornecedores.State <> stInsert) and
           ((UpperCase(Descricao) = 'LIVRARIA') or
           (UpperCase(Descricao) = 'EDITORA')) and
           (Descricao <> Edit_DescricaoF.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRTIPOFORNECEDOR,CAP_NOEXCLUIRTIPOFORNECEDOR,
                        MB_OKWARNING);
          exit;
        end;
        if (FTipoFornecedores.State = stInsert) and
           (ListBox_TiposF.Items.IndexOf(Edit_DescricaoF.Text) > -1) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOTIPOFORNECEDOR,CAP_ADESCRICAOTIPOFORNECEDOR,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FTipoFornecedores.State <> stInsert then
            FTipoFornecedores.Edit;
          Post(Self);
          FTipoFornecedores.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntTipoFornecedores do
      begin
        FTipoFornecedores.Cancel;
        Read(Self);
      end;
    end;
  end;

  if Cadastro = 'TA' then {Tipos de Acervo}
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntTipoAcervos, Application do
      begin
        if FTipoAcervos.RecCount = 20 then {maximo de 20 tipos de acervo}
        begin
          MessageBox(MSG_MUITOSTA,CAP_MUITOSTA,
                      MB_OKWARNING);
          exit;
        end;
        FTipoAcervos.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntTipoAcervos, Application do
      begin
        if (UpperCase(FTipoAcervos.Registro.Descricao) = 'LIVRO') or
           (UpperCase(FTipoAcervos.Registro.Descricao) = 'ENCICLOPÉDIA') then
        begin
          MessageBox(MSG_NOEXCLUIRTA,CAP_NOEXCLUIRTA,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRTA,CAP_EXCLUIRTA,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FTipoAcervos.Delete;
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntTipoAcervos,
           IntTipoAcervos.FTipoAcervos.Registro do
      begin
        if (FTipoAcervos.State <> stInsert) and
           ((UpperCase(Descricao) = 'LIVRO') or
           (UpperCase(Descricao) = 'ENCICLOPÉDIA')) and
           (Descricao <> Edit_DescricaoTA.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRTA,CAP_NOEXCLUIRTA,
                        MB_OKWARNING);
          exit;
        end;
        if (FTipoAcervos.State = stInsert) and
           (ListBox_TiposTA.Items.IndexOf(Edit_DescricaoTA.Text) > -1) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOTA,CAP_ADESCRICAOTA,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FTipoAcervos.State <> stInsert then
            FTipoAcervos.Edit;
          Post(Self);
          FTipoAcervos.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntTipoAcervos do
      begin
        FTipoAcervos.Cancel;
        Read(Self);
      end;
    end;
  end;

  if Cadastro = 'AA' then {Áreas de Acervo}
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntAreaAcervos, Application do
      begin
        if FAreaAcervos.RecCount = 30 then {maximo de 30 areas de acervo}
        begin
          MessageBox(MSG_MUITOSAA,CAP_MUITOSAA,
                      MB_OKWARNING);
          exit;
        end;
        FAreaAcervos.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntAreaAcervos, Application do
      begin
        if (UpperCase(FAreaAcervos.Registro.Descricao) = 'PORTUGUÊS') or
           (UpperCase(FAreaAcervos.Registro.Descricao) = 'MATEMÁTICA') or
           (UpperCase(FAreaAcervos.Registro.Descricao) = 'ESTUDOS SOCIAIS') or
           (UpperCase(FAreaAcervos.Registro.Descricao) = 'CIÊNCIAS') then
        begin
          MessageBox(MSG_NOEXCLUIRAA,CAP_NOEXCLUIRAA,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRAA,CAP_EXCLUIRAA,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FAreaAcervos.Delete;
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntAreaAcervos,
           IntAreaAcervos.FAreaAcervos.Registro do
      begin
        if (FAreaAcervos.State <> stInsert) and
           ((UpperCase(Descricao) = 'PORTUGUÊS') or
           (UpperCase(Descricao) = 'MATEMÁTICA') or
           (UpperCase(Descricao) = 'CIÊNCIAS') or
           (UpperCase(Descricao) = 'ESTUDOS SOCIAIS')) and
           (Descricao <> Edit_DescricaoAA.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRAA,CAP_NOEXCLUIRAA,
                        MB_OKWARNING);
          exit;
        end;
        if (FAreaAcervos.State = stInsert) and
           (ListBox_TiposAA.Items.IndexOf(Edit_DescricaoAA.Text) > -1) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOAA,CAP_ADESCRICAOAA,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FAreaAcervos.State <> stInsert then
            FAreaAcervos.Edit;
          Post(Self);
          FAreaAcervos.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntAreaAcervos do
      begin
        FAreaAcervos.Cancel;
        Read(Self);
      end;
    end;
  end;

  if Cadastro = 'CA' then {Classificações de Acervo}
  begin
    {Insert}
    if Operacao = 'Insert' then
    begin
      with IntClassificacaoAcervos, Application do
      begin
        if FClassificacaoAcervos.RecCount = 20 then {maximo de 20 class. acervo}
        begin
          MessageBox(MSG_MUITOSCA,CAP_MUITOSCA,
                      MB_OKWARNING);
          exit;
        end;
        FClassificacaoAcervos.Insert;
        Insert(Self);
      end;
    end;
    {Delete}
    if Operacao = 'Delete' then
    begin
      with IntClassificacaoAcervos, Application do
      begin
        if (UpperCase(FClassificacaoAcervos.Registro.Descricao) = 'AVALIAÇÃO') or
           (UpperCase(FClassificacaoAcervos.Registro.Descricao) = 'DIDÁTICO') or
           (UpperCase(FClassificacaoAcervos.Registro.Descricao) = 'RECREAÇÃO') then
        begin
          MessageBox(MSG_NOEXCLUIRCA,CAP_NOEXCLUIRCA,
                      MB_OKWARNING);
          exit;
        end;
        if MessageBox(MSG_EXCLUIRCA,CAP_EXCLUIRCA,
                      MB_YESNOQUESTION) = IDYES then
        begin
          FClassificacaoAcervos.Delete;
          Read(Self);
        end;
      end;
    end;
    {Post}
    if Operacao = 'Post' then
    begin
      with IntClassificacaoAcervos,
           IntClassificacaoAcervos.FClassificacaoAcervos.Registro do
      begin
        if (FClassificacaoAcervos.State <> stInsert) and
           ((UpperCase(Descricao) = 'AVALIAÇÃO') or
           (UpperCase(Descricao) = 'DIDÁTICO') or
           (UpperCase(Descricao) = 'RECREAÇÃO')) and
           (Descricao <> Edit_DescricaoCA.Text) then
        begin
          with Application do
            MessageBox(MSG_NOEXCLUIRCA,CAP_NOEXCLUIRCA,
                        MB_OKWARNING);
          exit;
        end;
        if (FClassificacaoAcervos.State = stInsert) and
           (ListBox_TiposCA.Items.IndexOf(Edit_DescricaoCA.Text) > -1) then
        begin
          with Application do
            MessageBox(MSG_ADESCRICAOCA,CAP_ADESCRICAOCA,
                       MB_OKWARNING);
          exit;
        end;
        if ConsisteDados(Self) then
        begin
          if FClassificacaoAcervos.State <> stInsert then
            FClassificacaoAcervos.Edit;
          Post(Self);
          FClassificacaoAcervos.Post;
          Read(Self);
        end;
      end;
    end;
    {Cancel}
    if Operacao = 'Cancel' then
    begin
      with IntClassificacaoAcervos do
      begin
        FClassificacaoAcervos.Cancel;
        Read(Self);
      end;
    end;
  end;
end;

end.

