{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_DatabaseClasses.pas

  Contém as Classes de Dados da Aplicação

  Data última revisão: 06/11/2001

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
  TDataClass = class
  private
    { Private declarations }
    procedure SetRegistro(Value: TDataRecord);
    function GetRegistro: TDataRecord;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
    FState: Byte; {ver constantes na unit_Comum}
    FDataRecord: TDataRecord;
    {provê acesso aos registros de dados}
    property Registro: TDataRecord read GetRegistro write SetRegistro;
    {número do registro atual (posição do cursor)}
    property RecNo: Integer read GetRecNo;
    {lê o dataset do banco de dados para os registros do objeto}
    procedure Refresh; dynamic; abstract;
    {insere um novo registro no objeto}
    procedure Insert; dynamic; abstract;
    {grava no banco de dados os registros do objeto}
    procedure Post; dynamic; abstract;
    {atualiza o registro corrente com o do BD}
    procedure Read; dynamic; abstract;
    {movimentação do cursor nos registros do objeto}
    procedure First; dynamic; abstract;
    procedure Last; dynamic; abstract;
    procedure Prior; dynamic; abstract;
    procedure Next; dynamic; abstract;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); dynamic; abstract;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; dynamic; abstract;
    function Eof: Boolean; dynamic; abstract;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; dynamic; abstract;
  public
    { Public declarations }
    {retorna o estado do objeto (ver constantes na unit_Comum)}
    property State: Byte read FState;
    {construtor / destrutor}
    constructor Create; dynamic;
    destructor Destroy; override;
    {etita um registro no objeto}
    procedure Edit;
    {apaga um registro do objeto e do banco de dados}
    procedure Delete;
    {cancela uma alteração (insert ou edit) feita no objeto}
    procedure Cancel;
  end;

{**** Classe do DataModule - contém os componentes para a conexão ao BD *******}
{TDataModule_Biblio}
type
  TDataModule_Biblio = class(TDataModule)
    ADOConnection_Biblio: TADOConnection;
    ADOCommand_Usuarios: TADOCommand;
    ADODataSet_Usuarios: TADODataSet;
    ADOCommand_TipoUsuarios: TADOCommand;
    ADODataSet_TipoUsuarios: TADODataSet;
    ADODataSet_TipoFornecedores: TADODataSet;
    ADOCommand_TipoFornecedores: TADOCommand;
    ADODataSet_ClassificacaoAcervos: TADODataSet;
    ADOCommand_ClassificacaoAcervos: TADOCommand;
    ADODataSet_TipoAcervos: TADODataSet;
    ADOCommand_TipoAcervos: TADOCommand;
    ADODataSet_AreaAcervos: TADODataSet;
    ADOCommand_AreaAcervos: TADOCommand;
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

{TTipoFornecedor}
{um registro da tabela TIPOFORNECEDOR}
type
  TTipoFornecedor = class(TDataRecord)
  public
    { Public declarations }
    IdTipoFornecedor: Integer;
    Descricao: String20;
    constructor Create;
    procedure Assign(Source: TTipoFornecedor);
  end;

{TTipoAcervo}
{um registro da tabela TipoAcervo}
type
  TTipoAcervo = class(TDataRecord)
  public
    { Public declarations }
    IdTipoAcervo: Integer;
    Descricao: String20;
    PodeEmprestar: Boolean;
    constructor Create;
    procedure Assign(Source: TTipoAcervo);
  end;

{TAreaAcervo}
{um registro da tabela AreaAcervo}
type
  TAreaAcervo = class(TDataRecord)
  public
    { Public declarations }
    IdAreaAcervo: Integer;
    Descricao: String20;
    constructor Create;
    procedure Assign(Source: TAreaAcervo);
  end;

{TClassificacaoAcervo}
{um registro da tabela ClassificacaoAcervo}
type
  TClassificacaoAcervo = class(TDataRecord)
  public
    { Public declarations }
    IdClassificacaoAcervo: Integer;
    Descricao: String20;
    constructor Create;
    procedure Assign(Source: TClassificacaoAcervo);
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

{TUsuarios}
{contém os dados relativos ao Cadastro de Usuários}
type
  TUsuarios = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TUsuario;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TUsuario);
    function GetRegistro: TUsuario;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TUsuario read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure Search(var ADODataSet: TADODataSet; FilterStr: String);
    procedure LocateId(Id: Integer);
  end;

