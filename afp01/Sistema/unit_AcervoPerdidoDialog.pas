{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_AcervoPerdidoDialog.pas

  Diálogo de AcervoPerdido

  Data última revisão: 07/12/2001

*****************************************************************************}

unit unit_AcervoPerdidoDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Mask, DBCtrls, ExtCtrls,
  unit_DatabaseClasses;

type
  Tform_AcervoPerdidoDialog = class(TForm)
    Panel_Dialogo: TPanel;
    Label_Titulo: TLabel;
    Label_Tombo: TLabel;
    Label_Data: TLabel;
    Label_Nome: TLabel;
    Label_RGA: TLabel;
    Edit_Nome: TEdit;
    Edit_RGA: TEdit;
    Edit_Titulo: TEdit;
    Edit_Tombo: TEdit;
    Edit_Data: TEdit;
    btn_OK: TBitBtn;
    btn_Cancelar: TBitBtn;
    procedure Edit_RGAChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MovData: TMovData;
  end;

var
  form_AcervoPerdidoDialog: Tform_AcervoPerdidoDialog;

implementation

{$R *.DFM}

uses unit_Comum;

procedure Tform_AcervoPerdidoDialog.Edit_RGAChange(Sender: TObject);
begin
  ConsisteNumerico(Sender);
end;

procedure Tform_AcervoPerdidoDialog.FormCreate(Sender: TObject);
begin
  MovData := TMovData.Create;
end;

procedure Tform_AcervoPerdidoDialog.FormDestroy(Sender: TObject);
begin
  MovData.Free;
end;

procedure Tform_AcervoPerdidoDialog.btn_OKClick(Sender: TObject);
begin
  if MovData.MoverPerdido(StrToInt(Edit_Tombo.Text),Edit_Nome.Text) then
  begin
    Application.MessageBox('Exemplar Movido para "Acervo Perdido".',
                           'Concluído com sucesso',MB_OKINFORMATION);
    ModalResult := mrOK;
  end
  else
  begin
    Application.MessageBox(PChar(MovData.UltimoErro),
                           'Erro',MB_OKWARNING);
  end;
end;

end.
