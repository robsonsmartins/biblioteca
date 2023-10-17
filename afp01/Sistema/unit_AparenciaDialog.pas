{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_AparenciaDialog.pas

  Contém as classes relativas às configurações de aparência do Sistema.

  Data última revisão: 07/11/2001

******************************************************************************}

unit unit_AparenciaDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, Registry,
  InterfaceComponentes, ImgList;

{Classe de Dados (Registro do Windows) }

type
  TConfiguracao = class
    public
      { Public declarations }
      {propriedades}
      IconTextColor: TColor;
      IconBackColor: TColor;
      DesktopColor: TColor;
      WallPaperName: String;
      {construtor}
      constructor Create;
      {métodos}
      {Lê config. do Registro}
      {WriteDef = grava config. default se não existir config.}
      function Read(WriteDef: Boolean = False): Boolean;
      {grava config. no Registro}
      function Write: Boolean;
    end;

{Classe do Form}

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
    Btn_Ok: TBitBtn;
    Btn_Cancelar: TBitBtn;
    Panel_ProcuraArquivo: TPanel;
    Btn_Procurar: TBitBtn;
    Edit_NomeArquivo: TEdit;
    Label_NomeArquivo: TLabel;
    TabSheet_Cores: TTabSheet;
    ColorDialog_Cores: TColorDialog;
    Panel_PreviewCores: TPanel;
    Label_IconePreview: TLabel;
    Image_IconePreview: TImage;
    Label_PreviewCores: TLabel;
    Panel_CoresConfig: TPanel;
    Btn_CorDesktop: TButton;
    Panel_CorDesktop: TPanel;
    Btn_DescricaoTextColor: TButton;
    Panel_DescricaoTextColor: TPanel;
    Btn_DescricaoColor: TButton;
    Panel_DescricaoColor: TPanel;
    ImageList_Aparencia: TImageList;
    {tratadores de evento}
    procedure RadioGroup_PapelDeParedeClick(Sender: TObject);
    procedure Btn_ProcurarClick(Sender: TObject);
    procedure Btn_CorDesktopClick(Sender: TObject);
    procedure Btn_DescricaoTextColorClick(Sender: TObject);
    procedure Btn_DescricaoColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    {contém inform. da config.}
    FConfiguracao: TConfiguracao;
    {atualiza os comps. do diálogo com os valores da config.}
    procedure AtualizaInterface;
  public
    { Public declarations }
    {chama o diálogo e faz config. sistema}
    procedure Configura(Desktop: TDesktop);
    {aplica as configs. correntes no programa}
    procedure Aplicar(Desktop: TDesktop);
  end;

var
  form_AparenciaDialog: Tform_AparenciaDialog;

implementation

{$R *.DFM}

{-------------------- TConfiguracao -----------------------}

constructor TConfiguracao.Create;
begin
  inherited Create;
  {lê config / cria config default se não existir}
  IconTextColor := clSilver;
  IconBackColor := clNavy;
  DesktopColor := clNavy;
  WallPaperName := ExtractFilePath(Application.ExeName) + 'default.bmp';
  Read(True);
end;

function TConfiguracao.Read(WriteDef: Boolean = False): Boolean;
var Reg: TRegistry;
begin
  {Lê config. do Registro (grava default = sim ou não)}
  Reg := TRegistry.Create;
  with Reg do
  begin
    {config. para cada usuário}
    RootKey := HKEY_CURRENT_USER;
    Result := OpenKey('\Software\FBAI\Sistema Biblioteca',WriteDef);
    {se não exisite config. e não configurado para gravar, falha}
    if not Result then
    begin
      Free;
      exit;
    end;
    try
      {se não exisite config. e configurado para gravar, grava default}
      if WriteDef then
      begin
        if not ValueExists('IconTextColor') then
          WriteInteger('IconTextColor',IconTextColor);
        if not ValueExists('IconBackColor') then
          WriteInteger('IconBackColor',IconBackColor);
        if not ValueExists('DesktopColor') then
          WriteInteger('DesktopColor',DesktopColor);
        if not ValueExists('WallPaperName') then
          WriteString('WallPaperName',WallPaperName);
      end;
      {lê config. do registro}
      IconTextColor := ReadInteger('IconTextColor');
      IconBackColor := ReadInteger('IconBackColor');
      DesktopColor := ReadInteger('DesktopColor');
      WallPaperName := ReadString('WallPaperName');
      if not FileExists(WallPaperName) then
        WallPaperName := '';
    except
      Free;
      Result := False;
      exit;
    end;
    CloseKey;
    Free;
    Result := True;
  end;
end;

function TConfiguracao.Write: Boolean;
var Reg: TRegistry;
begin
  {grava config. no Registro}
  Reg := TRegistry.Create;
  with Reg do
  begin
    {config. para cada usuário}
    RootKey := HKEY_CURRENT_USER;
    Result := OpenKey('\Software\FBAI\Sistema Biblioteca',True);
    if not Result then
    begin
      Free;
      exit;
    end;
    try
      WriteInteger('IconTextColor',IconTextColor);
      WriteInteger('IconBackColor',IconBackColor);
      WriteInteger('DesktopColor',DesktopColor);
      WriteString('WallPaperName',WallPaperName);
    except
      Free;
      Result := False;
      exit;
    end;
    CloseKey;
    Free;
    Result := True;
  end;
