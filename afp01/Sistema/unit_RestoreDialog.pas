{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_RestoreDialog.pas

  Contém classes relativas ao Restore do Banco de Dados.

  Usa a biblioteca ZLib (copyright (c) 2000-2001 base2 technologies,
                         copyright (c) 1997 Borland International -
                         http://www.info-zip.org/pub/infozip/zlib.
                         ZLibEx.pas by erik turner)

  Data última revisão: 09/11/2001

******************************************************************************}

{$WARN UNIT_PLATFORM OFF}

unit unit_RestoreDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Registry, FileCtrl, ZLibEx,
  unit_Comum, ExtCtrls;

{Tipo - evento OnProgress}
type
  TCompressEvent = procedure (Sender: TObject;
                              Progresso: Byte; Compress: Boolean) of object;

{Classe de Restore}
type
  TRestoreBD = class
  private
    { Private declarations }
    FCompressEvent: TCompressEvent;
  public
    { Public declarations }
    BackupPath: String;
    DataBasePath: String;
    DiscoIns: Integer;
    QtdDiscos: Integer;
    DataBackup: TDate;
    {evento OnProgress}
    property OnProgress: TCompressEvent read FCompressEvent
                                        write FCompressEvent;
    {construtor Create}
    constructor Create;
    {Lê config. do Registro}
    procedure LeConfig;
    {Grava config. do Registro}
    procedure GravaConfig;
    {Procura pasta}
    procedure BrowsePath;
    {verifica disco, no BackupPath}
    function DiscoFree: Int64;
    {repete até que a mídia esteja inserida}
    function MidiaInserida: Boolean;
    {comprime arquivo}
    function DecompressBD: Boolean;
    {lê arquivos}
    function LeBackup: Boolean;
  end;

{Classe do Form}
type
  Tform_RestoreBDDialog = class(TForm)
    GroupBox_Principal: TGroupBox;
    btn_Procurar: TBitBtn;
    Label_Pasta: TLabel;
    Label_Titulo: TLabel;
    GroupBox_Progresso: TGroupBox;
    ProgressBar_Total: TProgressBar;
    Label_Porcento: TLabel;
    Label_Progresso: TLabel;
    btn_OK: TBitBtn;
    btn_Fechar: TBitBtn;
    Image1: TImage;
    procedure btn_ProcurarClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BackupBDProgress(Sender: TObject; Progresso: Byte;
                               Compress: Boolean);
  private
    { Private declarations }
    RestoreBD: TRestoreBD;
    procedure EnableIHC(Executing: Boolean);
  public
    { Public declarations }
  end;

var
  form_RestoreBDDialog: Tform_RestoreBDDialog;

implementation

uses unit_BackupDialog;

{$R *.DFM}

{-------------------- TRestoreBD ----------------------------------}

constructor TRestoreBD.Create;
begin
  inherited Create;
  LeConfig;
  DataBasePath := ExtractFilePath(Application.ExeName) + 'Database\';
  DiscoIns := 0;
  QtdDiscos := 0;
  DataBackup := Date;
end;

