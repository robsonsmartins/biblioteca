{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_CadastroAcervo.pas

  Contém as classes de Interface do Cadastro de Acervo.

  Data última revisão: 24/11/2001

******************************************************************************}

unit unit_CadastroAcervo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables,
  unit_DataBaseClasses;

{Classe de Interface}
type
  TDataInterface = class {contém métodos para esta Interface}
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FDataClass: TAcervos;
    FTipoAcervos: TTipoAcervos;
    FAreaAcervos: TAreaAcervos;
    FClassificacaoAcervos: TClassificacaoAcervos;
    FFornecedores: TFornecedores;
    Exemplares: TExemplares;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject);
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    {Configura objetos de Interface para modo leitura}
    procedure Read(Sender: TObject);
    procedure ReadTipos(Sender: TObject);
    {Configura objetos de Interface para modo inserir}
    procedure Insert(Sender: TObject);
    {Configura objetos de Interface para modo editar}
    procedure Edit(Sender: TObject);
    {Configura objetos de Interface para modo leitura / após um Post}
    procedure Post(Sender: TObject);
    {Faz consistência dos dados digitados}
    function ConsisteDados(Sender: TObject): Boolean;
    {Exibe uma mensagem e dá foco ao controle}
    procedure ExibeMensagem(Controle: TWinControl;
                            Mensagem, Caption: String; Flags: Longint);
    function SituacaoToStr(Situacao: Char): String;
    function StrToSituacao(SitStr: String): Char;
  end;

{Classe do Form}
type
  Tform_CadastroAcervo = class(TForm)
    ScrollBox_Formulario: TScrollBox;
    Label_TipoAcervo: TLabel;
    Label_Titulo: TLabel;
    Label_Edicao: TLabel;
    Label_Ano: TLabel;
    Label_Autor: TLabel;
    Label_Editora: TLabel;
    Label_Colecao: TLabel;
    Label_Volume: TLabel;
    Label_Paginas: TLabel;
    Label_Assunto: TLabel;
    Label_Area: TLabel;
    Label_Fornecedor: TLabel;
    Label_Localizacao: TLabel;
    Label_Classificacao: TLabel;
    btn_Adicionar: TBitBtn;
    btn_Remover: TBitBtn;
    Label_Etaria: TLabel;
    Label_EtariaDe: TLabel;
    Label_EtariaAnosDe: TLabel;
    Label_EtariaAte: TLabel;
    Label_EtariaAnosAte: TLabel;
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
    Edit_Tombo: TEdit;
    Label_Tombo: TLabel;
    Panel_Etaria: TPanel;
    ComboBox_TipoAcervo: TComboBox;
    ComboBox_Area: TComboBox;
    ComboBox_Classificacao: TComboBox;
    ComboBox_Fornecedor: TComboBox;
    Edit_Titulo: TEdit;
    Edit_Autor: TEdit;
    Edit_Editora: TEdit;
    Edit_Colecao: TEdit;
    Edit_Volume: TEdit;
    Edit_Edicao: TEdit;
    Edit_Ano: TEdit;
    Edit_Paginas: TEdit;
    Edit_Assunto: TEdit;
    Edit_Localizacao: TEdit;
    Edit_DeEtaria: TEdit;
    Edit_AteEtaria: TEdit;
    Label_DataCadastro: TLabel;
    Edit_DataCadastro: TEdit;
    Panel_Exemplares: TPanel;
    Label_Exemplares: TLabel;
    ListView_Exemplares: TListView;
    {Tratadores de Evento}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButtonClick(Sender: TObject);
    procedure ProcurarClick(Sender: TObject);
    procedure EditNumericoChange(Sender: TObject);
    procedure EditLiteralChange(Sender: TObject);
    procedure btn_AdicionarClick(Sender: TObject);
    procedure btn_RemoverClick(Sender: TObject);
    procedure ListView_ExemplaresClick(Sender: TObject);
    procedure Edit_TomboKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    {Classe de Interface usada}
    DataInterface: TDataInterface;
    FAccessRW: Boolean;
    {Métodos para funcionalidade}
    procedure GotoRecord(Onde: String);
    procedure ExecutaRecord(Operacao: String);
    procedure Pesquisar;
    {Métodos para atribuição de propriedades}
    procedure SetAccess(Value: Boolean);
  public
    { Public declarations }
    {propriedades visíveis}
    {Configura controles de acordo com o nível de acesso}
    property AccessRW: Boolean read FAccessRW write SetAccess;
  end;

