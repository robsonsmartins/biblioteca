{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_PainelDeControle.pas

  Cont�m as Classes e a Tela do Painel de Controle

  Data �ltima revis�o: 06/11/2001

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
  {exibe a dica dos �cones do Painel de Controle}
  with RichEdit_Descricao.Lines do
  begin
    if Item.Caption = 'Apar�ncia' then
    begin
      if Painel = 'Aparencia' then
        exit;
      Clear;
      Text :=
        'APAR�NCIA DA �REA DE TRABALHO' + #13#10#13#10 +
        'Altera a Apar�ncia do Sistema Biblioteca, permitindo a escolha das ' +
        'Cores da �rea de Trabalho e do Papel de Parede.';
      Painel := 'Aparencia';
    end;
    if Item.Caption = 'Configura��o dos Cadastros' then
    begin
      if Painel = 'Cadastro' then
        exit;
      Clear;
      Text :=
        'CONFIGURA��O DOS CADASTROS' + #13#10#13#10 +
        'Altera as Op��es dos Cadastros (Tipos de Usu�rio, Fornecedor, ' +
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
        'Define os usu�rios e as permiss�es das Contas para efetuar Login ' +
        'no Sistema Biblioteca.';
      Painel := 'Login';
    end;
  end;
end;

procedure Tform_PainelDeControle.ListView_IconesClick(Sender: TObject);
begin
  {abre os forms correspondentes ao �cone clicado}
  if ListView_Icones.Selected.Caption = 'Apar�ncia' then
  begin
    form_AparenciaDialog := Tform_AparenciaDialog.Create(Self);
    form_AparenciaDialog.Configura(form_Desktop.Desktop_Desktop);
    FreeAndNil(form_AparenciaDialog);
  end;
  if ListView_Icones.Selected.Caption = 'Configura��o dos Cadastros' then
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
