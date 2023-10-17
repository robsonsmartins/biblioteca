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
    procedure Read(Explorer: Boolean = False); dynamic; abstract;
    {movimentação do cursor nos registros do objeto}
    procedure First; dynamic; abstract;
    procedure Last; dynamic; abstract;
    procedure Prior; dynamic; abstract;
    procedure Next; dynamic; abstract;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer;
                      Explorer: Boolean = False); dynamic; abstract;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; dynamic; abstract;
    function Eof: Boolean; dynamic; abstract;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; dynamic; abstract;
  public
    { Public declarations }
    {retorna o estado do objeto (ver constantes na unit_Comum)}
    property State: Byte read FState write FState;
    {construtor / destrutor}
    constructor Create; dynamic;
    destructor Destroy; override;
    {etita um registro no objeto}
    procedure Edit;
    {apaga um registro do objeto e do banco de dados}
    procedure Delete; dynamic;
    {cancela uma alteração (insert ou edit) feita no objeto}
    procedure Cancel;
    {transações}
    procedure BeginTrans;
    procedure CommitTrans;
    procedure RollBackTrans;
    function InTransaction: Boolean;
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
    ADODataSet_GrupoLogins: TADODataSet;
    ADOCommand_GrupoLogins: TADOCommand;
    ADOCommand_ContaLogins: TADOCommand;
    ADODataSet_ContaLogins: TADODataSet;
    ADOCommand_RegLogin: TADOCommand;
    ADODataSet_RegLogin: TADODataSet;
    ADOCommand_Fornecedores: TADOCommand;
    ADODataSet_Fornecedores: TADODataSet;
    ADOCommand_Acervos: TADOCommand;
    ADODataSet_Acervos: TADODataSet;
    ADODataSet_Exemplares: TADODataSet;
    ADOCommand_Exemplares: TADOCommand;
    ADODataSet_Explorer: TADODataSet;
    ADOCommand_Explorer: TADOCommand;
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
    IdArea: Integer;
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
    IdClassificacao: Integer;
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

{TFornecedor}
{um registro da tabela FORNECEDOR (contém também um TIPOFORNECEDOR)}
type
  TFornecedor = class(TDataRecord)
  public
    { Public declarations }
    IdFornec: Integer;
    Nome: String50;
    Endereco: String80;
    Bairro: String20;
    Cidade: String20;
    Estado: String2;
    CEP: String10;
    Telefones: AnsiString;
    DataCadastro: TDateTime;
    TipoFornecedor: TTipoFornecedor;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TFornecedor);
  end;

{TAcervo}
{um registro da tabela ACERVO}
type
  TAcervo = class(TDataRecord)
  public
    { Public declarations }
    Tombo: Integer;
    Situacao: Char;
    Titulo: String50;
    Autor: String50;
    Editora: String50;
    Colecao: String50;
    Volume: Integer;
    Edicao: Integer;
    Ano: Integer;
    Paginas: Integer;
    Assunto: String50;
    FaixaEtaria: String20;
    Localizacao: String20;
    DataCadastro: TDateTime;
    TipoAcervo: TTipoAcervo;
    AreaAcervo: TAreaAcervo;
    ClassificacaoAcervo: TClassificacaoAcervo;
    Fornecedor: TFornecedor;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TAcervo);
  end;

{TDireitos}
{Campo Permissoes de GRUPOLOGIN traduzido}
type
  TDireitos = class(TDataRecord)
  public
    { Public declarations }
    VerCadUsuarios: Boolean;
    VerCadFornecedores: Boolean;
    VerCadAcervo: Boolean;
    VerPainelControle: Boolean;
    VerExplorer: Boolean;
    VerRelatorios: Boolean;
    AlterarCadUsuarios: Boolean;
    AlterarCadFornecedores: Boolean;
    AlterarCadAcervo: Boolean;
    Emprestar: Boolean;
    Devolver: Boolean;
    MoverPerdido: Boolean;
    Reservar: Boolean;
  end;

{TGrupoLogin}
{um registro da tabela GRUPOLOGIN}
type
  TGrupoLogin = class(TDataRecord)
  public
    { Public declarations }
    IdGrupo: Integer;
    Descricao: String20;
    Permissoes: String20;
    constructor Create;
    procedure Assign(Source: TGrupoLogin);
    procedure SetPermissoes(Direitos: TDireitos);
    procedure GetPermissoes(var Direitos: TDireitos);
  end;

{TContaLogin}
{um registro da tabela CONTALOGIN}
type
  TContaLogin = class(TDataRecord)
  public
    { Public declarations }
    IdConta: Integer;
    Nome: String50;
    UserName: String10;
    Senha: String10;
    GrupoLogin: TGrupoLogin;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TContaLogin);
    function GetPassword: String;
    procedure SetPassword(Password: String);
  end;

{TRegistroLogin}
{tabela REGLOGIN}
type
  TRegistroLogin = class(TDataRecord)
  public
    { Public declarations }
    procedure Login(IdConta: Integer);
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    procedure Search(var ADODataSet: TADODataSet; FilterStr: String);
    procedure LocateId(Id: Integer);
    function Exists(RGA: String): Boolean;
  end;

{TFornecedores}
{contém os dados relativos ao Cadastro de Fornecedores}
type
  TFornecedores = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TFornecedor;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TFornecedor);
    function GetRegistro: TFornecedor;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TFornecedor read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    procedure Search(var ADODataSet: TADODataSet; FilterStr: String);
    procedure LocateId(Id: Integer);
    procedure LocateNome(Nm: String);
    function Exists(Nome: String): Boolean;
  end;

{TAcervos}
{contém os dados relativos ao Cadastro de Acervos}
type
  TExemplar = record
    Tombo: Integer;
    Situacao: Char;
  end;
type
  TExemplares = Array of TExemplar;
type
  TClasse = Array of String;
type
  TClasses = record
    TipoAcervo, AreaAcervo, ClassificacaoAcervo: TClasse;
  end;
type
  TAcervos = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TAcervo;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TAcervo);
    function GetRegistro: TAcervo;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TAcervo read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    procedure Delete; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    {pesquisa e localização}
    procedure Search(var ADODataSet: TADODataSet; FilterStr: String);
    procedure LocateTombo(Tmb: Integer);
    function Exists(Tmb: Integer): Boolean;
    procedure GetExemplares(var Exemplares: TExemplares);
    procedure GetClasses(var Classes: TClasses);
    procedure GetTitulos(Tipo,Area,Classificacao: String);
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
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
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TGrupoLogins}
{contém os dados relativos ao Cadastro de Grupos de Login}
type
  TGrupoLogins = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TGrupoLogin;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TGrupoLogin);
    function GetRegistro: TGrupoLogin;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TGrupoLogin read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    procedure LocateDescricao(Descricao: String);
    function Exists(Descricao: String): Boolean;
  end;

{TContaLogins}
{contém os dados relativos ao Cadastro de Contas de Login}
type
  TContaLogins = class(TDataClass)
  private
    { Private declarations }
    {rotinas de gravação no BD}
    FDataRecord: TContaLogin;
    procedure PostInsert;
    procedure PostDelete;
    procedure PostEdit;
    {rotinas para atribuir propriedades}
    procedure SetRegistro(Value: TContaLogin);
    function GetRegistro: TContaLogin;
    function GetRecNo: Integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {redeclaração das propriedades e reimplementação dos métodos do TDataClass}
    constructor Create; override;
    property RecNo: Integer read GetRecNo;
    property Registro: TContaLogin read GetRegistro write SetRegistro;
    procedure Refresh; override;
    procedure Insert; override;
    {grava no banco de dados os registros do objeto}
    procedure Post; override;
    {atualiza o registro corrente com o do BD}
    procedure Read(Explorer: Boolean = False); override;
    {movimentação do cursor nos registros do objeto}
    procedure First; override;
    procedure Last; override;
    procedure Prior; override;
    procedure Next; override;
    {vai direto para um registro na posição especificada}
    procedure GotoReg(RecIndex: Integer; Explorer: Boolean = False); override;
    {retorna a posição do cursor Begin Of File (primeiro registro) ou
     End Of File (último registro) no objeto}
    function Bof: Boolean; override;
    function Eof: Boolean; override;
    {retorna a quantidade de registros do objeto}
    function RecCount(Explorer: Boolean = False): Integer; override;
    procedure LocateUserName(UserName: String);
    function Exists(UserName: String): Boolean;
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