procedure TRestoreBD.LeConfig;
var Reg: TRegistry;
begin
  {Lê config. do Registro}
  Reg := TRegistry.Create;
  with Reg do
  begin
    {config. para cada usuário}
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('\Software\FBAI\Sistema Biblioteca',True);
      if (not ValueExists('PastaRestore')) or
         (ReadString('PastaRestore') = '') then
        WriteString('PastaRestore','A:\');
      {lê config. do registro}
      BackupPath := ReadString('PastaRestore');
    finally
      CloseKey;
    end;
    Free;
  end;
end;

procedure TRestoreBD.GravaConfig;
var Reg: TRegistry;
begin
  {Grava config. do Registro}
  Reg := TRegistry.Create;
  with Reg do
  begin
    {config. para cada usuário}
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('\Software\FBAI\Sistema Biblioteca',True);
      WriteString('PastaRestore',BackupPath);
    finally
      CloseKey;
    end;
    Free;
  end;
end;

procedure TRestoreBD.BrowsePath;
var TmpStr: String;
begin
  {abre diálogo de seleção da pasta}
  SelectDirectory('Selecione a Pasta de onde será restaurada a Cópia de ' +
                  'Segurança do Banco de Dados do Sistema Biblioteca',
                  'Desktop',TmpStr);
  if TmpStr <> '' then
  begin
    BackupPath := TmpStr;
    if BackupPath[Length(BackupPath)] <> '\' then
      BackupPath := BackupPath + '\';
    GravaConfig;
  end;
end;

function TRestoreBD.DiscoFree: Int64;
var Letra: String[1];
begin
  {retorna a quantidade livre (Bytes) do disco do BackupPath}
  {retorna -1 se o disco não é válido, 2 se não é unidade local}
  Screen.Cursor := crHourGlass;
  Letra := UpperCase(Copy(BackupPath,1,1));
  {calcula espaço livre}
  if not (Ord(Letra[1]) in [65..90]) then {A..Z}
    Result := 2  {drive de rede, não dá para saber o espaço}
  else
    Result := DiskFree(Ord(Letra[1]) - 64);
  Screen.Cursor := crDefault;
end;

function TRestoreBD.MidiaInserida: Boolean;
var Letra: String[1];
    TmpStr: String;          
    sr: TSearchRec;          
    ArqValido: Boolean;
    F: File of Byte;
    TmpByte: Byte;
begin
  {verifica mídia}
  Letra := UpperCase(Copy(BackupPath,1,1));
  Result := True;
  ArqValido := False;
  TmpStr := BackupPath + '????????.???';
  while (DiscoFree < 0) or (not ArqValido) do
  begin
    with Application do
    begin
      if FindFirst(TmpStr,faAnyFile,sr) = 0 then
      begin
        repeat
          TmpStr :=
            Copy(sr.Name,1,2) + '/' + Copy(sr.Name,3,2) + '/' + Copy(sr.Name,5,4);
          try
            DataBackup := StrToDate(TmpStr);
            ArqValido := True;
          except
            ArqValido := False;
          end;
        until (FindNext(sr) <> 0) or ArqValido;
      end;
      if ArqValido then
      begin
        try
          AssignFile(F,BackupPath + sr.Name);
          Reset(F);
          Read(F,TmpByte);
          DiscoIns := TmpByte;
          Read(F,TmpByte);
          QtdDiscos := TmpByte;
        except
          ArqValido := False;
        end;
        CloseFile(F);
      end;
      FindClose(sr);
      if not ArqValido then
      begin
        if MessageBox(PChar(MSG_INSDISCOR + Letra[1] + MSG_INSDISCO2),
                      CAP_INSDISCO, MB_OKCANCELWARNING) = IDCANCEL then
        begin
          Result := False;
          exit;
        end;
      end;
    end;
  end;
end;

function TRestoreBD.DecompressBD: Boolean;
var Orig, Dest: TFileStream;
    ZComp: TZDecompressionStream;
    Buf: Array [0..102399] of Byte; {100 KB}
    qtdBytes: Integer;
begin
  Result := True;
  Screen.Cursor := crHourGlass;
  {descomprime o arquivo do BD, usando a ZLib}
  {descomprimindo o arquivo do Temp}
  try
    Orig := TFileStream.Create(DataBasePath + 'biblio.tmp',fmOpenRead);
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROLERE + E.Message),
                   CAP_ERROREALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  try
    Dest := TFileStream.Create(DataBasePath + 'biblio.mdb',fmCreate);
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROTMPRE + E.Message),
                   CAP_ERROREALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  try
    ZComp := TZDecompressionStream.Create(Orig);
    repeat
      qtdBytes := ZComp.Read(Buf,SizeOf(Buf));
      Dest.Write(Buf,qtdBytes);
      {dispara evento OnProgress}
      if Assigned(FCompressEvent) then
        FCompressEvent(Self,Byte(Round(Orig.Position / Orig.Size * 100)),True);
    until qtdBytes = 0;
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROZIPRE + E.Message),
                   CAP_ERROREALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  Screen.Cursor := crDefault;
  ZComp.Free;
  Dest.Free;
  Orig.Free;
  DeleteFile(DataBasePath + 'biblio.tmp');
end;

function TRestoreBD.LeBackup: Boolean;
var Disco: Integer;
    NDiscos: Integer;
    Orig, Dest: TFileStream;
    Buf: Array [0..102399] of Byte; {100 KB}
    qtdBytes: Integer;
    TmpStr: String;
