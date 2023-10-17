
// para fazer:
{
- Colocar o TIdleTimer nesta unit.(implementar um componente para fezer o login)
}

unit InterfaceComponentes;

{**************************** Interface **************************************}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  buttons, extctrls, menus, stdctrls, Math, comctrls;

{---------------------------- Tipos de Eventos -------------------------------}

type
{evento OnCommand}
  TCommandEvent = procedure(Command: String; Sender: TObject) of object;
{evento OnPopupCommand}
  TPopupCommandEvent = procedure(Command: String; PopupCommand: String;
                                 Sender: TObject) of object;

{---------------------------- TTaskBar ---------------------------------------}

type
  TTaskButtons = Array of TSpeedButton;

  {forward declarations}
  TTaskBar = class;

  TMenuButton = class(TPersistent) {propriedede MenuButton do TTaskBar}
  private
    { Private declarations }
    FPopupMenu: TPopupMenu;
    FMenuImageIndex: Integer;
    FOwner: TTaskBar;
    {métodos para atribuição de propriedades}
    procedure SetMenuCaption(Value: TCaption);
    procedure SetMenuWidth(Value: Integer);
    procedure SetMenuImageIndex(Value: Integer);
    procedure SetMenuPopup(Value: TPopupMenu);
    procedure SetMenu(Value: TPopupMenu);
    procedure SetHint(Value: String);
    procedure SetShowHint(Value: Boolean);
    function GetMenuCaption: TCaption;
    function GetMenuWidth: Integer;
    function GetMenuPopup: TPopupMenu;
    function GetHint: String;
    function GetShowHint: Boolean;
  published
    { Published declarations }
    {propriedades visuais}
    property Menu: TPopupMenu read FPopupMenu write SetMenu;
    property Popup: TPopupMenu read GetMenuPopup write SetMenuPopup;
    property Caption: TCaption read GetMenuCaption write SetMenuCaption;
    property Width: Integer read GetMenuWidth write SetMenuWidth;
    property ImageIndex: Integer read FMenuImageIndex
                                 write SetMenuImageIndex default 0;
    property Hint: String read GetHint write SetHint;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
  end;

  TSystemMenu = class(TPersistent) {propriedede SystemMenu do TTaskBar}
  private
    { Private declarations }
    FSystemMenu: Boolean;
    FMinimizeImageIndex: Integer;
    FExitImageIndex: Integer;
    FOwner: TTaskBar;
    {métodos para atribuição de propriedades}
    procedure SetSystemMenu(Value: Boolean);
    procedure SetMinimizeImageIndex(Value: Integer);
    procedure SetExitImageIndex(Value: Integer);
  published
    { Published declarations }
    {propriedades visuais}
    property Visible: Boolean read FSystemMenu
                              write SetSystemMenu default True;
    property BMinimizeImageIndex: Integer read FMinimizeImageIndex
                                          write SetMinimizeImageIndex;
    property BExitImageIndex: Integer read FExitImageIndex
                                      write SetExitImageIndex;
  end;

  {TTaskBar}
  TTaskBar = class(TCustomPanel)
  private
    { Private declarations }
    FMenuProp: TMenuButton;
    FSysProp: TSystemMenu;
    FTaskButtons: TTaskButtons;
    FImage: TImageList;
    FMenuButton: TSpeedButton;
    FMinimizeButton: TSpeedButton;
    FExitButton: TSpeedButton;
    FTaskPopup: TPopupMenu;
    {eventos}
    FOnCommand: TCommandEvent;
    FOnPopupCommand: TPopupCommandEvent;
    {propriedades de TCustomPanel ocultadas}
    property BevelInner;
    property BevelOuter;
    property Caption;
    {métodos para atribuição de propriedades}
    procedure SetImage(Value: TImageList);
    {métodos manipuladores de eventos internos}
    procedure MenuButtonClick(Sender: TObject);
    procedure MinimizeButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure TaskButtonClick(Sender: TObject);
    procedure TaskPopupClick(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure TaskBarResize(Sender: TObject);
    {métodos para funcionalidade}
    procedure CriaSystemMenu;
    procedure Redimensiona;
  protected
    { Protected declarations }
    {permite a proteção de propriedades de agregação}
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    { Public declarations }
    {constructors e destructors}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {propriedades públicas não visuais}
    property TaskButtons: TTaskButtons read FTaskButtons write FTaskButtons;
    {eventos}
    property OnCommand: TCommandEvent read FOnCommand write FOnCommand;
    property OnPopupCommand: TPopupCommandEvent read FOnPopupCommand
                                                write FOnPopupCommand;
    {métodos}
    procedure AddButton(BCaption: TCaption; BImage: TIcon);
    procedure RemoveButton(BCaption: TCaption);
    procedure CopyButton(Source, Dest: TSpeedButton);
    procedure ClearButtons;
    procedure ActiveButton(BCaption: TCaption);
    procedure VisibleMenu(MCaption: String; MVisible: Boolean = True);
  published
    { Published declarations }
    {propriedades visuais}
    property Image: TImageList read FImage write SetImage;
    property MenuButton: TMenuButton read FMenuProp write FMenuProp;
    property SystemMenu: TSystemMenu read FSysProp write FSysProp;
    {propriedades de TCustomPanel publicadas}
    property Align;
    property ShowHint;
  end;

{---------------------------- TIcone ---------------------------------------}

type
  TIcone = class(TCustomPanel)
  private
    { Private declarations }
    FLabel: TLabel;
    FImage: TImage;
    FImageIndex: Integer;
    FImageList: TImageList;
    FTexto: String;
    FCanvasImage: TImage;
    FSelected: Boolean;
    {métodos para atribuição de propriedades}
    procedure SetImageIndex(Value: Integer);
    procedure SetTexto(Value: String);
    {métodos para funcionalidade}
    procedure Redimensiona;
  protected
    { Protected declarations }
  public
    { Public declarations }
    {propriedades não visuais}
    property ImageList: TImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex
                                 write SetImageIndex default -1;
    property Texto: String read FTexto write SetTexto;
    property Selected: Boolean read FSelected write FSelected;
    {propriedades de TCustomPanel publicadas}
    property ShowHint;
    property OnClick;
    {constructors e destructors}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {métodos}
    procedure Refresh;
  published
    { Published declarations }
  end;

{---------------------------- TDesktop ---------------------------------------}

type
  TIcones = Array of TIcone;

  {forward declarations}
  TDesktop = class;

  TIconeItem = class(TCollectionItem)  {propriedede Items do TIconeCollection}
  private
    { Private declarations }
    FTexto: String;
    FImageIndex: Integer;
    FHint: String;
    FShowHint: Boolean;
    FVisible: Boolean;
    FIndice: Integer;
  public
    { Public declarations }
    {propriedades não-visuais}
    property Indice: Integer read FIndice;
    {constructors e destructors}
    constructor Create(Collection: TCollection); override;
  published
    { Published declarations }
    {propriedades visuais}
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Caption: String read FTexto write FTexto;
    property Visible: Boolean read FVisible write FVisible;
    property ShowHint: Boolean read FShowHint write FShowHint;
    property Hint: String read FHint write FHint;
  end;

  TIconeCollection = class(TCollection)  {propriedede IconeList do TDesktop}
  private
    { Private declarations }
    FDesktop: TDesktop;
    {métodos para atribuição de propriedades}
    function GetItem(Index: Integer): TIconeItem;
    procedure SetItem(Index: Integer; Value: TIconeItem);
  protected
    { Protected declarations }
    function GetOwner: TPersistent; override;
  public
    { Public declarations }
    {propriedades não visuais}
    property Items[Index: Integer]: TIconeItem read GetItem
                                               write SetItem; default;
    {constructors e destructors}
    constructor Create(Desktop: TDesktop);
    {métodos}
    function Add: TIconeItem;
  end;

  {TDesktop}
  TDesktop = class(TCustomPanel)
  private
    { Private declarations }
    FIconeCollection: TIconeCollection;
    FImageList: TImageList;
    FIcones: TIcones;
    FTamanhoIcone: Byte;
    FWallPaper: TImage;
    FTextColor: TColor;
    FLabelColor: TColor;
    FFirstIconX: Integer;
    FFirstIconY: Integer;
    FGridSizeX: Integer;
    FGridSizeY: Integer;
    FGridRows: Integer;
    FGridCols: Integer;
    FDesColor: TColor;
    {eventos}
    FAppOnMsgOld : TMessageEvent;
    FOnCommand: TCommandEvent;
    {propriedades de TCustomPanel ocultadas}
    property BevelInner;
    property BevelOuter;
    property Caption;
    {métodos para atribuição de propriedades}
    function GetPicture: TPicture;
    procedure SetPicture(Value: TPicture);
    procedure SetTextColor(Value: TColor);
    procedure SetLabelColor(Value: TColor);
    procedure SetImageList(Value: TImageList);
    procedure SetIcone(Index: Integer; Value: TIcone);
    function GetIcone(Index: Integer): TIcone;
    {métodos manipuladores de eventos internos}
    procedure ApplicationOnMessage(var Msg: TMsg; var Handled: Boolean);
    procedure IconeClick(Sender: TObject);
  protected
    { Protected declarations }
    {permite a proteção de propriedades de agregação}
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    { Public declarations }
    {propriedades não visuais}
    property WallPaper: TImage read FWallPaper write FWallPaper;
    property Icones[index: Integer]: TIcone read GetIcone write SetIcone;
    {eventos}
    property OnCommand: TCommandEvent read FOnCommand write FOnCommand;
    {constructors e destructors}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {métodos}
    procedure AddIcone(const Descricao: String; ImageIdx: Integer;
                       AHint: String = '');
    procedure ClearIcones;
    procedure CreateIcones;
  published
    { Published declarations }
    {propriedades visuais}
    property IconeList: TIconeCollection read FIconeCollection
                                      write FIconeCollection stored True;
    property ImageList: TImageList read FImageList write SetImageList;
    property TamanhoIcone: Byte read FTamanhoIcone
                                write FTamanhoIcone default 32;
    property Picture: TPicture read GetPicture write SetPicture;
    property TextColor: TColor read FTextColor
                               write SetTextColor default clBlack;
    property LabelColor: TColor read FLabelColor
                                write SetLabelColor default clSilver;
    property FirstIconX: Integer read FFirstIconX write FFirstIconX;
    property FirstIconY: Integer read FFirstIconY write FFirstIconY;
    property GridSizeX: Integer read FGridSizeX write FGridSizeX;
    property GridSizeY: Integer read FGridSizeY write FGridSizeY;
    property GridRows: Integer read FGridRows write FGridRows;
    property GridCols: Integer read FGridCols write FGridCols;
    property UnSelectColor: TColor read FDesColor write FDesColor
                                                 default $00373737;
    {propriedades de TCustomPanel publicadas}
    property Align;
    property Color;
    property ShowHint;
  end;

{---------------------------- TBBStatusBar -----------------------------------}

type
  TBBStatusBar = class(TStatusBar)
  private
    { Private declarations }
    FTimer: TTimer;
    FCount: TDateTime;
    FStart: TDateTime;
    FActive: Boolean;
    FOldHint: TNotifyEvent;
    FUsuario: String;
    {métodos para atribuição de propriedades}
    procedure SetActive(Value: Boolean);
    {métodos manipuladores de eventos internos}
    procedure ApplicationHint(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure BBStatusBarResize(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    {propriedades não visuais}
    property Elapsed: TDateTime read FCount write FCount;
    {constructors e destructors}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {métodos}
  published
    { Published declarations }
    {propriedades visuais}
    property Active: Boolean read FActive write SetActive;
    property Usuario: String read FUsuario write FUsuario;
  end;

{---------------------------- TDesktopLaunch ---------------------------------}

type
  TFormItem = record
    FormVar: TForm;
    FormClass: TFormClass;
    Command: String;
  end;

  TFormItems = Array of TFormItem;

type
  TFormsList = class   {propriedede FormsList do TDesktopLaunch}
  private
    { Private declarations }
    FFormItem: TFormItems;
    {métodos para atribuição de propriedades}
    procedure SetFormItem(Index: Integer; Value: TFormItem);
    function GetFormItem(Index: Integer): TFormItem;
  public
    { Public declarations }
    {propriedades não visuais}
    property FormItem[index: Integer]: TFormItem read GetFormItem
                                                 write SetFormItem;
    {constructors e destructors}
    constructor Create;
    destructor Destroy; override;
    {métodos}
    procedure Add(Command: String; FormVar: TForm; FormClass: TFormClass);
    procedure Clear;
    function Count: Integer;
    procedure Delete(Index: Integer);
  end;

{TDesktopLaunch}
type
  TDesktopLaunch = class(TComponent)
  private
    { Private declarations }
    FDesktop: TDesktop;
    FTaskBar: TTaskBar;
    FFormsList: TFormsList;
    {eventos}
    FOnCommand: TCommandEvent;
    {métodos para atribuição de propriedades}
    procedure SetDesktop(Value: TDesktop);
    procedure SetTaskBar(Value: TTaskBar);
    {manipuladores de eventos internos}
    procedure IHMCommand(Command: String; Sender: TObject);
    procedure IHMPopupCommand(Command: String; PopupCommand: String;
                              Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DesktopResize(Sender: TObject);
    {métodos para funcionalidade}
    procedure ExecuteForm(Index: Integer; Command: String);
  protected
    { Protected declarations }
    {permite a proteção de propriedades de agregação}
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    { Public declarations }
    {propriedades não visuais}
    property FormsList: TFormsList read FFormsList write FFormsList;
    {constructors e destructors}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {métodos}
    procedure MinimizeAll;
    function RestoreLast(NoRestore: Integer = -1): Boolean;
    function HasFormOpen: Boolean;
  published
    { Published declarations }
    {propriedades visuais}
    property Desktop: TDesktop read FDesktop write SetDesktop;
    property TaskBar: TTaskBar read FTaskBar write SetTaskBar;
    {eventos}
    property OnCommand: TCommandEvent read FOnCommand write FOnCommand;
  end;

{procedures e functions globais}
procedure Register;

{**************************** Implementação **********************************}

implementation

{procedures e functions globais}

procedure Register;
begin
  RegisterComponents('Biblioteca',
                     [TDesktop,TTaskBar,TBBStatusBar,TDesktopLaunch]);
end;

{---------------------------- TMenuButton -----------------------------------}

{.................Métodos para a atribuição de propriedades...................}

procedure TMenuButton.SetMenuCaption(Value: TCaption);
begin
  {altera propriedade MenuCaption, aplica o valor no botão de Menu e
  redimensiona-o de acordo com o comprimento do caption}
  with FOwner do
  begin
    FMenuButton.Caption := Value;
    Canvas.Font.Style := [fsBold];
    FMenuButton.Width := Canvas.TextWidth(Value) + 50;
  end;
end;

function TMenuButton.GetMenuCaption: TCaption;
begin
  {lê propriedade MenuCaption}
  with FOwner do
    Result := FMenuButton.Caption;
end;

procedure TMenuButton.SetMenuWidth(Value: Integer);
begin
  {altera propriedade MenuWidth e aplica-a}
  with FOwner do
    FMenuButton.Width := Value;
end;

function TMenuButton.GetMenuWidth: Integer;
begin
  {lê propriedade MenuWidth}
  with FOwner do
    Result := FMenuButton.Width;
end;

procedure TMenuButton.SetMenuImageIndex(Value: Integer);
begin
  {altera propriedade SetMenuImageIndex e aplica-a}
  with FOwner do
  begin
    FMenuImageIndex := Value;
    if (FImage <> nil) and (FMenuImageIndex >= 0) then
    begin
      Image.GetBitmap(FMenuImageIndex,FMenuButton.Glyph);
    end
    else
      FMenuButton.Glyph := nil;
  end;
end;

procedure TMenuButton.SetMenuPopup(Value: TPopupMenu);
begin
  {altera propriedade MenuPopup}
  with FOwner do
    FMenuButton.PopupMenu := Value;
end;

procedure TMenuButton.SetMenu(Value: TPopupMenu);
var i, j: Integer;
begin
  {altera propriedade Menu}
  FPopupMenu := Value;
  if FPopupMenu <> nil then
  begin
    for i := 0 to FPopupMenu.Items.Count - 1 do
    begin
      if FPopupMenu.Items[i].Count = 0 then
      begin
        FPopupMenu.Items[i].OnClick := FOwner.MenuClick;
        FPopupMenu.Items[i].OnAdvancedDrawItem := nil;
        FPopupMenu.Items[i].OnDrawItem := nil;
        FPopupMenu.Items[i].OnMeasureItem := nil;
      end
      else
      begin     {isso existe para habilitar o OnClick de submenus (só 1 nível!)}
        for j := 0 to FPopupMenu.Items[i].Count - 1 do
        begin
          FPopupMenu.Items[i].Items[j].OnClick := FOwner.MenuClick;
          FPopupMenu.Items[i].Items[j].OnAdvancedDrawItem := nil;
          FPopupMenu.Items[i].Items[j].OnDrawItem := nil;
          FPopupMenu.Items[i].Items[j].OnMeasureItem := nil;
        end;
      end;
    end;
  end;
end;

function TMenuButton.GetMenuPopup: TPopupMenu;
begin
  {lê propriedade MenuPopup}
  with FOwner do
    Result := FMenuButton.PopupMenu;
end;

procedure TMenuButton.SetHint(Value: String);
begin
  {altera propriedade Hint}
  with FOwner do
    FMenuButton.Hint := Value;
end;

procedure TMenuButton.SetShowHint(Value: Boolean);
begin
  {altera propriedade ShowHint}
  with FOwner do
    FMenuButton.ShowHint := Value;
end;

function TMenuButton.GetHint: String;
begin
  {lê propriedade Hint}
  with FOwner do
    Result := FMenuButton.Hint;
end;

function TMenuButton.GetShowHint: Boolean;
begin
  {lê propriedade ShowHint}
  with FOwner do
    Result := FMenuButton.ShowHint;
end;

{---------------------------- TSystemMenu -----------------------------------}

{.................Métodos para a atribuição de propriedades...................}

procedure TSystemMenu.SetSystemMenu(Value: Boolean);
begin
  {altera a propriedade SystemMenu e aplica-a}
  with FOwner do
  begin
    FSystemMenu := Value;
    CriaSystemMenu;
  end;
end;

procedure TSystemMenu.SetMinimizeImageIndex(Value: Integer);
begin
  {altera a propriedade MinimizeImageIndex e aplica-a}
  FMinimizeImageIndex := Value;
  with FOwner do
    CriaSystemMenu;
end;

procedure TSystemMenu.SetExitImageIndex(Value: Integer);
begin
  {altera a propriedade ExitImageIndex e aplica-a}
  FExitImageIndex := Value;
  with FOwner do
    CriaSystemMenu;
end;

{---------------------------- TTaskBar ---------------------------------------}

{.................construtor Create de TTaskBar...............................}
constructor TTaskBar.Create(AOwner: TComponent);
begin
  {executa Create do TCustomPanel}
  inherited Create(AOwner);
  {cria propriededes de menu / systemmenu}
  FMenuProp := TMenuButton.Create;
  FMenuProp.FOwner := Self;
  FSysProp := TSystemMenu.Create;
  FSysProp.FOwner := Self;
  {define suas propriedades}
  Parent := (AOwner as TWinControl);
  Width := Parent.ClientWidth;
  Align := alTop;
  BevelInner := bvRaised;
  BevelOuter := bvRaised;
  Height := 32;
  OnResize := TaskBarResize;
  {cria o botão de menu}
  FMenuButton := TSpeedButton.Create(Self);
  with FMenuButton do
  begin
    {define propriedades do botão de menu}
    Font.Style := [fsBold];
    FMenuProp.Caption := 'Menu Button';
    Canvas.Font.Style := [fsBold];
    FMenuProp.Width := Canvas.TextWidth(FMenuProp.Caption) + 50;
    Margin := 8;
    Spacing := 4;
    Left := 8;
    Top := 4;
    Height := Self.Height - 8;
    Cursor := crHandPoint;
    Parent := Self;
    {define manipulador do evento OnClick do botão de Menu}
    OnClick := MenuButtonClick;
  end;
  Self.Caption := ' ';
  FSysProp.FSystemMenu := True;
  {executa método para a criação dos botões de Sistema}
  CriaSystemMenu;
end;

{.................destrutor Destroy de TTaskBar...............................}
destructor TTaskBar.Destroy;
begin
  {limpa as props MenuButton e SystemMenu}
  FMenuProp.Free;
  FSysProp.Free;
  {executa método destroy de TCustomPanel}
  inherited Destroy;
end;

{.................Método para a notificação de TTaskBar.......................}
procedure TTaskBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  {executa método herdado}
  inherited Notification(AComponent, Operation);
  {caso algum componente associado ao TTaskBar seja removido, preenche a
  propriedade com NIL. As propriedades verificadas: Image, Menu}
  if Operation = opRemove then
  begin
    if AComponent = FImage then
      FImage := nil;
    if AComponent = FMenuProp.FPopupMenu then
      FMenuProp.FPopupMenu := nil;
  end;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TTaskBar.SetImage(Value: TImageList);
{altera propriedade Image}
begin
  FImage := Value;
  if (FImage <> nil) and (FMenuProp.ImageIndex >= 0) then
  begin
    {carrega os bitmaps da propriedade Image nos Botões de Menu e Sistema}
    Image.GetBitmap(FMenuProp.ImageIndex,FMenuButton.Glyph);
    if FMinimizeButton <> nil then
      Image.GetBitmap(FSysProp.FMinimizeImageIndex,FMinimizeButton.Glyph);
    if FExitButton <> nil then
      Image.GetBitmap(FSysProp.FExitImageIndex,FExitButton.Glyph);
  end
  else
  begin
    {se a propriedade Image for NIL, apaga glyph dos botões}
    FMenuButton.Glyph := nil;
    if FMinimizeButton <> nil then
      FMinimizeButton.Glyph := nil;
    if FExitButton <> nil then
      FExitButton.Glyph := nil;
  end;
end;

{.................Manipuladores de Eventos Internos...........................}

procedure TTaskBar.MenuButtonClick(Sender: TObject);
begin
  {evento OnClick dp Botão de Menu}
  {chama o popupmenu associado, com a animação dependente do alinhamento}
  if FMenuProp.FPopupMenu <> nil then
  begin
    with FMenuButton.ClientOrigin, FMenuProp.FPopupMenu do
    begin
      if Self.Align = alBottom then
      begin
        MenuAnimation := [maBottomToTop];
        Popup(x, y);
      end
      else
      begin
        MenuAnimation := [maTopToBottom];
        Popup(x, y + FMenuButton.Height);
      end;
    end;
  end;
end;

procedure TTaskBar.MinimizeButtonClick(Sender: TObject);
begin
  {evento OnClick do botão de Minimizar}
  {Minimiza a Aplicação}
  Application.Minimize;
end;

procedure TTaskBar.ExitButtonClick(Sender: TObject);
var Tmp: TControl;
begin
  {evento OnClick do botão de Sair}
  {procura nos controles "parent" o form que contém esse taskbar, e fecha-o}
  Tmp := (Sender as TControl);
  while (Tmp <> nil) and not (Tmp is TForm) do
  begin
    Tmp := Tmp.Parent;
  end;
  if Tmp <> nil then
    (Tmp as TForm).Close;
end;

procedure TTaskBar.TaskButtonClick(Sender: TObject);
var idx: Integer;
begin
  {evento OnClick do botão da Taskbar}
  {ativa o botão clicado e desativa os outros}
  {dispara evento OnCommand}
  for idx := 0 to Length(FTaskButtons) - 1 do
  begin
    FTaskButtons[idx].Font.Style := [];
    FTaskButtons[idx].PopupMenu.AutoPopup := False;
  end;
  with (Sender as TSpeedButton) do
  begin
    Font.Style := [fsBold];
    PopupMenu.AutoPopup := True;
    if Assigned(FOnCommand) then
      FOnCommand(Caption,Sender);
  end;
end;

procedure TTaskBar.TaskPopupClick(Sender: TObject);
begin
  {evento OnClick do Menu Popup do botão do TaskBar}
  {dispara evento OnPopupCommand}
  with ((Sender as TMenuItem).GetParentMenu as TPopupMenu) do
    if Assigned(FOnPopupCommand) then
      FOnPopupCommand((PopupComponent as TSpeedButton).Caption,
                      (Sender as TMenuItem).Caption,
                      (PopupComponent as TObject));
end;

procedure TTaskBar.MenuClick(Sender: TObject);
begin
  {evento OnClick do Menu do botão}
  {dispara evento OnCommand}
  if Assigned(FOnCommand) then
    FOnCommand((Sender as TMenuItem).Caption,Sender);
end;

procedure TTaskBar.TaskBarResize(Sender: TObject);
begin
  {evento OnResize do Taskbar}
  {executa método para criação dos botões de system menu}
  CriaSystemMenu;
  {executa método para redimensionar os botões}
  Redimensiona;
end;

{.................Métodos para promover a funcionalidade......................}

procedure TTaskBar.CriaSystemMenu;
begin
  {Cria ou destrói o SystemMenu (botões minimizar e sair)}
  if FSysProp.FSystemMenu then
  begin
    {botão minimizar}
    if FMinimizeButton = nil then
      FMinimizeButton := TSpeedButton.Create(Self);
    with FMinimizeButton do
    begin
      Caption := '';
      Width := 28;
      Margin := 4;
      Left := Self.Width - 66;
      Top := 4;
      Height := Self.Height - 8;
      Cursor := crHandPoint;
      Hint := 'Minimizar|Minimiza o Sistema Biblioteca';
      ShowHint := True;
      Parent := Self;
      OnClick := MinimizeButtonClick;
    end;
    {botão sair}
    if FExitButton = nil then
      FExitButton := TSpeedButton.Create(Self);
    with FExitButton do
    begin
      Caption := '';
      Width := 28;
      Margin := 4;
      Left := Self.Width - 36;
      Top := 4;
      Height := Self.Height - 8;
      Cursor := crHandPoint;
      Hint := 'Sair|Fecha o Sistema Biblioteca';
      ShowHint := True;
      Parent := Self;
      OnClick := ExitButtonClick;
    end;
    {atualizar ícones dos botões}
    if (FImage <> nil) and (FSysProp.FMinimizeImageIndex >= 0) then
      FImage.GetBitmap(FSysProp.FMinimizeImageIndex,FMinimizeButton.Glyph)
    else
      FMinimizeButton.Glyph := nil;
    if (FImage <> nil) and (FSysProp.FExitImageIndex >= 0) then
      FImage.GetBitmap(FSysProp.FExitImageIndex,FExitButton.Glyph)
    else
      FExitButton.Glyph := nil;
    FMinimizeButton.Repaint;
    FExitButton.Repaint;
    Repaint;
  end
  else
  begin
   {se a propriedade SystemMenu está false, destrói os botões}
    if FMinimizeButton <> nil then
      FMinimizeButton.Free;
    FMinimizeButton := nil;
    if FExitButton <> nil then
      FExitButton.Free;
    FExitButton := nil;
  end;
end;

procedure TTaskBar.AddButton(BCaption: TCaption; BImage: TIcon);
var idx: Integer;
    MenuItens: Array of TMenuItem;
begin
  {adiciona um botão na taskbar}
  SetLength(FTaskButtons,Length(FTaskButtons) + 1);
  FTaskButtons[Length(FTaskButtons) - 1] := TSpeedButton.Create(Self);
  {configura propriedades do botão}
  with FTaskButtons[Length(FTaskButtons) - 1] do
  begin
    AllowAllUp := False;
    GroupIndex := 99;
    Margin := 8;
    Spacing := 4;
    Caption := BCaption;
    ShowHint := False;
    Hint := BCaption;
    idx := FImage.AddIcon(BImage);
    FImage.GetBitmap(idx,Glyph);
    FImage.Delete(idx);
    Font.Style := [fsBold];
    {auto dimensiona o botão}
    Canvas.Font.Style := [fsBold];
    Width := Canvas.TextWidth(BCaption) + 50;
    if Length(FTaskButtons) = 1 then
      Left := FMenuButton.Left + FMenuButton.Width + 8
    else
      Left := FTaskButtons[Length(FTaskButtons) - 2].Left +
              FTaskButtons[Length(FTaskButtons) - 2].Width + 2;
    Top := 4;
    Height := Self.Height - 8;
    Cursor := crHandPoint;
    Parent := Self;
    Down := True;
    OnClick := TaskButtonClick;
    {cria popupmenu do botão}
    FTaskPopup := TPopupMenu.Create(Self);
    with FTaskPopup do
    begin
      SetLength(MenuItens,4);
      MenuItens[0] := TMenuItem.Create(Self);
      with MenuItens[0] do
      begin
        Caption := '&Restaurar';
        ShortCut := TextToShortCut('CTRL+R');
        OnClick := TaskPopupClick;
      end;
      MenuItens[1] := TMenuItem.Create(Self);
      with MenuItens[1] do
      begin
        Caption := 'Minimi&zar';
        ShortCut := TextToShortCut('CTRL+N');
        OnClick := TaskPopupClick;
      end;
      MenuItens[2] := TMenuItem.Create(Self);
      MenuItens[2].Caption := '-';
      MenuItens[3] := TMenuItem.Create(Self);
      with MenuItens[3] do
      begin
        Caption := '&Fechar';
        ShortCut := TextToShortCut('ALT+F4');
        OnClick := TaskPopupClick;
      end;
      Items.Add(MenuItens);
      SetLength(MenuItens,0);
    end;
    {configura o botão ativo para negrito e autopopup, os outros para normal}
    PopupMenu := FTaskPopup;
    PopupMenu.AutoPopup := True;
    for idx := 0 to Length(FTaskButtons) - 2 do
    begin
      FTaskButtons[idx].Font.Style := [];
      FTaskButtons[idx].PopupMenu.AutoPopup := False;
    end;
   {redimensiona todos os botões, se necessário}
   Redimensiona;
  end;
end;

procedure TTaskBar.RemoveButton(BCaption: TCaption);
var i: Integer;
    BtnOK: Integer;
begin
  {remove um botão da taskbar}
  BtnOK := -1;
  {procura o botão que tem o caption pedido}
  for i := 0 to Length(FTaskButtons) - 1 do
  begin
    if FTaskButtons[i].Caption = BCaption then
    begin
      BtnOK := i;
      break;
    end;
  end;
  if BtnOK <> -1 then
  begin
    {se há um botão com o caption pedido, copia o botão seguinte (se houver)
     para o anterior, sucessivamente até o último (sobreescreve o botão a ser
     removido com o botão seguinte, e assim por diante}
    if BtnOK < Length(FTaskButtons) - 1 then
      for i := BtnOK + 1 to Length(FTaskButtons) - 1 do
        CopyButton(FTaskButtons[i],FTaskButtons[i - 1]);
    {destrói o último botão e diminui 1 na lista de botões}
    FTaskButtons[Length(FTaskButtons) - 1].Free;
    SetLength(FTaskButtons,Length(FTaskButtons) - 1);
    {redimensiona todos os botões}
    Redimensiona;
  end;
end;

procedure TTaskBar.CopyButton(Source, Dest: TSpeedButton);
begin
  {copia as propriedades que interessam ao taskbar de um botão para outro}
  with Dest do
  begin
    Caption := Source.Caption;
    Glyph := Source.Glyph;
    Font := Source.Font;
    Down := Source.Down;
    Hint := Source.Hint;
    ShowHint := Source.ShowHint;
    OnClick := Source.OnClick;
    PopupMenu := Source.PopupMenu;
  end;
end;

procedure TTaskBar.ClearButtons;
var idx: Integer;
begin
  {apaga todos os botões da TaskBar}
  for idx := 0 to Length(FTaskButtons) - 1 do
    FTaskButtons[idx].Free;
  SetLength(FTaskButtons,0);
end;

procedure TTaskBar.ActiveButton(BCaption: TCaption);
var i: Integer;
begin
  {ativa o botão especificado na taskbar}
  for i := 0 to Length(FTaskButtons) - 1 do
  begin
    {desativa o botão}
    with FTaskButtons[i] do
    begin
      Font.Style := [];
      PopupMenu.AutoPopup := False;
      {se é o botão procurado, ativa-o}
      if Caption = BCaption then
      begin
        Font.Style := [fsBold];
        PopupMenu.AutoPopup := True;
        Down := True;
      end;
    end;
  end;
end;

procedure TTaskBar.Redimensiona;
var BarSize, BtnSize: Integer;
    idx: Integer;
begin
  {redimensiona todos os botões se necessário}
  {auto dimensiona todos botões}
  if Length(FTaskButtons) = 0 then
    exit;
  Canvas.Font.Style := [fsBold];
  for idx := 0 to Length(FTaskButtons) - 1 do
  begin
    with FTaskButtons[idx] do
    begin
      Width := Canvas.TextWidth(Caption) + 50;
      if idx = 0 then
        Left := FMenuButton.Left + FMenuButton.Width + 8
      else
        Left := FTaskButtons[idx - 1].Left + FTaskButtons[idx - 1].Width + 2;
    end;
  end;
  {calcula tamanho dos botões}
  BarSize := Width -
    (FMenuButton.Left + FMenuButton.Width +
     FMinimizeButton.Width + FExitButton.Width + 14);
  BtnSize := 0;
  if Length(FTaskButtons) > 0 then
    BtnSize := Length(FTaskButtons) * (FTaskButtons[0].Width + 2);
  {se ultrapassa o tamanho da Taskbar, redimensiona todos os botões}
  if BtnSize > BarSize then
  begin
    for idx := 0 to Length(FTaskButtons) - 1 do
    begin
      FTaskButtons[idx].Width :=
        Trunc((Self.Width - FMenuProp.Width - 86) / Length(FTaskButtons) - 2);
      if idx = 0 then
        FTaskButtons[idx].Left := FMenuButton.Left + FMenuButton.Width + 8
      else
        FTaskButtons[idx].Left := FTaskButtons[idx - 1].Left +
          FTaskButtons[idx - 1].Width + 2;
      with FTaskButtons[idx] do
      begin
        Canvas.Font.Style := [fsBold];
        if Width < Canvas.TextWidth(Caption) + 50 then
          ShowHint := True
        else
          ShowHint := False;
      end;
    end;
  end;
end;

procedure TTaskBar.VisibleMenu(MCaption: String; MVisible: Boolean = True);
var i, j: Integer;
    TmpStr: String;
begin
  {faz um menu invisível ou visível}
  if not Assigned(FMenuProp.FPopupMenu) then
    exit;
  for i := 0 to FMenuProp.FPopupMenu.Items.Count - 1 do
  begin
    TmpStr :=
      Trim(UpperCase(FMenuProp.FPopupMenu.Items[i].Caption));
    if Pos('&',TmpStr) <> 0 then
      Delete(TmpStr,Pos('&',TmpStr),1);
    if TmpStr = Trim(UpperCase(MCaption)) then
    begin
      FMenuProp.FPopupMenu.Items[i].Visible := MVisible;
      exit;
    end;
    if FMenuProp.FPopupMenu.Items[i].Count > 0 then
    begin
      for j := 0 to FMenuProp.FPopupMenu.Items[i].Count - 1 do
      begin
        TmpStr :=
          Trim(UpperCase(FMenuProp.FPopupMenu.Items[i].Items[j].Caption));
        if Pos('&',TmpStr) <> 0 then
          Delete(TmpStr,Pos('&',TmpStr),1);
        if TmpStr = Trim(UpperCase(MCaption)) then
        begin
          FMenuProp.FPopupMenu.Items[i].Items[j].Visible := MVisible;
          exit;
        end;
      end;
    end;
  end;
end;

{---------------------------- TIcone ---------------------------------------}

{.................construtor Create de TIcone...............................}
constructor TIcone.Create(AOwner: TComponent);
begin
  {executa Create do TCustomPanel}
  inherited Create(AOwner);
  {define suas propriedades}
  Parent := (AOwner as TWinControl);
  Align := alNone;
  ParentColor := True;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Caption := ' ';
  FullRepaint := False;
  {cria o canvasimage, que é um timage que possibilita a "transparência"}
  FCanvasImage := TImage.Create(Self);
  FCanvasImage.Parent := Self;
  with FCanvasImage do
  begin
    AutoSize := False;
    ParentColor := True;
    Transparent := False;
    Stretch := False;
    Align := alClient;
  end;
  {cria o label do icone}
  FLabel := TLabel.Create(Self);
  FLabel.Parent := Self;
  with FLabel do
  begin
    Alignment := taCenter;
    AutoSize := True;
    Caption := '';
    Color := (Self.Parent as TDesktop).FLabelColor;
    Font.Color := (Self.Parent as TDesktop).FTextColor;
  end;
  {cria a imagem do icone}
  FImage := TImage.Create(Self);
  with FImage do
  begin
    Parent := Self;
    Stretch := True;
    Transparent := True;
    AutoSize := False;
    with Canvas do
    begin
      {isso vai dar o efeito da seleção do ícone}
      Brush.Style := bsSolid;
      Brush.Color := (Self.Parent as TDesktop).FDesColor;
      CopyMode := cmPatInvert;
    end;
  end;
  FSelected := False;
  Cursor := crHandPoint;
end;

{.................destrutor Destroy de TIcone...............................}
destructor TIcone.Destroy;
begin
  {limpa o image, label e o canvasimage}
  FImage.Free;
  FLabel.Free;
  FCanvasImage.Free;
  {executa método destroy de TCustomPanel}
  inherited Destroy;
end;

{.................Métodos para promover a funcionalidade...................}

procedure TIcone.Refresh;
begin
  {auto-redimensiona o ticone}
  Redimensiona;
  {executa o método refresh de TCustomPanel}
  inherited Refresh;
end;

procedure TIcone.Redimensiona;
var Linha, Coluna: Integer;
begin
  {ajusta automaticamente o tamanho do ticone e de seus elementos}
  with (Self.Parent as TDesktop), FImage do
  begin
    Top := 0;
    Width := TamanhoIcone;
    Height := TamanhoIcone;
  end;
  Width := Max(FImage.Width, FLabel.Width);
  if Width = FImage.Width then
  begin
    FImage.Left := 0;
    FLabel.Left := Round((Width - FLabel.Width) / 2);
  end
  else
  begin
    FLabel.Left := 0;
    FImage.Left := Round((Width - FImage.Width) / 2);
  end;
  Height := FImage.Height + FLabel.Height + 2;
  FLabel.Top := FImage.Height + 2;
  {Recalcula posição do ícone}
  with (Parent as TDesktop) do
  begin
    {se é o primeiro ícone, usa FirstIcon X e Y}
    if Length(FIcones) = 1 then
    begin
      Self.Top := Round(FFirstIconY - Self.Height / 2);
      Self.Left := Round(FFirstIconX - Self.FLabel.Width / 2);
    end
    else
    begin
      {se não, usa a posição do último ícone e o grid}
      {calcula em que coluna está o ícone}
      Coluna :=  Trunc(Length(FIcones) / FGridRows);
      if Frac(Length(FIcones) / FGridRows) <> 0 then
        Coluna := Coluna + 1;
      {calcula em que linha está o ícone}
      Linha := Length(FIcones) - FGridRows * (Coluna - 1);
      Top := Round((FFirstIconY + (Linha - 1) * FGridSizeY) -
                   Self.Height / 2);
      Left := Round((FFirstIconX + (Coluna - 1) * FGridSizeX) -
                    Self.Width / 2);
    end;
  end;
  FCanvasImage.Width := Self.Width;
  FCanvasImage.Height := Self.Height;
  {com o canvasimage, é produzido o efeito de "transparência"}
  with (Parent as TDesktop).WallPaper, FCanvasImage.Canvas do
  begin
    {se há um picture no wallpaper, copia seu canvas para dentro do
     canvasimage}
    if (Assigned(Picture)) and (Assigned(Picture.Graphic)) and
       (not Picture.Graphic.Empty) then
    begin
      CopyRect(Rect(0,0,Self.Width,Self.Height),Canvas,Rect(Self.Left,Self.Top,
               Self.Width + Self.Left,Self.Height + Self.Top));
    end
    else
    begin
      {se não tem um picture, pinta o canvasimage com a cor do desktop}
      Brush.Color := (Parent as TDesktop).Color;
      Brush.Style := bsSolid;
      FillRect(Rect(0,0,FCanvasImage.Width,FCanvasImage.Height));
    end;
  end;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TIcone.SetImageIndex(Value: Integer);
{altera a propriedade ImageIndex}
begin
  FImageIndex := Value;
  if FImageList = nil then
    FImageList := (Parent as TDesktop).ImageList;
  if FImageList <> nil then
    FImageList.GetBitmap(Value,FImage.Picture.Bitmap);
end;

procedure TIcone.SetTexto(Value: String);
{altera a propriedade Texto}
begin
  FTexto := Value;
  FLabel.Caption := Value;
  Redimensiona;
end;

{---------------------------- TIconeItem --------------------------------------}

{.................construtor Create de TIconeItem..............................}
constructor TIconeItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  {inicializa as propriedades do IconeItem}
  FTexto := 'IconeItem' + IntToStr(Index);
  DisplayName := FTexto;
  FImageIndex := -1;
  FHint := '';
  FShowHint := False;
  FVisible := True;
  FIndice := -1;
end;

{---------------------------- TIconeCollection --------------------------------}

{.................construtor Create de TIconeCollection........................}
constructor TIconeCollection.Create(Desktop: TDesktop);
begin
  {o proprietário do iconecollecion é o TDesktop}
  FDesktop := Desktop;
  inherited Create(TIconeItem);
end;

{.................Métodos para promover a funcionalidade...................}

function TIconeCollection.Add: TIconeItem;
begin
  {adiciona um item}
  Result := TIconeItem(inherited Add);
end;

function TIconeCollection.GetItem(Index: Integer): TIconeItem;
begin
  {retorna um item}
  Result := TIconeItem(inherited GetItem(Index));
end;

function TIconeCollection.GetOwner: TPersistent;
begin
  {retorna o Owner do IconeCollecion}
  Result := FDesktop;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TIconeCollection.SetItem(Index: Integer; Value: TIconeItem);
begin
  {altera a propriedade Items}
  inherited SetItem(Index, Value);
end;

{---------------------------- TDesktop ---------------------------------------}

{.................construtor Create de TDesktop...............................}
constructor TDesktop.Create(AOwner: TComponent);
begin
  {executa Create do TCustomPanel}
  inherited Create(AOwner);
  {define suas propriedades}
  Parent := (AOwner as TWinControl);
  Width := Parent.ClientWidth;
  Align := alClient;
  FullRepaint := False;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Height := Parent.ClientHeight;
  Caption := ' ';
  TamanhoIcone := 32;
  LabelColor := clSilver;
  TextColor := clBlack;
  FFirstIconX := 90;
  FFirstIconY := 50;
  FGridSizeX := 150;
  FGridSizeY := 70;
  FGridRows :=  6;
  FGridCols := 5;
  FDesColor := $00373737;
  {cria o papel de parede}
  FWallPaper := TImage.Create(Self);
  with FWallPaper do
  begin
    Parent := Self;
    Transparent := False;
    AutoSize := False;
    Stretch := False;
    Width := Self.Width;
    Height := Self.Height;
    Align := alClient;
  end;
  {cria o IconeCollection - prop. IconeList}
  FIconeCollection := TIconeCollection.Create(Self);
  {atribui o manipulador de evento do Application.OnMessage}
  {permite o "highligth" do ícone selecionado}
  {se já atribuído, salva o manipulador antigo}
  if Assigned(Application.OnMessage) then
    FAppOnMsgOld := Application.OnMessage;
  Application.OnMessage := ApplicationOnMessage;
end;

{.................destrutor Destroy de TDesktop..............................}
destructor TDesktop.Destroy;
begin
  {Limpa o IconeCollection - prop. IconeList}
  FIconeCollection.Clear;
  FIconeCollection.Free;
  {limpa os ícones e o papel de parede}
  ClearIcones;
  FWallPaper.Free;
  Application.OnMessage := nil;
  {executa o método Destroy do TCustomPanel}
  inherited Destroy;
end;

{.................Método para a notificação de TDesktop.......................}
procedure TDesktop.Notification(AComponent: TComponent; Operation: TOperation);
begin
  {executa método herdado}
  inherited Notification(AComponent, Operation);
  {caso algum componente associado ao TDesktop seja removido, preenche a
  propriedade com NIL. As propriedades verificadas: ImageList}
  if Operation = opRemove then
  begin
    if AComponent = FImageList then
      FImageList := nil;
  end;
end;

{.................Métodos para promover a funcionalidade...................}

procedure TDesktop.AddIcone(const Descricao: String; ImageIdx: Integer;
                            AHint: String = '');
var Coluna, Linha: Integer;
begin
  {adiciona um ícone no desktop}
  SetLength(FIcones,Length(FIcones) + 1);
  FIcones[Length(FIcones) - 1] := TIcone.Create(Self);
  FIcones[Length(FIcones) - 1].ImageList := Self.ImageList;
  with FIcones[Length(FIcones) - 1] do
  begin
    Texto := Descricao;
    ImageIndex := ImageIdx;
    FLabel.Color := LabelColor;
    FLabel.Font.Color := TextColor;
    {se é o primeiro ícone, usa FirstIcon X e Y}
    if Length(FIcones) = 1 then
    begin
      Top := Round(FFirstIconY - FIcones[Length(FIcones) - 1].Height / 2);
      Left := Round(FFirstIconX - FIcones[Length(FIcones) - 1].Width / 2);
    end
    else
    begin
      {se não, usa a posição do último ícone e o grid}
      {calcula em que coluna está o ícone}
      Coluna :=  Trunc(Length(FIcones) / FGridRows);
      if Frac(Length(FIcones) / FGridRows) <> 0 then
        Coluna := Coluna + 1;
      {calcula em que linha está o ícone}
      Linha := Length(FIcones) - FGridRows * (Coluna - 1);
      Top := Round((FFirstIconY + (Linha - 1) * FGridSizeY) -
                   FIcones[Length(FIcones) - 1].Height / 2);
      Left := Round((FFirstIconX + (Coluna - 1) * FGridSizeX) -
                    FIcones[Length(FIcones) - 1].Width / 2);
    end;
    FIcones[Length(FIcones) - 1].Hint := AHint;
    FIcones[Length(FIcones) - 1].Refresh;
    FLabel.Hint := AHint;
    FImage.Hint := AHint;
    FCanvasImage.Hint := AHint;
    OnClick := IconeClick;
    FImage.OnClick := IconeClick;
    FLabel.OnClick := IconeClick;
    FCanvasImage.OnClick := IconeClick;
    {provê um "esmaecimento" do ícone desselecionado}
    with FImage, FImage.Canvas do
      CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
  end;
end;

procedure TDesktop.ClearIcones;
var i: Integer;
begin
  {apaga todos os ícones do desktop}
  for i := 0 to Length(FIcones) - 1 do
    FIcones[i].Free;
  SetLength(FIcones,0);
end;

procedure TDesktop.CreateIcones;
var i: Integer;
begin
  {adiciona todos os ícones descritos em "IconeList" (Visible = True)}
  with FIconeCollection do
  begin
    if Count > 0 then
    begin
      for i := 0 to Count - 1 do
      begin
        if Items[i].Visible then
        begin
          AddIcone(Items[i].Caption,Items[i].ImageIndex,Items[i].Hint);
          FIcones[Length(FIcones) - 1].ShowHint := Items[i].ShowHint;
          Items[i].FIndice := Length(FIcones) - 1;
        end;
      end;
    end;
  end;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TDesktop.SetPicture(Value: TPicture);
{altera a propriedade Picture}
begin
  FWallPaper.Picture := Value;
end;

function TDesktop.GetPicture: TPicture;
{lê a propriedade Picture}
begin
  Result := FWallPaper.Picture;
end;

procedure TDesktop.SetTextColor(Value: TColor);
{altera a propriedade TextColor, e aplica em todos os ícones}
var i: Integer;
begin
  FTextColor := Value;
  for i := 0 to Length(FIcones) - 1 do
    FIcones[i].FLabel.Font.Color := Value;
end;

procedure TDesktop.SetLabelColor(Value: TColor);
{altera a propriedade LabelColor, e aplica em todos os ícones}
var i: Integer;
begin
  FLabelColor := Value;
  for i := 0 to Length(FIcones) - 1 do
    FIcones[i].FLabel.Color := Value;
end;

procedure TDesktop.SetImageList(Value: TImageList);
{altera a propriedade ImageList}
begin
  FImageList := Value;
end;

procedure TDesktop.SetIcone(Index: Integer; Value: TIcone);
{altera a propriedade Icones}
begin
  FIcones[Index] := Value;
end;

function TDesktop.GetIcone(Index: Integer): TIcone;
{lê a propriedade Icones}
begin
  Result := FIcones[Index];
end;

{.................Manipuladores de Eventos Internos...........................}

procedure TDesktop.ApplicationOnMessage(var Msg: TMsg; var Handled: Boolean);
var i, xmin, xmax, ymin, ymax: Integer;
    P: TControl;
    FormActive: Boolean;
begin
  {evento OnMessage de TApplication}
  if not Application.Active then
    exit;
  {procura o form pai do TDesktop}
  FormActive := False;
  P := Self;
  while P <> nil do
  begin
    if (P is TForm) then
    begin
      FormActive := (P as TForm).Active;
      break;
    end;
    P := P.Parent;
  end;
  {quando a aplicação recebe uma mensagem do windows, executa esse manipulador}
  {apenas se o form que contém o TDesktop estiver ativo}
  if (Msg.message = WM_MOUSEMOVE) and (FormActive) then
  {se a msg for "MouseMove", verifica se foi um dos ícones}
  begin
    {varre todos os ícones de TDesktop}
    for i := 0 to Length(FIcones) - 1 do
    begin
      with FIcones[i], Msg.pt do
      begin
        xmin := ClientOrigin.x;
        xmax := xmin + Width;
        ymin := ClientOrigin.y;
        ymax := ymin + Height;
        {verifica se o ponto (cursor) onde a msg foi gerada está dentro dos
        limites de um ícone}
        if (x >= xmin) and (x <= xmax) and (y >= ymin) and (y <= ymax) then
        begin
          {se sim, "seleciona" esse ícone, se não estiver selecionado}
          FLabel.Color := clHighlight;
          FLabel.Font.Color := clWhite;
          if not FSelected then
          begin
            with FImage, FImage.Canvas do  {realça o ícone}
              CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
            FSelected := True;
          end;
        end
        else
        begin
          {se não, "desseleciona" esse ícone, se estiver selecionado}
          FLabel.Color := FLabelColor;
          FLabel.Font.Color := FTextColor;
          if FSelected then
          begin
            with FImage, FImage.Canvas do   {"esmaece" o ícone}
              CopyRect(Rect(0,0,Width,Height),Canvas,Rect(0,0,Width,Height));
            FSelected := False;
          end;
        end;
      end;
      Handled := False;
    end;
  end;
  {executa o manipulador desse evento que foi salvo, se houver}
  try
    if Assigned(FAppOnMsgOld) then
      FAppOnMsgOld(Msg,Handled);
  except
    FAppOnMsgOld := nil;
  end;
end;

procedure TDesktop.IconeClick(Sender: TObject);
var P: TControl;
begin
  {evento OnClick dos ícones}
  {procura qual ícone clicado}
  {dispara evento OnCommand}
  P := Sender as TControl;
  while P <> nil do
  begin
    if P is TIcone then
      break;
    P := P.Parent;
  end;
  if (P <> nil) and (P is TIcone) and (Assigned(FOnCommand)) then
    FOnCommand((P as TIcone).Texto,Sender);
end;

{---------------------------- TFormsList -------------------------------------}

{.................construtor Create de TFormsList.............................}
constructor TFormsList.Create;
begin
  {executa método herdado}
  inherited Create;
  {define tamanho 0}
  SetLength(FFormItem,0);
end;

{.................destrutor Destroy de TFormsList.............................}
destructor TFormsList.Destroy;
begin
  {apaga todos elementos de TFormsList}
  Clear;
  {executa método herdado}
  inherited Destroy;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TFormsList.SetFormItem(Index: Integer; Value: TFormItem);
begin
  {altera propriedade FormItem}
  FFormItem[Index] := Value;
end;

function TFormsList.GetFormItem(Index: Integer): TFormItem;
begin
  {lê propriedade FormItem}
  Result := FFormItem[Index];
end;

{.................Métodos para promover a funcionalidade...................}

procedure TFormsList.Add(Command: String; FormVar: TForm;
                         FormClass: TFormClass);
begin
  {adiciona uma entrada que associa uma string (Command) a um form da aplicação
   (FormVar e FormClass) - deve ser executada na aplicação para promover a
   função Launch dos ícones do Desktop para os Forms}
  SetLength(FFormItem,Length(FFormItem) + 1);
  FFormItem[Length(FFormItem) - 1].FormVar := FormVar;
  FFormItem[Length(FFormItem) - 1].FormClass := FormClass;
  FFormItem[Length(FFormItem) - 1].Command := Command;
end;

procedure TFormsList.Clear;
begin
  {apaga todas as associações}
  SetLength(FFormItem,0);
end;

function TFormsList.Count: Integer;
begin
  {retorna o número de entradas de associação adicionadas}
  Result := Length(FFormItem);
end;

procedure TFormsList.Delete(Index: Integer);
var i: Integer;
begin
  {apaga uma entrada de associação}
  if Index < Length(FFormItem) - 1 then
    for i := Index + 1 to Length(FFormItem) - 1 do
      FFormItem[i - 1] := FFormItem[i];
  SetLength(FFormItem,Length(FFormItem) - 1);
end;


{---------------------------- TBBStatusBar -----------------------------------}

{.................constructor Create de TBBStatusBar........................}
constructor TBBStatusBar.Create(AOwner: TComponent);
begin
  {executa Create do TStatusBar}
  inherited Create(AOwner);
  {cria o Timer}
  FTimer := TTimer.Create(Self);
  {configura as propriedades}
  with FTimer do
  begin
    Enabled := False;
    Interval := 500;
    OnTimer := TimerTimer;
  end;
  FActive := False;
  FStart := 0;
  FCount := 0;
  FUsuario := 'NENHUM';
  Width := (AOwner as TWinControl).Width;
  OnResize := BBStatusBarResize;
  {se há um manipulador para Application.OnHint, salva-o}
  if Assigned(Application.OnHint) then
    FOldHint := Application.OnHint;
  {atribui o manipulador interno}
  Application.OnHint := ApplicationHint;
  {cria e configura os painéis}
  Panels.Clear;
  with Panels.Add do
  begin
    Alignment := taLeftJustify;
    Width := Self.Width - 410;
  end;
  with Panels.Add do
  begin
    Alignment := taLeftJustify;
    Text := 'Usuário: NENHUM';
    Width := 180;
  end;
  with Panels.Add do
  begin
    Alignment := taLeftJustify;
    Text := 'Tempo de Login: 00:00:00';
    Width := 140;
  end;
  with Panels.Add do
  begin
    Alignment := taRightJustify;
    Text := FormatDateTime('dd/mm/yyyy',Date);
  end;
end;

{.................destrutor Destroy de TBBStatusBar........................}
destructor TBBStatusBar.Destroy;
begin
  {destrói o TTimer}
  FTimer.Free;
  Application.OnHint := nil;
  {executa método destroy de TStatusBar}
  inherited Destroy;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TBBStatusBar.SetActive(Value: Boolean);
begin
  {altera a propriedade Active}
  FActive := Value;
  {se ativado, zera e liga o timer}
  if FActive then
  begin
    FStart := Now;
    FCount := 0;
    if Panels.Count >= 4 then
    begin
      Panels[1].Text := 'Usuário: ' + FUsuario;
      Panels[2].Text := 'Tempo de Login: 00:00:00';
      Panels[3].Text := FormatDateTime('dd/mm/yyyy',Date);
    end;
    FTimer.Enabled := True;
  end
  else
  begin
    {se não, desliga o Timer}
    FTimer.Enabled := False;
    FCount := 0;
    if Panels.Count >= 4 then
    begin
      Panels[1].Text := 'Usuário: ' + 'NENHUM';
      Panels[2].Text := 'Tempo de Login: 00:00:00';
      Panels[3].Text := FormatDateTime('dd/mm/yyyy',Date);
    end;
  end;
end;

{.................Manipuladores de Eventos Internos...........................}

procedure TBBStatusBar.TimerTimer(Sender: TObject);
begin
  {evento OnTimer do FTimer}
  {atualiza o TBBStatusBar}
  FCount := Now - FStart;
  if Panels.Count >= 4 then
  begin
    Panels[1].Text := 'Usuário: ' + FUsuario;
    Panels[2].Text := 'Tempo de Login: ' + FormatDateTime('hh:mm:ss',FCount);
    Panels[3].Text := FormatDateTime('dd/mm/yyyy',Date);
  end;
end;

procedure TBBStatusBar.ApplicationHint(Sender: TObject);
begin
  {evento OnHint de TApplication}
  if not Application.Active then
    exit;
  {atualiza o painel de Hints}
  if Panels.Count > 0 then
    Panels[0].Text := GetLongHint(Application.Hint);
  if Assigned(FOldHint) then
    FOldHint(Sender);
end;

procedure TBBStatusBar.BBStatusBarResize(Sender: TObject);
begin
  {evento OnResize do TBBStatusBar}
  {redimensiona os painéis}
  if Panels.Count > 0 then
    Panels[0].Width := Self.Width - 410;
end;

{---------------------------- TDesktopLaunch ---------------------------------}

{.................constructor Create de TDesktopLaunch........................}
constructor TDesktopLaunch.Create(AOwner: TComponent);
begin
  {executa Create do TComponent}
  inherited Create(AOwner);
  {cria o TFormsList}
  FFormsList := TFormsList.Create;
end;

{.................destrutor Destroy de TDesktopLaunch........................}
destructor TDesktopLaunch.Destroy;
begin
  {destrói o TFormsList}
  FFormsList.Free;
  {executa método destroy de TComponent}
  inherited Destroy;
end;

{.................Método para a notificação de TDesktopLaunch................}
procedure TDesktopLaunch.Notification(AComponent: TComponent;
                                      Operation: TOperation);
begin
  {executa método herdado}
  inherited Notification(AComponent, Operation);
  {caso algum componente associado ao TDesktopLaunch seja removido, preenche a
  propriedade com NIL. As propriedades verificadas: TaskBar e Desktop}
  if Operation = opRemove then
  begin
    if AComponent = FTaskBar then
      FTaskBar := nil;
    if AComponent = FDesktop then
      FDesktop := nil;
  end;
end;

{.................Métodos para a atribuição de propriedades...................}

procedure TDesktopLaunch.SetDesktop(Value: TDesktop);
begin
  {altera a propriedade Desktop}
  FDesktop := Value;
  if FDesktop <> nil then
  begin
    FDesktop.OnCommand := IHMCommand;
    FDesktop.OnResize := DesktopResize;
  end;
end;

procedure TDesktopLaunch.SetTaskBar(Value: TTaskBar);
begin
  {altera a propriedade TaskBar}
  FTaskBar := Value;
  if FTaskBar <> nil then
  begin
    FTaskBar.OnCommand := IHMCommand;
    FTaskBar.OnPopupCommand := IHMPopupCommand;
  end;
end;

{.................Manipuladores de Eventos Internos...........................}

procedure TDesktopLaunch.IHMCommand(Command: String; Sender: TObject);
var i: Integer;
    CommTmp: String;
begin
  {evento OnCommand do TaskBar e do Desktop}
  CommTmp := Command;
  if Pos('&',CommTmp) <> 0 then
    Delete(CommTmp,Pos('&',CommTmp),1);
  {procura no formslist uma entrada que corresponde ao Command e executa o form}
  for i := 0 to FormsList.Count - 1 do
  begin
    if Trim(UpperCase(FormsList.FormItem[i].Command)) =
        Trim(UpperCase(CommTmp)) then
    begin
      ExecuteForm(i,CommTmp);
      break;
    end;
  end;
  {dispara evento OnCommand}
  if Assigned(FOnCommand) then
    FOnCommand(CommTmp,Self);
end;

procedure TDesktopLaunch.IHMPopupCommand(Command: String; PopupCommand: String;
                                         Sender: TObject);
var i: Integer;
    CommandOK: Integer;
    CommTmp: String;
begin
  {evento OnPopupCommand do TaskBar}
  CommTmp := Command;
  if Pos('&',CommTmp) <> 0 then
    Delete(CommTmp,Pos('&',CommTmp),1);
  {localiza qual form corresponde ao command}
  CommandOK := -1;
  for i := 0 to FormsList.Count - 1 do
  begin
    if Trim(UpperCase(FormsList.FormItem[i].Command)) =
        Trim(UpperCase(CommTmp)) then
    begin
      CommandOK := i;
      break;
    end;
  end;
  if CommandOK = -1 then
    exit;
  {executa o popupcommand especificado}
  with FormsList.FormItem[CommandOK].FormVar do
  begin
    if PopupCommand = '&Fechar' then
    begin
      {fecha o form correspondente}
      Close;
    end
    else if PopupCommand = 'Minimi&zar' then
    begin
      {minimiza todos os forms}
      MinimizeAll;
      {visibiliza o último form criado, menos este, que é minimizado}
      RestoreLast(CommandOK);
    end
    else
    begin
      {minimiza todos os forms}
      MinimizeAll;
      {restaura o form correspondente}
      WindowState := wsNormal;
      Visible := True;
      SetFocus;
      {ativa o botão correspondente}
      FTaskBar.ActiveButton(CommTmp);
    end;
  end;
end;

procedure TDesktopLaunch.FormClose(Sender: TObject; var Action: TCloseAction);
var i: Integer;
begin
  {evento OnClose dos forms relacionados em FormsList}
  {procura qual form deve ser fechado}
  for i := 0 to FormsList.Count - 1 do
  begin
    if FormsList.FormItem[i].FormVar = (Sender as TForm) then
    begin
      {remove o botão correspondente do taskbar}
      if (Assigned(FTaskBar)) then
        FTaskBar.RemoveButton(FormsList.FormItem[i].Command);
      {libera o form}
      Action := caFree;
      FormsList.FFormItem[i].FormVar := nil;
      break;
    end;
  end;
  {visibiliza o último form criado}
  RestoreLast;
end;

procedure TDesktopLaunch.DesktopResize(Sender: TObject);
var i: Integer;
begin
  {evento OnResize do TDesktop}
  if FormsList = nil then
    exit;
  {reposiciona todos os forms abertos}
  for i := 0 to FormsList.Count - 1 do
  begin
    with FormsList.FFormItem[i], FormsList.FFormItem[i].FormVar do
    begin
      if FormVar <> nil then
      begin
        Top := Round((FDesktop.Height - Height) / 2 + FDesktop.ClientOrigin.y);
        Left := Round((FDesktop.Width - Width) / 2 + FDesktop.ClientOrigin.x);
      end;
    end;
  end;
end;

{.................Métodos para promover a funcionalidade...................}

procedure TDesktopLaunch.ExecuteForm(Index: Integer; Command: String);
var TmpForm: TForm;
begin
  {abre um form que corresponde ao Command}
  with FormsList.FFormItem[Index] do
  begin
    if FormVar = nil then
    begin
      {se o form não está criado, cria agora}
      Application.CreateForm(FormClass,TmpForm);
      FormVar := TmpForm;
      TmpForm := nil;
      with FormVar do
      begin
        OnClose := FormClose;
        Position := poScreenCenter;
        FormStyle := fsStayOnTop;
        BorderStyle := bsSingle;
        BorderIcons := [biSystemMenu];
      end;
      {adiciona o botão correspondente na TaskBar}
      if Assigned(FTaskBar) then
      begin
        if Assigned(FormVar.Icon) then
          FTaskBar.AddButton(Command,FormVar.Icon)
        else
          FTaskBar.AddButton(Command,Application.Icon);
      end;
    end;
    {minimiza todos os forms}
    MinimizeAll;
    {visualiza esse form}
    if not FormVar.Visible then
    begin
      FormVar.WindowState := wsNormal;
      FormVar.Visible := True;
      FormVar.SetFocus;
      {ativa o botão correspondente}
      FTaskBar.ActiveButton(Command);
    end;
  end;
end;

procedure TDesktopLaunch.MinimizeAll;
var i: Integer;
begin
  {minimiza todos os forms abertos}
  for i := 0 to FormsList.Count - 1 do
  begin
    if FormsList.FormItem[i].FormVar <> nil then
    begin
      with FormsList.FormItem[i].FormVar do
      begin
        Visible := False;
        WindowState := wsMinimized;
      end;
    end;
  end;
end;

function TDesktopLaunch.RestoreLast(NoRestore: Integer = -1): Boolean;
var i: Integer;
begin
  {visibiliza o último form criado}
  Result := False;
  {varre todas as entradas de FormsList, do último para o primeiro}
  for i := FormsList.Count - 1 downto 0 do
  begin
    if (FormsList.FormItem[i].FormVar <> nil) and
       ((NoRestore = -1) or ((NoRestore > -1) and (i <> NoRestore))) then
    begin
      {se o form está criado (aberto), restaura e visibiliza}
      with FormsList.FormItem[i].FormVar do
      begin
        WindowState := wsNormal;
        Visible := True;
        SetFocus;
        Result := True;
        {ativa o botão correspondente}
        FTaskBar.ActiveButton(FormsList.FormItem[i].Command);
        break;
      end;
    end;
  end;
end;

function TDesktopLaunch.HasFormOpen: Boolean;
var i: Integer;
begin
  {retorna True se tiver algum Form aberto}
  Result := False;
  {procura os forms abertos}
  for i := 0 to FormsList.Count - 1 do
  begin
    if Assigned(FormsList.FormItem[i].FormVar) then
    begin
      Result := True;
      break;
    end;
  end;
end;

end.
