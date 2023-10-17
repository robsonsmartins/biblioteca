unit unit_AparenciaDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs;

type
  Tform_AparenciaDialog = class(TForm)
    Panel_Dialog: TPanel;
    Panel_Botoes: TPanel;
    OpenDialog_Imagem: TOpenPictureDialog;
    PageControl_Opcoes: TPageControl;
    TabSheet_PapelDeParede: TTabSheet;
    Label_PreviewPapelDeParede: TLabel;
    RadioGroup_PapelDeParede: TRadioGroup;
    Panel_PreviewPapelDeParede: TPanel;
    Image_Preview: TImage;
    BitBtn_Ok: TBitBtn;
    BitBtn_Cancelar: TBitBtn;
    Panel_ProcuraArquivo: TPanel;
    BitBtn_Procurar: TBitBtn;
    Edit_NomeArquivo: TEdit;
    Label_NomeArquivo: TLabel;
    TabSheet_Cores: TTabSheet;
    ColorDialog_Cores: TColorDialog;
    Panel_PreviewCores: TPanel;
    Label_IconePreview: TLabel;
    Image_IconePreview: TImage;
    Label_PreviewCores: TLabel;
    Panel_CoresConfig: TPanel;
    Button_CorDesktop: TButton;
    Panel_CorDesktop: TPanel;
    Button_DescricaoTextColor: TButton;
    Panel_DescricaoTextColor: TPanel;
    Button_DescricaoColor: TButton;
    Panel_DescricaoColor: TPanel;
    procedure RadioGroup_PapelDeParedeClick(Sender: TObject);
    procedure BitBtn_ProcurarClick(Sender: TObject);
    procedure Button_CorDesktopClick(Sender: TObject);
    procedure Button_DescricaoTextColorClick(Sender: TObject);
    procedure Button_DescricaoColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_AparenciaDialog: Tform_AparenciaDialog;

implementation

{$R *.DFM}

procedure Tform_AparenciaDialog.RadioGroup_PapelDeParedeClick(
  Sender: TObject);
begin
  case RadioGroup_PapelDeParede.ItemIndex of
    0: begin
         {Nenhum}
         BitBtn_Procurar.Enabled := False;
         Label_NomeArquivo.Enabled := False;
       end;
    1: begin
         {Imagem}
         BitBtn_Procurar.Enabled := True;
         Label_NomeArquivo.Enabled := True;
       end;
  end;
end;

procedure Tform_AparenciaDialog.BitBtn_ProcurarClick(Sender: TObject);
begin
  with OpenDialog_Imagem do
  begin
    if Execute then
    begin
      Image_Preview.Picture.LoadFromFile(FileName);
    end;
  end;
end;

procedure Tform_AparenciaDialog.Button_CorDesktopClick(Sender: TObject);
begin
  if ColorDialog_Cores.Execute then
  begin
    Panel_CorDesktop.Color := ColorDialog_Cores.Color;
    Panel_PreviewCores.Color := ColorDialog_Cores.Color;
  end;
end;

procedure Tform_AparenciaDialog.Button_DescricaoTextColorClick(
  Sender: TObject);
begin
  if ColorDialog_Cores.Execute then
  begin
    Panel_DescricaoTextColor.Color := ColorDialog_Cores.Color;
    Label_IconePreview.Font.Color := ColorDialog_Cores.Color;
  end;
end;

procedure Tform_AparenciaDialog.Button_DescricaoColorClick(
  Sender: TObject);
begin
  if ColorDialog_Cores.Execute then
  begin
    Panel_DescricaoColor.Color := ColorDialog_Cores.Color;
    Label_IconePreview.Color := ColorDialog_Cores.Color;
  end;
end;

end.