begin
  Result := True;
  Disco := 1;
  NDiscos := 1;
  Dest := TFileStream.Create(DataBasePath + 'biblio.tmp',fmCreate);
  {dispara evento OnProgress}
  if Assigned(FCompressEvent) then
    FCompressEvent(Self,0,False);
  repeat
    repeat
      {pede a mídia - disco Disco}
      with Application do
      begin
        if MessageBox(PChar(MSG_INSDISCONRE + IntToStr(Disco) +
                      MSG_INSDISCON2), CAP_INSDISCON,
                      MB_OKCANCELWARNING) = IDCANCEL then
        begin
          Result := False;
          Dest.Free;
          DeleteFile(DataBasePath + 'biblio.tmp');
          exit;
        end;
      end;
      {verifica se mídia está pronta}
      if not MidiaInserida then
      begin
        Result := False;
        Dest.Free;
        DeleteFile(DataBasePath + 'biblio.tmp');
        exit;
      end;
    until DiscoIns = Disco;
    if Disco = 1 then
      NDiscos := QtdDiscos;
    {lendo da mídia}
    Screen.Cursor := crHourGlass;
    ShortDateFormat := 'ddmmyyyy';
    TmpStr := IntToStr(Disco);
    if Length(TmpStr) = 1 then
      TmpStr := '00' + TmpStr;
    if Length(TmpStr) = 2 then
      TmpStr := '0' + TmpStr;
    TmpStr := BackupPath + DateToStr(DataBackup) + '.' + TmpStr;
    ShortDateFormat := 'dd/mm/yyyy';
    Orig := TFileStream.Create(TmpStr,fmOpenRead);
    {primeiro byte: Volume / segundo byte: Numero de Volumes}
    Orig.Read(Buf,2);
    repeat
      qtdBytes := Orig.Read(Buf,SizeOf(Buf));
      Dest.Write(Buf,qtdBytes);
      {dispara evento OnProgress}
      if Assigned(FCompressEvent) then
        FCompressEvent(Self,Byte(Round(Orig.Position / Orig.Size * 100)),False);
    until qtdBytes = 0;
    Screen.Cursor := crDefault;
    Inc(Disco);
    Orig.Free;
  until Disco > NDiscos;
  Dest.Free;
end;

{-------------------- Tform_BackupBDDialog ---------------------------}

procedure Tform_RestoreBDDialog.btn_ProcurarClick(Sender: TObject);
begin
  RestoreBD.BrowsePath;
  Label_Pasta.Caption := RestoreBD.BackupPath;
end;

procedure Tform_RestoreBDDialog.btn_OKClick(Sender: TObject);
begin
  {ler backup}
  EnableIHC(True);
  with Application do
  begin
    if MessageBox(MSG_RESTAURAR,CAP_RESTAURAR,MB_YESNOQUESTION) = IDNO then
    begin
      EnableIHC(False);
      exit;
    end;
  end;
  {lê backup}
  Label_Progresso.Caption := 'Lendo Disco(s)...';
  Repaint;
  with RestoreBD do
  begin
    if not LeBackup then
    begin
      EnableIHC(False);
      exit;
    end;
    {descomprimindo}
    Label_Progresso.Caption := 'Descomprimindo Arquivo...';
    Repaint;
    if not DecompressBD then
    begin
      EnableIHC(False);
      exit;
    end;
    Application.MessageBox(MSG_OKRE,CAP_OKBAK,MB_OKINFORMATION);
    EnableIHC(False);
  end;
end;

procedure Tform_RestoreBDDialog.FormCreate(Sender: TObject);
begin
  {inicia variáveis}
  RestoreBD := TRestoreBD.Create;
  RestoreBD.OnProgress := BackupBDProgress;
  EnableIHC(False);
  Label_Pasta.Caption := RestoreBD.BackupPath;
end;

procedure Tform_RestoreBDDialog.FormDestroy(Sender: TObject);
begin
  {destrói o objeto RestoreBD}
  RestoreBD.Free;
end;

procedure Tform_RestoreBDDialog.BackupBDProgress(Sender: TObject;
                                            Progresso: Byte; Compress: Boolean);
begin
  {exibe o progresso}
  Label_Porcento.Caption := IntToStr(Progresso) + ' %';
  ProgressBar_Total.Position := Progresso;
  Repaint;
end;

procedure Tform_RestoreBDDialog.EnableIHC(Executing: Boolean);
begin
  {habilita / desabilita componentes visuais}
  btn_Procurar.Enabled := not Executing;
  btn_OK.Enabled := not Executing;
  btn_Fechar.Enabled := not Executing;
  Label_Porcento.Caption := '0 %';
  Label_Progresso.Caption := '';
  Label_Porcento.Visible := Executing;
  Label_Progresso.Visible := Executing;
  ProgressBar_Total.Position := 0;
end;

end.