procedure TDataClass.BeginTrans;
begin
  with DataModule_Biblio.ADOConnection_Biblio do
  begin
    if not InTransaction then
      BeginTrans;
  end;
end;

procedure TDataClass.CommitTrans;
begin
  with DataModule_Biblio.ADOConnection_Biblio do
  begin
    if InTransaction then
      CommitTrans;
  end;
end;

function TDataClass.InTransaction: Boolean;
begin
  with DataModule_Biblio.ADOConnection_Biblio do
  begin
    Result := InTransaction;
  end;
end;

procedure TDataClass.RollBackTrans;
begin
  with DataModule_Biblio.ADOConnection_Biblio do
  begin
    if InTransaction then
      RollBackTrans;
  end;
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

{-------------------- TFornecedor -----------------------}

constructor TFornecedor.Create;
begin
  inherited Create;
  {inicializa os campos do TFornecedor}
  IdFornec := 0;
  Nome := '';
  Endereco := '';
  Bairro := '';
  Cidade := '';
  Estado := 'SP';
  CEP := '';
  Telefones := '';
  DataCadastro := Date;
  TipoFornecedor := TTipoFornecedor.Create;
end;

destructor TFornecedor.Destroy;
begin
  {destrói o objeto de Tipo de Fornecedor}
  TipoFornecedor.Free;
  inherited Destroy;
end;

procedure TFornecedor.Assign(Source: TFornecedor);
begin
  {copia as propriedades de um outro TFornecedor}
  IdFornec := Source.IdFornec;
  Nome := Source.Nome;
  Endereco := Source.Endereco;
  Bairro := Source.Bairro;
  Cidade := Source.Cidade;
  Estado := Source.Estado;
  CEP := Source.CEP;
  Telefones := Source.Telefones;
  DataCadastro := Source.DataCadastro;
  TipoFornecedor.Assign(Source.TipoFornecedor);
end;

{-------------------- TAcervo -----------------------}

constructor TAcervo.Create;
begin
  inherited Create;
  {inicializa os campos do TAcervo}
  Tombo := 0;
  Situacao := 'D';
  Titulo := '';
  Autor := '';
  Editora := '';
  Colecao := '';
  Volume := 1;
  Edicao := 1;
  Ano := 2001;
  Paginas := 0;
  Assunto := '';
  FaixaEtaria := '0099';
  Localizacao := '';
  DataCadastro := Date;
  TipoAcervo := TTipoAcervo.Create;
  AreaAcervo := TAreaAcervo.Create;
  ClassificacaoAcervo := TClassificacaoAcervo.Create;
  Fornecedor := TFornecedor.Create;
end;

destructor TAcervo.Destroy;
begin
  {destrói o objeto de Tipo de Acervo}
  TipoAcervo.Free;
  AreaAcervo.Free;
  ClassificacaoAcervo.Free;
  Fornecedor.Free;
  inherited Destroy;
end;

procedure TAcervo.Assign(Source: TAcervo);
begin
  {copia as propriedades de um outro TAcervo}
  Titulo := Source.Titulo;
  Autor := Source.Autor;
  Editora := Source.Editora;
  Colecao := Source.Colecao;
  Volume := Source.Volume;
  Edicao := Source.Edicao;
  Ano := Source.Ano;
  Paginas := Source.Paginas;
  Assunto := Source.Assunto;
  FaixaEtaria := Source.FaixaEtaria;
  Localizacao := Source.Localizacao;
  DataCadastro := Source.DataCadastro;
  TipoAcervo.Assign(Source.TipoAcervo);
  AreaAcervo.Assign(Source.AreaAcervo);
  ClassificacaoAcervo.Assign(Source.ClassificacaoAcervo);
  Fornecedor.Assign(Source.Fornecedor);
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
  IdArea := 0;
  Descricao := '';
end;

procedure TAreaAcervo.Assign(Source: TAreaAcervo);
begin
  {copia as propriedades de um outro TAreaAcervo}
  IdArea := Source.IdArea;
  Descricao := Source.Descricao;
end;

{-------------------- TClassificacaoAcervo -----------------------}

constructor TClassificacaoAcervo.Create;
begin
  {cria um objeto TClassificacaoAcervo}
  inherited Create;
  IdClassificacao := 0;
  Descricao := '';
end;

procedure TClassificacaoAcervo.Assign(Source: TClassificacaoAcervo);
begin
  {copia as propriedades de um outro TClassificacaoAcervo}
  IdClassificacao := Source.IdClassificacao;
  Descricao := Source.Descricao;
end;

{-------------------- TGrupoLogin -----------------------}

constructor TGrupoLogin.Create;
var Direitos: TDireitos;
begin
  {cria um objeto TGrupoLogin}
  inherited Create;
  IdGrupo := 0;
  Descricao := '';
  Direitos := TDireitos.Create;
  with Direitos do
  begin
    VerCadUsuarios := False;
    VerCadFornecedores := False;
    VerCadAcervo := False;
    VerPainelControle := False;
    VerExplorer := True;
    VerRelatorios := False;
    AlterarCadUsuarios := False;
    AlterarCadFornecedores := False;
    AlterarCadAcervo := False;
    Emprestar := False;
    Devolver := False;
    MoverPerdido := False;
    Reservar := False;
  end;
  SetPermissoes(Direitos);
  Direitos.Free;
end;

procedure TGrupoLogin.Assign(Source: TGrupoLogin);
begin
  {copia as propriedades de um outro TGrupoLogin}
  IdGrupo := Source.IdGrupo;
  Descricao := Source.Descricao;
  Permissoes := Source.Permissoes;
end;

procedure TGrupoLogin.SetPermissoes(Direitos: TDireitos);
var TmpChar: Char;
begin
  {configura as permissões - traduzido}
  Permissoes := '';
  with Direitos do
  begin
    TmpChar := #0;
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerCadUsuarios) shl 7));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerCadFornecedores) shl 6));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerCadAcervo) shl 5));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerPainelControle) shl 4));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerExplorer) shl 3));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(VerRelatorios) shl 2));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(AlterarCadUsuarios) shl 1));
    TmpChar := Char(Ord(TmpChar) or BoolToInt(AlterarCadFornecedores));
    Permissoes := Permissoes + TmpChar;
    TmpChar := Char($E0);
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(AlterarCadAcervo) shl 4));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(Emprestar) shl 3));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(Devolver) shl 2));
    TmpChar := Char(Ord(TmpChar) or (BoolToInt(MoverPerdido) shl 1));
    TmpChar := Char(Ord(TmpChar) or BoolToInt(Reservar));
    Permissoes := Permissoes + TmpChar;
  end;
end;

procedure TGrupoLogin.GetPermissoes(var Direitos: TDireitos);
begin
  {lê as permissões - traduzido}
  with Direitos do
  begin
    VerCadUsuarios := (Ord(Permissoes[1]) and $80) <> 0;
    VerCadFornecedores := (Ord(Permissoes[1]) and $40) <> 0;
    VerCadAcervo := (Ord(Permissoes[1]) and $20) <> 0;
    VerPainelControle := (Ord(Permissoes[1]) and $10) <> 0;
    VerExplorer := (Ord(Permissoes[1]) and $08) <> 0;
    VerRelatorios := (Ord(Permissoes[1]) and $04) <> 0;
    AlterarCadUsuarios := (Ord(Permissoes[1]) and $02) <> 0;
    AlterarCadFornecedores := (Ord(Permissoes[1]) and $01) <> 0;
    AlterarCadAcervo := (Ord(Permissoes[2]) and $10) <> 0;
    Emprestar := (Ord(Permissoes[2]) and $08) <> 0;
    Devolver := (Ord(Permissoes[2]) and $04) <> 0;
    MoverPerdido := (Ord(Permissoes[2]) and $02) <> 0;
    Reservar := (Ord(Permissoes[2]) and $01) <> 0;
  end;
end;

{-------------------- TContaLogin -----------------------}

constructor TContaLogin.Create;
begin
  {cria um objeto TContaLogin}
  inherited Create;
  IdConta := 0;
  Nome := '';
  UserName := '';
  Senha := '';
  GrupoLogin := TGrupoLogin.Create;
end;

