{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_Comum.pas

  Contém tipos de dados, constantes, rotinas funções comuns a toda Aplicação.

  Data última revisão: 06/11/2001

******************************************************************************}

unit unit_Comum;

interface

uses Windows, Forms, Sysutils, stdctrls, graphics;

{************* Tipos de dados **************}

{Strings reduzidas}
type
  String80 = String[80];
  String50 = String[50];
  String20 = String[20];
  String10 = String[10];
  String2 = String[2];

{************* Constantes **************}

{Constantes de State do campo FState do TDataClass}
const
  stRead = 0;
  stEdit = 1;
  stInsert = 2;
  stDelete = 3;
  stDBWait = 4;

{Constantes das configurações dos Diálogos}
  MB_OKICONSTOP =
    MB_OK + MB_ICONSTOP;
  MB_OKWARNING =
    MB_OK + MB_ICONWARNING;
  MB_OKINFORMATION =
    MB_OK + MB_ICONINFORMATION;
  MB_OKCANCELWARNING =
    MB_OKCANCEL + MB_ICONWARNING;
  MB_YESNOQUESTION =
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2;
  MB_YESNOQUESTIONDEFYES =
    MB_YESNO + MB_ICONQUESTION;

{Constantes das mensagens}
  MSG_SEMDB =
    'Não foi possível encontrar o Banco de Dados do Sistema Biblioteca.' +
    #13#10 + 'Reinstale o Sistema e restaure a última Cópia de Segurança do ' +
    'Banco de Dados.';
  CAP_SEMDB =
    'Banco de Dados não encontrado';
  MSG_NOCONNDB =
    'Não foi possível conectar com o Banco de Dados do Sistema Biblioteca.' +
    #13#10 + 'Reinstale o Sistema e restaure a última Cópia de Segurança do ' +
    'Banco de Dados.' + #13#10 + 'Erro: ';
  CAP_NOCONNDB =
    'Erro ao conectar com o Banco de Dados';
  CAP_ERRODB =
    'Erro em operação com Banco de Dados';
  MSG_ERROSELECT =
    'Erro ao ler registros do Banco de Dados. ' +
    'Talvez haja problemas com o Banco de Dados. Restaure a última cópia ' +
    ' de segurança. ' + #13#10 + 'Erro: ';
  MSG_ERROINSERT =
    'Erro ao inserir o registro no Banco de Dados. ' + #13#10;
  MSG_ERROUPDATE =
    'Erro ao atualizar o registro no Banco de Dados. ' + #13#10;
  MSG_ERRODELETE =
    'Erro ao apagar o registro no Banco de Dados. ' + #13#10;
  MSG_FORMOPEN =
    'Há dados que foram alterados mas não foram gravados. Clique em "Gravar" ' +
    'para salvar as alterações ou em "Cancelar" para cancelar as alterações.';
  CAP_FORMOPEN =
    'Não foi possível fechar a janela';
  MSG_SAIR =
    'Há janelas abertas no Sistema Biblioteca. Feche-as antes de sair do ' +
    'Sistema.';
  CAP_SAIR =
    'Não foi possível sair do Sistema Biblioteca';
  MSG_SAIRBBT =
    'Tem certeza que deseja sair do Sistema Biblioteca ?';
  CAP_SAIRBBT =
    'Sair do Sistema Biblioteca';
  MSG_LOGOFF =
    'Há janelas abertas no Sistema Biblioteca. Feche-as antes de efetuar o ' +
    'Logoff.';
  CAP_LOGOFF =
    'Não foi possível efetuar o Logoff no Sistema Biblioteca';
  MSG_NOBAK =
    'Há janelas abertas no Sistema Biblioteca. Feche-as antes de criar uma ' +
    'Cópia de Segurança do Banco da Dados.';
  CAP_NOBAK =
    'Não é possível criar Cópia de Segurança';
  MSG_NOREST =
    'Há janelas abertas no Sistema Biblioteca. Feche-as antes de restaurar ' +
    'uma Cópia de Segurança do Banco da Dados.';
  CAP_NOREST =
    'Não é possível restaurar Cópia de Segurança';
  MSG_MINRES =
    'O Sistema Biblioteca só funciona com uma resolução de vídeo de pelo ' +
    'menos 800x600.' + #13#10 +
    'Consulte a ajuda do Windows para saber como alterar a resolução do ' +
    'vídeo.';
  CAP_MINRES =
    'Resolução de vídeo menor do que 800x600';
  MSG_ERROLOGINR =
    'A Senha está incorreta.' + #13#10 +
    'Não foi possível realizar o Login, pois o número ' +
    'de tentativas foi esgotado. Clique em OK para fechar o programa.';
  CAP_ERROLOGINR =
    'Esgotado número máximo de tentativas';
  MSG_ERROLOGIN =
    'A Senha está incorreta.' + #13#10 +
    'Tente digitar novamente, lembrando que a Senha é ' +
    'sensível a letras maiúsculas/minúsculas';
  CAP_ERROLOGIN =
    'Erro de Login';
  MSG_PICPEQ =
    'Não é possível usar esse arquivo como papel de parede, pois suas ' +
    'dimensões são menores do que as dimensões da tela.' + #13#10 +
    'Tente procurar outro arquivo.';
  CAP_PICPEQ =
    'Imagem muito pequena';
  MSG_EXEMPRESERVADO =
    'Este exemplar do acervo já está reservado para os seguintes usuários:' +
    #13#10;
  MSG_EXEMPRESERVADO1 =
    'Confirma mesmo assim o empréstimo ?';
  {constantes usadas pelo backup/restore}
  CAP_ERROBAKALL =
    'Erro na criação da Cópia de Segurança';
  MSG_ERROLEBAK =
    'Não foi possível ler o arquivo do Banco de Dados.' + #13#10 + 'Erro: ';
  MSG_ERROTMPBAK =
    'Não foi possível gravar o arquivo temporário.' + #13#10 + 'Erro: ';
  MSG_ERROZIPBAK =
    'Não foi possível compactar o arquivo do Banco de Dados.' +
    #13#10 + 'Erro: ';
  CAP_ERROREALL =
    'Erro na restauração da Cópia de Segurança';
  MSG_ERROLERE =
    'Não foi possível ler o arquivo compactado da Cópia de Segurança.' +
    #13#10 + 'Erro: ';
  MSG_ERROTMPRE =
    'Não foi possível sobrescrever o arquivo do Banco de Dados.' + #13#10 +
    'Erro: ';
  MSG_ERROZIPRE =
    'Não foi possível descompactar o arquivo da Cópia de Segurança.' +
    #13#10 + 'Erro: ';
  MSG_INSDISCO =
    'Insira um disco vazio e desprotegido contra gravação na unidade ';
  MSG_INSDISCOR =
    'Insira o disco da cópia de segurança na unidade ';
  MSG_INSDISCO2 =
    ': e clique em OK. ' + #13#10 + 'Clique em Cancelar para sair.';
  CAP_INSDISCO =
    'Disco inválido';
  MSG_EXISTBAK =
    'Já existe no disco uma Cópia de Segurança realizada hoje.' + #13#10;
  MSG_VDSKBAK =
    'Serão necessários ';
  MSG_VDSKBAK2 =
    ' discos para criar a Cópia de Segurança. Deseja Continuar?';
  CAP_VDSKBAK =
    'Mais de um disco necessário';
  MSG_INSDISCON =
    'Insira o disco onde será gravado o volume ';
  MSG_INSDISCON2 =
    ' da Cópia de Segurança do Banco de Dados.' + #13#10 +
    'Clique em OK quando estiver pronto ou em Cancelar para sair.';
  CAP_INSDISCON =
    'Inserir disco';
  MSG_INSDISCONRE =
    'Insira o disco ';
  MSG_OKBAK =
    'A Cópia de Segurança do Banco de Dados foi criada com sucesso.';
  CAP_OKBAK =
    'Concluído';
  MSG_OKRE =
    'A Cópia de Segurança do Banco de Dados foi restaurada com sucesso.';
  MSG_RESTAURAR =
    'ATENÇÃO! A Restauração da Cópia de Segurança APAGARÁ TODOS OS DADOS ' +
    'EXISTENTES no Banco de Dados Atual, e NÃO HAVERÁ NENHUMA FORMA DE ' +
    'REVERTER O PROCESSO. Tem certeza que deseja continuar ?';
  CAP_RESTAURAR =
    'Confirmação da restauração do BD';
  MSG_AUTOLOGOFF =
    'Somente a Conta abaixo poderá desbloquear o Sistema Biblioteca:' +
    #13#10 + 'Conta de Login: ';
  CAP_AUTOLOGOFF =
    'Sistema Bloqueado';

  CAP_NOALL =
    'Informações incompletas ou incorretas';
  {constantes usadas pelo cadastro de usuários}
  MSG_NONOME =
    'O campo "Nome" não pode estar em branco. Digite o Nome do Usuário.';
  MSG_NOENDERECO =
    'O campo "Endereço" não pode estar em branco. ' +
    'Digite o Endereço do Usuário.';
  MSG_NOBAIRRO =
    'O campo "Bairro" não pode estar em branco. Digite o Bairro.';
  MSG_NOCIDADE =
    'O campo "Cidade" não pode estar em branco. Digite a Cidade.';
  MSG_NOCEP =
    'O campo "CEP" não foi digitado corretamente. Digite o CEP correto.';
  MSG_NOCPF =
    'O CPF digitado é inválido. Digite o CPF correto.';
  MSG_NORGA =
    'O campo "RGA" não pode estar em branco. Digite o RGA.';
  MSG_EXISTERGA =
    'O valor digitado no campo "RGA" já existe. Digite outro número de RGA.';
  MSG_EXCLUIRUSUARIO =
    'Tem certeza que deseja excluir o Usuário do cadastro ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRUSUARIO =
    'Excluir Usuário';
  {constantes usadas pelo cadastro de fornecedores}
  MSG_NONOMEF =
    'O campo "Nome" não pode estar em branco. Digite o Nome do Fornecedor.';
  MSG_NOENDERECOF =
    'O campo "Endereço" não pode estar em branco. ' +
    'Digite o Endereço do Fornecedor.';
  MSG_EXCLUIRFORNECEDOR =
    'Tem certeza que deseja excluir o Fornecedor do cadastro ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRFORNECEDOR =
    'Excluir Fornecedor';
  {constantes usadas pelo cadastro de acervo}
  MSG_NOTOMBO =
    'Digite o número do Tombo no campo correspondente.';
  CAP_NOTOMBO =
    'Nenhum exemplar para adicionar';
  MSG_ATOMBO =
    'Já existe um exemplar com este número de Tombo. Digite outro Tombo.';
  CAP_ATOMBO =
    'Já existe exemplar';
  MSG_DTOMBO =
    'Deve existir pelo menos um exemplar do acervo.';
  CAP_DTOMBO =
    'Único exemplar';
  MSG_EXCTOMBO =
    'Tem certeza que deseja excluir o exemplar do cadastro ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCTOMBO =
    'Excluir exemplar';
  MSG_EXCLUIRACERVO =
    'Tem certeza que deseja excluir o Acervo do cadastro ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRACERVO =
    'Excluir Acervo';
  MSG_NOTITULO =
    'O campo "Título" não pode estar em branco. Digite o Título.';
  MSG_NOAUTOR =
    'O campo "Autor" não pode estar em branco. Digite o Autor.';
  MSG_NOEDITORA =
    'O campo "Editora" não pode estar em branco. Digite a Editora.';
  MSG_NOEDICAO =
    'O campo "Edição" não pode estar em branco. Digite a Edição.';
  MSG_NOEXEMPLARES =
    'Deve existir pelo menos um exemplar do acervo. Adicione exemplares para ' +
    'esse acervo.';
  {constantes usadas pelo cadastro de tipos de usuários}
  MSG_NODESCRICAO =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição do ' +
    ' Tipo de Usuário.';
  MSG_NOMAXEXEMPLARES =
    'O campo "Máximo de Exemplares" não pode estar em branco. Digite o ' +
    'Número Máximo de Exemplares que esse Tipo de Usuário pode emprestar.';
  MSG_NOTEMPOEMPRESTIMO =
    'O campo "Tempo de Empréstimo" não pode estar em branco. Digite a ' +
    'quantidade máxima de dias que esse Tipo de Usuário pode permanecer ' +
    'com itens emprestados.';
  MSG_NOTEMPOSUSP =
    'O campo "Tempo de Suspensão" não pode estar em branco. Digite o ' +
    'número de dias que esse Tipo de Usuário fica suspenso por atrasar a ' +
    'devolução de itens emprestados.';
  MSG_EXCLUIRTIPOUSUARIO =
    'Tem certeza que deseja excluir o Tipo de Usuário selecionado ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRTIPOUSUARIO =
    'Excluir Tipo de Usuário';
  MSG_ADESCRICAOTIPOUSUARIO =
    'Já existe um Tipo de Usuário com esse nome. Altere o campo "Descrição".';
  CAP_ADESCRICAOTIPOUSUARIO =
    'Tipo de Usuário duplicado';
  MSG_NOEXCLUIRTIPOUSUARIO =
    'Não é possível alterar ou excluir os Tipos de Usuário pré-definidos ' +
    'pelo Sistema Biblioteca (ALUNO, PROFESSOR, BIBLIOTECÁRIO e FUNCIONÁRIO).';
  CAP_NOEXCLUIRTIPOUSUARIO =
    'Tipo de Usuário criado pelo Sistema';
  MSG_MUITOSTIPOUSUARIO =
    'Não é possível ter mais do que 20 Tipos de Usuário cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTIPOUSUARIO =
    'Limite Máximo de Tipos de Usuário';
  {constantes usadas pelo cadastro de tipos de fornecedores}
  MSG_NODESCRICAOF =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição do ' +
    'Tipo de Fornecedor.';
  MSG_EXCLUIRTIPOFORNECEDOR =
    'Tem certeza que deseja excluir o Tipo de Fornecedor selecionado ?'
    + #13#10 + '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRTIPOFORNECEDOR =
    'Excluir Tipo de Fornecedor';
  MSG_ADESCRICAOTIPOFORNECEDOR =
    'Já existe um Tipo de Fornecedor com esse nome. ' +
    'Altere o campo "Descrição".';
  CAP_ADESCRICAOTIPOFORNECEDOR =
    'Tipo de Fornecedor duplicado';
  MSG_NOEXCLUIRTIPOFORNECEDOR =
    'Não é possível alterar ou excluir os Tipos de Fornecedor pré-definidos ' +
    'pelo Sistema Biblioteca (LIVRARIA, EDITORA).';
  CAP_NOEXCLUIRTIPOFORNECEDOR =
    'Tipo de Fornecedor criado pelo Sistema';
  MSG_MUITOSTIPOFORNECEDORES =
    'Não é possível ter mais do que 10 Tipos de Fornecedor cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTIPOFORNECEDORES =
    'Limite Máximo de Tipos de Fornecedor';
  {constantes usadas pelo cadastro de tipos de acervo}
  MSG_NODESCRICAOTA =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição do ' +
    'Tipo de Acervo.';
  MSG_EXCLUIRTA =
    'Tem certeza que deseja excluir o Tipo de Acervo selecionado ?'
    + #13#10 + '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRTA =
    'Excluir Tipo de Acervo';
  MSG_ADESCRICAOTA =
    'Já existe um Tipo de Acervo com esse nome. ' +
    'Altere o campo "Descrição".';
  CAP_ADESCRICAOTA =
    'Tipo de Acervo duplicado';
  MSG_NOEXCLUIRTA =
    'Não é possível alterar ou excluir os Tipos de Acervo pré-definidos ' +
    'pelo Sistema Biblioteca (LIVRO, ENCICLOPÉDIA).';
  CAP_NOEXCLUIRTA =
    'Tipo de Acervo criado pelo Sistema';
  MSG_MUITOSTA =
    'Não é possível ter mais do que 20 Tipos de Acervo cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTA =
    'Limite Máximo de Tipos de Acervo';
  {constantes usadas pelo cadastro de áreas de acervo}
  MSG_NODESCRICAOAA =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição da ' +
    'Área de Acervo.';
  MSG_EXCLUIRAA =
    'Tem certeza que deseja excluir a Área de Acervo selecionada ?'
    + #13#10 + '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRAA =
    'Excluir Área de Acervo';
  MSG_ADESCRICAOAA =
    'Já existe uma Área de Acervo com esse nome. ' +
    'Altere o campo "Descrição".';
  CAP_ADESCRICAOAA =
    'Área de Acervo duplicada';
  MSG_NOEXCLUIRAA =
    'Não é possível alterar ou excluir as Áreas de Acervo pré-definidas ' +
    'pelo Sistema Biblioteca (PORTUGUÊS, MATEMÁTICA, CIÊNCIAS, ESTUDOS SOCIAIS).';
  CAP_NOEXCLUIRAA =
    'Área de Acervo criada pelo Sistema';
  MSG_MUITOSAA =
    'Não é possível ter mais do que 30 Áreas de Acervo cadastradas no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSAA =
    'Limite Máximo de Áreas de Acervo';
  {constantes usadas pelo cadastro de classificações de acervo}
  MSG_NODESCRICAOCA =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição da ' +
    'Classificação de Acervo.';
  MSG_EXCLUIRCA =
    'Tem certeza que deseja excluir a Classificação de Acervo selecionada ?'
    + #13#10 + '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRCA =
    'Excluir Classificação de Acervo';
  MSG_ADESCRICAOCA =
    'Já existe uma Classificação de Acervo com esse nome. ' +
    'Altere o campo "Descrição".';
  CAP_ADESCRICAOCA =
    'Classificação de Acervo duplicada';
  MSG_NOEXCLUIRCA =
    'Não é possível alterar ou excluir as Classificações de Acervo pré-definidas ' +
    'pelo Sistema Biblioteca (AVALIAÇÃO, DIDÁTICO, RECREAÇÃO).';
  CAP_NOEXCLUIRCA =
    'Classificação de Acervo criada pelo Sistema';
  MSG_MUITOSCA =
    'Não é possível ter mais do que 20 Classificações de Acervo cadastradas no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSCA =
    'Limite Máximo de Classificações de Acervo';
  {constantes usadas pelo cadastro grupos login}
  MSG_NODESCRICAOG =
    'O campo "Descrição" não pode estar em branco. Digite a Descrição do ' +
    'Grupo de Login.';
  MSG_EXCLUIRGRUPO =
    'Tem certeza que deseja excluir o Grupo de Login selecionado ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRGRUPO =
    'Excluir Grupo de Login';
  MSG_ADESCRICAOGRUPO =
    'Já existe um Grupo de Login com esse nome. Altere o campo "Descrição".';
  CAP_ADESCRICAOGRUPO =
    'Grupo de Login duplicado';
  MSG_NOEXCLUIRGRUPO =
    'Não é possível alterar ou excluir os Grupos de Login pré-definidos ' +
    'pelo Sistema Biblioteca (ADMINISTRADORES, BIBLIOTECÁRIOS e ALUNOS).';
  CAP_NOEXCLUIRGRUPO =
    'Grupo de Login criado pelo Sistema';
  {constantes usadas pelo cadastro contas login}
  MSG_NODESCRICAOC =
    'O campo "Conta" não pode estar em branco. Digite o Nome da ' +
    'Conta de Login.';
  MSG_EXCLUIRCONTA =
    'Tem certeza que deseja excluir a Conta de Login selecionada ?' + #13#10 +
    '(esta operação não poderá ser desfeita).';
  CAP_EXCLUIRCONTA =
    'Excluir Conta de Login';
  MSG_ADESCRICAOCONTA =
    'Já existe uma Conta de Login com esse nome. Altere o campo "Conta".';
  CAP_ADESCRICAOCONTA =
    'Conta de Login duplicada';
  MSG_NOEXCLUIRCONTA =
    'Não é possível alterar ou excluir as Contas de Login pré-definidas ' +
    'pelo Sistema Biblioteca (ADMIN e ALUNO).';
  CAP_NOEXCLUIRCONTA =
    'Conta de Login criada pelo Sistema';
  MSG_NOSENHAC =
    'A senha digitada não confere. Digite a mesma senha nos campos "Senha" e ' +
    '"Confirmação da Senha"';

