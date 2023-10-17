unit u_gerarwiz3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm_gerarwiz3 = class(TForm)
    Panel1: TPanel;
    Button_Proximo: TBitBtn;
    Button_Cancelar: TBitBtn;
    Edit_Codigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit_Revisao: TEdit;
    procedure Button_ProximoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz3: TForm_gerarwiz3;

implementation

{$R *.DFM}

procedure TForm_gerarwiz3.Button_ProximoClick(Sender: TObject);
begin
  //verifica se o código do documento está correto
  if Length(Edit_Codigo.Text) < 6 then
  begin
    ShowMessage('Apenas são válidos Códigos no formato XXX.YY (onde X é um caracter e Y é um dígito numérico)');
    Edit_Codigo.SetFocus;
    Form_GerarWiz3.ModalResult := mrNone;
    exit;
  end;
  if not (Edit_Codigo.Text[1] in ['A'..'Z']) or
     not (Edit_Codigo.Text[2] in ['A'..'Z']) or
     not (Edit_Codigo.Text[3] in ['A'..'Z']) or
     not (Edit_Codigo.Text[4] = '.') or
     not (Edit_Codigo.Text[5] in ['0'..'9']) or
     not (Edit_Codigo.Text[6] in ['0'..'9']) then
  begin
    ShowMessage('Apenas são válidos Códigos no formato XXX.YY (onde X é um caracter e Y é um dígito numérico)');
    Edit_Codigo.SetFocus;
    Form_GerarWiz3.ModalResult := mrNone;
    exit;
  end;
  //verifica se a revisão do documento está correta
  if Length(Edit_Revisao.Text) < 1 then
  begin
    ShowMessage('Apenas são válidas Revisões "0" e "A" até "Z"');
    Edit_Revisao.SetFocus;
    Form_GerarWiz3.ModalResult := mrNone;
    exit;
  end;
  if not (Edit_Revisao.Text[1] in ['0','A'..'Z']) then
  begin
    ShowMessage('Apenas são válidas Revisões "0" e "A" até "Z"');
    Edit_Revisao.SetFocus;
    Form_GerarWiz3.ModalResult := mrNone;
    exit;
  end;
end;

end.