destructor TContaLogin.Destroy;
begin
  {destrói um objeto TContaLogin}
  GrupoLogin.Free;
  inherited Destroy;
end;

procedure TContaLogin.Assign(Source: TContaLogin);
begin
  {copia as propriedades de um outro TContaLogin}
  IdConta := Source.IdConta;
  Nome := Source.Nome;
  UserName := Source.UserName;
  Senha := Source.Senha;
  GrupoLogin.Assign(Source.GrupoLogin);
end;

function TContaLogin.GetPassword: String;
var i: Integer;
begin
  {retorna a senha desencriptada}
  Result := '';
  if Senha = #244 then
    Result := ''
  else
    for i := 1 to Length(Senha) do
      Result := Result + Char(Ord(Senha[i]) - i * 3);
end;

procedure TContaLogin.SetPassword(Password: String);
var i: Integer;
begin
  {configura a senha criptografada}
  Senha := '';
  if Length(Password) = 0 then
    Senha := #244
  else
    for i := 1 to Length(Password) do
      Senha := Senha + Char(Ord(Password[i]) + i * 3);
end;

{-------------------- TUsuarios -----------------------}

constructor TUsuarios.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TUsuario.Create;
  DataModule_Biblio.ADODataSet_Usuarios.Close;
end;

procedure TUsuarios.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TUsuarios.RecCount(Explorer: Boolean = False): Integer;
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

procedure TUsuarios.Read(Explorer: Boolean = False);
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

function TUsuarios.Exists(RGA: String): Boolean;
begin
  {retorna True se RGA do usuário existe}
  Result := False;
  if (RecCount = 0) or (RGA = '') then
    exit;
  with DataModule_Biblio.ADODataSet_Usuarios do
    Result := Locate('RGA', RGA,[]);
end;

{-------------------- TFornecedores -----------------------}

constructor TFornecedores.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TFornecedor.Create;
  DataModule_Biblio.ADODataSet_Fornecedores.Close;
end;

procedure TFornecedores.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TFornecedores.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TFornecedores.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TFornecedores.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TFornecedores.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TFornecedores.SetRegistro(Value: TFornecedor);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TFornecedores.GetRegistro: TFornecedor;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TFornecedores.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Result := (RecNo = 1);
end;

function TFornecedores.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Result := (RecNo = RecordCount);
end;

function TFornecedores.RecCount(Explorer: Boolean = False): Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Result := RecordCount;
end;

function TFornecedores.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Result := RecNo;
end;

procedure TFornecedores.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TFornecedor.Create;
    FState := stInsert;
  end;
end;

procedure TFornecedores.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_Fornecedores,
       DataModule_Biblio.ADOCommand_Fornecedores do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_Fornecedores.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT ' +
      '  F.*, T.DESCRICAO ' +
      'FROM ' +
      '  FORNECEDOR F, TIPOFORNECEDOR T ' +
      'WHERE ' +
      '  F.IDTIPOFORNECEDOR = T.IDTIPOFORNECEDOR ' +
      'ORDER BY F.NOME';
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

procedure TFornecedores.Read;
var i: Integer;
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_Fornecedores, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdFornec := FieldByName('IdFornec').AsInteger;
    Nome := FieldByName('Nome').AsString;
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
    with TipoFornecedor do
    begin
      IdTipoFornecedor := FieldByName('IdTipoFornecedor').AsInteger;
      Descricao := FieldByName('Descricao').AsString;
    end;
  end;
end;

procedure TFornecedores.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_Fornecedores.RecNo;
  DataModule_Biblio.ADODataSet_Fornecedores.Close;
  with DataModule_Biblio.ADODataSet_Fornecedores,
       DataModule_Biblio.ADOCommand_Fornecedores,
       FDataRecord, FDataRecord.TipoFornecedor do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  FORNECEDOR ' +
      '    (NOME,' +
      '     ENDERECO,' +
      '     BAIRRO,' +
      '     CIDADE,' +
      '     ESTADO,' +
      '     CEP,' +
      '     TELEFONES,' +
      '     DATACADASTRO,' +
      '     IDTIPOFORNECEDOR) ' +
      'VALUES ' +
      '  (' + #39 + Nome + #39 + ',' +
      '   ' + #39 + Endereco + #39 + ',' +
      '   ' + #39 + Bairro + #39 + ',' +
      '   ' + #39 + Cidade + #39 + ',' +
      '   ' + #39 + Estado + #39 + ',' +
      '   ' + #39 + CEP + #39 + ',' +
      '   ' + #39 + Telefones + #39 + ',' +
      '   ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '   ' + IntToStr(IdTipoFornecedor) + ')';
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
    {Lê o IdFornec do registro}
    CommandText :=
      'SELECT ' +
      '  IDFORNEC ' +
      'FROM ' +
      '  FORNECEDOR ' +
      'WHERE ' +
      '  (NOME = ' + #39 + Nome + #39 + ') AND ' +
      '  (ENDERECO = ' + #39 + Endereco + #39 + ') AND ' +
      '  (BAIRRO = ' + #39 + Bairro + #39 + ') AND ' +
      '  (CIDADE = ' + #39 + Cidade + #39 + ') AND ' +
      '  (ESTADO = ' + #39 + Estado + #39 + ') AND ' +
      '  (CEP = ' + #39 + CEP + #39 + ') AND ' +
      '  (TELEFONES = ' + #39 + Telefones + #39 + ') AND ' +
      '  (IDTIPOFORNECEDOR = ' +  IntToStr(IdTipoFornecedor) + ')';
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
    id := FieldByName('IdFornec').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdFornec', id,[]);
  end;
  Self.Read;
end;