{************* Rotinas e Funções **************}

{Converte uma UF (sigla) em uma string com o Estado}
function UFToEstado(UF: String): String;
{Converte uma string com o Estado em uma string com a UF (sigla)}
function EstadoToUF(Estado: String): String;
{Retorna True se outra instância da aplicação está rodando}
function SystemRunning: Boolean;
{retorna True se a resolução de tela é pelo menos 800x600}
function MinRes800x600: Boolean;
{retorna True se o tamanho do Picture é pelo menos igual a resolução da tela}
function PictSizeOK(Picture: TPicture): Boolean;
{converte um Boolean em uma String reconhecida pelo Access}
function BoolToAccessStr(Booleano: Boolean): String;
{converte um Boolean em um Inteiro}
function BoolToInt(Booleano: Boolean): Integer;
{Consiste número de CPF}
function ConsisteCPF(CPFString: String): Boolean;
{Consiste On-Line os campos apenas numéricos (inteiros) no OnChange}
procedure ConsisteNumerico(Sender: TObject);
{Consiste On-Line os campos apenas literais no OnChange}
procedure ConsisteLiteral(Sender: TObject);

implementation

function UFToEstado(UF: String): String;
{Converte uma UF (sigla) em uma string com o Estado}
begin
  Result := 'São Paulo'; {default}
  if UF = 'AC' then
    Result := 'Acre';
  if UF = 'AL' then
    Result := 'Alagoas';
  if UF = 'AP' then
    Result := 'Amapá';
  if UF = 'AM' then
    Result := 'Amazonas';
  if UF = 'BA' then
    Result := 'Bahia';
  if UF = 'CE' then
    Result := 'Ceará';
  if UF = 'DF' then
    Result := 'Distrito Federal';
  if UF = 'ES' then
    Result := 'Espírito Santo';
  if UF = 'GO' then
    Result := 'Goiás';
  if UF = 'MA' then
    Result := 'Maranhão';
  if UF = 'MT' then
    Result := 'Mato Grosso';
  if UF = 'MS' then
    Result := 'Mato Grosso do Sul';
  if UF = 'MG' then
    Result := 'Minas Gerais';
  if UF = 'PA' then
    Result := 'Pará';
  if UF = 'PB' then
    Result := 'Paraíba';
  if UF = 'PR' then
    Result := 'Paraná';
  if UF = 'PE' then
    Result := 'Pernambuco';
  if UF = 'PI' then
    Result := 'Piauí';
  if UF = 'RJ' then
    Result := 'Rio de Janeiro';
  if UF = 'RN' then
    Result := 'Rio Grande do Norte';
  if UF = 'RS' then
    Result := 'Rio Grande do Sul';
  if UF = 'RO' then
    Result := 'Rondônia';
  if UF = 'RR' then
    Result := 'Roraima';
  if UF = 'SC' then
    Result := 'Santa Catarina';
  if UF = 'SP' then
    Result := 'São Paulo';
  if UF = 'SE' then
    Result := 'Sergipe';
  if UF = 'TO' then
    Result := 'Tocantins';
