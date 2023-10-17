{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_Comum.pas

  Cont�m tipos de dados, constantes, rotinas fun��es comuns a toda Aplica��o.

  Data �ltima revis�o: 06/11/2001

******************************************************************************}

unit unit_Comum;

interface

uses Windows, Forms, Sysutils, stdctrls;

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
  MB_YESNOQUESTION =
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2;

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
  MSG_EXCLUIRUSUARIO =
    'Tem certeza que deseja excluir o Usu�rio do cadastro ?' + #13#10 +
    '(esta opera��o n�o poder� ser desfeita).';
  CAP_EXCLUIRUSUARIO =
    'Excluir Usu�rio';
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
    
{************* Rotinas e Fun��es **************}

{Converte uma UF (sigla) em uma string com o Estado}
function UFToEstado(UF: String): String;
{Converte uma string com o Estado em uma string com a UF (sigla)}
function EstadoToUF(Estado: String): String;
{Retorna True se outra inst�ncia da aplica��o est� rodando}
function SystemRunning: Boolean;
{converte um Boolean em uma String reconhecida pelo Access}
function BoolToAccessStr(Booleano: Boolean): String;
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

function BoolToAccessStr(Booleano: Boolean): String;
begin
  {converte um Boolean em uma String reconhecida pelo Access}
  if Booleano then
    Result := '-1'
  else
    Result := '0';
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
      if (Ord(Text[i]) < 32) or (Ord(Text[i]) > 199) or
         ((Ord(Text[i]) > 122) and (Ord(Text[i]) < 128)) or
         ((Ord(Text[i]) > 32) and (Ord(Text[i]) < 65)) then
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