{TTipoUsuarios}
{contém os dados relativos ao Cadastro de Tipos de Usuários}
type
  TTipoUsuarios = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TTipoUsuario;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TTipoUsuario);
    function GetRegistro: TTipoUsuario;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TTipoUsuario read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TTipoFornecedores}
{contém os dados relativos ao Cadastro de Tipos de Fornecedores}
type
  TTipoFornecedores = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TTipoFornecedor;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TTipoFornecedor);
    function GetRegistro: TTipoFornecedor;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TTipoFornecedor read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TTipoAcervos}
{contém os dados relativos ao Cadastro de Tipos de Acervo}
type
  TTipoAcervos = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TTipoAcervo;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TTipoAcervo);
    function GetRegistro: TTipoAcervo;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TTipoAcervo read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TAreaAcervos}
{contém os dados relativos ao Cadastro de Áreas de Acervo}
type
  TAreaAcervos = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TAreaAcervo;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TAreaAcervo);
    function GetRegistro: TAreaAcervo;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TAreaAcervo read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TClassificacaoAcervos}
{contém os dados relativos ao Cadastro de Classificações de Acervo}
type
  TClassificacaoAcervos = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TClassificacaoAcervo;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TClassificacaoAcervo);
    function GetRegistro: TClassificacaoAcervo;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TClassificacaoAcervo read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read; override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount: Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
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
  FState := stRead;
  FDataRecord := TDataRecord.Create;
end;

destructor TDataClass.Destroy;
begin
  FDataRecord.Free;
  inherited Destroy;
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
begin
  {lê novamente os registros do BD}
  if (FState = stInsert) or (FState = stEdit) then
  begin
    FState := stRead;
    Self.Read;
  end;
end;

function TDataClass.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  Result := 0;
end;

procedure TDataClass.SetRegistro(Value: TDataRecord);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TDataClass.GetRegistro: TDataRecord;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
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
  {copia as propriedades de um outro TUsuario}
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
  {cria um objeto TTipoUsuario}
  inherited Create;
  IdTipoUsuario := 0;
  Descricao := '';
  TempoEmprestimo := 0;
  TempoSusp := 0;
  MaxExemplares := 0;
end;

procedure TTipoUsuario.Assign(Source: TTipoUsuario);
begin
  {copia as propriedades de um outro TTipoUsuario}
  IdTipoUsuario := Source.IdTipoUsuario;
  Descricao := Source.Descricao;
  TempoEmprestimo := Source.TempoEmprestimo;
  TempoSusp := Source.TempoSusp;
  MaxExemplares := Source.MaxExemplares;
end;

{-------------------- TTipoFornecedor -----------------------}

constructor TTipoFornecedor.Create;
begin
  {cria um objeto TTipoFornecedor}
  inherited Create;
  IdTipoFornecedor := 0;
  Descricao := '';
end;

procedure TTipoFornecedor.Assign(Source: TTipoFornecedor);
begin
  {copia as propriedades de um outro TTipoFornecedor}
  IdTipoFornecedor := Source.IdTipoFornecedor;
  Descricao := Source.Descricao;
end;

{-------------------- TTipoAcervo -----------------------}

constructor TTipoAcervo.Create;
begin
  {cria um objeto TTipoAcervo}
  inherited Create;
  IdTipoAcervo := 0;
  Descricao := '';
  PodeEmprestar := True;
end;

procedure TTipoAcervo.Assign(Source: TTipoAcervo);
begin
  {copia as propriedades de um outro TTipoAcervo}
  IdTipoAcervo := Source.IdTipoAcervo;
  Descricao := Source.Descricao;
  PodeEmprestar := Source.PodeEmprestar;
end;

{-------------------- TAreaAcervo -----------------------}

constructor TAreaAcervo.Create;
begin
  {cria um objeto TAreaAcervo}
  inherited Create;
  IdAreaAcervo := 0;
  Descricao := '';
end;

procedure TAreaAcervo.Assign(Source: TAreaAcervo);
begin
  {copia as propriedades de um outro TAreaAcervo}
  IdAreaAcervo := Source.IdAreaAcervo;
  Descricao := Source.Descricao;
end;

{-------------------- TClassificacaoAcervo -----------------------}