end;

function EstadoToUF(Estado: String): String;
{Converte uma string com o Estado em uma string com a UF (sigla)}
begin
  Result := 'SP'; {default}
  if Estado = 'Acre' then
    Result := 'AC';
  if Estado = 'Alagoas' then
    Result := 'AL';
  if Estado = 'Amapá' then
    Result := 'AP';
  if Estado = 'Amazonas' then
    Result := 'AM';
  if Estado = 'Bahia' then
    Result := 'BA';
  if Estado = 'Ceará' then
    Result := 'CE';
  if Estado = 'Distrito Federal' then
    Result := 'DF';
  if Estado = 'Espírito Santo' then
    Result := 'ES';
  if Estado = 'Goiás' then
    Result := 'GO';
  if Estado = 'Maranhão' then
    Result := 'MA';
  if Estado = 'Mato Grosso' then
    Result := 'MT';
  if Estado = 'Mato Grosso do Sul' then
    Result := 'MS';
  if Estado = 'Minas Gerais' then
    Result := 'MG';
  if Estado = 'Pará' then
    Result := 'PA';
  if Estado = 'Paraíba' then
    Result := 'PB';
  if Estado = 'Paraná' then
    Result := 'PR';
  if Estado = 'Pernambuco' then
    Result := 'PE';
  if Estado = 'Piauí' then
    Result := 'PI';
  if Estado = 'Rio de Janeiro' then
    Result := 'RJ';
  if Estado = 'Rio Grande do Norte' then
    Result := 'RN';
  if Estado = 'Rio Grande do Sul' then
    Result := 'RS';
  if Estado = 'Rondônia' then
    Result := 'RO';
  if Estado = 'Roraima' then
    Result := 'RR';
  if Estado = 'Santa Catarina' then
    Result := 'SC';
  if Estado = 'São Paulo' then
    Result := 'SP';
  if Estado = 'Sergipe' then
    Result := 'SE';
  if Estado = 'Tocantins' then
    Result := 'TO';
