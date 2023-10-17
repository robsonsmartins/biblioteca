{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_ReservaDialog.pas

  Diálogo de Reserva

  Data última revisão: 07/12/2001

*****************************************************************************}

unit unit_ReservaDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Mask, DBCtrls, ExtCtrls,
  unit_DatabaseClasses;

type
  Tform_ReservaDialog = class(TForm)
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
  form_ReservaDialog: Tform_ReservaDialog;

implementation

{$R *.DFM}

uses unit_Comum;

procedure Tform_ReservaDialog.Edit_RGAChange(Sender: TObject);
begin
  ConsisteNumerico(Sender);
end;

procedure Tform_ReservaDialog.FormCreate(Sender: TObject);
begin
  MovData := TMovData.Create;
end;

procedure Tform_ReservaDialog.FormDestroy(Sender: TObject);
begin
  MovData.Free;
end;

procedure Tform_ReservaDialog.btn_OKClick(Sender: TObject);
begin
  if (Edit_Nome.Text = '') and (Edit_RGA.Text = '') then
  begin
    Application.MessageBox('Deve ser especificado o Nome ou o RGA do usuário',
                           'Informações incompletas',MB_OKWARNING);
    exit;
  end;
  if (Edit_Nome.Text = '') then
    Edit_Nome.Text := MovData.RGAToUsuario(Edit_RGA.Text);
  if (Edit_Nome.Text = '') then
  begin
    Application.MessageBox('RGA inválido.',
                           'Informações incorretas',MB_OKWARNING);
    exit;
  end;
  Edit_RGA.Text := MovData.UsuarioToRGA(Edit_Nome.Text);
  if MovData.UltimoErro <> '' then
  begin
    Application.MessageBox(PChar(MovData.UltimoErro),
                           'Informações incorretas',MB_OKWARNING);
    exit;
  end;
  if MovData.Reservar(StrToInt(Edit_Tombo.Text),Edit_Nome.Text) then
  begin
    Application.MessageBox('Exemplar Reservado.',
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
