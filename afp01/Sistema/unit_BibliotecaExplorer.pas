{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_BibliotecaExplorer.pas

  Contém as classes de Interface do "Explorar Biblioteca".

  Data última revisão: 25/11/2001

******************************************************************************}

unit unit_BibliotecaExplorer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ImgList, ToolWin, Menus,
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
    Exemplares: TExemplares;
(*    {Lê a partir da Classe de Dados e escreve nos objetos da Interface}
    procedure LeRegistros(Sender: TObject);*)
  public
    { Public declarations }
    {construtor/destrutor}
    constructor Create;
    destructor Destroy; override;
    {Métodos}
    procedure Read(Sender: TObject);
    procedure ReadAcervo(Sender: TObject);
    procedure ReadExemplares(Sender: TObject);
(*    {Configura objetos de Interface para modo leitura}
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
                            Mensagem, Caption: String; Flags: Longint); *)
    function SituacaoToStr(Situacao: Char): String;
    function StrToSituacao(SitStr: String): Char;
  end;

{Classe do Form}
type
  Tform_BibliotecaExplorer = class(TForm)
    ImageList_Explorer: TImageList;
    TreeView_Classes: TTreeView;
    Splitter_Vertical: TSplitter;
    StatusBar1: TStatusBar;
    ListView_Acervo: TListView;
    Splitter_Horizontal: TSplitter;
    ListView_Exemplares: TListView;
    ToolBar_Principal: TToolBar;
    ToolButton_Emprestar: TToolButton;
    ToolButton_Devolver: TToolButton;
    ToolButton_Reservar: TToolButton;
    ToolButton_Perdido: TToolButton;
    ToolButton_Fechar: TToolButton;
    ToolButton_Separator: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure Emprestar1Click(Sender: TObject);
    procedure Reservar1Click(Sender: TObject);
    procedure MoverparaAcervoPerdido1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeView_ClassesClick(Sender: TObject);
    procedure ListView_AcervoClick(Sender: TObject);
  private
    { Private declarations }
    DataInterface: TDataInterface;
//    procedure SetAccess;
  public
    { Public declarations }
  end;

var
  form_BibliotecaExplorer: Tform_BibliotecaExplorer;

implementation

uses unit_RetiradaDialog, unit_ReservaDialog, unit_AcervoPerdidoDialog,
     unit_Desktop, unit_Comum;

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
var Node, Node2, Node3: TTreeNode;
    i,j,l: Integer;
    Classes: TClasses;
begin
  with (Sender as Tform_BibliotecaExplorer) do
  begin
    with TreeView_Classes.Items do
    begin
      Clear;
      FDataClass.GetClasses(Classes);
      for i := 0 to Length(Classes.TipoAcervo) - 1 do
      begin
        Node := Add(nil,Classes.TipoAcervo[i]);
        Node.ImageIndex := 0;
        Node.SelectedIndex := 1;
        Node.StateIndex := 1;
        for j := 0 to Length(Classes.AreaAcervo) - 1 do
        begin
          Node2 := AddChild(Node,Classes.AreaAcervo[j]);
          Node2.ImageIndex := 0;
          Node2.SelectedIndex := 1;
          Node2.StateIndex := 1;
          for l := 0 to Length(Classes.ClassificacaoAcervo) - 1 do
          begin
            Node3 := AddChild(Node2,Classes.ClassificacaoAcervo[l]);
            Node3.ImageIndex := 0;
            Node3.SelectedIndex := 1;
            Node3.StateIndex := 1;
          end;
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
        with TreeView_Classes.Selected do
          FDataClass.GetTitulos(Parent.Parent.Text,Parent.Text,
                                TreeView_Classes.Selected.Text);
        for i := 1 to FDataClass.RecCount(True) do
        begin
          FDataClass.GotoReg(i,True);
          with Add do
          begin
            Caption := FDataClass.Registro.Titulo;
            ImageIndex := 3;
          end;
        end;
      end;
      if Count > 0 then
        ListView_Acervo.Selected := Item[0];
    end;
  end;
end;

procedure TDataInterface.ReadExemplares(Sender: TObject);
begin
  with (Sender as Tform_BibliotecaExplorer) do
  begin
    with ListView_Acervo.Items do
    begin
      Clear;
    //      FDataClass.GetExemplares(Classes);
          with Add do
          begin
            Caption := FDataClass.Registro.Titulo;
            ImageIndex := 3;
          end;
    end;
  end;
end;

{-------------------- Tform_BibliotecaExplorer -----------------------}

procedure Tform_BibliotecaExplorer.Emprestar1Click(Sender: TObject);
begin
  form_RetiradaDialog := Tform_RetiradaDialog.Create(Application);
  form_RetiradaDialog.ShowModal;
  form_RetiradaDialog.Free;
end;

procedure Tform_BibliotecaExplorer.Reservar1Click(Sender: TObject);
begin
  form_ReservaDialog := Tform_ReservaDialog.Create(Application);
  form_ReservaDialog.ShowModal;
  form_ReservaDialog.Free;
end;

procedure Tform_BibliotecaExplorer.MoverparaAcervoPerdido1Click(
  Sender: TObject);
begin
  form_AcervoPerdidoDialog := Tform_AcervoPerdidoDialog.Create(Application);
  form_AcervoPerdidoDialog.ShowModal;
  form_AcervoPerdidoDialog.Free;
end;

procedure Tform_BibliotecaExplorer.FormCreate(Sender: TObject);
begin
  DataInterface := TDataInterface.Create;
  DataInterface.Read(Self);
end;

procedure Tform_BibliotecaExplorer.FormDestroy(Sender: TObject);
begin
  DataInterface.Free;
end;

procedure Tform_BibliotecaExplorer.TreeView_ClassesClick(Sender: TObject);
begin
  DataInterface.ReadAcervo(Self);
end;

procedure Tform_BibliotecaExplorer.ListView_AcervoClick(Sender: TObject);
begin
 //
end;

end.