end;

function SystemRunning: Boolean;
var hWnd: THandle;
begin
  {Retorna True se outra instância da aplicação está rodando}
  {procura uma janela do Sistema que já está rodando}
  hWnd := FindWindow('Tform_Desktop','Desktop do Sistema Biblioteca');
  if (hWnd = 0) then
    Result := False
  else
    Result := True;
end;

function MinRes800x600: Boolean;
begin
  {retorna True se a resolução de tela é pelo menos 800x600}
  if Screen.Width >= 800 then
    Result := True
  else
    Result := False;
end;

function PictSizeOK(Picture: TPicture): Boolean;
begin
  {retorna True se o tamanho do Picture é pelo menos igual a resolução da tela}
  if (Picture.Width < Screen.Width) or (Picture.Height < Screen.Height) then
    Result := False
  else
    Result := True;
end;

function BoolToAccessStr(Booleano: Boolean): String;
begin
  {converte um Boolean em uma String reconhecida pelo Access}
  if Booleano then
    Result := '-1'
  else
    Result := '0';
end;

function BoolToInt(Booleano: Boolean): Integer;
begin
  {converte um Boolean em um Inteiro}
  if Booleano then
    Result := 1
  else
    Result := 0;
end;

function ConsisteCPF(CPFString: String): Boolean;
var i: Integer;
    CPF: String;
    Dig1, Dig2: Integer;