procedure TFornecedores.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_Fornecedores.Close;
  with DataModule_Biblio.ADODataSet_Fornecedores,
       DataModule_Biblio.ADOCommand_Fornecedores,
       FDataRecord, FDataRecord.TipoFornecedor do
  begin
    {Faz Fpdate do registro na Tabela}
    id := IdFornec;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  FORNECEDOR ' +
      'SET ' +
      '  NOME = ' + #39 + Nome + #39 + ',' +
      '  ENDERECO = ' + #39 + Endereco + #39 + ',' +
      '  BAIRRO = ' + #39 + Bairro + #39 + ',' +
      '  CIDADE = ' + #39 + Cidade + #39 + ',' +
      '  ESTADO = ' + #39 + Estado + #39 + ',' +
      '  CEP = ' + #39 + CEP + #39 + ',' +
      '  TELEFONES = ' + #39 + Telefones + #39 + ',' +
      '  DATACADASTRO = ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '  IDTIPOFORNECEDOR = ' + IntToStr(IdTipoFornecedor) + ' ' +
      'WHERE ' +
      '  IDFORNEC = ' + IntToStr(IdFornec);
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
        Locate('IdFornec', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdFornec', id,[]);
    Self.Read;
  end;
end;

procedure TFornecedores.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_Fornecedores, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_Fornecedores.RecNo;
    DataModule_Biblio.ADODataSet_Fornecedores.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  FORNECEDOR ' +
      'WHERE ' +
      '  IDFORNEC = ' + IntToStr(IdFornec);
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

procedure TFornecedores.Post;
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

procedure TFornecedores.Search(var ADODataSet: TADODataSet; FilterStr: String);
begin
  Screen.Cursor := crSQLWait;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    ADODataSet.Close;
    ADODataSet.Connection := ADOConnection_Biblio;
    with ADOCommand_Fornecedores do
    begin
      CommandText :=
        'SELECT ' +
        '  F.Nome, F.ENDERECO AS Endereço, F.Bairro, F.Cidade, F.Estado, ' +
        '  F.CEP, F.DATACADASTRO AS Data_de_Cadastro, ' +
        '  T.DESCRICAO AS Tipo_de_Fornecedor, F.IDFORNEC AS Idx ' +
        'FROM ' +
        '  FORNECEDOR F, TIPOFORNECEDOR T ' +
        'WHERE ' +
        '  (F.IDTIPOFORNECEDOR = T.IDTIPOFORNECEDOR) ';
      if FilterStr <> '' then
        CommandText := CommandText + ' AND (' + FilterStr + ')';
      CommandText := CommandText + ' ORDER BY F.NOME';
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

procedure TFornecedores.LocateId(Id: Integer);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Locate('IdFornec', Id,[]);
  Self.Read;
end;

procedure TFornecedores.LocateNome(Nm: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Locate('Nome', Nm,[]);
  Self.Read;
end;

function TFornecedores.Exists(Nome: String): Boolean;
begin
  {retorna True se existe}
  Result := False;
  if (RecCount = 0) or (Nome = '') then
    exit;
  with DataModule_Biblio.ADODataSet_Fornecedores do
    Result := Locate('Nome', Nome,[]);
end;

{-------------------- TAcervos -----------------------}

constructor TAcervos.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TAcervo.Create;
  DataModule_Biblio.ADODataSet_Acervos.Close;
end;

procedure TAcervos.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
var Ds: TADODataSet;
begin
  {reabre dataset, se necessário}
  if not Explorer then
    Self.Refresh;
  {move cursor para o indice dado}
  if Explorer then
    Ds := DataModule_Biblio.ADODataSet_Explorer
  else
    Ds := DataModule_Biblio.ADODataSet_Acervos;
  with Ds do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read(Explorer);
end;

procedure TAcervos.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Acervos do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TAcervos.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Acervos do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TAcervos.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Acervos do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TAcervos.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_Acervos do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TAcervos.SetRegistro(Value: TAcervo);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TAcervos.GetRegistro: TAcervo;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TAcervos.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_Acervos do
    Result := (RecNo = 1);
end;

function TAcervos.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_Acervos do
    Result := (RecNo = RecordCount);
end;

function TAcervos.RecCount(Explorer: Boolean = False): Integer;
var Ds: TADODataSet;
begin
  {retorna a quantidade de registros}
  if Explorer then
    Ds := DataModule_Biblio.ADODataSet_Explorer
  else
    Ds := DataModule_Biblio.ADODataSet_Acervos;
  with Ds do
    Result := RecordCount;
end;

function TAcervos.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_Acervos do
    Result := RecNo;
end;

procedure TAcervos.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TAcervo.Create;
    FState := stInsert;
  end;
end;

procedure TAcervos.Delete;
begin
  if FState = stRead then
  begin
    {coloca em modo de "Delete"}
    FState := stDelete;
    {grava as alterações no BD}
    Post;
  end;
end;

procedure TAcervos.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_Acervos,
       DataModule_Biblio.ADOCommand_Acervos do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_Acervos.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT DISTINCT ' +
      '  A.TITULO,' +
      '  A.AUTOR,' +
      '  A.EDITORA,' +
      '  A.COLECAO,' +
      '  A.VOLUME,' +
      '  A.EDICAO,' +
      '  A.ANO,' +
      '  A.PAGINAS,' +
      '  A.ASSUNTO,' +
      '  A.FAIXAETARIA,' +
      '  A.LOCALIZACAO,' +
      '  A.IDFORNEC,' +
      '  A.IDAREA,' +
      '  A.IDTIPOACERVO,' +
      '  A.IDCLASSIFICACAO,' +
      '  A.DATACADASTRO,' +
      '  T.DESCRICAO AS TIPO, T.PODEEMPRESTAR, TA.DESCRICAO AS AREA, ' +
      '  TC.DESCRICAO AS CLASSIFICACAO, F.NOME AS FORNECEDOR  ' +
      'FROM ' +
      '  ACERVO A, TIPOACERVO T, TIPOAREA TA, TIPOCLASSIFICACAO TC, ' +
      '  FORNECEDOR F ' +
      'WHERE ' +
      '  A.IDTIPOACERVO = T.IDTIPOACERVO AND ' +
      '  A.IDAREA = TA.IDAREA AND ' +
      '  A.IDCLASSIFICACAO = TC.IDCLASSIFICACAO AND ' +
      '  A.IDFORNEC = F.IDFORNEC ' +
      'ORDER BY A.TITULO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        Self.RollBackTrans;
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

procedure TAcervos.Read(Explorer: Boolean = False);
var Ds: TADODataSet;
begin
  {lê registro atual}
  if Explorer then
    Ds := DataModule_Biblio.ADODataSet_Explorer
  else
    Ds := DataModule_Biblio.ADODataSet_Acervos;
  with Ds, FDataRecord do
  begin
    if (not Active) or (Ds.RecordCount = 0) then
      exit;
    Titulo := FieldByName('Titulo').AsString;
    Autor := FieldByName('Autor').AsString;
    Editora := FieldByName('Editora').AsString;
    Colecao := FieldByName('Colecao').AsString;
    Volume := FieldByName('Volume').AsInteger;
    Edicao := FieldByName('Edicao').AsInteger;
    Ano := FieldByName('Ano').AsInteger;
    Paginas := FieldByName('Paginas').AsInteger;
    Assunto := FieldByName('Assunto').AsString;
    FaixaEtaria := FieldByName('FaixaEtaria').AsString;
    Localizacao := FieldByName('Localizacao').AsString;
    DataCadastro := FieldByName('DataCadastro').AsDateTime;
    with TipoAcervo do
    begin
      IdTipoAcervo := FieldByName('IdTipoAcervo').AsInteger;
      Descricao := FieldByName('Tipo').AsString;
      PodeEmprestar := FieldByName('PodeEmprestar').AsBoolean;
    end;
    with AreaAcervo do
    begin
      IdArea := FieldByName('IdArea').AsInteger;
      Descricao := FieldByName('Area').AsString;
    end;
    with ClassificacaoAcervo do
    begin
      IdClassificacao := FieldByName('IdClassificacao').AsInteger;
      Descricao := FieldByName('Classificacao').AsString;
    end;
    with Fornecedor do
    begin
      IdFornec := FieldByName('IdFornec').AsInteger;
      Nome := FieldByName('Fornecedor').AsString;
    end;
  end;
end;

procedure TAcervos.PostInsert;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_Acervos.Close;
  with DataModule_Biblio.ADODataSet_Acervos,
       DataModule_Biblio.ADOCommand_Acervos,
       FDataRecord, FDataRecord.TipoAcervo, FDataRecord.Fornecedor,
       FDataRecord.AreaAcervo, FDataRecord.ClassificacaoAcervo do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  ACERVO ' +
      '    (TOMBO,' +
      '     TITULO,' +
      '     AUTOR,' +
      '     EDITORA,' +
      '     COLECAO,' +
      '     VOLUME,' +
      '     EDICAO,' +
      '     ANO,' +
      '     PAGINAS,' +
      '     ASSUNTO,' +
      '     FAIXAETARIA,' +
      '     LOCALIZACAO,' +
      '     SITUACAO,' +
      '     DATACADASTRO,' +
      '     IDTIPOACERVO,' +
      '     IDAREA,' +
      '     IDCLASSIFICACAO,' +
      '     IDFORNEC) ' +
      'VALUES ' +
      '  (' + IntToStr(Tombo) + ',' +
      '   ' + #39 + Titulo + #39 + ',' +
      '   ' + #39 + Autor + #39 + ',' +
      '   ' + #39 + Editora + #39 + ',' +
      '   ' + #39 + Colecao + #39 + ',' +
      '   ' + IntToStr(Volume) + ',' +
      '   ' + IntToStr(Edicao) + ',' +
      '   ' + IntToStr(Ano) + ',' +
      '   ' + IntToStr(Paginas) + ',' +
      '   ' + #39 + Assunto + #39 + ',' +
      '   ' + #39 + FaixaEtaria + #39 + ',' +
      '   ' + #39 + Localizacao + #39 + ',' +
      '   ' + #39 + Situacao + #39 + ',' +
      '   ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '   ' + IntToStr(IdTipoAcervo) + ',' +
      '   ' + IntToStr(IdArea) + ',' +
      '   ' + IntToStr(IdClassificacao) + ',' +
      '   ' + IntToStr(IdFornec) + ')';
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROINSERT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        Self.RollBackTrans;
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Close;
  end;
end;

procedure TAcervos.PostEdit;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_Acervos.Close;
  with DataModule_Biblio.ADODataSet_Acervos,
       DataModule_Biblio.ADOCommand_Acervos,
       FDataRecord, FDataRecord.TipoAcervo, FDataRecord.Fornecedor,
       FDataRecord.AreaAcervo, FDataRecord.ClassificacaoAcervo do
  begin
    {Faz Update do registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  ACERVO ' +
      'SET ' +
      '  TOMBO = ' + IntToStr(Tombo) + ',' +
      '  TITULO = ' + #39 + Titulo + #39 + ',' +
      '  AUTOR = ' + #39 + Autor + #39 + ',' +
      '  EDITORA = ' + #39 + Editora + #39 + ',' +
      '  COLECAO = ' + #39 + Colecao + #39 + ',' +
      '  VOLUME = ' + IntToStr(Volume) + ',' +
      '  EDICAO = ' + IntToStr(Edicao) + ',' +
      '  ANO = ' + IntToStr(Ano) + ',' +
      '  PAGINAS = ' + IntToStr(Paginas) + ',' +
      '  ASSUNTO = ' + #39 + Assunto + #39 + ',' +
      '  FAIXAETARIA = ' + #39 + FaixaEtaria + #39 + ',' +
      '  LOCALIZACAO = ' + #39 + Localizacao + #39 + ',' +
      '  SITUACAO = ' + #39 + Situacao + #39 + ',' +
      '  DATACADASTRO = ' + #39 + DateToStr(DataCadastro) + #39 + ',' +
      '  IDTIPOACERVO = ' + IntToStr(IdTipoAcervo) + ',' +
      '  IDAREA = ' + IntToStr(IdArea) + ',' +
      '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacao) + ',' +
      '  IDFORNEC = ' + IntToStr(IdFornec) + ' ' +
      'WHERE ' +
      '  TOMBO = ' + IntToStr(Tombo);
    ShortDateFormat := 'dd/mm/yyyy';
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROUPDATE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        Self.RollBackTrans;
        FState := stRead;
        Screen.Cursor := crDefault;
        Self.Refresh;
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    Self.Read;
  end;
end;

procedure TAcervos.PostDelete;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_Acervos, FDataRecord do
  begin
    DataModule_Biblio.ADODataSet_Acervos.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  ACERVO ' +
      'WHERE ' +
      '  TOMBO = ' + IntToStr(Tombo);
    try
      Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERRODELETE + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        Self.RollBackTrans;
        FState := stRead;
        Self.Refresh;
        Self.Read;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
  end;
end;

procedure TAcervos.Post;
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

procedure TAcervos.Search(var ADODataSet: TADODataSet; FilterStr: String);
begin
  Screen.Cursor := crSQLWait;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    ADODataSet.Close;
    ADODataSet.Connection := ADOConnection_Biblio;
    with ADOCommand_Acervos do
    begin
      CommandText :=
        'SELECT ' +
        '  A.TOMBO AS Tombo, A.TITULO AS Título, ' +
        '  A.AUTOR AS Autor, A.EDITORA AS Editora, ' +
        '  A.COLECAO AS Coleção, A.VOLUME AS Volume, A.EDICAO AS Edição, ' +
        '  A.ANO AS Ano, A.PAGINAS AS Páginas, A.ASSUNTO AS Assunto, ' +
        '  A.LOCALIZACAO AS Localização, A.SITUACAO AS Situação, ' +
        '  A.DATACADASTRO AS Data_de_Cadastro, ' +
        '  T.DESCRICAO AS Tipo_de_Acervo, TA.DESCRICAO AS Área_de_Acervo, ' +
        '  TC.DESCRICAO AS Classificação_de_Acervo, F.NOME AS Fornecedor, ' +
        '  A.TOMBO AS Idx ' +
        'FROM ' +
        '  ACERVO A, TIPOACERVO T, TIPOAREA TA, ' +
        '  TIPOCLASSIFICACAO TC, FORNECEDOR F ' +
        'WHERE ' +
        '  (A.IDTIPOACERVO = T.IDTIPOACERVO) AND ' +
        '  (A.IDAREA = TA.IDAREA) AND ' +
        '  (A.IDCLASSIFICACAO = TC.IDCLASSIFICACAO) AND ' +
        '  (A.IDFORNEC = F.IDFORNEC) ';
      if FilterStr <> '' then
        CommandText := CommandText + ' AND (' + FilterStr + ')';
      CommandText := CommandText + ' ORDER BY A.TITULO, A.TOMBO';
      try
        ADODataSet.RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
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

procedure TAcervos.LocateTombo(Tmb: Integer);
var st: Integer;
begin
  Screen.Cursor := crSQLWait;
  st := FState;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    with ADODataSet_Exemplares, ADOCommand_Exemplares do
    begin
      ADODataSet_Exemplares.Close;
      CommandText :=
        'SELECT ' +
        '  TITULO,' +
        '  AUTOR,' +
        '  EDITORA,' +
        '  COLECAO,' +
        '  VOLUME,' +
        '  EDICAO ' +
        'FROM ' +
        '  ACERVO ' +
        'WHERE ' +
        '  TOMBO = ' + IntToStr(Tmb);
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      if not IsEmpty then
        DataModule_Biblio.ADODataSet_Acervos.Locate(
            'TITULO;AUTOR;EDITORA;COLECAO;VOLUME;EDICAO',
            VarArrayOf([FieldByName('Titulo').AsString,
                        FieldByName('Autor').AsString,
                        FieldByName('Editora').AsString,
                        FieldByName('Colecao').AsString,
                        FieldByName('Volume').AsInteger,
                        FieldByName('Edicao').AsInteger]),[]);
      Close;
      Screen.Cursor := crDefault;
      FState := st;
    end;
  end;
  Self.Read;
end;

function TAcervos.Exists(Tmb: Integer): Boolean;
var st: Integer;
begin
  {retorna True se tombo existe}
  Result := False;
  Screen.Cursor := crSQLWait;
  st := FState;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    with ADODataSet_Exemplares, ADOCommand_Exemplares do
    begin
      ADODataSet_Exemplares.Close;
      CommandText :=
        'SELECT ' +
        '  TOMBO ' +
        'FROM ' +
        '  ACERVO ' +
        'WHERE ' +
        '  TOMBO = ' + IntToStr(Tmb);
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      if not IsEmpty then
        Result := True;
      Close;
      Screen.Cursor := crDefault;
      FState := st;
    end;
  end;
end;

procedure TAcervos.GetExemplares(var Exemplares: TExemplares);
var st: Integer;
begin
  Screen.Cursor := crSQLWait;
  st := FState;
  FState := stDBWait;
  with DataModule_Biblio do
  begin
    with ADODataSet_Exemplares, ADOCommand_Exemplares,
         FDataRecord, FDataRecord.TipoAcervo, FDataRecord.AreaAcervo,
         FDataRecord.ClassificacaoAcervo, FDataRecord.Fornecedor do
    begin
      ADODataSet_Exemplares.Close;
      CommandText :=
        'SELECT ' +
        '  TOMBO, SITUACAO ' +
        'FROM ' +
        '  ACERVO ' +
        'WHERE ' +
        '  TITULO = ' + #39 + Titulo + #39 + ' AND ' +
        '  AUTOR = ' + #39 + Autor + #39 + ' AND ' +
        '  EDITORA = ' + #39 + Editora + #39 + ' AND ' +
        '  COLECAO = ' + #39 + Colecao + #39 + ' AND ' +
        '  VOLUME = ' + IntToStr(Volume) + ' AND ' +
        '  EDICAO = ' + IntToStr(Edicao) + ' AND ' +
        '  ANO = ' + IntToStr(Ano) + ' AND ' +
        '  PAGINAS = ' + IntToStr(Paginas) + ' AND ' +
        '  ASSUNTO = ' + #39 + Assunto + #39 + ' AND ' +
        '  FAIXAETARIA = ' + #39 + FaixaEtaria + #39 + ' AND ' +
        '  LOCALIZACAO = ' + #39 + Localizacao + #39 + ' AND ' +
        '  IDTIPOACERVO = ' + IntToStr(IdTipoAcervo) + ' AND ' +
        '  IDAREA = ' + IntToStr(IdArea) + ' AND ' +
        '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacao) + ' AND ' +
        '  IDFORNEC = ' + IntToStr(IdFornec) + ' ' +
        'ORDER BY TOMBO';
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      First;
      SetLength(Exemplares,0);
      while (not IsEmpty) and (not Eof) do
      begin
        SetLength(Exemplares,Length(Exemplares) + 1);
        with Exemplares[Length(Exemplares) - 1] do
        begin
          Tombo := FieldByName('Tombo').AsInteger;
          Situacao := FieldByName('Situacao').AsString[1];
        end;
        Next;
      end;
      Close;
      Screen.Cursor := crDefault;
      FState := st;
    end;
  end;
end;

procedure TAcervos.GetClasses(var Classes: TClasses);
var st: Integer;
begin
  Screen.Cursor := crSQLWait;
  st := FState;
  FState := stDBWait;
  SetLength(Classes.TipoAcervo,0);
  SetLength(Classes.AreaAcervo,0);
  SetLength(Classes.ClassificacaoAcervo,0);
  with DataModule_Biblio do
  begin
    with ADODataSet_Exemplares, ADOCommand_Exemplares do
    begin
      ADODataSet_Exemplares.Close;
      CommandText :=
        'SELECT ' +
        '  TA.DESCRICAO ' +
        'FROM ' +
        '  ACERVO A, TIPOACERVO TA ' +
        'WHERE ' +
        '  TA.IDTIPOACERVO =  A.IDTIPOACERVO ' +
        'GROUP BY TA.DESCRICAO ' +
        'ORDER BY TA.DESCRICAO';
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      First;
      while (not IsEmpty) and (not Eof) do
      begin
        with Classes do
        begin
          SetLength(TipoAcervo,Length(TipoAcervo) + 1);
          TipoAcervo[Length(TipoAcervo) - 1] :=
            FieldByName('Descricao').AsString;
        end;
        Next;
      end;
      Close;
      CommandText :=
        'SELECT ' +
        '  AA.DESCRICAO ' +
        'FROM ' +
        '  ACERVO A, TIPOAREA AA ' +
        'WHERE ' +
        '  AA.IDAREA =  A.IDAREA ' +
        'GROUP BY AA.DESCRICAO ' +
        'ORDER BY AA.DESCRICAO';
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      First;
      while (not IsEmpty) and (not Eof) do
      begin
        with Classes do
        begin
          SetLength(AreaAcervo,Length(AreaAcervo) + 1);
          AreaAcervo[Length(AreaAcervo) - 1] :=
            FieldByName('Descricao').AsString;
        end;
        Next;
      end;
      Close;
      CommandText :=
        'SELECT ' +
        '  CA.DESCRICAO ' +
        'FROM ' +
        '  ACERVO A, TIPOCLASSIFICACAO CA ' +
        'WHERE ' +
        '  CA.IDCLASSIFICACAO =  A.IDCLASSIFICACAO ' +
        'GROUP BY CA.DESCRICAO ' +
        'ORDER BY CA.DESCRICAO';
      try
        RecordSet := Execute;
      except
        on E: Exception do
        begin
          with Application do
            MessageBox(PChar(MSG_ERROSELECT + E.Message),
                       CAP_ERRODB,MB_OKICONSTOP);
          Self.RollBackTrans;
          Screen.Cursor := crDefault;
          FState := st;
          exit;
        end;
      end;
      Open;
      First;
      while (not IsEmpty) and (not Eof) do
      begin
        with Classes do
        begin
          SetLength(ClassificacaoAcervo,Length(ClassificacaoAcervo) + 1);
          ClassificacaoAcervo[Length(ClassificacaoAcervo) - 1] :=
            FieldByName('Descricao').AsString;
        end;
        Next;
      end;
      Close;
      Screen.Cursor := crDefault;
      FState := st;
    end;
  end;
end;

procedure TAcervos.GetTitulos(Tipo,Area,Classificacao: String);
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_Explorer,
       DataModule_Biblio.ADOCommand_Explorer do
  begin
    FState := stDBWait;
    Close;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT DISTINCT ' +
      '  A.TITULO,' +
      '  A.AUTOR,' +
      '  A.EDITORA,' +
      '  A.COLECAO,' +
      '  A.VOLUME,' +
      '  A.EDICAO,' +
      '  A.ANO,' +
      '  A.PAGINAS,' +
      '  A.ASSUNTO,' +
      '  A.FAIXAETARIA,' +
      '  A.LOCALIZACAO,' +
      '  A.IDFORNEC,' +
      '  A.IDAREA,' +
      '  A.IDTIPOACERVO,' +
      '  A.IDCLASSIFICACAO,' +
      '  A.DATACADASTRO,' +
      '  T.DESCRICAO AS TIPO, T.PODEEMPRESTAR, TA.DESCRICAO AS AREA, ' +
      '  TC.DESCRICAO AS CLASSIFICACAO, F.NOME AS FORNECEDOR  ' +
      'FROM ' +
      '  ACERVO A, TIPOACERVO T, TIPOAREA TA, TIPOCLASSIFICACAO TC, ' +
      '  FORNECEDOR F ' +
      'WHERE ' +
      '  A.IDTIPOACERVO = T.IDTIPOACERVO AND ' +
      '  A.IDAREA = TA.IDAREA AND ' +
      '  A.IDCLASSIFICACAO = TC.IDCLASSIFICACAO AND ' +
      '  A.IDFORNEC = F.IDFORNEC AND ' +
      '  T.DESCRICAO = ' + #39 + Tipo + #39 + ' AND ' +
      '  TA.DESCRICAO = ' + #39 + Area + #39 + ' AND ' +
      '  TC.DESCRICAO = ' + #39 + Classificacao + #39 + ' ' +
      'ORDER BY A.TITULO';
    try
      RecordSet := Execute;
    except
      on E: Exception do
      begin
        with Application do
          MessageBox(PChar(MSG_ERROSELECT + E.Message),
                     CAP_ERRODB,MB_OKICONSTOP);
        Self.RollBackTrans;
        FState := stRead;
        Screen.Cursor := crDefault;
        exit;
      end;
    end;
    Open;
    First;
  end;
  Self.Read(True);
  FState := stRead;
  Screen.Cursor := crDefault;
end;

{-------------------- TTipoUsuarios -----------------------}

constructor TTipoUsuarios.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TTipoUsuario.Create;
  DataModule_Biblio.ADODataSet_TipoUsuarios.Close;
end;

procedure TTipoUsuarios.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TTipoUsuarios.RecCount(Explorer: Boolean = False): Integer;
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

procedure TTipoUsuarios.Read(Explorer: Boolean = False);
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

procedure TTipoFornecedores.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TTipoFornecedores.RecCount(Explorer: Boolean = False): Integer;
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

procedure TTipoFornecedores.Read(Explorer: Boolean = False);
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

procedure TTipoAcervos.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TTipoAcervos.RecCount(Explorer: Boolean = False): Integer;
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

procedure TTipoAcervos.Read(Explorer: Boolean = False);
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

procedure TAreaAcervos.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TAreaAcervos.RecCount(Explorer: Boolean = False): Integer;
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

procedure TAreaAcervos.Read(Explorer: Boolean = False);
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_AreaAcervos, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdArea := FieldByName('IdArea').AsInteger;
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
    {Lê o IdArea do registro}
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
    id := IdArea;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOAREA ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ' ' +
      'WHERE ' +
      '  IDAREA = ' + IntToStr(IdArea);
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
      '  IDAREA = ' + IntToStr(IdArea);
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

procedure TClassificacaoAcervos.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
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

function TClassificacaoAcervos.RecCount(Explorer: Boolean = False): Integer;
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

procedure TClassificacaoAcervos.Read(Explorer: Boolean = False);
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_ClassificacaoAcervos, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdClassificacao := FieldByName('IdClassificacao').AsInteger;
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
    {Lê o IdClassificacao do registro}
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
    id := IdClassificacao;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  TIPOCLASSIFICACAO ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ' ' +
      'WHERE ' +
      '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacao);
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
      '  IDCLASSIFICACAO = ' + IntToStr(IdClassificacao);
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

{-------------------- TGrupoLogins -----------------------}

constructor TGrupoLogins.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TGrupoLogin.Create;
  DataModule_Biblio.ADODataSet_GrupoLogins.Close;
end;

procedure TGrupoLogins.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TGrupoLogins.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TGrupoLogins.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TGrupoLogins.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TGrupoLogins.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TGrupoLogins.SetRegistro(Value: TGrupoLogin);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TGrupoLogins.GetRegistro: TGrupoLogin;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TGrupoLogins.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Result := (RecNo = 1);
end;

function TGrupoLogins.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Result := (RecNo = RecordCount);
end;

function TGrupoLogins.RecCount(Explorer: Boolean = False): Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Result := RecordCount;
end;

function TGrupoLogins.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Result := RecNo;
end;

procedure TGrupoLogins.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TGrupoLogin.Create;
    FState := stInsert;
  end;
end;

procedure TGrupoLogins.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_GrupoLogins,
       DataModule_Biblio.ADOCommand_GrupoLogins do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_GrupoLogins.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT * ' +
      'FROM ' +
      '  GRUPOLOGIN ' +
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

procedure TGrupoLogins.Read(Explorer: Boolean = False);
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_GrupoLogins, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdGrupo := FieldByName('IdGrupo').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
    Permissoes := FieldByName('Permissoes').AsString;
  end;
end;

procedure TGrupoLogins.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_GrupoLogins.RecNo;
  DataModule_Biblio.ADODataSet_GrupoLogins.Close;
  with DataModule_Biblio.ADODataSet_GrupoLogins,
       DataModule_Biblio.ADOCommand_GrupoLogins, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  GRUPOLOGIN ' +
      '    (DESCRICAO,' +
      '     PERMISSOES) ' +
      'VALUES ' +
      '  (' + #39 + Descricao + #39 + ',' +
      '   ' + #39 + Permissoes + #39 + ')';
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
    {Lê o Id do registro}
    CommandText :=
      'SELECT ' +
      '  IDGRUPO ' +
      'FROM ' +
      '  GRUPOLOGIN ' +
      'WHERE ' +
      '  (DESCRICAO = ' + #39 + Descricao + #39 + ') AND ' +
      '  (PERMISSOES = ' + #39 + Permissoes + #39 + ')';
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
    id := FieldByName('IdGrupo').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdGrupo', id,[]);
  end;
  Self.Read;
end;

procedure TGrupoLogins.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_GrupoLogins.Close;
  with DataModule_Biblio.ADODataSet_GrupoLogins,
       DataModule_Biblio.ADOCommand_GrupoLogins, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdGrupo;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  GRUPOLOGIN ' +
      'SET ' +
      '  DESCRICAO = ' + #39 + Descricao + #39 + ',' +
      '  PERMISSOES = ' + #39 + Permissoes + #39 + ' ' +
      'WHERE ' +
      '  IDGRUPO = ' + IntToStr(IdGrupo);
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
        Locate('IdGrupo', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdGrupo', id,[]);
    Self.Read;
  end;
end;

procedure TGrupoLogins.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_GrupoLogins, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_GrupoLogins.RecNo;
    DataModule_Biblio.ADODataSet_GrupoLogins.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  GRUPOLOGIN ' +
      'WHERE ' +
      '  IDGRUPO = ' + IntToStr(IdGrupo);
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

procedure TGrupoLogins.Post;
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

procedure TGrupoLogins.LocateDescricao(Descricao: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_GrupoLogins do
    Locate('Descricao', Descricao,[]);
  Self.Read;
end;

function TGrupoLogins.Exists(Descricao: String): Boolean;
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

{-------------------- TContaLogins -----------------------}

constructor TContaLogins.Create;
begin
  inherited Create;
  {inicializa valores}
  FDataRecord := TContaLogin.Create;
  DataModule_Biblio.ADODataSet_ContaLogins.Close;
end;

procedure TContaLogins.GotoReg(RecIndex: Integer; Explorer: Boolean = False);
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor para o indice dado}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    if (RecIndex > 0) and (RecIndex <= RecordCount) then
      RecNo := RecIndex;
  {lê o registro}
  Self.Read;
end;

procedure TContaLogins.First;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    First;
  {lê o registro}
  Self.Read;
end;

procedure TContaLogins.Last;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Last;
  {lê o registro}
  Self.Read;
end;

procedure TContaLogins.Prior;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Prior;
  {lê o registro}
  Self.Read;
end;

procedure TContaLogins.Next;
begin
  {reabre dataset, se necessário}
  Self.Refresh;
  {move cursor}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Next;
  {lê o registro}
  Self.Read;
end;

procedure TContaLogins.SetRegistro(Value: TContaLogin);
begin
  {permite acesso ao registro}
  FDataRecord := Value;
end;

function TContaLogins.GetRegistro: TContaLogin;
begin
  {permite acesso ao registro}
  Result := FDataRecord;
end;

function TContaLogins.Bof: Boolean;
begin
  {retorna True se for o primeiro registro}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Result := (RecNo = 1);
end;

function TContaLogins.Eof: Boolean;
begin
  {retorna True se for o último registro}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Result := (RecNo = RecordCount);
end;

function TContaLogins.RecCount(Explorer: Boolean = False): Integer;
begin
  {retorna a quantidade de registros}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Result := RecordCount;
end;

function TContaLogins.GetRecNo: Integer;
begin
  {retorna numero do reg atual}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Result := RecNo;
end;

procedure TContaLogins.Insert;
begin
  {coloca em modo stInsert}
  if FState = stRead then
  begin
    FDataRecord := TContaLogin.Create;
    FState := stInsert;
  end;
end;

procedure TContaLogins.Refresh;
begin
  {lê o banco de dados e atribui valores a classe de Dados}
  with DataModule_Biblio.ADODataSet_ContaLogins,
       DataModule_Biblio.ADOCommand_ContaLogins do
  begin
    {se recordset está ativo, não faz nada}
    if DataModule_Biblio.ADODataSet_ContaLogins.Active then
      exit;
    FState := stDBWait;
    Screen.Cursor := crSQLWait;
    CommandText :=
      'SELECT ' +
      '  C.*, ' +
      '  G.DESCRICAO, ' +
      '  G.PERMISSOES ' +
      'FROM ' +
      '  CONTALOGIN C,' +
      '  GRUPOLOGIN G ' +
      'WHERE ' +
      '  G.IDGRUPO = C.IDGRUPO ' +
      'ORDER BY C.USERNAME';
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

procedure TContaLogins.Read(Explorer: Boolean = False);
begin
  {lê registro atual}
  with DataModule_Biblio.ADODataSet_ContaLogins, FDataRecord do
  begin
    if (not Active) or (RecordCount = 0) then
      exit;
    IdConta := FieldByName('IdConta').AsInteger;
    Nome := FieldByName('Nome').AsString;
    UserName := FieldByName('UserName').AsString;
    Senha := FieldByName('Senha').AsString;
    GrupoLogin.Descricao := FieldByName('Descricao').AsString;
    GrupoLogin.Permissoes := FieldByName('Permissoes').AsString;
    GrupoLogin.IdGrupo := FieldByName('IdGrupo').AsInteger;
  end;
end;

procedure TContaLogins.PostInsert;
var id: Integer;
begin
  FState := stDBWait;
  id := DataModule_Biblio.ADODataSet_ContaLogins.RecNo;
  DataModule_Biblio.ADODataSet_ContaLogins.Close;
  with DataModule_Biblio.ADODataSet_ContaLogins,
       DataModule_Biblio.ADOCommand_ContaLogins, FDataRecord do
  begin
    {Insere o registro na Tabela}
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'INSERT INTO ' +
      '  CONTALOGIN ' +
      '    (NOME,' +
      '     USERNAME,' +
      '     SENHA,' +
      '     IDGRUPO) ' +
      'VALUES ' +
      '  (' + #39 + Nome + #39 + ',' +
      '   ' + #39 + UserName + #39 + ',' +
      '   ' + #39 + Senha + #39 + ',' +
      '   ' + IntToStr(GrupoLogin.IdGrupo) + ')';
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
    {Lê o Id do registro}
    CommandText :=
      'SELECT ' +
      '  IDCONTA ' +
      'FROM ' +
      '  CONTALOGIN ' +
      'WHERE ' +
      '  (NOME = ' + #39 + Nome + #39 + ') AND ' +
      '  (USERNAME = ' + #39 + UserName + #39 + ')';
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
    id := FieldByName('IdConta').AsInteger;
    Close;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdConta', id,[]);
  end;
  Self.Read;
end;

procedure TContaLogins.PostEdit;
var id: Integer;
begin
  FState := stDBWait;
  DataModule_Biblio.ADODataSet_ContaLogins.Close;
  with DataModule_Biblio.ADODataSet_ContaLogins,
       DataModule_Biblio.ADOCommand_ContaLogins, FDataRecord do
  begin
    {Faz Update do registro na Tabela}
    id := IdConta;
    ShortDateFormat := 'yyyy/mm/dd';
    CommandText :=
      'UPDATE ' +
      '  CONTALOGIN ' +
      'SET ' +
      '  NOME = ' + #39 + Nome + #39 + ',' +
      '  SENHA = ' + #39 + Senha + #39 + ',' +
      '  IDGRUPO = ' + IntToStr(GrupoLogin.IdGrupo) + ',' +
      '  USERNAME = ' + #39 + UserName + #39 + ' ' +
      'WHERE ' +
      '  IDCONTA = ' + IntToStr(IdConta);
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
        Locate('IdConta', id,[]);
        Self.Read;
        exit;
      end;
    end;
    Self.Refresh;
    {posiciona no registro}
    Locate('IdConta', id,[]);
    Self.Read;
  end;
end;

procedure TContaLogins.PostDelete;
var id: Integer;
begin
  FState := stDBWait;
  with DataModule_Biblio.ADOCommand_ContaLogins, FDataRecord do
  begin
    id := DataModule_Biblio.ADODataSet_ContaLogins.RecNo;
    DataModule_Biblio.ADODataSet_ContaLogins.Close;
    {apaga registro na Tabela}
    CommandText :=
      'DELETE FROM ' +
      '  CONTALOGIN ' +
      'WHERE ' +
      '  IDCONTA = ' + IntToStr(IdConta);
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

procedure TContaLogins.Post;
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

procedure TContaLogins.LocateUserName(UserName: String);
begin
  {posiciona no registro}
  with DataModule_Biblio.ADODataSet_ContaLogins do
    Locate('UserName', UserName,[]);
  Self.Read;
end;

function TContaLogins.Exists(UserName: String): Boolean;
var i: Integer;
begin
  {retorna True se conta login existe}
  Result := False;
  if RecCount = 0 then
    exit;
  for i := 1 to RecCount do
  begin
    GotoReg(i);
    if Registro.UserName = UserName then
    begin
      Result := True;
      break;
    end;
  end;
end;

{-------------------- TRegistroLogin -----------------------}

procedure TRegistroLogin.Login(IdConta: Integer);
begin
  with DataModule_Biblio.ADODataSet_RegLogin,
       DataModule_Biblio.ADOCommand_RegLogin do
  begin
    Close;
    CommandText :=
      'SELECT ' +
      '  DATAHORA, IDCONTA ' +
      'FROM ' +
      '  REGLOGIN ' +
      'ORDER BY DATAHORA';
    RecordSet := Execute;
    Open;
    Last;
    if FieldByName('IDCONTA').AsInteger <> IdConta then
    begin
      Close;
      CommandText :=
        'INSERT INTO ' +
        '  REGLOGIN ' +
        '  (OPERACAO, IDCONTA, DATAHORA) ' +
        'VALUES ' +
        '  (' + #39 + 'LOGIN' + #39 + ', ' +
        IntToStr(IdConta) + ', ' + #39 + DateTimeToStr(Now) + #39 + ')';
      Execute;
    end;
    Close;
  end;
end;

{-------------------- TDataModule_Biblio -----------------------}

procedure TDataModule_Biblio.DataModuleCreate(Sender: TObject);
var Path: String;
    FGrupoLogins: TGrupoLogins;
    FDireitos: TDireitos;
    FContaLogins: TContaLogins;
    FTipoUsuarios: TTipoUsuarios;
    FTipoFornecedores: TTipoFornecedores;
    FFornecedores: TFornecedores;
    FTipoAcervos: TTipoAcervos;
    FAreaAcervos: TAreaAcervos;
    FClassificacaoAcervos: TClassificacaoAcervos;
    id: Integer;
begin
  id := 1;
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
    'Provider=Microsoft.Jet.OLEDB.4.0;Password=biblio fbai;User ID=bibliouser;' +
    'Data Source=' + Path + 'biblio.mdb;Mode=ReadWrite|Share Deny None;' +
    'Extended Properties="";Persist Security Info=True;' +
    'Jet OLEDB:System database=' + Path + 'biblio.mdw;' +
    'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";' +
    'Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;' +
    'Jet OLEDB:Global Partial Bulk Ops=2;' +
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
  {cria os grupos de login padrão do sistema, se não existirem}
  FGrupoLogins := TGrupoLogins.Create;
  FDireitos := TDireitos.Create;
  with FGrupoLogins do
  begin
    Refresh;
    if not Exists('ADMINISTRADORES') then
    begin
      Insert;
      Registro.Descricao := 'ADMINISTRADORES';
      with FDireitos do
      begin
        VerCadUsuarios := True;
        VerCadFornecedores := True;
        VerCadAcervo := True;
        VerPainelControle := True;
        VerExplorer := True;
        VerRelatorios := True;
        AlterarCadUsuarios := True;
        AlterarCadFornecedores := True;
        AlterarCadAcervo := True;
        Emprestar := True;
        Devolver := True;
        MoverPerdido := True;
        Reservar := True;
      end;
      Registro.SetPermissoes(FDireitos);
      Post;
    end;
    if not Exists('BIBLIOTECÁRIOS') then
    begin
      Insert;
      Registro.Descricao := 'BIBLIOTECÁRIOS';
      with FDireitos do
      begin
        VerCadUsuarios := True;
        VerCadFornecedores := True;
        VerCadAcervo := True;
        VerPainelControle := False;
        VerExplorer := True;
        VerRelatorios := True;
        AlterarCadUsuarios := True;
        AlterarCadFornecedores := True;
        AlterarCadAcervo := True;
        Emprestar := True;
        Devolver := True;
        MoverPerdido := True;
        Reservar := True;
      end;
      Registro.SetPermissoes(FDireitos);
      Post;
    end;
    if not Exists('ALUNOS') then
    begin
      Insert;
      Registro.Descricao := 'ALUNOS';
      with FDireitos do
      begin
        VerCadUsuarios := False;
        VerCadFornecedores := False;
        VerCadAcervo := True;
        VerPainelControle := False;
        VerExplorer := True;
        VerRelatorios := False;
        AlterarCadUsuarios := False;
        AlterarCadFornecedores := False;
        AlterarCadAcervo := False;
        Emprestar := False;
        Devolver := False;
        MoverPerdido := False;
        Reservar := False;
      end;
      Registro.SetPermissoes(FDireitos);
      Post;
    end;
    Free;
  end;
  FDireitos.Free;
  {cria as contas padrão do sistema, se não existirem}
  FContaLogins := TContaLogins.Create;
  FGrupoLogins := TGrupoLogins.Create;
  FGrupoLogins.Refresh;
  with FContaLogins do
  begin
    Refresh;
    if not Exists('ALUNO') then
    begin
      Insert;
      Registro.Nome := 'ALUNO DA ESCOLA';
      Registro.UserName := 'ALUNO';
      Registro.SetPassword('');
      FGrupoLogins.LocateDescricao('ALUNOS');
      Registro.GrupoLogin.Assign(FGrupoLogins.Registro);
      Post;
    end;
    if not Exists('ADMIN') then
    begin
      Insert;
      Registro.Nome := 'ADMINISTRADOR DO SISTEMA';
      Registro.UserName := 'ADMIN';
      Registro.SetPassword('');
      FGrupoLogins.LocateDescricao('ADMINISTRADORES');
      Registro.GrupoLogin.Assign(FGrupoLogins.Registro);
      Post;
    end;
    Free;
  end;
  FGrupoLogins.Free;
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
    if RecCount > 0 then
      id := Registro.IdTipoFornecedor;
    if not Exists('LIVRARIA') then
    begin
      Insert;
      Registro.Descricao := 'LIVRARIA';
      Post;
      id := Registro.IdTipoFornecedor;
    end;
    if not Exists('EDITORA') then
    begin
      Insert;
      Registro.Descricao := 'EDITORA';
      Post;
    end;
    Free;
  end;
  {cria os fornecedores padrão do sistema, se não existirem}
  FFornecedores := TFornecedores.Create;
  with FFornecedores do
  begin
    Refresh;
    if (RecCount = 0) and (not Exists('FORNECEDOR PADRÃO')) then
    begin
      Insert;
      Registro.Nome := 'FORNECEDOR PADRÃO';
      Registro.Endereco := 'SISTEMA BIBLIOTECA';
      Registro.Bairro := 'SISTEMA BIBLIOTECA';
      Registro.Cidade := 'SÃO PAULO';
      Registro.CEP := '00000000';
      Registro.TipoFornecedor.IdTipoFornecedor := id;
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
