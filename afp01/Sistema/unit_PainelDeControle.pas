{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_PainelDeControle.pas

  Contém as Classes e a Tela do Painel de Controle

  Data última revisão: 06/11/2001

******************************************************************************}

unit unit_PainelDeControle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, Menus, StdCtrls,
  unit_AparenciaDialog, unit_CadastroOpcoesDialog, unit_ContasDialog;

type
  Tform_PainelDeControle = class(TForm)
    ListView_Icones: TListView;
    ImageList_Icones: TImageList;
    RichEdit_Descricao: TRichEdit;
    procedure ListView_IconesInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: String);
    procedure ListView_IconesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_PainelDeControle: Tform_PainelDeControle;

implementation

uses unit_Desktop;

var Painel: String = '';

{$R *.DFM}

procedure Tform_PainelDeControle.ListView_IconesInfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: String);
begin
  {exibe a dica dos ícones do Painel de Controle}
  with RichEdit_Descricao.Lines do
  begin
    if Item.Caption = 'Aparência' then
    begin
      if Painel = 'Aparencia' then
        exit;
      Clear;
      Text :=
        'APARÊNCIA DA ÁREA DE TRABALHO' + #13#10#13#10 +
        'Altera a Aparência do Sistema Biblioteca, permitindo a escolha das ' +
        'Cores da Área de Trabalho e do Papel de Parede.';
      Painel := 'Aparencia';
    end;
    if Item.Caption = 'Configuração dos Cadastros' then
    begin
      if Painel = 'Cadastro' then
        exit;
      Clear;
      Text :=
        'CONFIGURAÇÃO DOS CADASTROS' + #13#10#13#10 +
        'Altera as Opções dos Cadastros (Tipos de Usuário, Fornecedor, ' +
        'Acervo, etc).';
      Painel := 'Cadastro';
    end;
    if Item.Caption = 'Grupos e Contas de Login' then
    begin
      if Painel = 'Login' then
        exit;
      Clear;
      Text :=
        'DIRETIVAS DE GRUPOS E CONTAS DE LOGIN' + #13#10#13#10 +
        'Define os usuários e as permissões das Contas para efetuar Login ' +
        'no Sistema Biblioteca.';
      Painel := 'Login';
    end;
  end;
end;

procedure Tform_PainelDeControle.ListView_IconesClick(Sender: TObject);
begin
  {abre os forms correspondentes ao ícone clicado}
  if ListView_Icones.Selected.Caption = 'Aparência' then
  begin
    form_AparenciaDialog := Tform_AparenciaDialog.Create(Self);
    form_AparenciaDialog.Configura(form_Desktop.Desktop_Desktop);
    FreeAndNil(form_AparenciaDialog);
  end;
  if ListView_Icones.Selected.Caption = 'Configuração dos Cadastros' then
  begin
    form_CadastroOpcoesDialog := Tform_CadastroOpcoesDialog.Create(Self);
    form_CadastroOpcoesDialog.ShowModal;
    FreeAndNil(form_CadastroOpcoesDialog);
  end;
  if ListView_Icones.Selected.Caption =
     'Grupos e Contas de Login' then
  begin
    form_ContasDialog := Tform_ContasDialog.Create(Self);
    form_ContasDialog.ShowModal;
    FreeAndNil(form_ContasDialog);
  end;
end;

end.