begin
  Result := False;
  {se tamanho = 0, não calcula}
  if Length(CPFString) = 0 then
    exit;
  {Remove caracteres não numéricos}
  CPF := '';
  for i := 1 to Length(CPFString) do
  begin
    if CPFString[i] in ['0'..'9'] then
      CPF := CPF + CPFString[i];
  end;
  {se tamanho <> 11, não calcula}
  if Length(CPF) <> 11 then
    exit;
  {Cálculo 1º dígito ver.}
  Dig1 := 0;
  for i := 1 to 9 do
    Dig1 := Dig1 + (11 - i) * StrToInt(CPF[i]);
  Dig1 := Dig1 mod 11;
  if Dig1 < 2 then
    Dig1 := 0
  else
    Dig1 := 11 - Dig1;
  {Se 1º dig ver. não estiver correto, sai}
  if StrToInt(CPF[10]) <> Dig1 then
    exit;
  {Cálculo 2º dígito ver.}
  Dig2 := 0;
  for i := 1 to 9 do
    Dig2 := Dig2 + (12 - i) * StrToInt(CPF[i]);
  Dig2 := (Dig2 + Dig1 * 2) mod 11;
  if Dig2 < 2 then
    Dig2 := 0
  else
    Dig2 := 11 - Dig2;
  {Se 2º dig ver. estiver correto, retorna True}
  if StrToInt(CPF[11]) = Dig2 then
    Result := True;