var
  form_CadastroAcervo: Tform_CadastroAcervo;

implementation

uses unit_Desktop, unit_PesquisaDialog, unit_Comum;

{$R *.DFM}

{-------------------- TDataInterface -----------------------}

constructor TDataInterface.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FDataClass := TAcervos.Create;
  FTipoAcervos := TTipoAcervos.Create;
  FAreaAcervos := TAreaAcervos.Create;
  FClassificacaoAcervos := TClassificacaoAcervos.Create;
  FFornecedores := TFornecedores.Create;
  {retorna o primeiro registro}
  FDataClass.Refresh;
end;

destructor TDataInterface.Destroy;
begin
  {destrói o objeto da classe de dados}
  FDataClass.Free;
  FTipoAcervos.Free;
  FAreaAcervos.Free;
  FClassificacaoAcervos.Free;
  FFornecedores.Free;
  inherited Destroy;
end;

procedure TDataInterface.LeRegistros(Sender: TObject);
var i: Integer;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroAcervo), FDataClass, FDataClass.Registro do
  begin
    Edit_Titulo.Text := Titulo;
    Edit_Autor.Text := Autor;
    Edit_Editora.Text := Editora;
    Edit_Colecao.Text := Colecao;
    Edit_Volume.Text := IntToStr(Volume);
    Edit_Edicao.Text := IntToStr(Edicao);
    Edit_Ano.Text := IntToStr(Ano);
    Edit_Paginas.Text := IntToStr(Paginas);
    Edit_Assunto.Text := Assunto;
    Edit_DeEtaria.Text := Copy(FaixaEtaria,1,2);
    Edit_AteEtaria.Text := Copy(FaixaEtaria,3,2);
    Edit_Localizacao.Text := Localizacao;
    with TipoAcervo do
    begin
      with ComboBox_TipoAcervo do
      begin
        ItemIndex := 0;
        for i := 0 To Items.Count - 1 do
        begin
          if Items[i] = Descricao then
          begin
            ItemIndex := i;
            break;
          end;
        end;
      end;
    end;
    with AreaAcervo do
    begin
      with ComboBox_Area do
      begin
        ItemIndex := 0;
        for i := 0 To Items.Count - 1 do
        begin
          if Items[i] = Descricao then
          begin
            ItemIndex := i;
            break;
          end;
        end;
      end;
    end;
    with ClassificacaoAcervo do
    begin
      with ComboBox_Classificacao do
      begin
        ItemIndex := 0;
        for i := 0 To Items.Count - 1 do
        begin
          if Items[i] = Descricao then
          begin
            ItemIndex := i;
            break;
          end;
        end;
      end;
    end;
    with Fornecedor do
    begin
      with ComboBox_Fornecedor do
      begin
        ItemIndex := 0;
        for i := 0 To Items.Count - 1 do
        begin
          if Items[i] = Nome then
          begin
            ItemIndex := i;
            break;
          end;
        end;
      end;
    end;
    Edit_DataCadastro.Text := DateToStr(DataCadastro);
    GetExemplares(Exemplares);
    with ListView_Exemplares do
    begin
      Items.Clear;
      for i := 0 to Length(Exemplares) - 1 do
      begin
        with Items.Add do
        begin
          Caption := IntToStr(Exemplares[i].Tombo);
          ImageIndex := 11;
          SubItems.Add(SituacaoToStr(Exemplares[i].Situacao));
        end;
      end;
      Selected := Items.Item[0];
      if Items.Count > 0 then
        Edit_Tombo.Text := Items.Item[0].Caption;
    end;
  end;
end;