end;

{-------------------- Tform_AparenciaDialog -----------------------}

{Métodos}

procedure Tform_AparenciaDialog.Configura(Desktop: TDesktop);
begin
  {chama diálogo p/ config. o sistema}
  if ShowModal = mrOK then
  begin
    with FConfiguracao do
    begin
      {iconeback}
      IconBackColor := Panel_DescricaoColor.Color;
      {iconetext}
      IconTextColor := Panel_DescricaoTextColor.Color;
      {desktop}
      DesktopColor := Panel_CorDesktop.Color;
      {wallpaper}
      WallPaperName := Edit_NomeArquivo.Text;
      {gravar config.}
      Write;
      {aplica config.}
      Aplicar(Desktop);
    end;
  end;
end;

procedure Tform_AparenciaDialog.Aplicar(Desktop: TDesktop);
begin
 {aplica configs. no programa}
  with FConfiguracao do
  begin
    with Desktop do
    begin
      Screen.Cursor := crHourGlass;
      Visible := False;
      ClearIcones;
      LabelColor := IconBackColor;
      TextColor := IconTextColor;
      Color := DesktopColor;
      if WallPaperName <> '' then
        Picture.LoadFromFile(WallPaperName)
      else
        Picture := nil;
      CreateIcones;
      Visible := True;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure Tform_AparenciaDialog.AtualizaInterface;
begin
  {atualiza diálogo}
  with FConfiguracao do
  begin
    {iconeback}
    Panel_DescricaoColor.Color := IconBackColor;
    Label_IconePreview.Color := IconBackColor;
    {iconetext}
    Panel_DescricaoTextColor.Color := IconTextColor;
    Label_IconePreview.Font.Color := IconTextColor;
    {desktop}
    Panel_CorDesktop.Color := DesktopColor;
    Panel_PreviewCores.Color := DesktopColor;
    {wallpaper}
    Edit_NomeArquivo.Text := WallPaperName;
    if WallPaperName = '' then
    begin
      {Nenhum}
      Btn_Procurar.Enabled := False;
      Label_NomeArquivo.Enabled := False;
      RadioGroup_PapelDeParede.ItemIndex := 0;
      Image_Preview.Picture := nil;
    end
    else
    begin
      {Imagem}
      Btn_Procurar.Enabled := True;
      Label_NomeArquivo.Enabled := True;
      RadioGroup_PapelDeParede.ItemIndex := 1;
      Image_Preview.Picture.LoadFromFile(WallPaperName);
    end;
  end;
end;

{tratadores de evento}

procedure Tform_AparenciaDialog.RadioGroup_PapelDeParedeClick(
  Sender: TObject);
begin
  {evento OnClick do radio box de escolha do wallpaper}
  Image_Preview.Picture := nil;
  case RadioGroup_PapelDeParede.ItemIndex of
    0: begin
         {Nenhum}
         Btn_Procurar.Enabled := False;
         Label_NomeArquivo.Enabled := False;
         Edit_NomeArquivo.Text := '';
       end;
    1: begin
         {Imagem}
         Btn_Procurar.Enabled := True;
         Label_NomeArquivo.Enabled := True;
       end;
  end;
end;

procedure Tform_AparenciaDialog.Btn_ProcurarClick(Sender: TObject);
begin
  {evento OnClick do Botão Procurar}
  with OpenDialog_Imagem do
  begin
    if Execute then
    begin
      Image_Preview.Picture.LoadFromFile(FileName);
    end;
    Edit_NomeArquivo.Text := FileName;
  end;
end;

procedure Tform_AparenciaDialog.Btn_CorDesktopClick(Sender: TObject);
begin
  {evento OnClick do Botão da cor do desktop}
  if ColorDialog_Cores.Execute then
  begin
    Panel_CorDesktop.Color := ColorDialog_Cores.Color;
    Panel_PreviewCores.Color := ColorDialog_Cores.Color;
  end;
end;

procedure Tform_AparenciaDialog.Btn_DescricaoTextColorClick(
  Sender: TObject);
begin
  {evento OnClick do Botão da cor do texto do ícone}
  if ColorDialog_Cores.Execute then
  begin
    Panel_DescricaoTextColor.Color := ColorDialog_Cores.Color;
    Label_IconePreview.Font.Color := ColorDialog_Cores.Color;
  end;
end;

procedure Tform_AparenciaDialog.Btn_DescricaoColorClick(
  Sender: TObject);
begin
  {evento OnClick do Botão da cor de fundo do ícone}
  if ColorDialog_Cores.Execute then
  begin
    Panel_DescricaoColor.Color := ColorDialog_Cores.Color;
    Label_IconePreview.Color := ColorDialog_Cores.Color;
  end;
end;

procedure Tform_AparenciaDialog.FormCreate(Sender: TObject);
begin
  {evento OnCreate do Form}
  {cria o objeto de dados}
  FConfiguracao := TConfiguracao.Create;
  {atualiza o diálogo com as configs.}
  AtualizaInterface;
end;

procedure Tform_AparenciaDialog.FormDestroy(Sender: TObject);
begin
  {evento OnDestroy do Form}
  {destrói o objeto de dados}
  FConfiguracao.Free;
end;

end.