constructor TClassificacaoAcervo.Create;
begin
  {cria um objeto TClassificacaoAcervo}
  inherited Create;
  IdClassificacaoAcervo := 0;
  Descricao := '';
end;

procedure TClassificacaoAcervo.Assign(Source: TClassificacaoAcervo);
begin
  {copia as propriedades de um outro TClassificacaoAcervo}
  IdClassificacaoAcervo := Source.IdClassificacaoAcervo;
  Descricao := Source.Descricao;
end;

{-------------------- TUsuarios -----------------------}

constructor TUsuarios.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TUsuario.Create;
  DataModule_Biblio.ADODataSet_Usuarios.Close;
end;

procedure TUsuarios.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_Usuarios do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TUsuarios.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Usuarios do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TUsuarios.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TUsuarios.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TUsuarios.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TUsuarios.SetRegistro(Value: TUsuario);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TUsuarios.GetRegistro: TUsuario;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TUsuarios.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Result := (RecNo = 1);
end;

function TUsuarios.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Result := (RecNo = RecordCount);
end;

function TUsuarios.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Result := RecordCount;
end;

function TUsuarios.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Result := RecNo;
end;

procedure TUsuarios.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TUsuario.Create;
    FState := stInsert;
  end;
end;

procedure TUsuarios.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_Usuarios,
       DataModule_Biblio.ADOCommand_Usuarios do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_Usuarios.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT ' +
      '  U.*, T.DESCRICAO, T.TEMPOEMPRESTIMO, T.TEMPOSUSP, T.MAXEXEMPLARES ' +
      'FROM ' +
      '  USUARIO U, TIPOUSUARIO T ' +
      'WHERE ' +
      '  U.IDTIPOUSUARIO = T.IDTIPOUSUARIO ' +
      'ORDER BY U.NOME';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TUsuarios.Read;
var i: Integer;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_Usuarios, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
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
end;

procedure TUsuarios.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_Usuarios.RecNo;
  DataModule_Biblio.ADODataSet_Usuarios.Close;
  with DataModule_Biblio.ADODataSet_Usuarios,
       DataModule_Biblio.ADOCommand_Usuarios,
       FDataRecord, FDataRecord.TipoUsuario do
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
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdUsuario do registro}
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
      '  (SITUACAO = ' + #39 + Situacao + #39 + ') AND ' +
      '  (IDTIPOUSUARIO = ' +  IntToStr(IdTipoUsuario) + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdUsuario').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdUsuario', id,[]);
  end;
  Self.Read;
end;

procedure TUsuarios.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_Usuarios.Close;
  with DataModule_Biblio.ADODataSet_Usuarios,
       DataModule_Biblio.ADOCommand_Usuarios,
       FDataRecord, FDataRecord.TipoUsuario do
  begin
    {Faz Update do registro na Tabela}
    id := IdUsuario;
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
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdUsuario', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdUsuario', id,[]);
    Self.Read;
  end;
end;

procedure TUsuarios.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_Usuarios, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_Usuarios.RecNo;
    DataModule_Biblio.ADODataSet_Usuarios.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  USUARIO ' +
      'WHERE ' +
      '  IDUSUARIO = ' + IntToStr(IdUsuario);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TUsuarios.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TUsuarios.Search(var ADODataSet: TADODataSet; FilterStr: String);
begin
  Screen.Cursor := crSQLWait;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    ADODataSet.Close;
    ADODataSet.Connection := ADOConnection_Biblio;
    with ADOCommand_Usuarios do
    begin
      CommandText :=
        'SELECT ' +
        '  U.Nome, U.ENDERECO AS Endereço, U.Bairro, U.Cidade, U.Estado, ' +
        '  U.CEP, U.RGA, U.RG, U.CPF, U.DATACADASTRO AS Data_de_Cadastro, ' +
        '  T.DESCRICAO AS Tipo_de_Usuário, U.IDUSUARIO AS Idx ' +
        'FROM ' +
        '  USUARIO U, TIPOUSUARIO T ' +
        'WHERE ' +
        '  (U.IDTIPOUSUARIO = T.IDTIPOUSUARIO) ';
      if FilterStr <> '' then
        CommandText := CommandText + ' AND (' + FilterStr + ')';
      CommandText := CommandText + ' ORDER BY U.NOME';
      try
        ADODataSet.RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Screen.Cursor := crDefault;
          FState := stRead;
          exit;
        end;
      end;
    end;
    ADODataSet.Open;
    Screen.Cursor := crDefault;
    FState := stRead;
  end;
