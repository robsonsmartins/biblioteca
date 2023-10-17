unit unit_EscolhaRelatorios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, Menus, StdCtrls, ExtCtrls, QRPrntr;

type
  Tform_EscolhaRelatorios = class(TForm)
    MainMenu1: TMainMenu;
    Relatrio1: TMenuItem;
    Imprimir1: TMenuItem;
    ConfigurarImpressora1: TMenuItem;
    VisualizarImpresso1: TMenuItem;
    Fechar1: TMenuItem;
    N1: TMenuItem;
    Relatrios1: TMenuItem;
    SituaodoUsurio1: TMenuItem;
    SituaodoAcervo1: TMenuItem;
    ListadeReservas1: TMenuItem;
    Relatrios2: TMenuItem;
    MovimentaodoAcervo1: TMenuItem;
    MovimentaodeUsurios1: TMenuItem;
    Listagens1: TMenuItem;
    CadastrodeAcervo1: TMenuItem;
    CadastrodeUsurios1: TMenuItem;
    CadastrodeFornecedores1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    StaticText1: TStaticText;
    Edit2: TEdit;
    Label2: TLabel;
    QRPreview1: TQRPreview;
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
