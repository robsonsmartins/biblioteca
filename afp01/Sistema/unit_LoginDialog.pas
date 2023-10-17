{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_LoginDialog.pas

  Contém tipos de dados, e funções relativos ao Login.

  Data última revisão: 20/11/2001

******************************************************************************}

unit unit_LoginDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, unit_Comum, unit_DataBaseClasses;

type
  Tform_LoginDialog = class(TForm)
    Panel_Login: TPanel;
    Label_UserName: TLabel;
    ComboBox_UserName: TComboBox;
    Label_Senha: TLabel;
    Edit_Senha: TEdit;
    Btn_Ok: TBitBtn;
    Btn_Cancelar: TBitBtn;
    Image_Login: TImage;
    procedure ComboBox_UserNameKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_SenhaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FContas: TContaLogins;
  public
    { Public declarations }
    ContaLogin: TContaLogin;
    {mostra este form e chama método de validação de login}
    function Login: Boolean;
    {autentica o usuário}
    function AutenticaUsuario(EUserName, ESenha: String): Boolean;
  end;

var
  form_LoginDialog: Tform_LoginDialog;

implementation

uses unit_AparenciaDialog;

{$R *.DFM}

var NumeroTentativasLogin: Integer = 3;

function Tform_LoginDialog.AutenticaUsuario(EUserName, ESenha: String): Boolean;
begin
  {faz a autenticação do usuário}
  FContas.Refresh;
  FContas.LocateUserName(EUserName);
  if (FContas.Registro.UserName = EUserName) and
     (FContas.Registro.GetPassword = ESenha) then
    Result := True
  else
    Result := False;
end;

function Tform_LoginDialog.Login: Boolean;
var Tentativa: Byte;
    RegistroLogin: TRegistroLogin;
begin
  {repete a exibição do diálogo de login até que o login seja concluído ou
  até o número máximo de terntativas}
  Tentativa := 0;
  repeat
    Inc(Tentativa);
    {exibe o diálogo de login e verifica qual botão o usuário clicou}
    if ShowModal <> mrOk then
      {se usuário clicou em CANCELAR, sai do processo}
      break;
    {se usuário clicou em OK, faz autenticação do usuário}
    if AutenticaUsuario(ComboBox_UserName.Text, Edit_Senha.Text) then
    {se usuário foi autenticado com sucesso, retorna True}
    begin
      FContas.Refresh;
      FContas.LocateUserName(ComboBox_UserName.Text);
      ContaLogin.Assign(FContas.Registro);
      RegistroLogin := TRegistroLogin.Create;
      RegistroLogin.Login(ContaLogin.IdConta);
      RegistroLogin.Free;
      Result := True;
      exit;
    end;
    {se usuário não foi autenticado}
    {exibe msg de senha ou username errado ou não reconhecido}
    if Tentativa = NumeroTentativasLogin then
      Application.MessageBox(MSG_ERROLOGINR,CAP_ERROLOGINR,MB_OKICONSTOP)
    else
      Application.MessageBox(MSG_ERROLOGIN,CAP_ERROLOGIN,MB_OKWARNING);
    if Tentativa = 255 then {reinicializa tentativa se chegar a 255}
      Tentativa := 1;
  until Tentativa = NumeroTentativasLogin;
  Result := False;
end;

procedure Tform_LoginDialog.ComboBox_UserNameKeyPress(Sender: TObject;
                                                      var Key: Char);
begin
  {quando é pressionado ENTER na caixa de digitação do username, joga o foco
  sobre o campo de senha}
  if Key = #13 then {enter}
  begin
    Key := #0; {nenhuma tecla}
    Edit_Senha.SetFocus;
  end;
end;

procedure Tform_LoginDialog.Edit_SenhaEnter(Sender: TObject);
begin
  {quando o foco é coloado sobre o campo de senha, faz com que o botão OK
  seja Default}
  btn_Ok.Default := True;
end;

procedure Tform_LoginDialog.FormShow(Sender: TObject);
begin
  {mostra o diálogo de login com o campo senha vazio,
  o botão OK sem ser default e
  com o foco no campo de digitação do username}
  Edit_Senha.Text := '';
  btn_Ok.Default := False;
  ComboBox_UserName.SetFocus;
end;

procedure Tform_LoginDialog.FormCreate(Sender: TObject);
var i: Integer;
    Config: TConfiguracao;
begin
  {lê config.}
  Config := TConfiguracao.Create;
  with Config do
  begin
    Read(True);
    NumeroTentativasLogin := NTentativas;
    Free;
  end;
  {cria o FContas e preenche o combobox}
  FContas := TContaLogins.Create;
  FContas.Refresh;
  with ComboBox_UserName.Items do
  begin
    Clear;
    for i := 1 to FContas.RecCount do
    begin
      FContas.GotoReg(i);
      Add(FContas.Registro.UserName);
    end;
    ComboBox_UserName.ItemIndex := 0;
  end;
  ContaLogin := TContaLogin.Create;
end;

procedure Tform_LoginDialog.FormDestroy(Sender: TObject);
begin
  {destrói o contalogin e o fcontas}
  ContaLogin.Free;
  FContas.Free;
end;

procedure Tform_LoginDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {confirma saída do sistema}
  if ModalResult <> mrOK then
  begin
    with Application do
      if (not btn_Cancelar.Enabled) or
         (MessageBox(MSG_SAIRBBT,CAP_SAIRBBT,MB_YESNOQUESTION) = IDNO) then
        Action := caNone;
  end;
end;

end.

