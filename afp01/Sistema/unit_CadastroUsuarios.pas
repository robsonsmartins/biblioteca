{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_CadastroUsuarios.pas

  Contém as classes de Interface do Cadastro de Usuários.

  Data última revisão: 24/11/2001

******************************************************************************}

unit unit_CadastroUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables,
  unit_DatabaseClasses, unit_Comum, unit_PesquisaDialog;

{Classe de Interface}
type
  TDataInterface = class {contém métodos para esta Interface}
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FDataClass: TUsuarios;
    FTipoUsuarios: TTipoUsuarios;
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
  end;

{Classe do Form}
type
  Tform_CadastroUsuarios = class(TForm)
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
    ScrollBox_Formulario: TScrollBox;
    Label_TipoUsuario: TLabel;
    Label_RGA: TLabel;
    Label_Nome: TLabel;
    Label_CPF: TLabel;
    Label_RG: TLabel;
    Label_Endereco: TLabel;
    Label_Bairro: TLabel;
    Label_Cidade: TLabel;
    Label_Estado: TLabel;
    Label_CEP: TLabel;
    Label_Telefone: TLabel;
    Label_DataCadastro: TLabel;
    Label_TempoEmprestimo: TLabel;
    Label_TempoSuspensao: TLabel;
    ToolButton_Separator4: TToolButton;
    ToolButton_Fechar: TToolButton;
    ToolButton_Editar: TToolButton;
    ComboBox_TipoUsuario: TComboBox;
    ToolButton_Pesquisar: TToolButton;
    ToolButton_Separator2: TToolButton;
    ToolButton_Separator3: TToolButton;
    ComboBox_Estado: TComboBox;
    Edit_RGA: TEdit;
    Edit_Nome: TEdit;
    Edit_Endereco: TEdit;
    Edit_Bairro: TEdit;
    Edit_Cidade: TEdit;
    Edit_CEP: TEdit;
    Edit_CPF: TEdit;
    Edit_RG: TEdit;
    Edit_DataCadastro: TEdit;
    Edit_TempoEmprestimo: TEdit;
    Edit_TempoSuspensao: TEdit;
    Memo_Telefone: TMemo;
    Edit_MaxExemplares: TEdit;
    Label_MaxExemplares: TLabel;
    DateEdit_Expira: TDateTimePicker;
    CheckBox_Suspenso: TCheckBox;
    Label_Expira: TLabel;
    {Tratadores de Evento}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButtonClick(Sender: TObject);
    procedure ProcurarClick(Sender: TObject);
    procedure EditNumericoChange(Sender: TObject);
    procedure EditLiteralChange(Sender: TObject);
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
  form_CadastroUsuarios: Tform_CadastroUsuarios;

implementation

uses unit_Desktop;

{$R *.DFM}

{-------------------- TDataInterface -----------------------}

constructor TDataInterface.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FDataClass := TUsuarios.Create;
  FTipoUsuarios := TTipoUsuarios.Create;
  {retorna o primeiro registro}
  FDataClass.Refresh;
end;

destructor TDataInterface.Destroy;
begin
  {destrói o objeto da classe de dados}
  FDataClass.Free;
  FTipoUsuarios.Free;
  inherited Destroy;
end;

procedure TDataInterface.LeRegistros(Sender: TObject);
var i: Integer;
begin
  {Lê os campos do registro atual no objeto de dados e atribui aos
   controles da Interface}
  with (Sender as Tform_CadastroUsuarios), FDataClass.Registro do
  begin
    Edit_Nome.Text := Nome;
    Edit_Endereco.Text := Endereco;
    Edit_Bairro.Text := Bairro;
    Edit_Cidade.Text := Cidade;
    Edit_RGA.Text := RGA;
    Edit_RG.Text := RG;
    Edit_CPF.Text := CPF;
    Edit_CEP.Text := CEP;
    Edit_DataCadastro.Text := DateToStr(DataCadastro);
    if Situacao = 'N' then
      CheckBox_Suspenso.Checked := False
    else
      CheckBox_Suspenso.Checked := True;
    DateEdit_Expira.DateTime := DataExpiraSusp;
    with TipoUsuario do
    begin
      Edit_TempoEmprestimo.Text := IntToStr(TempoEmprestimo);
      Edit_TempoSuspensao.Text := IntToStr(TempoSusp);
      Edit_MaxExemplares.Text := IntToStr(MaxExemplares);
      with ComboBox_TipoUsuario do
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
    Memo_Telefone.Lines.Clear;
    Memo_Telefone.Lines.Text := Telefones;
    Memo_Telefone.SelStart := 0;
    Memo_Telefone.SelLength := 0;
    ComboBox_Estado.ItemIndex := 24; {Default: São Paulo}
    for i := 0 to ComboBox_Estado.Items.Count - 1 do
    begin
      if ComboBox_Estado.Items[i] = UFToEstado(Estado) then
      begin
        ComboBox_Estado.ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TDataInterface.Post(Sender: TObject);
