unit u_novapasta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm_NovaPasta = class(TForm)
    GroupBox1: TGroupBox;
    Edit_Pasta: TEdit;
    Button_OK: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button_OKClick(Sender: TObject);
  end;

var
  Form_NovaPasta: TForm_NovaPasta;

implementation

{$R *.DFM}

procedure TForm_NovaPasta.Button_OKClick(Sender: TObject);
var i: Integer;
    ok: Boolean;
begin
  //verifica se há caracteres inválidos no nome da pasta
  ok := True;
  if Edit_Pasta.Text = '' then
    ok := False;
  for i := 1 to Length(Edit_Pasta.Text) do
  begin
    if (Edit_Pasta.Text[i] in ['\','/','?','*','|','+','=','>','<','.',',','@','!']) or
       (Edit_Pasta.Text = '') then
    begin
      ok := False;
      break;
    end;
  end;
  if not ok then
  begin
    ShowMessage('O nome a ser dado à Pasta tem caracteres inválidos');
    Button_OK.ModalResult := mrNone;
    Form_NovaPasta.ModalResult := mrNone;
    Edit_Pasta.SetFocus;
  end
  else
  begin
    Button_OK.ModalResult := mrOK;
    Form_NovaPasta.ModalResult := mrOK;
  end;
end;

end.
