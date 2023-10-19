{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_Comum.pas

  Cont�m tipos de dados, constantes, rotinas fun��es comuns a toda Aplica��o.

  Data �ltima revis�o: 06/11/2001

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

{Constantes das configura��es dos Di�logos}
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
    'N�o foi poss�vel encontrar o Banco de Dados do Sistema Biblioteca.' +
    #13#10 + 'Reinstale o Sistema e restaure a �ltima C�pia de Seguran�a do ' +
    'Banco de Dados.';
  CAP_SEMDB =
    'Banco de Dados n�o encontrado';
  MSG_NOCONNDB =
    'N�o foi poss�vel conectar com o Banco de Dados do Sistema Biblioteca.' +
    #13#10 + 'Reinstale o Sistema e restaure a �ltima C�pia de Seguran�a do ' +
    'Banco de Dados.' + #13#10 + 'Erro: ';
  CAP_NOCONNDB =
    'Erro ao conectar com o Banco de Dados';
  CAP_ERRODB =
    'Erro em opera��o com Banco de Dados';
  MSG_ERROSELECT =
    'Erro ao ler registros do Banco de Dados. ' +
    'Talvez haja problemas com o Banco de Dados. Restaure a �ltima c�pia ' +
    ' de seguran�a. ' + #13#10 + 'Erro: ';
  MSG_ERROINSERT =
    'Erro ao inserir o registro no Banco de Dados. ' + #13#10;
  MSG_ERROUPDATE =
    'Erro ao atualizar o registro no Banco de Dados. ' + #13#10;
  MSG_ERRODELETE =
    'Erro ao apagar o registro no Banco de Dados. ' + #13#10;
  MSG_FORMOPEN =
    'H� dados que foram alterados mas n�o foram gravados. Clique em "Gravar" ' +
    'para salvar as altera��es ou em "Cancelar" para cancelar as altera��es.';
  CAP_FORMOPEN =
    'N�o foi poss�vel fechar a janela';
  MSG_SAIR =
    'H� janelas abertas no Sistema Biblioteca. Feche-as antes de sair do ' +
    'Sistema.';
  CAP_SAIR =
    'N�o foi poss�vel sair do Sistema Biblioteca';
  MSG_SAIRBBT =
    'Tem certeza que deseja sair do Sistema Biblioteca ?';
  CAP_SAIRBBT =
    'Sair do Sistema Biblioteca';
  MSG_LOGOFF =
    'H� janelas abertas no Sistema Biblioteca. Feche-as antes de efetuar o ' +
    'Logoff.';
  CAP_LOGOFF =
    'N�o foi poss�vel efetuar o Logoff no Sistema Biblioteca';
  MSG_NOBAK =
    'H� janelas abertas no Sistema Biblioteca. Feche-as antes de criar uma ' +
    'C�pia de Seguran�a do Banco da Dados.';
  CAP_NOBAK =
    'N�o � poss�vel criar C�pia de Seguran�a';
  MSG_NOREST =
    'H� janelas abertas no Sistema Biblioteca. Feche-as antes de restaurar ' +
    'uma C�pia de Seguran�a do Banco da Dados.';
  CAP_NOREST =
    'N�o � poss�vel restaurar C�pia de Seguran�a';
  MSG_MINRES =
    'O Sistema Biblioteca s� funciona com uma resolu��o de v�deo de pelo ' +
    'menos 800x600.' + #13#10 +
    'Consulte a ajuda do Windows para saber como alterar a resolu��o do ' +
    'v�deo.';
  CAP_MINRES =
    'Resolu��o de v�deo menor do que 800x600';
  MSG_ERROLOGINR =
    'A Senha est� incorreta.' + #13#10 +
    'N�o foi poss�vel realizar o Login, pois o n�mero ' +
    'de tentativas foi esgotado. Clique em OK para fechar o programa.';
  CAP_ERROLOGINR =
    'Esgotado n�mero m�ximo de tentativas';
  MSG_ERROLOGIN =
    'A Senha est� incorreta.' + #13#10 +
    'Tente digitar novamente, lembrando que a Senha � ' +
    'sens�vel a letras mai�sculas/min�sculas';
  CAP_ERROLOGIN =
    'Erro de Login';
  MSG_PICPEQ =
    'N�o � poss�vel usar esse arquivo como papel de parede, pois suas ' +
    'dimens�es s�o menores do que as dimens�es da tela.' + #13#10 +
    'Tente procurar outro arquivo.';
  CAP_PICPEQ =
    'Imagem muito pequena';
  MSG_EXEMPRESERVADO =
    'Este exemplar do acervo j� est� reservado para os seguintes usu�rios:' +
    #13#10;
  MSG_EXEMPRESERVADO1 =
    'Confirma mesmo assim o empr�stimo ?';
  {constantes usadas pelo backup/restore}
  CAP_ERROBAKALL =
    'Erro na cria��o da C�pia de Seguran�a';
  MSG_ERROLEBAK =
    'N�o foi poss�vel ler o arquivo do Banco de Dados.' + #13#10 + 'Erro: ';
  MSG_ERROTMPBAK =
    'N�o foi poss�vel gravar o arquivo tempor�rio.' + #13#10 + 'Erro: ';
  MSG_ERROZIPBAK =
    'N�o foi poss�vel compactar o arquivo do Banco de Dados.' +
    #13#10 + 'Erro: ';
  CAP_ERROREALL =
    'Erro na restaura��o da C�pia de Seguran�a';
  MSG_ERROLERE =
    'N�o foi poss�vel ler o arquivo compactado da C�pia de Seguran�a.' +
    #13#10 + 'Erro: ';
  MSG_ERROTMPRE =
    'N�o foi poss�vel sobrescrever o arquivo do Banco de Dados.' + #13#10 +
    'Erro: ';
  MSG_ERROZIPRE =
    'N�o foi poss�vel descompactar o arquivo da C�pia de Seguran�a.' +
    #13#10 + 'Erro: ';
  MSG_INSDISCO =
    'Insira um disco vazio e desprotegido contra grava��o na unidade ';
  MSG_INSDISCOR =
    'Insira o disco da c�pia de seguran�a na unidade ';
  MSG_INSDISCO2 =
    ': e clique em OK. ' + #13#10 + 'Clique em Cancelar para sair.';
  CAP_INSDISCO =
    'Disco inv�lido';
  MSG_EXISTBAK =
    'J� existe no disco uma C�pia de Seguran�a realizada hoje.' + #13#10;
  MSG_VDSKBAK =
    'Ser�o necess�rios ';
  MSG_VDSKBAK2 =
    ' discos para criar a C�pia de Seguran�a. Deseja Continuar?';
  CAP_VDSKBAK =
    'Mais de um disco necess�rio';
  MSG_INSDISCON =
    'Insira o disco onde ser� gravado o volume ';
  MSG_INSDISCON2 =
    ' da C�pia de Seguran�a do Banco de Dados.' + #13#10 +
    'Clique em OK quando estiver pronto ou em Cancelar para sair.';
  CAP_INSDISCON =
    'Inserir disco';
  MSG_INSDISCONRE =
    'Insira o disco ';
  MSG_OKBAK =
    'A C�pia de Seguran�a do Banco de Dados foi criada com sucesso.';
  CAP_OKBAK =
    'Conclu�do';
  MSG_OKRE =
    'A C�pia de Seguran�a do Banco de Dados foi restaurada com sucesso.';
  MSG_RESTAURAR =
    'ATEN��O! A Restaura��o da C�pia de Seguran�a APAGAR� TODOS OS DADOS ' +
    'EXISTENTES no Banco de Dados Atual, e N�O HAVER� NENHUMA FORMA DE ' +
    'REVERTER O PROCESSO. Tem certeza que deseja continuar ?';
  CAP_RESTAURAR =
    'Confirma��o da restaura��o do BD';
  MSG_AUTOLOGOFF =
    'Somente a Conta abaixo poder� desbloquear o Sistema Biblioteca:' +
    #13#10 + 'Conta de Login: ';
  CAP_AUTOLOGOFF =
    'Sistema Bloqueado';

  CAP_NOALL =
    'Informa��es incompletas ou incorretas';
  {constantes usadas pelo cadastro de usu�rios}
  MSG_NONOME =
    'O campo "Nome" n�o pode estar em branco. Digite o Nome do Usu�rio.';
  MSG_NOENDERECO =
    'O campo "Endere�o" n�o pode estar em branco. ' +
    'Digite o Endere�o do Usu�rio.';
  MSG_NOBAIRRO =
    'O campo "Bairro" n�o pode estar em branco. Digite o Bairro.';
  MSG_NOCIDADE =
    'O campo "Cidade" n�o pode estar em branco. Digite a Cidade.';
  MSG_NOCEP =
    'O campo "CEP" n�o foi digitado corretamente. Digite o CEP correto.';
  MSG_NOCPF =
    'O CPF digitado � inv�lido. Digite o CPF correto.';
  MSG_NORGA =
    'O campo "RGA" n�o pode estar em branco. Digite o RGA.';
  MSG_EXISTERGA =
    'O valor digitado no campo "RGA" j� existe. Digite outro n�mero de RGA.';
  MSG_EXCLUIRUSUARIO =
    'Tem certeza que deseja excluir o Usu�rio do cadastro ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRUSUARIO =
    'Excluir Usu�rio';
  {constantes usadas pelo cadastro de fornecedores}
  MSG_NONOMEF =
    'O campo "Nome" n�o pode estar em branco. Digite o Nome do Fornecedor.';
  MSG_NOENDERECOF =
    'O campo "Endere�o" n�o pode estar em branco. ' +
    'Digite o Endere�o do Fornecedor.';
  MSG_EXCLUIRFORNECEDOR =
    'Tem certeza que deseja excluir o Fornecedor do cadastro ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRFORNECEDOR =
    'Excluir Fornecedor';
  {constantes usadas pelo cadastro de acervo}
  MSG_NOTOMBO =
    'Digite o n�mero do Tombo no campo correspondente.';
  CAP_NOTOMBO =
    'Nenhum exemplar para adicionar';
  MSG_ATOMBO =
    'J� existe um exemplar com este n�mero de Tombo. Digite outro Tombo.';
  CAP_ATOMBO =
    'J� existe exemplar';
  MSG_DTOMBO =
    'Deve existir pelo menos um exemplar do acervo.';
  CAP_DTOMBO =
    '�nico exemplar';
  MSG_EXCTOMBO =
    'Tem certeza que deseja excluir o exemplar do cadastro ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCTOMBO =
    'Excluir exemplar';
  MSG_EXCLUIRACERVO =
    'Tem certeza que deseja excluir o Acervo do cadastro ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRACERVO =
    'Excluir Acervo';
  MSG_NOTITULO =
    'O campo "T�tulo" n�o pode estar em branco. Digite o T�tulo.';
  MSG_NOAUTOR =
    'O campo "Autor" n�o pode estar em branco. Digite o Autor.';
  MSG_NOEDITORA =
    'O campo "Editora" n�o pode estar em branco. Digite a Editora.';
  MSG_NOEDICAO =
    'O campo "Edi��o" n�o pode estar em branco. Digite a Edi��o.';
  MSG_NOEXEMPLARES =
    'Deve existir pelo menos um exemplar do acervo. Adicione exemplares para ' +
    'esse acervo.';
  {constantes usadas pelo cadastro de tipos de usu�rios}
  MSG_NODESCRICAO =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o do ' +
    ' Tipo de Usu�rio.';
  MSG_NOMAXEXEMPLARES =
    'O campo "M�ximo de Exemplares" n�o pode estar em branco. Digite o ' +
    'N�mero M�ximo de Exemplares que esse Tipo de Usu�rio pode emprestar.';
  MSG_NOTEMPOEMPRESTIMO =
    'O campo "Tempo de Empr�stimo" n�o pode estar em branco. Digite a ' +
    'quantidade m�xima de dias que esse Tipo de Usu�rio pode permanecer ' +
    'com itens emprestados.';
  MSG_NOTEMPOSUSP =
    'O campo "Tempo de Suspens�o" n�o pode estar em branco. Digite o ' +
    'n�mero de dias que esse Tipo de Usu�rio fica suspenso por atrasar a ' +
    'devolu��o de itens emprestados.';
  MSG_EXCLUIRTIPOUSUARIO =
    'Tem certeza que deseja excluir o Tipo de Usu�rio selecionado ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRTIPOUSUARIO =
    'Excluir Tipo de Usu�rio';
  MSG_ADESCRICAOTIPOUSUARIO =
    'J� existe um Tipo de Usu�rio com esse nome. Altere o campo "Descri��o".';
  CAP_ADESCRICAOTIPOUSUARIO =
    'Tipo de Usu�rio duplicado';
  MSG_NOEXCLUIRTIPOUSUARIO =
    'N�o � poss�vel alterar ou excluir os Tipos de Usu�rio pr�-definidos ' +
    'pelo Sistema Biblioteca (ALUNO, PROFESSOR, BIBLIOTEC�RIO e FUNCION�RIO).';
  CAP_NOEXCLUIRTIPOUSUARIO =
    'Tipo de Usu�rio criado pelo Sistema';
  MSG_MUITOSTIPOUSUARIO =
    'N�o � poss�vel ter mais do que 20 Tipos de Usu�rio cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTIPOUSUARIO =
    'Limite M�ximo de Tipos de Usu�rio';
  {constantes usadas pelo cadastro de tipos de fornecedores}
  MSG_NODESCRICAOF =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o do ' +
    'Tipo de Fornecedor.';
  MSG_EXCLUIRTIPOFORNECEDOR =
    'Tem certeza que deseja excluir o Tipo de Fornecedor selecionado ?'
    + #13#10 + '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRTIPOFORNECEDOR =
    'Excluir Tipo de Fornecedor';
  MSG_ADESCRICAOTIPOFORNECEDOR =
    'J� existe um Tipo de Fornecedor com esse nome. ' +
    'Altere o campo "Descri��o".';
  CAP_ADESCRICAOTIPOFORNECEDOR =
    'Tipo de Fornecedor duplicado';
  MSG_NOEXCLUIRTIPOFORNECEDOR =
    'N�o � poss�vel alterar ou excluir os Tipos de Fornecedor pr�-definidos ' +
    'pelo Sistema Biblioteca (LIVRARIA, EDITORA).';
  CAP_NOEXCLUIRTIPOFORNECEDOR =
    'Tipo de Fornecedor criado pelo Sistema';
  MSG_MUITOSTIPOFORNECEDORES =
    'N�o � poss�vel ter mais do que 10 Tipos de Fornecedor cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTIPOFORNECEDORES =
    'Limite M�ximo de Tipos de Fornecedor';
  {constantes usadas pelo cadastro de tipos de acervo}
  MSG_NODESCRICAOTA =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o do ' +
    'Tipo de Acervo.';
  MSG_EXCLUIRTA =
    'Tem certeza que deseja excluir o Tipo de Acervo selecionado ?'
    + #13#10 + '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRTA =
    'Excluir Tipo de Acervo';
  MSG_ADESCRICAOTA =
    'J� existe um Tipo de Acervo com esse nome. ' +
    'Altere o campo "Descri��o".';
  CAP_ADESCRICAOTA =
    'Tipo de Acervo duplicado';
  MSG_NOEXCLUIRTA =
    'N�o � poss�vel alterar ou excluir os Tipos de Acervo pr�-definidos ' +
    'pelo Sistema Biblioteca (LIVRO, ENCICLOP�DIA).';
  CAP_NOEXCLUIRTA =
    'Tipo de Acervo criado pelo Sistema';
  MSG_MUITOSTA =
    'N�o � poss�vel ter mais do que 20 Tipos de Acervo cadastrados no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSTA =
    'Limite M�ximo de Tipos de Acervo';
  {constantes usadas pelo cadastro de �reas de acervo}
  MSG_NODESCRICAOAA =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o da ' +
    '�rea de Acervo.';
  MSG_EXCLUIRAA =
    'Tem certeza que deseja excluir a �rea de Acervo selecionada ?'
    + #13#10 + '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRAA =
    'Excluir �rea de Acervo';
  MSG_ADESCRICAOAA =
    'J� existe uma �rea de Acervo com esse nome. ' +
    'Altere o campo "Descri��o".';
  CAP_ADESCRICAOAA =
    '�rea de Acervo duplicada';
  MSG_NOEXCLUIRAA =
    'N�o � poss�vel alterar ou excluir as �reas de Acervo pr�-definidas ' +
    'pelo Sistema Biblioteca (PORTUGU�S, MATEM�TICA, CI�NCIAS, ESTUDOS SOCIAIS).';
  CAP_NOEXCLUIRAA =
    '�rea de Acervo criada pelo Sistema';
  MSG_MUITOSAA =
    'N�o � poss�vel ter mais do que 30 �reas de Acervo cadastradas no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSAA =
    'Limite M�ximo de �reas de Acervo';
  {constantes usadas pelo cadastro de classifica��es de acervo}
  MSG_NODESCRICAOCA =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o da ' +
    'Classifica��o de Acervo.';
  MSG_EXCLUIRCA =
    'Tem certeza que deseja excluir a Classifica��o de Acervo selecionada ?'
    + #13#10 + '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRCA =
    'Excluir Classifica��o de Acervo';
  MSG_ADESCRICAOCA =
    'J� existe uma Classifica��o de Acervo com esse nome. ' +
    'Altere o campo "Descri��o".';
  CAP_ADESCRICAOCA =
    'Classifica��o de Acervo duplicada';
  MSG_NOEXCLUIRCA =
    'N�o � poss�vel alterar ou excluir as Classifica��es de Acervo pr�-definidas ' +
    'pelo Sistema Biblioteca (AVALIA��O, DID�TICO, RECREA��O).';
  CAP_NOEXCLUIRCA =
    'Classifica��o de Acervo criada pelo Sistema';
  MSG_MUITOSCA =
    'N�o � poss�vel ter mais do que 20 Classifica��es de Acervo cadastradas no ' +
    'Sistema Biblioteca.';
  CAP_MUITOSCA =
    'Limite M�ximo de Classifica��es de Acervo';
  {constantes usadas pelo cadastro grupos login}
  MSG_NODESCRICAOG =
    'O campo "Descri��o" n�o pode estar em branco. Digite a Descri��o do ' +
    'Grupo de Login.';
  MSG_EXCLUIRGRUPO =
    'Tem certeza que deseja excluir o Grupo de Login selecionado ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRGRUPO =
    'Excluir Grupo de Login';
  MSG_ADESCRICAOGRUPO =
    'J� existe um Grupo de Login com esse nome. Altere o campo "Descri��o".';
  CAP_ADESCRICAOGRUPO =
    'Grupo de Login duplicado';
  MSG_NOEXCLUIRGRUPO =
    'N�o � poss�vel alterar ou excluir os Grupos de Login pr�-definidos ' +
    'pelo Sistema Biblioteca (ADMINISTRADORES, BIBLIOTEC�RIOS e ALUNOS).';
  CAP_NOEXCLUIRGRUPO =
    'Grupo de Login criado pelo Sistema';
  {constantes usadas pelo cadastro contas login}
  MSG_NODESCRICAOC =
    'O campo "Conta" n�o pode estar em branco. Digite o Nome da ' +
    'Conta de Login.';
  MSG_EXCLUIRCONTA =
    'Tem certeza que deseja excluir a Conta de Login selecionada ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRCONTA =
    'Excluir Conta de Login';
  MSG_ADESCRICAOCONTA =
    'J� existe uma Conta de Login com esse nome. Altere o campo "Conta".';
  CAP_ADESCRICAOCONTA =
    'Conta de Login duplicada';
  MSG_NOEXCLUIRCONTA =
    'N�o � poss�vel alterar ou excluir as Contas de Login pr�-definidas ' +
    'pelo Sistema Biblioteca (ADMIN e ALUNO).';
  CAP_NOEXCLUIRCONTA =
    'Conta de Login criada pelo Sistema';
  MSG_NOSENHAC =
    'A senha digitada n�o confere. Digite a mesma senha nos campos "Senha" e ' +
    '"Confirma��o da Senha"';

{************* Rotinas e Fun��es **************}

{Converte uma UF (sigla) em uma string com o Estado}
function UFToEstado(UF: String): String;
{Converte uma string com o Estado em uma string com a UF (sigla)}
function EstadoToUF(Estado: String): String;
{Retorna True se outra inst�ncia da aplica��o est� rodando}
function SystemRunning: Boolean;
{retorna True se a resolu��o de tela � pelo menos 800x600}
function MinRes800x600: Boolean;
{retorna True se o tamanho do Picture � pelo menos igual a resolu��o da tela}
function PictSizeOK(Picture: TPicture): Boolean;
{converte um Boolean em uma String reconhecida pelo Access}
function BoolToAccessStr(Booleano: Boolean): String;
{converte um Boolean em um Inteiro}
function BoolToInt(Booleano: Boolean): Integer;
{Consiste n�mero de CPF}
function ConsisteCPF(CPFString: String): Boolean;
{Consiste On-Line os campos apenas num�ricos (inteiros) no OnChange}
procedure ConsisteNumerico(Sender: TObject);
{Consiste On-Line os campos apenas literais no OnChange}
procedure ConsisteLiteral(Sender: TObject);

implementation

function UFToEstado(UF: String): String;
{Converte uma UF (sigla) em uma string com o Estado}
begin
  Result := 'S�o Paulo'; {default}
  if UF = 'AC' then
    Result := 'Acre';
  if UF = 'AL' then
    Result := 'Alagoas';
  if UF = 'AP' then
    Result := 'Amap�';
  if UF = 'AM' then
    Result := 'Amazonas';
  if UF = 'BA' then
    Result := 'Bahia';
  if UF = 'CE' then
    Result := 'Cear�';
  if UF = 'DF' then
    Result := 'Distrito Federal';
  if UF = 'ES' then
    Result := 'Esp�rito Santo';
  if UF = 'GO' then
    Result := 'Goi�s';
  if UF = 'MA' then
    Result := 'Maranh�o';
  if UF = 'MT' then
    Result := 'Mato Grosso';
  if UF = 'MS' then
    Result := 'Mato Grosso do Sul';
  if UF = 'MG' then
    Result := 'Minas Gerais';
  if UF = 'PA' then
    Result := 'Par�';
  if UF = 'PB' then
    Result := 'Para�ba';
  if UF = 'PR' then
    Result := 'Paran�';
  if UF = 'PE' then
    Result := 'Pernambuco';
  if UF = 'PI' then
    Result := 'Piau�';
  if UF = 'RJ' then
    Result := 'Rio de Janeiro';
  if UF = 'RN' then
    Result := 'Rio Grande do Norte';
  if UF = 'RS' then
    Result := 'Rio Grande do Sul';
  if UF = 'RO' then
    Result := 'Rond�nia';
  if UF = 'RR' then
    Result := 'Roraima';
  if UF = 'SC' then
    Result := 'Santa Catarina';
  if UF = 'SP' then
    Result := 'S�o Paulo';
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
  if Estado = 'Amap�' then
    Result := 'AP';
  if Estado = 'Amazonas' then
    Result := 'AM';
  if Estado = 'Bahia' then
    Result := 'BA';
  if Estado = 'Cear�' then
    Result := 'CE';
  if Estado = 'Distrito Federal' then
    Result := 'DF';
  if Estado = 'Esp�rito Santo' then
    Result := 'ES';
  if Estado = 'Goi�s' then
    Result := 'GO';
  if Estado = 'Maranh�o' then
    Result := 'MA';
  if Estado = 'Mato Grosso' then
    Result := 'MT';
  if Estado = 'Mato Grosso do Sul' then
    Result := 'MS';
  if Estado = 'Minas Gerais' then
    Result := 'MG';
  if Estado = 'Par�' then
    Result := 'PA';
  if Estado = 'Para�ba' then
    Result := 'PB';
  if Estado = 'Paran�' then
    Result := 'PR';
  if Estado = 'Pernambuco' then
    Result := 'PE';
  if Estado = 'Piau�' then
    Result := 'PI';
  if Estado = 'Rio de Janeiro' then
    Result := 'RJ';
  if Estado = 'Rio Grande do Norte' then
    Result := 'RN';
  if Estado = 'Rio Grande do Sul' then
    Result := 'RS';
  if Estado = 'Rond�nia' then
    Result := 'RO';
  if Estado = 'Roraima' then
    Result := 'RR';
  if Estado = 'Santa Catarina' then
    Result := 'SC';
  if Estado = 'S�o Paulo' then
    Result := 'SP';
  if Estado = 'Sergipe' then
    Result := 'SE';
  if Estado = 'Tocantins' then
    Result := 'TO';
end;

function SystemRunning: Boolean;
var hWnd: THandle;
begin
  {Retorna True se outra inst�ncia da aplica��o est� rodando}
  {procura uma janela do Sistema que j� est� rodando}
  hWnd := FindWindow('Tform_Desktop','Desktop do Sistema Biblioteca');
  if (hWnd = 0) then
    Result := False
  else
    Result := True;
end;

function MinRes800x600: Boolean;
begin
  {retorna True se a resolu��o de tela � pelo menos 800x600}
  if Screen.Width >= 800 then
    Result := True
  else
    Result := False;
end;

function PictSizeOK(Picture: TPicture): Boolean;
begin
  {retorna True se o tamanho do Picture � pelo menos igual a resolu��o da tela}
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
  {se tamanho = 0, n�o calcula}
  if Length(CPFString) = 0 then
    exit;
  {Remove caracteres n�o num�ricos}
  CPF := '';
  for i := 1 to Length(CPFString) do
  begin
    if CPFString[i] in ['0'..'9'] then
      CPF := CPF + CPFString[i];
  end;
  {se tamanho <> 11, n�o calcula}
  if Length(CPF) <> 11 then
    exit;
  {C�lculo 1� d�gito ver.}
  Dig1 := 0;
  for i := 1 to 9 do
    Dig1 := Dig1 + (11 - i) * StrToInt(CPF[i]);
  Dig1 := Dig1 mod 11;
  if Dig1 < 2 then
    Dig1 := 0
  else
    Dig1 := 11 - Dig1;
  {Se 1� dig ver. n�o estiver correto, sai}
  if StrToInt(CPF[10]) <> Dig1 then
    exit;
  {C�lculo 2� d�gito ver.}
  Dig2 := 0;
  for i := 1 to 9 do
    Dig2 := Dig2 + (12 - i) * StrToInt(CPF[i]);
  Dig2 := (Dig2 + Dig1 * 2) mod 11;
  if Dig2 < 2 then
    Dig2 := 0
  else
    Dig2 := 11 - Dig2;
  {Se 2� dig ver. estiver correto, retorna True}
  if StrToInt(CPF[11]) = Dig2 then
    Result := True;
end;

procedure ConsisteNumerico(Sender: TObject);
var i: Integer;
    tmpstr: String;
begin
  {consist�ncia On-Line dos campos apenas num�ricos (inteiros)}
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
        tmpstr := Text;     {qualquer caracter que n�o seja 0..9 � apagado}
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
  {consist�ncia On-Line dos campos apenas texto}
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
        tmpstr := Text;     {qualquer caracter que n�o seja Literal � apagado}
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