procedure TDataInterface.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroAcervo), FDataClass.Registro do
  begin
    Titulo := Edit_Titulo.Text;
    Autor := Edit_Autor.Text;
    Editora := Edit_Editora.Text;
    Colecao := Edit_Colecao.Text;
    Volume := StrToInt(Edit_Volume.Text);
    Edicao := StrToInt(Edit_Edicao.Text);
    Assunto := Edit_Assunto.Text;
    Localizacao := Edit_Localizacao.Text;
    if Edit_Ano.Text = '' then
      Ano := 2001
    else
      Ano := StrToInt(Edit_Ano.Text);
    if Edit_Paginas.Text = '' then
      Paginas := 0
    else
      Paginas := StrToInt(Edit_Paginas.Text);
    FaixaEtaria := Edit_DeEtaria.Text;
    if Length(FaixaEtaria) = 0 then
      FaixaEtaria := '00'
    else if Length(FaixaEtaria) = 1 then
      FaixaEtaria := '0' + FaixaEtaria;
    FaixaEtaria := FaixaEtaria + Edit_AteEtaria.Text;
    if Length(FaixaEtaria) = 2 then
      FaixaEtaria := FaixaEtaria + '00'
    else if Length(FaixaEtaria) = 3 then
      FaixaEtaria := Copy(FaixaEtaria,1,2) + '0' + Copy(FaixaEtaria,3,1);

    FTipoAcervos.Refresh;
    with ComboBox_TipoAcervo do
      FTipoAcervos.LocateDescricao(Items[ItemIndex]);
    TipoAcervo.IdTipoAcervo :=
      FTipoAcervos.Registro.IdTipoAcervo;
    FAreaAcervos.Refresh;
    with ComboBox_Area do
      FAreaAcervos.LocateDescricao(Items[ItemIndex]);
    AreaAcervo.IdArea :=
      FAreaAcervos.Registro.IdArea;
    FClassificacaoAcervos.Refresh;
    with ComboBox_Classificacao do
      FClassificacaoAcervos.LocateDescricao(Items[ItemIndex]);
    ClassificacaoAcervo.IdClassificacao :=
      FClassificacaoAcervos.Registro.IdClassificacao;
    FFornecedores.Refresh;
    with ComboBox_Fornecedor do
      FFornecedores.LocateNome(Items[ItemIndex]);
    Fornecedor.IdFornec :=
      FFornecedores.Registro.IdFornec;
  end;
end;

procedure TDataInterface.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroAcervo), FDataClass do
  begin
    ScrollBox_Formulario.Enabled := False;
    ToolButton_Primeiro.Enabled := not (Bof or (RecCount <= 0));
    ToolButton_Anterior.Enabled := not (Bof or (RecCount <= 0));
    ToolButton_Ultimo.Enabled := not (Eof or (RecCount <= 0));
    ToolButton_Proximo.Enabled := not (Eof or (RecCount <= 0));
    ToolButton_Pesquisar.Enabled := (RecCount > 0);
    ToolButton_Novo.Enabled := True;
    ToolButton_Editar.Enabled := (RecCount > 0);
    ToolButton_Excluir.Enabled := (RecCount > 0);
    ToolButton_Gravar.Enabled := False;
    ToolButton_Cancelar.Enabled := False;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TDataInterface.ReadTipos(Sender: TObject);
var i: Integer;
begin
  {lê os tipos de Acervo disponíveis}
  FTipoAcervos.Refresh;
  with (Sender as Tform_CadastroAcervo), FTipoAcervos do
  begin
    with ComboBox_TipoAcervo do
    begin
      Clear;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        Items.Add(Registro.Descricao);
      end;
    end;
  end;
  FAreaAcervos.Refresh;
  with (Sender as Tform_CadastroAcervo), FAreaAcervos do
  begin
    with ComboBox_Area do
    begin
      Clear;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        Items.Add(Registro.Descricao);
      end;
    end;
  end;
  FClassificacaoAcervos.Refresh;
  with (Sender as Tform_CadastroAcervo), FClassificacaoAcervos do
  begin
    with ComboBox_Classificacao do
    begin
      Clear;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        Items.Add(Registro.Descricao);
      end;
    end;
  end;
  FFornecedores.Refresh;
  with (Sender as Tform_CadastroAcervo), FFornecedores do
  begin
    with ComboBox_Fornecedor do
    begin
      Clear;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        Items.Add(Registro.Nome);
      end;
    end;
  end;
end;