end;

procedure TUsuarios.LocateId(Id: Integer);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_Usuarios do
    Locate('IdUsuario', Id,[]);
  Self.Read;
end;

{-------------------- TTipoUsuarios -----------------------}

constructor TTipoUsuarios.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TTipoUsuario.Create;
  DataModule_Biblio.ADODataSet_TipoUsuarios.Close;
end;

procedure TTipoUsuarios.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TTipoUsuarios.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TTipoUsuarios.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TTipoUsuarios.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TTipoUsuarios.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TTipoUsuarios.SetRegistro(Value: TTipoUsuario);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TTipoUsuarios.GetRegistro: TTipoUsuario;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TTipoUsuarios.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Result := (RecNo = 1);
end;

function TTipoUsuarios.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Result := (RecNo = RecordCount);
end;

function TTipoUsuarios.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Result := RecordCount;
end;

function TTipoUsuarios.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Result := RecNo;
end;

procedure TTipoUsuarios.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TTipoUsuario.Create;
    FState := stInsert;
  end;
end;

procedure TTipoUsuarios.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_TipoUsuarios,
       DataModule_Biblio.ADOCommand_TipoUsuarios do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_TipoUsuarios.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  TIPOUSUARIO ' +
      'ORDER BY DESCRICAO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TTipoUsuarios.Read;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_TipoUsuarios, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdTipoUsuario := FieldByName('IdTipoUsuario').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
    TempoEmprestimo := FieldByName('TempoEmprestimo').AsInteger;
    TempoSusp := FieldByName('TempoSusp').AsInteger;
    MaxExemplares := FieldByName('MaxExemplares').AsInteger;
  end;
end;

procedure TTipoUsuarios.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_TipoUsuarios.RecNo;
  DataModule_Biblio.ADODataSet_TipoUsuarios.Close;
  with DataModule_Biblio.ADODataSet_TipoUsuarios,
       DataModule_Biblio.ADOCommand_TipoUsuarios, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  TIPOUSUARIO ' +
      '    (DESCRICAO,' +
      '     TEMPOEMPRESTIMO,' +
      '     TEMPOSUSP,' +
      '     MAXEXEMPLARES) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ',' +
      '   ' + IntToStr(TempoEmprestimo) + ',' +
      '   ' + IntToStr(TempoSusp) + ',' +
      '   ' + IntToStr(MaxExemplares) + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdTipoUsuario do registro}
    CommandText :=
      'SELECT ' +
      '  IDTIPOUSUARIO ' +
      'FROM ' +
      '  TIPOUSUARIO ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ') AND ' +
      '  (TEMPOEMPRESTIMO = ' + IntToStr(TempoEmprestimo) + ') AND ' +
      '  (TEMPOSUSP = ' + IntToStr(TempoSusp) + ') AND ' +
      '  (MAXEXEMPLARES = ' + IntToStr(MaxExemplares) + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdTipoUsuario').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoUsuario', id,[]);
  end;
  Self.Read;
end;

procedure TTipoUsuarios.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_TipoUsuarios.Close;
  with DataModule_Biblio.ADODataSet_TipoUsuarios,
       DataModule_Biblio.ADOCommand_TipoUsuarios, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdTipoUsuario;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOUSUARIO ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ',' +
      '  TEMPOEMPRESTIMO = ' + IntToStr(TempoEmprestimo) + ',' +
      '  TEMPOSUSP = ' + IntToStr(TempoSusp) + ',' +
      '  MAXEXEMPLARES = ' + IntToStr(MaxExemplares) + ' ' +
      'WHERE ' +
      '  IDTIPOUSUARIO = ' + IntToStr(IdTipoUsuario);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdTipoUsuario', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoUsuario', id,[]);
    Self.Read;
  end;
end;

procedure TTipoUsuarios.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_TipoUsuarios, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_TipoUsuarios.RecNo;
    DataModule_Biblio.ADODataSet_TipoUsuarios.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  TIPOUSUARIO ' +
      'WHERE ' +
      '  IDTIPOUSUARIO = ' + IntToStr(IdTipoUsuario);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TTipoUsuarios.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TTipoUsuarios.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_TipoUsuarios do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TTipoUsuarios.Exists(Descricao: String): Boolean;
