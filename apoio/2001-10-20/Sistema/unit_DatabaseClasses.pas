{******************************************************************************

  unit_DatabaseClasses: Contém as Classes de Dados da Aplicação

******************************************************************************}
unit unit_DatabaseClasses;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, unit_Comum;

{**************** Classes base *********************}

{TDataClass}
{Superclasse ancestral de todas as classes de dados}
type
  TDataRecord = class {Superclasse ancestral de um registro de dados}
  end;
type
  TDataArray = Array of TDataRecord; {Conjunto de registros}
type
  TDataClass = class
  private
    { Private declarations }
  protected
    { Protected declarations }
    FState: Byte; {ver constantes na unit_Comum}
    FIndex: Integer;
    FDataArray: TDataArray;
    procedure SetRegistro(Value: TDataRecord);
    function GetRegistro: TDataRecord;
    {provê acesso aos registros de dados}
    property Registro: TDataRecord read GetRegistro write SetRegistro;
    {lê o dataset do banco de dados para os registros do objeto}
    {Opcionais: Field = campo; Keyword = palavras-chave; permitem uma pesquisa}
    procedure Refresh(Field: String50 = '';
                      Keyword: String50 = ''); dynamic; abstract;
    {insere um novo registro no objeto}
    procedure Insert; dynamic; abstract;
    {grava no banco de dados os registros do objeto}
    procedure Post; dynamic; abstract;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; dynamic; abstract;
    {classifica em ordem alfabetica os registros do objeto}
    procedure Sort; dynamic; abstract;
  public
    { Public declarations }
    {retorna o estado do objeto (ver constantes na unit_Comum)}
    property State: Byte read FState;
    {número do registro atual (posição do cursor)}
    property RecNo: Integer read FIndex;
    {construtor / destrutor}
    constructor Create; dynamic;
    destructor Destroy; override;
    {etita um registro no objeto}
    procedure Edit;
    {apaga um registro do objeto e do banco de dados}
    procedure Delete;
    {cancela uma alteração (insert ou edit) feita no objeto}
    procedure Cancel;
    {movimentação do cursor nos registros do objeto}
    procedure First;
    procedure Last;
    procedure Prior;
    procedure Next;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer);
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean;
    function Eof: Boolean;
  end;

{**** Classe do DataModule - contém os componentes para a conexão ao BD *******}
{TDataModule_Biblio}
type
  TDataModule_Biblio = class(TDataModule)
    ADOConnection_Biblio: TADOConnection;
    ADOCommand_Biblio: TADOCommand;
    ADODataSet_Biblio: TADODataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{**************** Classes de Dados *********************}

{TTipoUsuario}
{um registro da tabela TIPOUSUARIO}
type
  TTipoUsuario = class(TDataRecord)
  public
    { Public declarations }
    IdTipoUsuario: Integer;
    Descricao: String20;
    TempoEmprestimo: Word;
    TempoSusp: Word;
    MaxExemplares: Byte;
    constructor Create;
    procedure Assign(Source: TTipoUsuario);
  end;

{TUsuario}
{um registro da tabela USUARIO (contém também um TIPOUSUÁRIO)}
type
  TUsuario = class(TDataRecord)
  public
    { Public declarations }
    IdUsuario: Integer;
    Nome: String50;
    RGA: String20;
    CPF: String20;
    RG: String20;
    Endereco: String80;
    Bairro: String20;
    Cidade: String20;
    Estado: String2;
    CEP: String10;
    Telefones: AnsiString;
    DataCadastro: TDateTime;
    Situacao: Char;
    DataExpiraSusp: TDateTime;
    TipoUsuario: TTipoUsuario;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TUsuario);
  end;

{conjunto de registros TUSUARIO}
type
  TUsuarioArray = Array of TUsuario;

{TUsuarios}
{contém os dados relativos ao Cadastro de Usuários}
type
  TUsuarios = class(TDataClass)
  private
    { Private declarations }
    FDataArray: TUsuarioArray;
    {rotinas de gravação no BD}
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TUsuario);
    function GetRegistro: TUsuario;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    property Registro: TUsuario read GetRegistro write SetRegistro;
    procedure Refresh(Field: String50 = '';
                      Keyword: String50 = ''); override;
    procedure Post; override;
    procedure Insert; override;
    procedure Sort; override;
    function RecCount: Integer; override;
  end;

{**************** Variáveis Globais *********************}

var
  DataModule_Biblio: TDataModule_Biblio;


implementation
{$R *.DFM}

{-------------------- TDataClass -----------------------}

