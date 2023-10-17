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
    //mostra este form e chama método de validação de login
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
  //repete a exibição do diálogo de login até que o login seja concluído ou
  //até o número máximo de terntativas (variável declarada em
  //unit_LoginClasses)
  Tentativa := 0;
  repeat
    Inc(Tentativa);
    Desktop.RefreshStatusBar('Digite o Nome de Usuário e a Senha para ' +
                             'efetuar o Login');
    //exibe o diálogo de login e verifica qual botão o usuário clicou
    if ShowModal <> mrOk then
      //se usuário clicou em CANCELAR, sai do processo
      break;
    //se usuário clicou em OK, faz autenticação do usuário através do
    //método AUTENTICAUSUARIO do objeto do tipo TUSUARIO
    if Usuario.AutenticaUsuario(ComboBox_UserName.Text, Edit_Senha.Text,
                                DeskTop, DesktopIcons) then
    //se usuário foi autenticado com sucesso, retorna True
    begin
      Login := True;
      exit;
    end;
    Desktop.RefreshStatusBar('Clique em OK para tentar efetuar o Login ' +
                             'novamente');
    //se usuário não foi autenticado
    //exibe msg de senha ou username errado ou não reconhecido
    ErrMsg := 'O Nome do Usuário e/ou a Senha não foram reconhecidos. ' +
              'Tente digitar novamente, lembrando que a Senha é ' +
              'sensível a letras maiúsculas/minúsculas';
    ErrCaption := 'Erro de Login';
    if Tentativa < NumeroTentativasLogin then
      ErrCaption := ErrCaption + ' - Tentativa ' + IntToStr(Tentativa) +
                    ' de ' + IntToStr(NumeroTentativasLogin);
    if Tentativa = NumeroTentativasLogin then
    begin
      ErrMsg := 'O Nome do Usuário e/ou a Senha não foram reconhecidos. ' +
                'Não foi possível realizar o Login, pois o número ' +
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
  //quando é pressionado ENTER na caixa de digitação do username, joga o foco
  //sobre o campo de senha
  if Key = #13 then //enter
  begin
    Key := #0; //nenhuma tecla
    Edit_Senha.SetFocus;
  end;
end;

procedure Tform_LoginDialog.Edit_SenhaEnter(Sender: TObject);
begin
  //quando o foco é coloado sobre o campo de senha, faz com que o botão OK
  //seja Default
  BitBtn_Ok.Default := True;
end;

procedure Tform_LoginDialog.FormShow(Sender: TObject);
begin
  //mostra o diálogo de login com o campo senha vazio,
  //o botão OK sem ser default e
  //com o foco no campo de digitação do username
  Edit_Senha.Text := '';
  BitBtn_Ok.Default := False;
  ComboBox_UserName.SetFocus;
end;

end.

