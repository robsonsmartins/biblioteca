{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_BibliotecaExplorer.pas

  Contém as classes de Interface do "Explorar Biblioteca".

  Data última revisão: 07/12/2001

******************************************************************************}

unit unit_BibliotecaExplorer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ImgList, ToolWin, Menus,
  unit_DataBaseClasses, StdCtrls, Variants;

{Classe de Interface}
type
  TDataInterface = class {contém métodos para esta Interface}
  private
    { Private declarations }
    {Classes de Dados utilizadas nesta Interface}
    FDataClass: TAcervosEx;
    FClasseAcervos: TClasseAcervos;
    AcervoIndex: Integer;
    Exemplares: TExemplares;
    MovData: TMovData;
    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    procedure Read(Sender: TObject);
    procedure ReadAcervo(Sender: TObject);
    procedure ReadExemplares(Sender: TObject);
    procedure WriteDetalhes(Sender: TObject);
    function SituacaoToStr(Situacao: Char): String;
    function StrToSituacao(SitStr: String): Char;
  end;

{Classe do Form}
type
  Tform_BibliotecaExplorer = class(TForm)
    ImageList_Explorer: TImageList;
    TreeView_Classes: TTreeView;
    Splitter_Vertical: TSplitter;
    StatusBar_Explorer: TStatusBar;
    ListView_Acervo: TListView;
    Splitter_Horizontal: TSplitter;
    ListView_Exemplares: TListView;
    ToolBar_Principal: TToolBar;
    btn_Emprestar: TToolButton;
    btn_Devolver: TToolButton;
    btn_Reservar: TToolButton;
    btn_Perdido: TToolButton;
    btn_Fechar: TToolButton;
    ToolButton_Separator: TToolButton;
    ToolButton_Separator2: TToolButton;
    Splitter_Detalhes: TSplitter;
    Memo_Detalhes: TMemo;
    btn_Atualizar: TToolButton;
    Timer_Bar: TTimer;
    btn_Procurar: TToolButton;
    procedure Emprestar1Click(Sender: TObject);
    procedure Reservar1Click(Sender: TObject);
    procedure MoverparaAcervoPerdido1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeView_ClassesChange(Sender: TObject; Node: TTreeNode);
    procedure ListView_AcervoChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btn_AtualizarClick(Sender: TObject);
    procedure ListView_ExemplaresChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btn_DevolverClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure btn_ProcurarClick(Sender: TObject);
    procedure ProcurarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataInterface: TDataInterface;
  end;

var
  form_BibliotecaExplorer: Tform_BibliotecaExplorer;

implementation

uses unit_RetiradaDialog, unit_ReservaDialog, unit_AcervoPerdidoDialog,
     unit_Desktop, unit_Comum, unit_PesquisaDialog;

{$R *.DFM}

{-------------------- TDataInterface -----------------------}

constructor TDataInterface.Create;
begin
  {Instancia um objeto da Classe de Dados}
  inherited Create;
  FDataClass := TAcervosEx.Create;
  FClasseAcervos := TClasseAcervos.Create;
  MovData := TMovData.Create;
  {retorna o primeiro registro}
  FDataClass.Refresh;
  AcervoIndex := -1;
end;

destructor TDataInterface.Destroy;
begin
  {destrói o objeto da classe de dados}
  FDataClass.Free;
  FClasseAcervos.Free;
  MovData.Free; 
  inherited Destroy;
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

procedure TDataInterface.Read(Sender: TObject);
var Node, Node2: TTreeNode;
    i,j: Integer;
    JaTem: Integer;