constructor TDataClass.Create;
begin
  inherited Create;
  {inicializa valores}
  FIndex := -1;
  FState := stRead;
end;

destructor TDataClass.Destroy;
var i: Integer;
begin
  {destrói todos os objetos "registro" do array}
  for i := 0 to Length(FDataArray) - 1 do
    FDataArray[i].Free;
  {zera o array}
  SetLength(FDataArray,0);
  inherited Destroy;
end;

procedure TDataClass.GotoReg(RecIndex: Integer);
begin
  {atribui ao FIndex o valor do registro destino}
  if (FState = stRead) and (RecIndex < RecCount) then
  begin
    FIndex := RecIndex;
  end;
end;

procedure TDataClass.Edit;
begin
  {coloca em modo de edição}
  if (RecCount > 0) and (FState = stRead) then
    FState := stEdit;
end;

procedure TDataClass.Delete;
begin
  if (RecCount > 0) and (FState = stRead) then
  begin
    {coloca em modo de "Delete"}
    FState := stDelete;
    {grava as alterações no BD}
    Post;
  end;
end;

procedure TDataClass.Cancel;
var i: Integer;
    st: Byte;
begin
  {lê novamente os registros do BD}
  i := FIndex;
  st := FState;
  if (st = stInsert) or (st = stEdit) then
    Refresh;
  {retorna o FIndex original}
  if st = stInsert then
    FIndex := i - 1
  else if st = stEdit then
    FIndex := i;
end;

procedure TDataClass.First;
begin
  {vai para o primeiro registro (0)}
  if (RecCount > 0) and (FState = stRead) then
    FIndex := 0;
end;

procedure TDataClass.Last;
begin
  {vai para o último registro}
  if (RecCount > 0) and (FState = stRead) then
    FIndex := RecCount - 1;
end;

procedure TDataClass.Prior;
begin
  {vai para o registro anterior}
  if (RecCount > 0) and (FIndex > 0) and (FState = stRead) then
    dec(FIndex);
end;

procedure TDataClass.Next;
begin
  {vai para o próximo registro}
  if (RecCount > 0) and (FIndex < RecCount - 1) and
     (FState = stRead) then
    inc(FIndex);
end;

procedure TDataClass.SetRegistro(Value: TDataRecord);
begin
  {permite acesso ao array}
  if FIndex <> -1 then
    FDataArray[FIndex] := Value;
end;

function TDataClass.GetRegistro: TDataRecord;
begin
  {permite acesso ao array}
  Result := nil;
  if FIndex <> -1 then
    Result := FDataArray[FIndex];
end;

function TDataClass.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  Result := (FIndex <= 0);
end;

function TDataClass.Eof: Boolean;
begin
  {retorna True se for o último registro}
  Result := (FIndex = RecCount - 1);
end;

{-------------------- TUsuario -----------------------}

constructor TUsuario.Create;
begin
  inherited Create;
  {inicializa os campos do TUsuario}
  IdUsuario := 0;
  Nome := '';
  RGA := '';
  CPF := '';
  RG := '';
  Endereco := '';
  Bairro := '';
  Cidade := '';
  Estado := 'SP';
  CEP := '';
  Telefones := '';
  DataCadastro := Date;
  Situacao := 'N';
  DataExpiraSusp := Date;
  TipoUsuario := TTipoUsuario.Create;
end;

destructor TUsuario.Destroy;
begin
  {destrói o objeto de Tipo de Usuário}
  TipoUsuario.Free;
  inherited Destroy;
end;

procedure TUsuario.Assign(Source: TUsuario);
begin
  IdUsuario := Source.IdUsuario;
  Nome := Source.Nome;
  RGA := Source.RGA;
  CPF := Source.CPF;
  RG := Source.RG;
  Endereco := Source.Endereco;
  Bairro := Source.Bairro;
  Cidade := Source.Cidade;
  Estado := Source.Estado;
  CEP := Source.CEP;
  Telefones := Source.Telefones;
  DataCadastro := Source.DataCadastro;
  Situacao := Source.Situacao;
  DataExpiraSusp := Source.DataExpiraSusp;
  TipoUsuario.Assign(Source.TipoUsuario);
end;

{-------------------- TTipoUsuario -----------------------}

constructor TTipoUsuario.Create;
begin
  inherited Create;
  IdTipoUsuario := 0;
  Descricao := '';
  TempoEmprestimo := 0;
  TempoSusp := 0;
  MaxExemplares := 0;
end;

