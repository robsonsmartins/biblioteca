unit u_gerarwiz2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, FileCtrl;

type
  TForm_gerarwiz2 = class(TForm)
    Panel1: TPanel;
    Button_Proximo: TBitBtn;
    Button_Cancelar: TBitBtn;
    DirList: TDirectoryListBox;
    Label1: TLabel;
    Button_Novo: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Button_NovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz2: TForm_gerarwiz2;

implementation

uses u_novapasta;

{$R *.DFM}

procedure TForm_gerarwiz2.FormShow(Sender: TObject);
begin
  //diretório padrão C:\
  DirList.Directory := 'C:\';
end;

procedure TForm_gerarwiz2.Button_NovoClick(Sender: TObject);
var dir: String;
begin
  //chama o diálogo para a criação de uma nova pasta
  Form_NovaPasta := TForm_NovaPasta.Create(Application);
  if Form_NovaPasta.ShowModal = mrCancel then
  begin
    Form_NovaPasta.Free;
    exit;
  end;
  try
    dir := DirList.Directory;
    MkDir(dir + '\' + Form_NovaPasta.Edit_Pasta.Text);
    DirList.Update;
    DirList.Directory := dir + '\' + Form_NovaPasta.Edit_Pasta.Text;
  except
    ShowMessage('Não foi possível criar o diretório ' + dir + '\' + Form_NovaPasta.Edit_Pasta.Text);
  end;

  Form_NovaPasta.Free;
end;

end.