var i: Integer;
begin
  {retorna True se tipo de usuário existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.Descricao = Descricao then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TTipoFornecedores -----------------------}

constructor TTipoFornecedores.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TTipoFornecedor.Create;
  DataModule_Biblio.ADODataSet_TipoFornecedores.Close;
end;

procedure TTipoFornecedores.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TTipoFornecedores.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TTipoFornecedores.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TTipoFornecedores.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TTipoFornecedores.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TTipoFornecedores.SetRegistro(Value: TTipoFornecedor);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TTipoFornecedores.GetRegistro: TTipoFornecedor;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TTipoFornecedores.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Result := (RecNo = 1);
end;

function TTipoFornecedores.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Result := (RecNo = RecordCount);
end;

function TTipoFornecedores.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Result := RecordCount;
end;

function TTipoFornecedores.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Result := RecNo;
end;

procedure TTipoFornecedores.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TTipoFornecedor.Create;
    FState := stInsert;
  end;
end;

procedure TTipoFornecedores.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_TipoFornecedores,
       DataModule_Biblio.ADOCommand_TipoFornecedores do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_TipoFornecedores.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  TIPOFORNECEDOR ' +
      'ORDER BY DESCRICAO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TTipoFornecedores.Read;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_TipoFornecedores, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdTipoFornecedor := FieldByName('IdTipoFornecedor').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
  end;
end;

procedure TTipoFornecedores.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_TipoFornecedores.RecNo;
  DataModule_Biblio.ADODataSet_TipoFornecedores.Close;
  with DataModule_Biblio.ADODataSet_TipoFornecedores,
       DataModule_Biblio.ADOCommand_TipoFornecedores, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  TIPOFORNECEDOR ' +
      '    (DESCRICAO) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdTipoFornecedor do registro}
    CommandText :=
      'SELECT ' +
      '  IDTIPOFORNECEDOR ' +
      'FROM ' +
      '  TIPOFORNECEDOR ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdTipoFornecedor').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoFornecedor', id,[]);
  end;
  Self.Read;
end;

procedure TTipoFornecedores.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_TipoFornecedores.Close;
  with DataModule_Biblio.ADODataSet_TipoFornecedores,
       DataModule_Biblio.ADOCommand_TipoFornecedores, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdTipoFornecedor;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOFORNECEDOR ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ' ' +
      'WHERE ' +
      '  IDTIPOFORNECEDOR = ' + IntToStr(IdTipoFornecedor);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdTipoFornecedor', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoFornecedor', id,[]);
    Self.Read;
  end;
end;

procedure TTipoFornecedores.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_TipoFornecedores, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_TipoFornecedores.RecNo;
    DataModule_Biblio.ADODataSet_TipoFornecedores.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  TIPOFORNECEDOR ' +
      'WHERE ' +
      '  IDTIPOFORNECEDOR = ' + IntToStr(IdTipoFornecedor);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TTipoFornecedores.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TTipoFornecedores.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_TipoFornecedores do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TTipoFornecedores.Exists(Descricao: String): Boolean;
var i: Integer;
begin
  {retorna True se tipo de usuário existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.Descricao = Descricao then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TTipoAcervos -----------------------}

constructor TTipoAcervos.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TTipoAcervo.Create;
  DataModule_Biblio.ADODataSet_TipoAcervos.Close;
end;

procedure TTipoAcervos.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TTipoAcervos.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TTipoAcervos.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TTipoAcervos.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TTipoAcervos.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TTipoAcervos.SetRegistro(Value: TTipoAcervo);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TTipoAcervos.GetRegistro: TTipoAcervo;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TTipoAcervos.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Result := (RecNo = 1);
end;

function TTipoAcervos.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Result := (RecNo = RecordCount);
end;

function TTipoAcervos.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Result := RecordCount;
end;

function TTipoAcervos.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Result := RecNo;
end;

procedure TTipoAcervos.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TTipoAcervo.Create;
    FState := stInsert;
  end;
end;

