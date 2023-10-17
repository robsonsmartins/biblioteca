unit unit_PainelDeControle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, Menus, StdCtrls;

type
  Tform_PainelDeControle = class(TForm)
    MainMenu1: TMainMenu;
    PaineldeControle1: TMenuItem;
    Fechar1: TMenuItem;
    ListView1: TListView;
    ImageList1: TImageList;
    N1: TMenuItem;
    CoresdareadeTrabalho1: TMenuItem;
    PapeldeParede1: TMenuItem;
    OpesdeCadastro1: TMenuItem;
    DiretivasdeGruposeContasdeLogin1: TMenuItem;
    RichEdit1: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_PainelDeControle: Tform_PainelDeControle;

implementation

{$R *.DFM}

end.
