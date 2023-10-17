unit u_gerarwiz4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm_gerarwiz4 = class(TForm)
    Panel1: TPanel;
    Button_Proximo: TBitBtn;
    Button_Cancelar: TBitBtn;
    Label1: TLabel;
    Edit_Nome: TEdit;
    Label2: TLabel;
    Edit_Titulo: TEdit;
    procedure Button_ProximoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz4: TForm_gerarwiz4;

implementation

{$R *.DFM}

procedure TForm_gerarwiz4.Button_ProximoClick(Sender: TObject);
begin
  //verifica se o campo Nome do Documento está em branco
  if Edit_Nome.Text = '' then
  begin
    ShowMessage('Especifique o Nome do Documento');
    Edit_Nome.SetFocus;
    Form_GerarWiz4.ModalResult := mrNone;
    exit;
  end;
  //verifica se o campo Título do Documento está em branco
  if Edit_Titulo.Text = '' then
  begin
    ShowMessage('Especifique o Título do Documento');
    Edit_Titulo.SetFocus;
    Form_GerarWiz4.ModalResult := mrNone;
    exit;
  end;
end;

end.
