{******************************************************************************

  unit_Comum: Cont�m tipos de dados, constantes, rotinas fun��es comuns a
  toda Aplica��o.

******************************************************************************}
unit unit_Comum;

interface

uses Windows, Forms;

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
    'Banco de Dados.';
  CAP_NOCONNDB =
    'Erro ao conectar com o Banco de Dados';
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

{************* Rotinas e Fun��es **************}

{Converte uma UF (sigla) em uma string com o Estado}
function UFToEstado(UF: String): String;
{Converte uma string com o Estado em uma string com a UF (sigla)}
function EstadoToUF(Estado: String): String;
{Retorna True se outra inst�ncia da aplica��o est� rodando}
function SystemRunning: Boolean;

implementation

function UFToEstado(UF: String): String;
{Converte uma UF (sigla) em uma string com o Estado}
begin
  Result := '';
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
  Result := '';
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

end.