begin
  {grava o conteúdo dos controles da Interface nos campos do objeto de dados}
  with (Sender as Tform_CadastroUsuarios), FDataClass.Registro do
  begin
    Nome := Edit_Nome.Text;
    Endereco := Edit_Endereco.Text;
    Bairro := Edit_Bairro.Text;
    Cidade := Edit_Cidade.Text;
    RGA := Edit_RGA.Text;
    RG := Edit_RG.Text;
    CPF := Edit_CPF.Text;
    CEP := Edit_CEP.Text;
    DataCadastro := StrToDate(Edit_DataCadastro.Text);
    if CheckBox_Suspenso.Checked then
      Situacao := 'S'
    else
      Situacao := 'N';
    DataExpiraSusp := DateEdit_Expira.DateTime;
    with TipoUsuario do
    begin
      TempoEmprestimo := StrToInt(Edit_TempoEmprestimo.Text);
      TempoSusp := StrToInt(Edit_TempoSuspensao.Text);
    end;
    Telefones := Memo_Telefone.Lines.Text;
    with ComboBox_Estado do
      Estado := EstadoToUF(Items[ItemIndex]);
    FTipoUsuarios.Refresh;
    with ComboBox_TipoUsuario do
      FTipoUsuarios.LocateDescricao(Items[ItemIndex]);
    TipoUsuario.IdTipoUsuario := FTipoUsuarios.Registro.IdTipoUsuario;
  end;
end;

procedure TDataInterface.Read(Sender: TObject);
begin
  {configura controles para representar modo leitura}
  with (Sender as Tform_CadastroUsuarios), FDataClass do
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
  {lê os tipos de Usuário disponíveis}
  FTipoUsuarios.Refresh;
  with (Sender as Tform_CadastroUsuarios), FTipoUsuarios do
  begin
    with ComboBox_TipoUsuario do
    begin
      Clear;
      for i := 1 to RecCount do
      begin
        GotoReg(i);
        Items.Add(Registro.Descricao);
      end;
    end;
  end;
end;

procedure TDataInterface.Insert(Sender: TObject);
begin
  {configura controles para representar modo Insert}
  with (Sender as Tform_CadastroUsuarios), FDataClass do
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

procedure TDataInterface.Edit(Sender: TObject);
begin
  {configura controles para representar modo Edit}
  with (Sender as Tform_CadastroUsuarios), FDataClass do
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
  with (Sender as Tform_CadastroUsuarios),
       (Sender as Tform_CadastroUsuarios).ComboBox_TipoUsuario do
  begin
    {nome}
    if Edit_Nome.Text = '' then
      ExibeMensagem(Edit_Nome,MSG_NONOME,CAP_NOALL,MB_OKWARNING)
    {endereço}
    else if Edit_Endereco.Text = '' then
      ExibeMensagem(Edit_Endereco,MSG_NOENDERECO,CAP_NOALL,MB_OKWARNING)
    {bairro}
    else if Edit_Bairro.Text = '' then
      ExibeMensagem(Edit_Bairro,MSG_NOBAIRRO,CAP_NOALL,MB_OKWARNING)
    {cidade}
    else if Edit_Cidade.Text = '' then
      ExibeMensagem(Edit_Cidade,MSG_NOCIDADE,CAP_NOALL,MB_OKWARNING)
    {CEP}
    else if Length(Edit_CEP.Text) < 5 then
      ExibeMensagem(Edit_CEP,MSG_NOCEP,CAP_NOALL,MB_OKWARNING)
    {CPF}
    else if (Length(Edit_CPF.Text) > 0) and
            (not ConsisteCPF(Edit_CPF.Text)) then
      ExibeMensagem(Edit_CPF,MSG_NOCPF,CAP_NOALL,MB_OKWARNING)
    {RGA}
    else if (Length(Edit_RGA.Text) = 0) and
            (UpperCase(Items[ItemIndex]) = 'ALUNO') then
      ExibeMensagem(Edit_RGA,MSG_NORGA,CAP_NOALL,MB_OKWARNING)
    else if (DataInterface.FDataClass.Exists(Edit_RGA.Text)) and
            (DataInterface.FDataClass.State <> stEdit) then
      ExibeMensagem(Edit_RGA,MSG_EXISTERGA,CAP_NOALL,MB_OKWARNING)
    else
      Result := True;
  end;
end;

{-------------------- Tform_CadastroUsuarios -----------------------}

{** Tratadores de Evento ***}

procedure Tform_CadastroUsuarios.FormCreate(Sender: TObject);
begin
  {Evento OnCreate do Form}
  {Cria o objeto da classe de Interface}
  DataInterface := TDataInterface.Create;
  DataInterface.ReadTipos(Self);
  ComboBox_TipoUsuario.ItemIndex := 0;
  DataInterface.Read(Self);
  SetAccess(form_Desktop.Direitos.AlterarCadUsuarios);
end;

procedure Tform_CadastroUsuarios.FormDestroy(Sender: TObject);
begin
  {Evento OnDestroy do Form}
  {destrói o objeto da classe de interface}
  DataInterface.Free;
end;

