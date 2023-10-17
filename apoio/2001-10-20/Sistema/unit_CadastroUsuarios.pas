unit unit_CadastroUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, DBCtrls, Mask, Buttons,
  ExtCtrls, Grids, DBGrids, Db, DBTables, unit_DatabaseClasses, unit_Comum;

{classe de interface}

type
  TDataInterface = class
  private
    { Private declarations }
    FDataClass: TUsuarios;
    procedure LeRegistros(Sender: TObject);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure Read(Sender: TObject);
    procedure Insert(Sender: TObject);
    procedure Edit(Sender: TObject);
    procedure Post(Sender: TObject);
  end;

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
    procedure ToolButton_UltimoClick(Sender: TObject);
    procedure ToolButton_ProximoClick(Sender: TObject);
    procedure ToolButton_AnteriorClick(Sender: TObject);
    procedure ToolButton_PrimeiroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton_NovoClick(Sender: TObject);
    procedure ToolButton_EditarClick(Sender: TObject);
    procedure ToolButton_GravarClick(Sender: TObject);
    procedure ToolButton_CancelarClick(Sender: TObject);
    procedure ToolButton_ExcluirClick(Sender: TObject);
    procedure ToolButton_FecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    DataInterface: TDataInterface;
  public
    { Public declarations }
  end;

var
  form_CadastroUsuarios: Tform_CadastroUsuarios;

implementation

{$R *.DFM}

{TDataInterface}
constructor TDataInterface.Create;
begin
  inherited Create;
  FDataClass := TUsuarios.Create;
  FDataClass.Refresh;
end;

destructor TDataInterface.Destroy;
begin
  FDataClass.Free;
  inherited Destroy;
end;

procedure TDataInterface.LeRegistros(Sender: TObject);
var i: Byte;
begin
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
    with TipoUsuario do
    begin
      Edit_TempoEmprestimo.Text := IntToStr(TempoEmprestimo);
      Edit_TempoSuspensao.Text := IntToStr(TempoSusp);
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
    with TipoUsuario do
    begin
      TempoEmprestimo := StrToInt(Edit_TempoEmprestimo.Text);
      TempoSusp := StrToInt(Edit_TempoSuspensao.Text);
    end;
    Telefones := Memo_Telefone.Lines.Text;
    with ComboBox_Estado do
      Estado := EstadoToUF(Items[ItemIndex]);

    TipoUsuario.IdTipoUsuario := 1; //prov
  end;
end;

procedure TDataInterface.Read(Sender: TObject);
begin
  with (Sender as Tform_CadastroUsuarios), FDataClass do
  begin
    ScrollBox_Formulario.Enabled := False;
    ToolButton_Primeiro.Enabled := not (Bof or (RecCount = 0));
    ToolButton_Anterior.Enabled := not (Bof or (RecCount = 0));
    ToolButton_Ultimo.Enabled := not (Eof or (RecCount = 0));
    ToolButton_Proximo.Enabled := not (Eof or (RecCount = 0));
    ToolButton_Pesquisar.Enabled := (RecCount <> 0);
    ToolButton_Novo.Enabled := True;
    ToolButton_Editar.Enabled := (RecCount <> 0);
    ToolButton_Excluir.Enabled := (RecCount <> 0);
    ToolButton_Gravar.Enabled := False;
    ToolButton_Cancelar.Enabled := False;
  end;
  LeRegistros(Sender);
end;

procedure TDataInterface.Insert(Sender: TObject);
begin
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
  LeRegistros(Sender);
end;

procedure TDataInterface.Edit(Sender: TObject);
begin
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
  LeRegistros(Sender);
end;

procedure Tform_CadastroUsuarios.ToolButton_UltimoClick(Sender: TObject);
begin
  ToolButton_Primeiro.Enabled := True;
  ToolButton_Anterior.Enabled := True;
  ToolButton_Proximo.Enabled := False;
  ToolButton_Ultimo.Enabled := False;
  with DataInterface do
  begin
    FDataClass.Last;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_ProximoClick(Sender: TObject);
begin
  ToolButton_Primeiro.Enabled := True;
  ToolButton_Anterior.Enabled := True;
  with DataInterface do
  begin
    FDataClass.Next;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_AnteriorClick(Sender: TObject);
begin
  ToolButton_Proximo.Enabled := True;
  ToolButton_Ultimo.Enabled := True;
  with DataInterface do
  begin
    FDataClass.Prior;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_PrimeiroClick(Sender: TObject);
begin
  ToolButton_Primeiro.Enabled := False;
  ToolButton_Anterior.Enabled := False;
  ToolButton_Proximo.Enabled := True;
  ToolButton_Ultimo.Enabled := True;
  with DataInterface do
  begin
    FDataClass.First;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.FormCreate(Sender: TObject);
begin
  DataInterface := TDataInterface.Create;
  DataInterface.Read(Self);
end;

procedure Tform_CadastroUsuarios.FormDestroy(Sender: TObject);
begin
  DataInterface.Free;
end;

procedure Tform_CadastroUsuarios.ToolButton_NovoClick(Sender: TObject);
begin
  with DataInterface do
  begin
    FDataClass.Insert;
    Insert(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_EditarClick(Sender: TObject);
begin
  with DataInterface do
  begin
    FDataClass.Edit;
    Edit(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_GravarClick(Sender: TObject);
begin
  with DataInterface do
  begin
    Post(Self);
    FDataClass.Post;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_CancelarClick(Sender: TObject);
begin
  with DataInterface do
  begin
    FDataClass.Cancel;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_ExcluirClick(Sender: TObject);
begin
  with DataInterface do
  begin
    FDataClass.Delete;
    Read(Self);
  end;
end;

procedure Tform_CadastroUsuarios.ToolButton_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_CadastroUsuarios.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DataInterface.FDataClass.State <> stRead then
  begin
    with Application do
      MessageBox(MSG_FORMOPEN,CAP_FORMOPEN,MB_OKWARNING);
    CanClose := False;
  end;
end;

end.
