{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_EscolhaRelatorios.pas

  Contém a tela de escolha de relatórios

  Data última revisão: 12/12/2001

******************************************************************************}

unit unit_EscolhaRelatorios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, Menus, StdCtrls, ExtCtrls, QRPrntr;

type
  Tform_EscolhaRelatorios = class(TForm)
    ToolBar_Principal: TToolBar;
    btn_Sair: TToolButton;
    ImageList_Relat: TImageList;
    ListView_Relat: TListView;
    Panel1: TPanel;
    Label_Relat: TLabel;
    procedure btn_SairClick(Sender: TObject);
    procedure ListView_RelatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_EscolhaRelatorios: Tform_EscolhaRelatorios;

implementation

uses relatorio_acervo, relatorio_acervoperdido, relatorio_fornecedor,
  relatorio_reserva, relatorio_retirada, relatorio_usuario,
  relatorio_DevUsuario, relatorio_DevAcervo, relatorio_AcervoRet,
  relatorio_UsuSusp;

{$R *.DFM}

procedure Tform_EscolhaRelatorios.btn_SairClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_EscolhaRelatorios.ListView_RelatClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  if ListView_Relat.Selected.Index = 0 then
  begin
    Form_RelatorioUsuario := TForm_RelatorioUsuario.Create(Self);
    with Form_RelatorioUsuario do
    begin
      rel_usuario.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(Form_RelatorioUsuario);
    end;
  end
  else if ListView_Relat.Selected.Index = 1 then
  begin
    form_RelatorioAcervo := Tform_RelatorioAcervo.Create(Self);
    with form_RelatorioAcervo do
    begin
      rel_acervo.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioAcervo);
    end;
  end
  else if ListView_Relat.Selected.Index = 2 then
  begin
    form_RelatorioFornecedor := Tform_RelatorioFornecedor.Create(Self);
    with form_RelatorioFornecedor do
    begin
      rel_fornecedor.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioFornecedor);
    end;
  end
  else if ListView_Relat.Selected.Index = 3 then
  begin
    form_RelatorioRetirada := Tform_RelatorioRetirada.Create(Self);
    with form_RelatorioRetirada do
    begin
      rel_retirada.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioRetirada);
    end;
  end
  else if ListView_Relat.Selected.Index = 4 then
  begin
    form_RelatorioReserva := Tform_RelatorioReserva.Create(Self);
    with form_RelatorioReserva do
    begin
      rel_reserva.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioReserva);
    end;
  end
  else if ListView_Relat.Selected.Index = 5 then
  begin
    form_RelatorioAcervoPerdido := Tform_RelatorioAcervoPerdido.Create(Self);
    with form_RelatorioAcervoPerdido do
    begin
      rel_acervoperdido.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioAcervoPerdido);
    end;
  end
  else if ListView_Relat.Selected.Index = 6 then
  begin
    form_RelatorioDevUsuario := Tform_RelatorioDevUsuario.Create(Self);
    with form_RelatorioDevUsuario do
    begin
      rel_retirada.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioDevUsuario);
    end;
  end
  else if ListView_Relat.Selected.Index = 7 then
  begin
    form_RelatorioDevAcervo := Tform_RelatorioDevAcervo.Create(Self);
    with form_RelatorioDevAcervo do
    begin
      rel_retirada.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioDevAcervo);
    end;
  end
  else if ListView_Relat.Selected.Index = 8 then
  begin
    form_RelatorioAcervoRet := Tform_RelatorioAcervoRet.Create(Self);
    with form_RelatorioAcervoRet do
    begin
      rel_retirada.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioAcervoRet);
    end;
  end
  else if ListView_Relat.Selected.Index = 9 then
  begin
    form_RelatorioUsuSusp := Tform_RelatorioUsuSusp.Create(Self);
    with form_RelatorioUsuSusp do
    begin
      rel_retirada.Preview;
      Screen.Cursor := crDefault;
      FreeAndNil(form_RelatorioUsuSusp);
    end;
  end;
  Screen.Cursor := crDefault;
end;

end.