procedure TTipoUsuario.Assign(Source: TTipoUsuario);
begin
  IdTipoUsuario := Source.IdTipoUsuario;
  Descricao := Source.Descricao;
  TempoEmprestimo := Source.TempoEmprestimo;
  TempoSusp := Source.TempoSusp;
  MaxExemplares := Source.MaxExemplares;
end;

{-------------------- TUsuarios -----------------------}

procedure TUsuarios.SetRegistro(Value: TUsuario);
begin
  if FIndex <> -1 then
    FDataArray[FIndex] := Value;
end;

function TUsuarios.GetRegistro: TUsuario;
begin
  if FIndex <> -1 then
    Result := FDataArray[FIndex]
  else
    Result := TUsuario.Create;
end;

procedure TUsuarios.Sort;
var i, j: Integer;
    Tmp: TUsuario;
begin
  Tmp := TUsuario.Create;
  for j := Length(FDataArray) - 2 downto 0 do
  begin
    for i := 0 to j do
    begin
      Application.ProcessMessages;
      if FDataArray[i].Nome > FDataArray[i + 1].Nome then
      begin
        Tmp.Assign(FDataArray[i + 1]);
        FDataArray[i + 1].Assign(FDataArray[i]);
        FDataArray[i].Assign(Tmp);
      end;
    end;
  end;
  Tmp.Free;
end;

procedure TUsuarios.Insert;
begin
  if FState = stRead then
  begin
    SetLength(FDataArray,RecCount + 1);
    FIndex := RecCount - 1;
    FDataArray[FIndex] := TUsuario.Create;
    FState := stInsert;
  end;
end;

procedure TUsuarios.Refresh(Field: String50 = ''; Keyword: String50 = '');
var i: Integer;
    Keywords: TStringList;
