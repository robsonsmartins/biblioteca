{
Os seguintes relat�rios dever�o ser emitidos pelo Sistema Biblioteca:
Livros mais retirados,
Rela��o dos livros emprestados por aluno em um determinado per�odo de tempo,
Rela��o dos alunos / funcion�rios que
 emprestaram / devolveram livros em um determinado per�odo de tempo,
Rela��o dos livros cadastrados no sistema.
}
unit unit_EscolhaRelatorios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, Menus, StdCtrls, ExtCtrls, QRPrntr;

type
  Tform_EscolhaRelatorios = class(TForm)
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton16: TToolButton;
    ImageList1: TImageList;
    ListView1: TListView;
    ToolButton1: TToolButton;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_EscolhaRelatorios: Tform_EscolhaRelatorios;

implementation

{$R *.DFM}

end.
