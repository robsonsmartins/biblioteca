unit unit_LoginDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tform_LoginDialog = class(TForm)
    Panel_Login: TPanel;
    Label_UserName: TLabel;
    ComboBox_UserName: TComboBox;
    Label_Senha: TLabel;
    Edit_Senha: TEdit;
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancelar: TBitBtn;
    procedure ComboBox_UserNameKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_SenhaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //mostra este form e chama m�todo de valida��o de login
{    function Login(var Usuario: TUsuario; var DeskTop: TDesktop;
                   DesktopIcons: TDeskTopIcons): Boolean;}
  end;

var
  form_LoginDialog: Tform_LoginDialog;

implementation

{$R *.DFM}

{function Tform_LoginDialog.Login(var Usuario: TUsuario;
                  var DeskTop: TDesktop; DesktopIcons: TDeskTopIcons): Boolean;
var Tentativa: Byte;
    ErrMsg, ErrCaption: String;
begin
  //repete a exibi��o do di�logo de login at� que o login seja conclu�do ou
  //at� o n�mero m�ximo de terntativas (vari�vel declarada em
  //unit_LoginClasses)
  Tentativa := 0;
  repeat
    Inc(Tentativa);
    Desktop.RefreshStatusBar('Digite o Nome de Usu�rio e a Senha para ' +
                             'efetuar o Login');
    //exibe o di�logo de login e verifica qual bot�o o usu�rio clicou
    if ShowModal <> mrOk then
      //se usu�rio clicou em CANCELAR, sai do processo
      break;
    //se usu�rio clicou em OK, faz autentica��o do usu�rio atrav�s do
    //m�todo AUTENTICAUSUARIO do objeto do tipo TUSUARIO
    if Usuario.AutenticaUsuario(ComboBox_UserName.Text, Edit_Senha.Text,
                                DeskTop, DesktopIcons) then
    //se usu�rio foi autenticado com sucesso, retorna True
    begin
      Login := True;
      exit;
    end;
    Desktop.RefreshStatusBar('Clique em OK para tentar efetuar o Login ' +
                             'novamente');
    //se usu�rio n�o foi autenticado
    //exibe msg de senha ou username errado ou n�o reconhecido
    ErrMsg := 'O Nome do Usu�rio e/ou a Senha n�o foram reconhecidos. ' +
              'Tente digitar novamente, lembrando que a Senha � ' +
              'sens�vel a letras mai�sculas/min�sculas';
    ErrCaption := 'Erro de Login';
    if Tentativa < NumeroTentativasLogin then
      ErrCaption := ErrCaption + ' - Tentativa ' + IntToStr(Tentativa) +
                    ' de ' + IntToStr(NumeroTentativasLogin);
    if Tentativa = NumeroTentativasLogin then
    begin
      ErrMsg := 'O Nome do Usu�rio e/ou a Senha n�o foram reconhecidos. ' +
                'N�o foi poss�vel realizar o Login, pois o n�mero ' +
                'de tentativas (' + IntToStr(NumeroTentativasLogin) +
                ') foi esgotado. Clique em OK para fechar o programa.';
      ErrCaption := ErrCaption + ' - Tentativa ' + IntToStr(Tentativa) +
                    ' de ' + IntToStr(NumeroTentativasLogin);
      Desktop.RefreshStatusBar('Clique em OK para fechar o Sistema Biblioteca');
    end;
    Application.MessageBox(PChar(ErrMsg),PChar(ErrCaption),
                           MB_OK + MB_ICONEXCLAMATION);
    if Tentativa = 255 then //reinicializa tentativa se chegar a 255
      Tentativa := 1;
  until Tentativa = NumeroTentativasLogin;
  Login := False;
end;}

procedure Tform_LoginDialog.ComboBox_UserNameKeyPress(Sender: TObject;
                                                      var Key: Char);
begin
  //quando � pressionado ENTER na caixa de digita��o do username, joga o foco
  //sobre o campo de senha
  if Key = #13 then //enter
  begin
    Key := #0; //nenhuma tecla
    Edit_Senha.SetFocus;
  end;
end;

procedure Tform_LoginDialog.Edit_SenhaEnter(Sender: TObject);
begin
  //quando o foco � coloado sobre o campo de senha, faz com que o bot�o OK
  //seja Default
  BitBtn_Ok.Default := True;
end;

procedure Tform_LoginDialog.FormShow(Sender: TObject);
begin
  //mostra o di�logo de login com o campo senha vazio,
  //o bot�o OK sem ser default e
  //com o foco no campo de digita��o do username
  Edit_Senha.Text := '';
  BitBtn_Ok.Default := False;
  ComboBox_UserName.SetFocus;
end;

end.

