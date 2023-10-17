unit u_alteracoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TForm_Alteracoes = class(TForm)
    Memo: TMemo;
    Bevel1: TBevel;
    Button_Fechar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Alteracoes: TForm_Alteracoes;

implementation

{$R *.DFM}

end.