end;

procedure ConsisteNumerico(Sender: TObject);
var i: Integer;
    tmpstr: String;
begin
  {consistência On-Line dos campos apenas numéricos (inteiros)}
  {deve ser executado no evento OnChange do TEdit}
  with (Sender as TEdit) do
  begin
    if Length(Text) = 0 then
      exit;
    i := 1;
    while i <= Length(Text) do
    begin
      if not (Text[i] in ['0'..'9']) then
      begin
        tmpstr := Text;     {qualquer caracter que não seja 0..9 é apagado}
        Delete(tmpstr,i,1);
        Text := tmpstr;
        SelStart := i - 1;
      end
      else
        Inc(i);
    end;
  end;
end;

procedure ConsisteLiteral(Sender: TObject);
var i: Integer;
    tmpstr: String;
begin
  {consistência On-Line dos campos apenas texto}
  {deve ser executado no evento OnChange do TEdit}
  with (Sender as TEdit) do
  begin
    if Length(Text) = 0 then
      exit;
    i := 1;
    while i <= Length(Text) do
    begin
      if (Ord(Text[i]) < 32) or 
         ((Ord(Text[i]) > 122) and (Ord(Text[i]) < 128)) then
      begin
        tmpstr := Text;     {qualquer caracter que não seja Literal é apagado}
        Delete(tmpstr,i,1);
        Text := tmpstr;
        SelStart := i - 1;
      end
      else
        Inc(i);
    end;
  end;
end;

end.