begin
  with (Sender as Tform_BibliotecaExplorer) do
  begin
    with TreeView_Classes.Items, FClasseAcervos do
    begin
      Clear;
      Refresh;
      for i := 1 to RecCount  do
      begin
        GotoReg(i);
        JaTem := -1;
        for j := 0 to Count - 1 do
        begin
          Application.ProcessMessages;
          if Item[j].Text = Registro.Tipo then
          begin
            JaTem := j;
            break;
          end;
        end;
        if JaTem > -1 then
          Node := Item[JaTem]
        else
        begin
          Node := Add(nil,Registro.Tipo);
          Node.ImageIndex := 0;
          Node.SelectedIndex := 1;
          Node.StateIndex := 1;
        end;
        JaTem := -1;
        for j := 0 to Node.Count - 1 do
        begin
          Application.ProcessMessages;
          if Node.Item[j].Text = Registro.Area then
          begin
            JaTem := j;
            break;
          end;
        end;
        if JaTem > -1 then
          Node2 := Node.Item[JaTem]
        else
        begin
          Node2 := AddChild(Node,Registro.Area);
          Node2.ImageIndex := 0;
          Node2.SelectedIndex := 1;
          Node2.StateIndex := 1;
        end;
        JaTem := -1;
        for j := 0 to Node2.Count - 1 do
        begin
          Application.ProcessMessages;
          if Node2.Item[j].Text = Registro.Classificacao then
          begin
            JaTem := j;
            break;
          end;
        end;
        if JaTem = -1 then
        begin
          with AddChild(Node2,Registro.Classificacao) do
          begin
            ImageIndex := 0;
            SelectedIndex := 1;
            StateIndex := 1;
          end;
        end;
        SetLength(form_Desktop.AcervoArray,Length(form_Desktop.AcervoArray) + 1);
        SetLength(form_Desktop.AcervoArray[Length(form_Desktop.AcervoArray) - 1],
                  Length(Registro.Acervos));
        for j := 0 to Length(Registro.Acervos) - 1 do
        begin
          Application.ProcessMessages;
          form_Desktop.AcervoArray[Length(form_Desktop.AcervoArray) - 1][j] := TAcervo.Create;
          form_Desktop.AcervoArray[Length(form_Desktop.AcervoArray) - 1][j].Assign(Registro.Acervos[j]);
        end;
      end;
    end;
  end;
end;

procedure TDataInterface.ReadAcervo(Sender: TObject);
var i: Integer;
begin
  with (Sender as Tform_BibliotecaExplorer) do
  begin
    with ListView_Acervo.Items do
    begin
      Clear;
      if not TreeView_Classes.Selected.HasChildren then
      begin
        AcervoIndex := -1;
        for i := 0 to Length(form_Desktop.AcervoArray) - 1 do
        begin
          if (form_Desktop.AcervoArray[i][0].ClassificacaoAcervo.Descricao =
            TreeView_Classes.Selected.Text) and
             (form_Desktop.AcervoArray[i][0].AreaAcervo.Descricao =
            TreeView_Classes.Selected.Parent.Text) and
             (form_Desktop.AcervoArray[i][0].TipoAcervo.Descricao =
            TreeView_Classes.Selected.Parent.Parent.Text) then
          begin
            AcervoIndex := i;
            break;
          end;
        end;
        if AcervoIndex > -1 then
        begin
          for i := 0 to Length(form_Desktop.AcervoArray[AcervoIndex]) - 1 do
          begin
            with Add do
            begin
              Caption := form_Desktop.AcervoArray[AcervoIndex][i].Titulo;
              ImageIndex := 3;
            end;
          end;
        end;
      end;
      if Count > 0 then
      begin
        ListView_Acervo.SetFocus;
        ListView_Acervo.Selected := Item[0];
      end;
    end;
  end;
end;

procedure TDataInterface.ReadExemplares(Sender: TObject);
var i: Integer;
begin
  with (Sender as Tform_BibliotecaExplorer), form_Desktop do
  begin
    ListView_Exemplares.Items.Clear;
    if (ListView_Acervo.Selected = nil) or (AcervoIndex = -1) then
      exit;
    with ListView_Exemplares.Items,
         AcervoArray[AcervoIndex][ListView_Acervo.Selected.Index] do
    begin
      BeginUpdate;
      Clear;
      FDataClass.Refresh;
      DataModule_Biblio.ADODataSet_Explorer.Locate(
        'TITULO;AUTOR;EDITORA;COLECAO;VOLUME;EDICAO',
        VarArrayOf([Titulo,Autor,Editora,Colecao,Volume,Edicao]),[]);
      FDataClass.Read;
      FDataClass.GetExemplares(Exemplares);
      for i := 0 to Length(Exemplares) - 1 do
      begin
        with Add do
        begin
          Caption := IntToStr(Exemplares[i].Tombo);
          SubItems.Add(SituacaoToStr(Exemplares[i].Situacao));
          SubItems.Add(FDataClass.Registro.Localizacao);
          SubItems.Add(MovData.GetDataPrevDev(Exemplares[i].Tombo));
          ImageIndex := 2;
        end;
      end;
      EndUpdate;
      Application.ProcessMessages;
      ListView_Exemplares.SetFocus;
      ListView_Exemplares.Selected := ListView_Exemplares.Items.Item[0];
    end;
  end;
end;

