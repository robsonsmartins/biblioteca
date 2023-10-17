unit unit_ContasDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, CheckLst, ImgList, ToolWin;

type
  Tform_ContasDialog = class(TForm)
    Panel_Dialog: TPanel;
    Panel_Botoes: TPanel;
    PageControl_Opcoes: TPageControl;
    TabSheet_PapelDeParede: TTabSheet;
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancelar: TBitBtn;
    TabSheet_Cores: TTabSheet;
    TabSheet1: TTabSheet;
    ListView1: TListView;
    Label1: TLabel;
    ImageList1: TImageList;
    ListView2: TListView;
    Label3: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit4: TEdit;
    Label8: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel2: TPanel;
    Label2: TLabel;
    CheckListBox1: TCheckListBox;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Label9: TLabel;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label10: TLabel;
    Edit6: TEdit;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    Label11: TLabel;
    Edit7: TEdit;
    Label12: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_ContasDialog: Tform_ContasDialog;

implementation

{$R *.DFM}

end.