procedure TTipoAcervos.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_TipoAcervos,
       DataModule_Biblio.ADOCommand_TipoAcervos do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_TipoAcervos.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  TIPOACERVO ' +
      'ORDER BY DESCRICAO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TTipoAcervos.Read;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_TipoAcervos, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdTipoAcervo := FieldByName('IdTipoAcervo').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
    PodeEmprestar := FieldByName('PodeEmprestar').AsBoolean;
  end;
end;

procedure TTipoAcervos.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_TipoAcervos.RecNo;
  DataModule_Biblio.ADODataSet_TipoAcervos.Close;
  with DataModule_Biblio.ADODataSet_TipoAcervos,
       DataModule_Biblio.ADOCommand_TipoAcervos, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  TIPOACERVO ' +
      '    (DESCRICAO, ' +
      '     PODEEMPRESTAR) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ',' +
      '   ' + BoolToAccessStr(PodeEmprestar) + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdTipoAcervo do registro}
    CommandText :=
      'SELECT ' +
      '  IDTIPOACERVO ' +
      'FROM ' +
      '  TIPOACERVO ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ') AND ' +
      '  (PODEEMPRESTAR = ' + BoolToAccessStr(PodeEmprestar) + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdTipoAcervo').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoAcervo', id,[]);
  end;
  Self.Read;
end;

procedure TTipoAcervos.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_TipoAcervos.Close;
  with DataModule_Biblio.ADODataSet_TipoAcervos,
       DataModule_Biblio.ADOCommand_TipoAcervos, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdTipoAcervo;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOACERVO ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ', ' +
      '  PODEEMPRESTAR = ' + BoolToAccessStr(PodeEmprestar) + ' ' +
      'WHERE ' +
      '  IDTIPOACERVO = ' + IntToStr(IdTipoAcervo);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdTipoAcervo', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdTipoAcervo', id,[]);
    Self.Read;
  end;
end;

procedure TTipoAcervos.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_TipoAcervos, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_TipoAcervos.RecNo;
    DataModule_Biblio.ADODataSet_TipoAcervos.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  TIPOACERVO ' +
      'WHERE ' +
      '  IDTIPOACERVO = ' + IntToStr(IdTipoAcervo);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TTipoAcervos.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TTipoAcervos.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_TipoAcervos do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TTipoAcervos.Exists(Descricao: String): Boolean;
var i: Integer;
begin
  {retorna True se tipo de acervo existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.Descricao = Descricao then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TAreaAcervos -----------------------}

constructor TAreaAcervos.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TAreaAcervo.Create;
  DataModule_Biblio.ADODataSet_AreaAcervos.Close;
end;

procedure TAreaAcervos.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TAreaAcervos.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TAreaAcervos.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TAreaAcervos.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TAreaAcervos.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TAreaAcervos.SetRegistro(Value: TAreaAcervo);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TAreaAcervos.GetRegistro: TAreaAcervo;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TAreaAcervos.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Result := (RecNo = 1);
end;

function TAreaAcervos.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Result := (RecNo = RecordCount);
end;

function TAreaAcervos.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Result := RecordCount;
end;

function TAreaAcervos.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Result := RecNo;
end;

procedure TAreaAcervos.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TAreaAcervo.Create;
    FState := stInsert;
  end;
end;

procedure TAreaAcervos.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_AreaAcervos,
       DataModule_Biblio.ADOCommand_AreaAcervos do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_AreaAcervos.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  TIPOAREA ' +
      'ORDER BY DESCRICAO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TAreaAcervos.Read;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_AreaAcervos, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdAreaAcervo := FieldByName('IdArea').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
  end;
end;

procedure TAreaAcervos.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_AreaAcervos.RecNo;
  DataModule_Biblio.ADODataSet_AreaAcervos.Close;
  with DataModule_Biblio.ADODataSet_AreaAcervos,
       DataModule_Biblio.ADOCommand_AreaAcervos, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  TIPOAREA ' +
      '    (DESCRICAO) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdAreaAcervo do registro}
    CommandText :=
      'SELECT ' +
      '  IDAREA ' +
      'FROM ' +
      '  TIPOAREA ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdArea').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdArea', id,[]);
  end;
  Self.Read;
end;

procedure TAreaAcervos.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_AreaAcervos.Close;
  with DataModule_Biblio.ADODataSet_AreaAcervos,
       DataModule_Biblio.ADOCommand_AreaAcervos, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdAreaAcervo;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOAREA ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ' ' +
      'WHERE ' +
      '  IDAREA = ' + IntToStr(IdAreaAcervo);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdArea', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdArea', id,[]);
    Self.Read;
  end;
