unit u_gerarwiz5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TForm_gerarwiz5 = class(TForm)
    Panel1: TPanel;
    Button_Proximo: TBitBtn;
    Button_Cancelar: TBitBtn;
    Label1: TLabel;
    DT_Revisao: TDateTimePicker;
    Label2: TLabel;
    Memo_Alteracao: TMemo;
    procedure Button_ProximoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz5: TForm_gerarwiz5;

implementation

{$R *.DFM}

procedure TForm_gerarwiz5.Button_ProximoClick(Sender: TObject);
begin
  //verifica se o memo Alterações está em branco
  if Memo_Alteracao.Lines.Count = 0 then
  begin
    ShowMessage('Digite as Alterações realizadas nessa Revisão');
    Memo_Alteracao.SetFocus;
    Form_GerarWiz5.ModalResult := mrNone;
  end;
end;

procedure TForm_gerarwiz5.FormShow(Sender: TObject);
begin
  //coloca a data de hoje no DT_Revisão
  DT_Revisao.Date := Date;
end;

end.