procedure Tform_CadastroUsuarios.FormCloseQuery(Sender: TObject;
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

procedure Tform_CadastroUsuarios.ToolButtonClick(Sender: TObject);
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

procedure Tform_CadastroUsuarios.ProcurarClick(Sender: TObject);
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
      if FieldTxt = 'Nome' then
        FieldTxt := 'U.NOME'
      else if FieldTxt = 'Endereço' then
        FieldTxt := 'U.ENDERECO'
      else if FieldTxt = 'Bairro' then
        FieldTxt := 'U.BAIRRO'
      else if FieldTxt = 'Cidade' then
        FieldTxt := 'U.CIDADE'
      else if FieldTxt = 'Estado' then
        FieldTxt := 'U.ESTADO'
      else if FieldTxt = 'CEP' then
        FieldTxt := 'U.CEP'
      else if FieldTxt = 'RGA' then
        FieldTxt := 'U.RGA'
      else if FieldTxt = 'RG' then
        FieldTxt := 'U.RG'
      else if FieldTxt = 'CPF' then
        FieldTxt := 'U.CPF'
      else if FieldTxt = 'Data_de_Cadastro' then
        FieldTxt := 'U.DATACADASTRO'
      else if FieldTxt = 'Tipo_de_Usuário' then
        FieldTxt := 'T.DESCRICAO';
      if Edit_Pesquisa.Text <> '' then
      begin
        if (FieldTxt = 'U.ESTADO') and (Length(Edit_Pesquisa.Text) > 2) then
          FieldTxt :=
            FieldTxt + ' LIKE ' + #39 + '%' +
            EstadoToUF(Edit_Pesquisa.Text) + '%' + #39
        else
        begin
          if FieldTxt = 'U.DATACADASTRO' then
            FieldTxt :=
              FieldTxt + ' LIKE ' + #39 + Edit_Pesquisa.Text + #39
          else
            FieldTxt :=
              FieldTxt + ' LIKE ' + #39 + '%' + Edit_Pesquisa.Text + '%' + #39;
        end;
      end
      else
        FieldTxt := '';
      {executa busca na Classe de Dados}
      Search(ADODataSet_Resultado,FieldTxt);
    end;
  end;
end;

procedure Tform_CadastroUsuarios.EditNumericoChange(Sender: TObject);
begin
  {Evento OnChange dos TEdit numéricos}
  {chama rotina (unit_Comum) que faz consistência on-line do campo}
  ConsisteNumerico(Sender);
end;

procedure Tform_CadastroUsuarios.EditLiteralChange(Sender: TObject);
begin
  {Evento OnChange dos TEdit literais}
  {chama rotina (unit_Comum) que faz consistência on-line do campo}
  ConsisteLiteral(Sender);
end;

{** Métodos ***}

procedure Tform_CadastroUsuarios.SetAccess(Value: Boolean);
begin
  {Configura controles de acordo com a propriedade AccessRW}
  FAccessRW := Value;
  ToolButton_Novo.Visible := FAccessRW;
  ToolButton_Editar.Visible := FAccessRW;
  ToolButton_Excluir.Visible := FAccessRW;
  ToolButton_Cancelar.Visible := FAccessRW;
  ToolButton_Gravar.Visible := FAccessRW;
end;

procedure Tform_CadastroUsuarios.GotoRecord(Onde: String);
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

procedure Tform_CadastroUsuarios.ExecutaRecord(Operacao: String);
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
      if MessageBox(MSG_EXCLUIRUSUARIO,CAP_EXCLUIRUSUARIO,
                    MB_YESNOQUESTION) = IDYES then
      begin
        FDataClass.Delete;
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
        Post(Self);
        FDataClass.Post;
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

procedure Tform_CadastroUsuarios.Pesquisar;
var idx, idxold: Integer;
begin
  {Exibe o form e executa a pesquisa de registros}
  form_PesquisaDialog := Tform_PesquisaDialog.Create(Self);
  with form_PesquisaDialog do
  begin
    Caption := 'Pesquisa de Usuários';
    {Adiciona campos para pesquisa}
    with ComboBox_Campo.Items do
    begin
      Clear;
      Add('Nome');
      Add('Endereço');
      Add('Bairro');
      Add('Cidade');
      Add('Estado');
      Add('CEP');
      Add('RGA');
      Add('RG');
      Add('CPF');
      Add('Data_de_Cadastro');
      Add('Tipo_de_Usuário');
      ComboBox_Campo.ItemIndex := 0;
    end;
    {associa evento OnClick do botão Procurar ao tratador ProcurarClick}
    btn_Procurar.OnClick := Self.ProcurarClick;
    {executa método search da Classe de Dados}
    DataInterface.FDataClass.Search(ADODataSet_Resultado,'');
    idxold := DataInterface.FDataClass.Registro.IdUsuario;
    {executa método search do PesquisaDialog}
    idx := Search;
    {posiciona registro}
    if idx >= 0 then
      DataInterface.FDataClass.LocateId(idx)
    else
      DataInterface.FDataClass.LocateId(idxold);
    DataInterface.Read(Self);
    Free;
  end;
end;

end.