procedure TDataInterface.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroAcervo), FDataClass do
  begin
    ScrollBox_Formulario.Enabled := True;
    ToolButton_Primeiro.Enabled := False;
    ToolButton_Anterior.Enabled := False;
    ToolButton_Ultimo.Enabled := False;
    ToolButton_Proximo.Enabled := False;
    ToolButton_Pesquisar.Enabled := False;
    ToolButton_Novo.Enabled := False;
    ToolButton_Editar.Enabled := False;
    ToolButton_Excluir.Enabled := False;
    ToolButton_Gravar.Enabled := True;
    ToolButton_Cancelar.Enabled := True;
    Edit_Tombo.Text := '';
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TDataInterface.Edit(Sender: TObject);
begin
  {configura controles para representar modo Edit}
  with (Sender as Tform_CadastroAcervo), FDataClass do
  begin
    ScrollBox_Formulario.Enabled := True;
    ToolButton_Primeiro.Enabled := False;
    ToolButton_Anterior.Enabled := False;
    ToolButton_Ultimo.Enabled := False;
    ToolButton_Proximo.Enabled := False;
    ToolButton_Pesquisar.Enabled := False;
    ToolButton_Novo.Enabled := False;
    ToolButton_Editar.Enabled := False;
    ToolButton_Excluir.Enabled := False;
    ToolButton_Gravar.Enabled := True;
    ToolButton_Cancelar.Enabled := True;
  end;
  {lê os campos do registro atual no objeto de dados}
  LeRegistros(Sender);
end;

procedure TDataInterface.ExibeMensagem(Controle: TWinControl;
                         Mensagem, Caption: String; Flags: Longint);
begin
  {exibe um messagebox e dá foco no Controle}
  with Application do
    MessageBox(PChar(Mensagem),PChar(Caption),Flags);
  with Controle do
    if Enabled and Visible then
      SetFocus;
end;

