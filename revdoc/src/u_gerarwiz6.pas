unit u_gerarwiz6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm_gerarwiz6 = class(TForm)
    Panel1: TPanel;
    Button_Proximo: TBitBtn;
    Button_Cancelar: TBitBtn;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    Edit_Arquivo: TEdit;
    Button_Procurar: TSpeedButton;
    procedure Button_ProcurarClick(Sender: TObject);
    procedure Button_ProximoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz6: TForm_gerarwiz6;

implementation

{$R *.DFM}

procedure TForm_gerarwiz6.Button_ProcurarClick(Sender: TObject);
begin
  //Procura pelo arquivo
  if OpenDialog.Execute then
    Edit_Arquivo.Text := OpenDialog.FileName;
end;

procedure TForm_gerarwiz6.Button_ProximoClick(Sender: TObject);
var SearchRec: TSearchRec;
begin
  //verifica se o edit Arquivo está em branco
  if Edit_Arquivo.Text = '' then
  begin
    ShowMessage('Especifique o arquivo (Documento) a ser incluído no controle do RevDoc');
    Edit_Arquivo.SetFocus;
    Form_GerarWiz6.ModalResult := mrNone;
    exit;
  end;
  //verifica se existe o arquivo especificado
  if FindFirst(Edit_Arquivo.Text,faAnyFile,SearchRec) <> 0 then
  begin
    ShowMessage('O arquivo ' + Edit_Arquivo.Text +
                ' não foi encontrado. Especifique outro nome de arquivo');
    Edit_Arquivo.SetFocus;
    Form_GerarWiz6.ModalResult := mrNone;
  end;
  FindClose(SearchRec);
end;

end.