end;

procedure TAreaAcervos.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_AreaAcervos, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_AreaAcervos.RecNo;
    DataModule_Biblio.ADODataSet_AreaAcervos.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  TIPOAREA ' +
      'WHERE ' +
      '  IDAREA = ' + IntToStr(IdAreaAcervo);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TAreaAcervos.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TAreaAcervos.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_AreaAcervos do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TAreaAcervos.Exists(Descricao: String): Boolean;
var i: Integer;
begin
  {retorna True se area de acervo existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.Descricao = Descricao then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TClassificacaoAcervos -----------------------}

constructor TClassificacaoAcervos.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TClassificacaoAcervo.Create;
  DataModule_Biblio.ADODataSet_ClassificacaoAcervos.Close;
end;

procedure TClassificacaoAcervos.GotoReg(RecIndex: Integer);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TClassificacaoAcervos.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TClassificacaoAcervos.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TClassificacaoAcervos.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TClassificacaoAcervos.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TClassificacaoAcervos.SetRegistro(Value: TClassificacaoAcervo);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TClassificacaoAcervos.GetRegistro: TClassificacaoAcervo;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TClassificacaoAcervos.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Result := (RecNo = 1);
end;

function TClassificacaoAcervos.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Result := (RecNo = RecordCount);
end;

function TClassificacaoAcervos.RecCount: Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Result := RecordCount;
end;

function TClassificacaoAcervos.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Result := RecNo;
end;

procedure TClassificacaoAcervos.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TClassificacaoAcervo.Create;
    FState := stInsert;
  end;
end;

procedure TClassificacaoAcervos.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos,
       DataModule_Biblio.ADOCommand_ClassificacaoAcervos do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_ClassificacaoAcervos.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  TIPOCLASSIFICACAO ' +
      'ORDER BY DESCRICAO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read;
  FState := stRead;
  Screen.Cursor := crDefault;
end;

procedure TClassificacaoAcervos.Read;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdClassificacaoAcervo := FieldByName('IdClassificacao').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
  end;
end;

procedure TClassificacaoAcervos.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_ClassificacaoAcervos.RecNo;
  DataModule_Biblio.ADODataSet_ClassificacaoAcervos.Close;
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos,
       DataModule_Biblio.ADOCommand_ClassificacaoAcervos, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  TIPOCLASSIFICACAO ' +
      '    (DESCRICAO) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    {Lê o IdClassificacaoAcervo do registro}
    CommandText :=
      'SELECT ' +
      '  IDCLASSIFICACAO ' +
      'FROM ' +
      '  TIPOCLASSIFICACAO ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ')';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    id := FieldByName('IdClassificacao').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdClassificacao', id,[]);
  end;
  Self.Read;
end;

procedure TClassificacaoAcervos.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_ClassificacaoAcervos.Close;
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos,
       DataModule_Biblio.ADOCommand_ClassificacaoAcervos, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdClassificacaoAcervo;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOCLASSIFICACAO ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ' ' +
      'WHERE ' +
      '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacaoAcervo);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Locate('IdClassificacao', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdClassificacao', id,[]);
    Self.Read;
  end;
end;

procedure TClassificacaoAcervos.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_ClassificacaoAcervos, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_ClassificacaoAcervos.RecNo;
    DataModule_Biblio.ADODataSet_ClassificacaoAcervos.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  TIPOCLASSIFICACAO ' +
      'WHERE ' +
      '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacaoAcervo);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        FState := stRead;
        Self.Refresh;
        GotoReg(id);
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
  Self.Refresh;
  if id - 1 > 0 then
    GotoReg(id - 1);
  Self.Read;
end;

procedure TClassificacaoAcervos.Post;
begin
  {grava o registro atual no banco de dados}
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

procedure TClassificacaoAcervos.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TClassificacaoAcervos.Exists(Descricao: String): Boolean;
var i: Integer;
begin
  {retorna True se class. de acervo existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.Descricao = Descricao then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TDataModule_Biblio -----------------------}

