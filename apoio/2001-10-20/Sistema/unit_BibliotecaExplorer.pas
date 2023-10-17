unit unit_BibliotecaExplorer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ImgList, ToolWin, Menus;

type
  Tform_BibliotecaExplorer = class(TForm)
    MainMenu1: TMainMenu;
    Acervo1: TMenuItem;
    Emprestar1: TMenuItem;
    Devolver1: TMenuItem;
    Reservar1: TMenuItem;
    MoverparaAcervoPerdido1: TMenuItem;
    Localizar1: TMenuItem;
    Acervo2: TMenuItem;
    Explorer1: TMenuItem;
    Fechar1: TMenuItem;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    Splitter2: TSplitter;
    ListView2: TListView;
    ToolButton3: TToolButton;
    procedure Emprestar1Click(Sender: TObject);
    procedure Reservar1Click(Sender: TObject);
    procedure MoverparaAcervoPerdido1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_BibliotecaExplorer: Tform_BibliotecaExplorer;

implementation

uses unit_RetiradaDialog, unit_ReservaDialog, unit_AcervoPerdidoDialog;

{$R *.DFM}

procedure Tform_BibliotecaExplorer.Emprestar1Click(Sender: TObject);
begin
  form_RetiradaDialog := Tform_RetiradaDialog.Create(Application);
  form_RetiradaDialog.ShowModal;
  form_RetiradaDialog.Free;
end;

procedure Tform_BibliotecaExplorer.Reservar1Click(Sender: TObject);
begin
  form_ReservaDialog := Tform_ReservaDialog.Create(Application);
  form_ReservaDialog.ShowModal;
  form_ReservaDialog.Free;
end;

procedure Tform_BibliotecaExplorer.MoverparaAcervoPerdido1Click(
  Sender: TObject);
begin
  form_AcervoPerdidoDialog := Tform_AcervoPerdidoDialog.Create(Application);
  form_AcervoPerdidoDialog.ShowModal;
  form_AcervoPerdidoDialog.Free;
end;

end.