function TDataInterface.ConsisteDados(Sender: TObject): Boolean;
begin
  {consiste os dados que estão nos controles}
  Result := False;
  with (Sender as Tform_CadastroAcervo),
       (Sender as Tform_CadastroAcervo).ComboBox_Fornecedor do
  begin
    {titulo}
    if Edit_Titulo.Text = '' then
      ExibeMensagem(Edit_Titulo,MSG_NOTITULO,CAP_NOALL,MB_OKWARNING)
    {autor}
    else if Edit_Autor.Text = '' then
      ExibeMensagem(Edit_Autor,MSG_NOAUTOR,CAP_NOALL,MB_OKWARNING)
    {editora}
    else if Edit_Editora.Text = '' then
      ExibeMensagem(Edit_Editora,MSG_NOEDITORA,CAP_NOALL,MB_OKWARNING)
    {edicao}
    else if Edit_Edicao.Text = '' then
      ExibeMensagem(Edit_Edicao,MSG_NOEDICAO,CAP_NOALL,MB_OKWARNING)
    {exemplares}
    else if ListView_Exemplares.Items.Count = 0 then
      ExibeMensagem(Edit_Tombo,MSG_NOEXEMPLARES,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

function TDataInterface.SituacaoToStr(Situacao: Char): String;
begin
  if Situacao = 'D' then
    Result := 'Disponível'
  else if Situacao = 'E' then
    Result := 'Emprestado'
  else if Situacao = 'P' then
    Result := 'Perdido'
  else
    Result := 'Indefinido';
end;

function TDataInterface.StrToSituacao(SitStr: String): Char;
begin
  if SitStr = 'Disponível' then
    Result := 'D'
  else if SitStr = 'Emprestado' then
    Result := 'E'
  else if SitStr = 'Perdido' then
    Result := 'P'
  else
    Result := 'I';
end;

{-------------------- Tform_CadastroAcervo -----------------------}

{** Tratadores de Evento ***}

procedure Tform_CadastroAcervo.FormCreate(Sender: TObject);
begin
  {Evento OnCreate do Form}
  {Cria o objeto da classe de Interface}
  DataInterface := TDataInterface.Create;
  DataInterface.ReadTipos(Self);
  ComboBox_TipoAcervo.ItemIndex := 0;
  ComboBox_Area.ItemIndex := 0;
  ComboBox_Classificacao.ItemIndex := 0;
  ComboBox_Fornecedor.ItemIndex := 0;
  DataInterface.Read(Self);
  SetAccess(form_Desktop.Direitos.AlterarCadAcervo);
end;

procedure Tform_CadastroAcervo.FormDestroy(Sender: TObject);
begin
  {Evento OnDestroy do Form}
  {destrói o objeto da classe de interface}
  DataInterface.Free;
end;

procedure Tform_CadastroAcervo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {Evento OnCloseQuery do Form}
  {Não permite que a janela se feche se está em operação <> stRead}
  if DataInterface.FDataClass.State <> stRead then
  begin
    with Application do
      MessageBox(MSG_FORMOPEN,CAP_FORMOPEN,MB_OKWARNING);
    CanClose := False;
  end;
end;

procedure Tform_CadastroAcervo.ToolButtonClick(Sender: TObject);
var NomeBotao: String;
begin
  {OnClick de todos os botões do ToolBar}
  {Executa a operação conforme o nome do botão}
  NomeBotao := (Sender as TToolButton).Name;
  if NomeBotao = 'ToolButton_Ultimo' then
    GotoRecord('Last')
  else if NomeBotao = 'ToolButton_Proximo' then
    GotoRecord('Next')
  else if NomeBotao = 'ToolButton_Anterior' then
    GotoRecord('Prior')
  else if NomeBotao = 'ToolButton_Primeiro' then
    GotoRecord('First')
  else if NomeBotao = 'ToolButton_Novo' then
    ExecutaRecord('Insert')
  else if NomeBotao = 'ToolButton_Excluir' then
    ExecutaRecord('Delete')
  else if NomeBotao = 'ToolButton_Gravar' then
    ExecutaRecord('Post')
  else if NomeBotao = 'ToolButton_Cancelar' then
    ExecutaRecord('Cancel')
  else if NomeBotao = 'ToolButton_Editar' then
    ExecutaRecord('Edit')
  else if NomeBotao = 'ToolButton_Pesquisar' then
    ExecutaRecord('Search')
  else if NomeBotao = 'ToolButton_Fechar' then
    ExecutaRecord('Close Form');
end;

procedure Tform_CadastroAcervo.ProcurarClick(Sender: TObject);
var FieldTxt: String;
begin
  {tratador de evento do OnClick do botão "Procurar" no form de pesquisa}
  with form_PesquisaDialog do
  begin
    with DataInterface.FDataClass do
    begin
      {pesquisa a keyword nos registros da classe de dados}
      with form_PesquisaDialog.ComboBox_Campo do
        FieldTxt := Items[ItemIndex];
      {seleciona o campo a ser pesquisado}
      if FieldTxt = 'Título' then
        FieldTxt := 'A.TITULO'
      else if FieldTxt = 'Autor' then
        FieldTxt := 'A.AUTOR'
      else if FieldTxt = 'Assunto' then
        FieldTxt := 'A.ASSUNTO'
      else if FieldTxt = 'Localização' then
        FieldTxt := 'A.LOCALIZACAO'
      else if FieldTxt = 'Data_de_Cadastro' then
        FieldTxt := 'A.DATACADASTRO'
      else if FieldTxt = 'Tipo_de_Acervo' then
        FieldTxt := 'T.DESCRICAO'
      else if FieldTxt = 'Área_de_Acervo' then
        FieldTxt := 'TA.DESCRICAO'
      else if FieldTxt = 'Classificação_de_Acervo' then
        FieldTxt := 'TC.DESCRICAO'
      else if FieldTxt = 'Tombo' then
        FieldTxt := 'A.TOMBO';
      if Edit_Pesquisa.Text <> '' then
      begin
        if FieldTxt = 'A.DATACADASTRO' then
          FieldTxt :=
            FieldTxt + ' LIKE ' + #39 + Edit_Pesquisa.Text + #39
        else
          FieldTxt :=
            FieldTxt + ' LIKE ' + #39 + '%' + Edit_Pesquisa.Text + '%' + #39;
      end
      else
        FieldTxt := '';
      {executa busca na Classe de Dados}
      Search(ADODataSet_Resultado,FieldTxt);
    end;
  end;
end;

procedure Tform_CadastroAcervo.EditNumericoChange(Sender: TObject);
begin
  {Evento OnChange dos TEdit numéricos}
  {chama rotina (unit_Comum) que faz consistência on-line do campo}
  ConsisteNumerico(Sender);
end;

procedure Tform_CadastroAcervo.EditLiteralChange(Sender: TObject);
begin
  {Evento OnChange dos TEdit literais}
  {chama rotina (unit_Comum) que faz consistência on-line do campo}
  ConsisteLiteral(Sender);
end;

{** Métodos ***}

procedure Tform_CadastroAcervo.SetAccess(Value: Boolean);
begin
  {Configura controles de acordo com a propriedade AccessRW}
  FAccessRW := Value;
  ToolButton_Novo.Visible := FAccessRW;
  ToolButton_Editar.Visible := FAccessRW;
  ToolButton_Excluir.Visible := FAccessRW;
  ToolButton_Cancelar.Visible := FAccessRW;
  ToolButton_Gravar.Visible := FAccessRW;
end;

procedure Tform_CadastroAcervo.GotoRecord(Onde: String);
begin
  {Executa movimentação nos registros}
  {Last}
  if (Onde = 'Last') or (Onde = 'Next') then
  begin
    ToolButton_Primeiro.Enabled := True;
    ToolButton_Anterior.Enabled := True;
  end;
  if Onde = 'Last' then
  begin
    ToolButton_Proximo.Enabled := False;
    ToolButton_Ultimo.Enabled := False;
    with DataInterface do
      FDataClass.Last;
  end;
  {Next}
  if Onde = 'Next' then
  begin
    with DataInterface do
      FDataClass.Next;
  end;
  {Prior}
  if (Onde = 'Prior') or (Onde = 'First') then
  begin
    ToolButton_Proximo.Enabled := True;
    ToolButton_Ultimo.Enabled := True;
  end;
  if Onde = 'Prior' then
  begin
    with DataInterface do
      FDataClass.Prior;
  end;
  {First}
  if Onde = 'First' then
  begin
    ToolButton_Primeiro.Enabled := False;
    ToolButton_Anterior.Enabled := False;
    with DataInterface do
      FDataClass.First;
  end;
  {Todos}
  with DataInterface do
    Read(Self);
end;

procedure Tform_CadastroAcervo.ExecutaRecord(Operacao: String);
var i, id: Integer;
begin
  {Executa operações com os registros}
  {Insert}
  if Operacao = 'Insert' then
  begin
    with DataInterface do
    begin
      ReadTipos(Self);
      FDataClass.Insert;
      Insert(Self);
    end;
  end;
  {Edit}
  if Operacao = 'Edit' then
  begin
    with DataInterface do
    begin
      ReadTipos(Self);
      FDataClass.Edit;
      Edit(Self);
    end;
  end;
  {Delete}
  if Operacao = 'Delete' then
  begin
    with DataInterface, Application do
    begin
      if MessageBox(MSG_EXCLUIRACERVO,CAP_EXCLUIRACERVO,
                    MB_YESNOQUESTION) = IDYES then
      begin
        id := FDataClass.RecNo;
        FDataClass.GetExemplares(Exemplares);
        FDataClass.BeginTrans;
        for i := 0 to Length(Exemplares) - 1 do
        begin
          if FDataClass.InTransaction then
          begin
            FDataClass.Registro.Tombo := Exemplares[i].Tombo;
            FDataClass.Delete;
          end
          else
            break;
        end;
        FDataClass.CommitTrans;
        if id = 0 then
          FDataClass.GotoReg(1)
        else
          FDataClass.GotoReg(id - 1);
        Read(Self);
      end;
    end;
  end;
  {Post}
  if Operacao = 'Post' then
  begin
    with DataInterface do
    begin
      if ConsisteDados(Self) then
      begin
        FDataClass.GetExemplares(Exemplares);
        {apaga todos}
        FDataClass.BeginTrans;
        for i := 0 to Length(Exemplares) - 1 do
        begin
          with ListView_Exemplares, Exemplares[i] do
          begin
            if FDataClass.InTransaction then
            begin
              FDataClass.State := stRead;
              FDataClass.Registro.Tombo := Tombo;
              FDataClass.Delete;
            end
            else
              break;
          end;
        end;
        {faz insert}
        with ListView_Exemplares do
        begin
          for i := 0 to Items.Count - 1  do
          begin
            if FDataClass.InTransaction then
            begin
              Post(Self);
              FDataClass.State := stInsert;
              FDataClass.Registro.Tombo := StrToInt(Items.Item[i].Caption);
              FDataClass.Registro.Situacao :=
                StrToSituacao(Items.Item[i].SubItems.Strings[0]);
              FDataClass.Post;
            end
            else
              break;
          end;
        end;
        FDataClass.CommitTrans;
        id := FDataClass.Registro.Tombo;
        FDataClass.Refresh;
        FDataClass.Read;
        FDataClass.LocateTombo(id);
        Read(Self);
      end;
    end;
  end;
  {Cancel}
  if Operacao = 'Cancel' then
  begin
    with DataInterface do
    begin
      FDataClass.Cancel;
      Read(Self);
    end;
  end;
  {Search}
  if Operacao = 'Search' then
    Pesquisar;
  {Close Form}
  if Operacao = 'Close Form' then
    Close;
end;

procedure Tform_CadastroAcervo.Pesquisar;
var idx, idxold: Integer;
begin
  {Exibe o form e executa a pesquisa de registros}
  form_PesquisaDialog := Tform_PesquisaDialog.Create(Self);
  with form_PesquisaDialog do
  begin
    Caption := 'Pesquisa de Acervo';
    {Adiciona campos para pesquisa}
    with ComboBox_Campo.Items do
    begin
      Clear;
      Add('Título');
      Add('Autor');
      Add('Assunto');
      Add('Localização');
      Add('Data_de_Cadastro');
      Add('Tipo_de_Acervo');
      Add('Área_de_Acervo');
      Add('Classificação_de_Acervo');
      Add('Tombo');
      ComboBox_Campo.ItemIndex := 0;
    end;
    {associa evento OnClick do botão Procurar ao tratador ProcurarClick}
    btn_Procurar.OnClick := Self.ProcurarClick;
    {executa método search da Classe de Dados}
    DataInterface.FDataClass.Search(ADODataSet_Resultado,'');
    DataInterface.FDataClass.GetExemplares(DataInterface.Exemplares);
    idxold := DataInterface.Exemplares[0].Tombo;
    {executa método search do PesquisaDialog}
    idx := Search;
    {posiciona registro}
    if idx >= 0 then
      DataInterface.FDataClass.LocateTombo(idx)
    else
      DataInterface.FDataClass.LocateTombo(idxold);
    DataInterface.Read(Self);
    Free;
  end;
end;

procedure Tform_CadastroAcervo.btn_AdicionarClick(Sender: TObject);
begin
  if Edit_Tombo.Text = '' then
  begin
    Application.MessageBox(MSG_NOTOMBO,CAP_NOTOMBO,MB_OKWARNING);
    exit;
  end;
  with ListView_Exemplares do
  begin
    if (DataInterface.FDataClass.Exists(StrToInt(Edit_Tombo.Text))) or
       (FindCaption(0,Edit_Tombo.Text,False,True,False) <> nil) then
    begin
      Application.MessageBox(MSG_ATOMBO,CAP_ATOMBO,MB_OKWARNING);
      exit;
    end;
    with Items.Add do
    begin
      Caption := Edit_Tombo.Text;
      ImageIndex := 11;
      SubItems.Add('Disponível');
    end;
    Selected := nil;
    Edit_Tombo.Text := '';
    Edit_Tombo.SetFocus; 
  end;
end;

procedure Tform_CadastroAcervo.btn_RemoverClick(Sender: TObject);
begin
  with ListView_Exemplares do
  begin
    if Items.Count = 1 then
    begin
      Application.MessageBox(MSG_DTOMBO,CAP_DTOMBO,MB_OKWARNING);
      exit;
    end;
    with Application do
      if MessageBox(MSG_EXCTOMBO,CAP_EXCTOMBO,MB_YESNOQUESTION) = IDYES then
        Selected.Delete;
  end;
end;

procedure Tform_CadastroAcervo.ListView_ExemplaresClick(Sender: TObject);
begin
  Edit_Tombo.Text := ListView_Exemplares.Selected.Caption;
end;

procedure Tform_CadastroAcervo.Edit_TomboKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btn_Adicionar.SetFocus;
    Key := #27;
  end;
end;

end.