begin
  FState := stDBWait;
  Screen.Cursor := crSQLWait;
  for i := 0 to Length(FDataArray) - 1 do
    FDataArray[i].Free;
  SetLength(FDataArray,0);
  with DataModule_Biblio.ADODataSet_Biblio,
       DataModule_Biblio.ADOCommand_Biblio do
  begin
    if (Keyword = '') or (Field = '') then
    begin
      CommandText :=
        'SELECT ' +
        '  U.*, T.DESCRICAO, T.TEMPOEMPRESTIMO, T.TEMPOSUSP, T.MAXEXEMPLARES ' +
        'FROM ' +
        '  USUARIO U, TIPOUSUARIO T ' +
        'WHERE ' +
        '  U.IDTIPOUSUARIO = T.IDTIPOUSUARIO ' +
        'ORDER BY U.NOME';
    end
    else
    begin
      {Separa as palavras em Keyword pelos ;}
      Keywords := TStringList.Create;
      Keywords.Clear;
      if Pos(';',Keyword) = 0 then {só uma palavra}
        Keywords.Add(Keyword);
      while Pos(';',Keyword) > 0 do
      begin
        if Pos(';',Keyword) > 1 then
          Keywords.Add(Copy(Keyword,1,Pos(';',Keyword) - 1));
        System.Delete(Keyword,1,Pos(';',Keyword));
      end;
      CommandText :=
        'SELECT ' +
        '  U.*, T.DESCRICAO, T.TEMPOEMPRESTIMO, T.TEMPOSUSP, T.MAXEXEMPLARES ' +
        'FROM ' +
        '  USUARIO U, TIPOUSUARIO T ' +
        'WHERE ' +
        '  U.IDTIPOUSUARIO = T.IDTIPOUSUARIO ' +
        '  (U.' + Field + ' LIKE ' + Keywords.Strings[0] + ')';
      for i := 0 to Keywords.Count - 1 do
        CommandText := CommandText +
          '  AND (U.' + Field + ' LIKE ' + Keywords.Strings[i] + ')';
      CommandText := CommandText +
        'ORDER BY U.NOME';
      Keywords.Free;
    end;
    RecordSet := Execute;
    Open;
    First;
    while not Eof do
    begin
      SetLength(FDataArray,Length(FDataArray) + 1);
      FDataArray[Length(FDataArray) - 1] := TUsuario.Create;
      with FDataArray[Length(FDataArray) - 1] do
      begin
        IdUsuario := FieldByName('IdUsuario').AsInteger;
        Nome := FieldByName('Nome').AsString;
        RGA := FieldByName('RGA').AsString;
        CPF := FieldByName('CPF').AsString;
        RG := FieldByName('RG').AsString;
        Endereco := FieldByName('Endereco').AsString;
        Bairro := FieldByName('Bairro').AsString;
        Cidade := FieldByName('Cidade').AsString;
        Estado := FieldByName('Estado').AsString;
        CEP := FieldByName('CEP').AsString;
        Telefones := FieldByName('Telefones').AsString;
        for i := Length(Telefones) downto 1 do
        begin
          if (Telefones[i] = #13) or (Telefones[i] = #10) then
            System.Delete(Telefones,i,1)
          else
            break;
        end;
        DataCadastro := FieldByName('DataCadastro').AsDateTime;
        Situacao := FieldByName('Situacao').AsString[1];
        DataExpiraSusp := FieldByName('DataExpiraSusp').AsDateTime;
        with TipoUsuario do
        begin
          IdTipoUsuario := FieldByName('IdTipoUsuario').AsInteger;
          Descricao := FieldByName('Descricao').AsString;
          TempoEmprestimo := FieldByName('TempoEmprestimo').AsInteger;
          TempoSusp := FieldByName('TempoSusp').AsInteger;
          MaxExemplares := FieldByName('MaxExemplares').AsInteger;
        end;
      end;
      Next;
    end;
  end;
  FState := stRead;
  if Length(FDataArray) > 0 then
    FIndex := 0
  else
    FIndex := -1;
  Screen.Cursor := crDefault;
end;

procedure TUsuarios.PostInsert;
var i, id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADODataSet_Biblio,
       DataModule_Biblio.ADOCommand_Biblio,
       FDataArray[FIndex],
       FDataArray[FIndex].TipoUsuario do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  USUARIO ' +
      '    (NOME,' +
      '     RGA,' +
      '     CPF,' +
      '     RG,' +
      '     ENDERECO,' +
      '     BAIRRO,' +
      '     CIDADE,' +
      '     ESTADO,' +
      '     CEP,' +
      '     TELEFONES,' +
      '     DATACADASTRO,' +
      '     SITUACAO,' +
      '     DATAEXPIRASUSP,' +
      '     IDTIPOUSUARIO) ' +
      'VALUES ' +
      '  (' + #39 + Nome + #39 + ',' +
      '   ' + #39 + RGA + #39 + ',' +
      '   ' + #39 + CPF + #39 + ',' +
      '   ' + #39 + RG + #39 + ',' +
      '   ' + #39 + Endereco + #39 + ',' +
      '   ' + #39 + Bairro + #39 + ',' +
      '   ' + #39 + Cidade + #39 + ',' +
      '   ' + #39 + Estado + #39 + ',' +
      '   ' + #39 + CEP + #39 + ',' +
      '   ' + #39 + Telefones + #39 + ',' +
      '   ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '   ' + #39 + Situacao + #39 + ',' +
      '   ' + #39 + DateToStr(DataExpiraSusp) + #39 + ',' +
      '   ' + IntToStr(IdTipoUsuario) + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    Execute;
    {Lê o IdUsuario do registro}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'SELECT ' +
      '  IDUSUARIO ' +
      'FROM ' +
      '  USUARIO ' +
      'WHERE ' +
      '  (NOME = ' + #39 + Nome + #39 + ') AND ' +
      '  (RGA = ' + #39 + RGA + #39 + ') AND ' +
      '  (CPF = ' + #39 + CPF + #39 + ') AND ' +
      '  (RG = ' + #39 + RG + #39 + ') AND ' +
      '  (ENDERECO = ' + #39 + Endereco + #39 + ') AND ' +
      '  (BAIRRO = ' + #39 + Bairro + #39 + ') AND ' +
      '  (CIDADE = ' + #39 + Cidade + #39 + ') AND ' +
      '  (ESTADO = ' + #39 + Estado + #39 + ') AND ' +
      '  (CEP = ' + #39 + CEP + #39 + ') AND ' +
      '  (TELEFONES = ' + #39 + Telefones + #39 + ') AND ' +
      '  (DATACADASTRO = ' + DateToStr(DataCadastro) + ') AND ' +
      '  (SITUACAO = ' + #39 + Situacao + #39 + ') AND ' +
      '  (DATAEXPIRASUSP = ' + DateToStr(DataExpiraSusp) + ') AND' +
      '  (IDTIPOUSUARIO = ' +  IntToStr(IdTipoUsuario) + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    RecordSet := Execute;
    Open;
    IdUsuario := FieldByName('IdUsuario').AsInteger;
    Close;
    id := IdUsuario;
    {Classifica em ordem alfabética de Nome}
    Self.Sort;
    {posiciona o registro}
    FIndex := 0;
    for i := 0 to Length(FDataArray) - 1 do
    begin
      if FDataArray[i].IdUsuario = id then
      begin
        FIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TUsuarios.PostEdit;
var i, id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_Biblio,
       FDataArray[FIndex],
       FDataArray[FIndex].TipoUsuario do
  begin
    id := IdUsuario;
    {Faz Update do registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  USUARIO ' +
      'SET ' +
      '  NOME = ' + #39 + Nome + #39 + ',' +
      '  RGA = ' + #39 + RGA + #39 + ',' +
      '  CPF = ' + #39 + CPF + #39 + ',' +
      '  RG = ' +  #39 + RG + #39 + ',' +
      '  ENDERECO = ' + #39 + Endereco + #39 + ',' +
      '  BAIRRO = ' + #39 + Bairro + #39 + ',' +
      '  CIDADE = ' + #39 + Cidade + #39 + ',' +
      '  ESTADO = ' + #39 + Estado + #39 + ',' +
      '  CEP = ' + #39 + CEP + #39 + ',' +
      '  TELEFONES = ' + #39 + Telefones + #39 + ',' +
      '  DATACADASTRO = ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '  SITUACAO = ' + #39 + Situacao + #39 + ',' +
      '  DATAEXPIRASUSP = ' + #39 + DateToStr(DataExpiraSusp) + #39 + ',' +
      '  IDTIPOUSUARIO = ' + IntToStr(IdTipoUsuario) + ' ' +
      'WHERE ' +
      '  IDUSUARIO = ' + IntToStr(IdUsuario);
    ShortDateFormat := 'dd/mm/yyyy';
    Execute;
    {Classifica em ordem alfabética}
    Self.Sort;
    {posiciona o registro}
    FIndex := 0;
    for i := 0 to Length(FDataArray) - 1 do
    begin
      if FDataArray[i].IdUsuario = id then
      begin
        FIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TUsuarios.PostDelete;
var i: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_Biblio,
       FDataArray[FIndex] do
  begin
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  USUARIO ' +
      'WHERE ' +
      '  IDUSUARIO = ' + IntToStr(IdUsuario);
    Execute;
  end;
  {apaga registro do array}
  if FIndex = Length(FDataArray) - 1 then
  begin
    FDataArray[FIndex].Free;
    SetLength(FDataArray,Length(FDataArray) - 1);
  end
  else
  begin
    for i := FIndex + 1 to Length(FDataArray) - 1 do
      FDataArray[i - 1].Assign(FDataArray[i]);
    FDataArray[Length(FDataArray) - 1].Free;
    SetLength(FDataArray,Length(FDataArray) - 1);
  end;
  {posiciona o registro}
  FIndex := FIndex - 1;
  if (FIndex = -1) and (Length(FDataArray) > 0) then
    FIndex := 0;
end;

procedure TUsuarios.Post;
begin
  if (FState = stRead) or (FState = stDBWait) then
    exit;
  Screen.Cursor := crSQLWait;
  case FState of
    stInsert: PostInsert;
    stDelete: PostDelete;
    stEdit: PostEdit;
  end;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

function TUsuarios.RecCount: Integer;
begin
  Result := Length(FDataArray);
end;

{-------------------- TDataModule_Biblio -----------------------}

procedure TDataModule_Biblio.DataModuleCreate(Sender: TObject);
var Path: String;
begin
  Path := ExtractFilePath(Application.ExeName) + 'database\';
  if not FileExists(Path + 'biblio.mdb') then
  begin
    with Application do
    begin
      MessageBox(PChar(MSG_SEMDB),PChar(CAP_SEMDB),MB_OKICONSTOP);
      Terminate;
    end;
  end;
  ADOConnection_Biblio.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;' +
    'Data Source=' + Path + 'biblio.mdb;' +
    'Mode=ReadWrite;Extended Properties="";Persist Security Info=False;' +
    'Jet OLEDB:System database="";Jet OLEDB:Registry Path="";' +
    'Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;' +
    'Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;' +
    'Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";' +
    'Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;' +
    'Jet OLEDB:Don' + #39 + 't Copy Locale on Compact=False;' +
    'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
  try
    ADOConnection_Biblio.Open;
  except
    on E: Exception do
    begin
      with Application do
      begin
        MessageBox(PChar(MSG_NOCONNDB + #10#13 + 'Erro: ' + E.Message),
                   PChar(CAP_NOCONNDB),MB_OKICONSTOP);
        Terminate;
      end;
    end;
  end;
end;

end.