procedure TDataInterface.WriteDetalhes(Sender: TObject);
begin
  with (Sender as Tform_BibliotecaExplorer) do
  begin
    if (ListView_Acervo.Selected = nil) or (AcervoIndex = -1) then
      exit;
    with form_Desktop.AcervoArray[AcervoIndex][ListView_Acervo.Selected.Index],
         Memo_Detalhes.Lines do
    begin
      Clear;
      Add('Detalhes do Acervo:' + #13#10);
      Add('Título: ' + Titulo);
      Add('Autor: ' + Autor);
      Add('Editora: ' + Editora);
      Add('Coleção: ' + Colecao);
      Add('Volume: ' + IntToStr(Volume));
      Add('Edição: ' + IntToStr(Edicao));
      Add('Ano: ' + IntToStr(Ano));
      Add('Assunto: ' + Assunto);
      Add('Páginas: ' + IntToStr(Paginas));
      Add('Fornecedor: ' + Fornecedor.Nome);
    end;
  end;
end;

{-------------------- Tform_BibliotecaExplorer -----------------------}

procedure Tform_BibliotecaExplorer.Emprestar1Click(Sender: TObject);
begin
  form_RetiradaDialog := Tform_RetiradaDialog.Create(Application);
  with form_RetiradaDialog do
  begin
    Edit_Titulo.Text := ListView_Acervo.Selected.Caption;
    Edit_Data.Text := FormatDateTime('dd/mm/yyyy',Date);
    Edit_Tombo.Text := ListView_Exemplares.Selected.Caption;
    ShowModal;
    Free;
  end;
  DataInterface.ReadExemplares(Self);
end;

procedure Tform_BibliotecaExplorer.Reservar1Click(Sender: TObject);
begin
  form_ReservaDialog := Tform_ReservaDialog.Create(Application);
  with form_ReservaDialog do
  begin
    Edit_Titulo.Text := ListView_Acervo.Selected.Caption;
    Edit_Data.Text := FormatDateTime('dd/mm/yyyy',Date);
    Edit_Tombo.Text := ListView_Exemplares.Selected.Caption;
    ShowModal;
    Free;
  end;
  DataInterface.ReadExemplares(Self);
end;

procedure Tform_BibliotecaExplorer.MoverparaAcervoPerdido1Click(
  Sender: TObject);
var Usuario, RGA: String;
begin
  if ListView_Exemplares.Selected.SubItems[0] = 'Perdido' then
  begin
    if Application.MessageBox(PChar('Tem certeza que deseja restaurar o ' +
      'exemplar do Acervo Perdido ?'),
      'Confirmação',MB_YESNOQUESTION) = IDYES then
    begin
      with DataInterface.MovData, ListView_Exemplares.Selected do
        if not MoverPerdido(StrToInt(Caption),'',False) then
          Application.MessageBox(PChar(UltimoErro),'Erro',MB_OKWARNING)
        else
          Application.MessageBox('Exemplar Restaurado.',
                               'Concluído com sucesso',MB_OKINFORMATION);
      DataInterface.ReadExemplares(Self);
    end;
  end
  else
  begin
    form_AcervoPerdidoDialog := Tform_AcervoPerdidoDialog.Create(Application);
    with form_AcervoPerdidoDialog, ListView_Exemplares do
    begin
      Edit_Titulo.Text := Selected.Caption;
      Edit_Data.Text := FormatDateTime('dd/mm/yyyy',Date);
      Edit_Tombo.Text := Selected.Caption;
      MovData.GetUsuarioAPerdido(StrToInt(Selected.Caption),Usuario,RGA);
      Edit_Nome.Text := Usuario;
      Edit_RGA.Text := RGA;
      ShowModal;
      form_AcervoPerdidoDialog.Free;
    end;
    DataInterface.ReadExemplares(Self);
  end;
end;

procedure Tform_BibliotecaExplorer.FormCreate(Sender: TObject);
begin
  DataInterface := TDataInterface.Create;
  if Assigned(form_Desktop.TreeList) then
    TreeView_Classes.Items.Assign(form_Desktop.TreeList.Items);
  btn_Emprestar.Visible := form_Desktop.Direitos.Emprestar;
  btn_Devolver.Visible := form_Desktop.Direitos.Devolver;
  btn_Reservar.Visible := form_Desktop.Direitos.Reservar;
  btn_Perdido.Visible := form_Desktop.Direitos.MoverPerdido;
end;

procedure Tform_BibliotecaExplorer.FormDestroy(Sender: TObject);
begin
  DataInterface.Free;
end;

procedure Tform_BibliotecaExplorer.TreeView_ClassesChange(Sender: TObject;
  Node: TTreeNode);
begin
  Memo_Detalhes.Lines.Clear;
  DataInterface.ReadAcervo(Self);
end;

procedure Tform_BibliotecaExplorer.ListView_AcervoChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  DataInterface.WriteDetalhes(Self);
  DataInterface.ReadExemplares(Self);
end;

procedure Tform_BibliotecaExplorer.btn_AtualizarClick(Sender: TObject);
var i,j: Integer;
begin
  TreeView_Classes.Items.BeginUpdate;
  for i := 0 to Length(form_Desktop.AcervoArray) - 1 do
  begin
    for j := 0 to Length(form_Desktop.AcervoArray[i]) - 1 do
    begin
      form_Desktop.AcervoArray[i][j].Free;
      Application.ProcessMessages;
    end;
    SetLength(form_Desktop.AcervoArray[i],0);
  end;
  SetLength(form_Desktop.AcervoArray,0);
  DataInterface.Read(Self);
  TreeView_Classes.Items.EndUpdate;
  form_Desktop.TreeList.Items.Assign(TreeView_Classes.Items);
  Memo_Detalhes.Lines.Clear;
  ListView_Acervo.Items.Clear;
  ListView_Exemplares.Items.Clear;
end;

procedure Tform_BibliotecaExplorer.ListView_ExemplaresChange(
  Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btn_Emprestar.Enabled := False;
  btn_Devolver.Enabled := False;
  btn_Reservar.Enabled := False;
  btn_Perdido.Enabled := False;
  if ListView_Exemplares.Selected <> nil then
  begin
    btn_Emprestar.Enabled :=
      ListView_Exemplares.Selected.SubItems[0] = 'Disponível';
    btn_Devolver.Enabled :=
      ListView_Exemplares.Selected.SubItems[0] = 'Emprestado';
    btn_Reservar.Enabled :=
      ListView_Exemplares.Selected.SubItems[0] = 'Emprestado';
    btn_Perdido.Enabled :=
      ListView_Exemplares.Selected.SubItems[0] <> 'Disponível';
  end;
end;

procedure Tform_BibliotecaExplorer.btn_DevolverClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja devolver o exemplar ?',
    'Confirmação',MB_YESNOQUESTION) = IDYES then
  begin
    with DataInterface.MovData do
      if not Devolver(StrToInt(ListView_Exemplares.Selected.Caption)) then
        Application.MessageBox(PChar(UltimoErro),'Erro',MB_OKWARNING)
      else
        Application.MessageBox('Exemplar Devolvido.',
                             'Concluído com sucesso',MB_OKINFORMATION);
    DataInterface.ReadExemplares(Self);
  end;
end;

procedure Tform_BibliotecaExplorer.btn_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_BibliotecaExplorer.btn_ProcurarClick(Sender: TObject);
var i, idx: Integer;
    Tit: String;
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
    idx := Search;
    if idx > 0 then
    begin
      with DataInterface.FClasseAcervos, TreeView_Classes do
      begin
        DataInterface.FClasseAcervos.Refresh;
        DataInterface.FDataClass.Refresh;
        LocateTombo(idx);
        DataInterface.FClasseAcervos.Read;
        DataInterface.FDataClass.Read;
        Tit := DataInterface.FDataClass.Registro.Titulo;
        FullExpand;
        SetFocus;
        for i := 0 to Items.Count - 1 do
        begin
          if Items.Item[i].Text = Registro.Tipo then
          begin
            Selected := Items.Item[i];
            break;
          end;
        end;
        if Selected <> nil then
        begin
          for i := 0 to Selected.Count - 1 do
          begin
            if Selected.Item[i].Text = Registro.Area then
            begin
              Selected := Selected.Item[i];
              break;
            end;
          end;
        end;
        if Selected <> nil then
        begin
          for i := 0 to Selected.Count - 1 do
          begin
            if Selected.Item[i].Text = Registro.Classificacao then
            begin
              Selected := Selected.Item[i];
              break;
            end;
          end;
        end;
      end;
      ListView_Acervo.SetFocus;
      with ListView_Acervo do
        Selected := FindCaption(0,Tit,False,True,False);
      DataInterface.WriteDetalhes(Self);
      ListView_Exemplares.SetFocus;
      with ListView_Exemplares do
        Selected := FindCaption(0,IntToStr(idx),False,True,False);
    end;
    Free;
  end;
end;

procedure Tform_BibliotecaExplorer.ProcurarClick(Sender: TObject);
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


end.