procedure TDataModule_Biblio.DataModuleCreate(Sender: TObject);
var Path: String;
    FTipoUsuarios: TTipoUsuarios;
    FTipoFornecedores: TTipoFornecedores;
    FTipoAcervos: TTipoAcervos;
    FAreaAcervos: TAreaAcervos;
    FClassificacaoAcervos: TClassificacaoAcervos;
begin
  {verifica se existe o Banco de Dados}
  Path := ExtractFilePath(Application.ExeName) + 'database\';
  if not FileExists(Path + 'biblio.mdb') then
  begin
    with Application do
    begin
      MessageBox(MSG_SEMDB,CAP_SEMDB,MB_OKICONSTOP);
      Terminate;
    end;
  end;
  {Faz a conexão ao Banco de Dados}
  Screen.Cursor := crSQLWait;
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
        Screen.Cursor := crDefault;
        MessageBox(PChar(MSG_NOCONNDB + E.Message),CAP_NOCONNDB,MB_OKICONSTOP);
        Terminate;
      end;
    end;
  end;
  {cria os tipos de usuário padrão do sistema, se não existirem}
  FTipoUsuarios := TTipoUsuarios.Create;
  with FTipoUsuarios do
  begin
    Refresh;
    if not Exists('ALUNO') then
    begin
      Insert;
      Registro.Descricao := 'ALUNO';
      Post;
    end;
    if not Exists('PROFESSOR') then
    begin
      Insert;
      Registro.Descricao := 'PROFESSOR';
      Post;
    end;
    if not Exists('BIBLIOTECÁRIO') then
    begin
      Insert;
      Registro.Descricao := 'BIBLIOTECÁRIO';
      Post;
    end;
    if not Exists('FUNCIONÁRIO') then
    begin
      Insert;
      Registro.Descricao := 'FUNCIONÁRIO';
      Post;
    end;
    Free;
  end;
  {cria os tipos de fornecedor padrão do sistema, se não existirem}
  FTipoFornecedores := TTipoFornecedores.Create;
  with FTipoFornecedores do
  begin
    Refresh;
    if not Exists('LIVRARIA') then
    begin
      Insert;
      Registro.Descricao := 'LIVRARIA';
      Post;
    end;
    if not Exists('EDITORA') then
    begin
      Insert;
      Registro.Descricao := 'EDITORA';
      Post;
    end;
    Free;
  end;
  {cria os tipos de acervo padrão do sistema, se não existirem}
  FTipoAcervos := TTipoAcervos.Create;
  with FTipoAcervos do
  begin
    Refresh;
    if not Exists('LIVRO') then
    begin
      Insert;
      Registro.Descricao := 'LIVRO';
      Post;
    end;
    if not Exists('ENCICLOPÉDIA') then
    begin
      Insert;
      Registro.Descricao := 'ENCICLOPÉDIA';
      Post;
    end;
    Free;
  end;
  {cria as áreas de acervo padrão do sistema, se não existirem}
  FAreaAcervos := TAreaAcervos.Create;
  with FAreaAcervos do
  begin
    Refresh;
    if not Exists('PORTUGUÊS') then
    begin
      Insert;
      Registro.Descricao := 'PORTUGUÊS';
      Post;
    end;
    if not Exists('MATEMÁTICA') then
    begin
      Insert;
      Registro.Descricao := 'MATEMÁTICA';
      Post;
    end;
    if not Exists('CIÊNCIAS') then
    begin
      Insert;
      Registro.Descricao := 'CIÊNCIAS';
      Post;
    end;
    if not Exists('ESTUDOS SOCIAIS') then
    begin
      Insert;
      Registro.Descricao := 'ESTUDOS SOCIAIS';
      Post;
    end;
    Free;
  end;
  {cria as classificações de acervo padrão do sistema, se não existirem}
  FClassificacaoAcervos := TClassificacaoAcervos.Create;
  with FClassificacaoAcervos do
  begin
    Refresh;
    if not Exists('AVALIAÇÃO') then
    begin
      Insert;
      Registro.Descricao := 'AVALIAÇÃO';
      Post;
    end;
    if not Exists('DIDÁTICO') then
    begin
      Insert;
      Registro.Descricao := 'DIDÁTICO';
      Post;
    end;
    if not Exists('RECREAÇÃO') then
    begin
      Insert;
      Registro.Descricao := 'RECREAÇÃO';
      Post;
    end;
    Free;
  end;
  Screen.Cursor := crDefault;
end;

end.
