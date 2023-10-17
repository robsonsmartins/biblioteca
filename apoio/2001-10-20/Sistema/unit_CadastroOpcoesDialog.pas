unit unit_CadastroOpcoesDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, CheckLst, ImgList, ToolWin;

type
  Tform_CadastroOpcoesDialog = class(TForm)
    Panel_Dialog: TPanel;
    Panel_Botoes: TPanel;
    PageControl_Opcoes: TPageControl;
    TabSheet_PapelDeParede: TTabSheet;
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancelar: TBitBtn;
    TabSheet_Cores: TTabSheet;
    TabSheet1: TTabSheet;
    ImageList1: TImageList;
    GroupBox2: TGroupBox;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Label13: TLabel;
    Edit8: TEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label9: TLabel;
    ToolBar3: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ListBox2: TListBox;
    Edit5: TEdit;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    ToolBar4: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ListBox3: TListBox;
    Edit9: TEdit;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ListBox4: TListBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ToolBar5: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ListBox5: TListBox;
    Edit2: TEdit;
    Label7: TLabel;
    Edit3: TEdit;
    Label8: TLabel;
    Edit4: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_CadastroOpcoesDialog: Tform_CadastroOpcoesDialog;

implementation

{$R *.DFM}

end.

