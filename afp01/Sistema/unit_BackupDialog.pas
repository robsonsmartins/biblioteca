{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_BackupDialog.pas

  Contém classes relativas ao Backup do Banco de Dados.

  Usa a biblioteca ZLib (copyright (c) 2000-2001 base2 technologies,
                         copyright (c) 1997 Borland International -
                         http://www.info-zip.org/pub/infozip/zlib.
                         ZLibEx.pas by erik turner)

  Data última revisão: 09/11/2001

******************************************************************************}

{$WARN UNIT_PLATFORM OFF}

unit unit_BackupDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Registry, FileCtrl, ZLibEx,
  unit_Comum, ExtCtrls;

{Tipo - evento OnProgress}
type
  TCompressEvent = procedure (Sender: TObject;
                              Progresso: Byte; Compress: Boolean) of object;

{Classe de Backup}
type
  TBackupBD = class
  private
    { Private declarations }
    FCompressEvent: TCompressEvent;
  public
    { Public declarations }
    BackupPath: String;
    DataBasePath: String;
    BackupSize: Int64;
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
    {verifica disco gravável, no BackupPath}
    function WRDiscoFree: Int64;
    {retorna tamanho do disco}
    function WRDiscoSize: Int64;
    {repete até que a mídia esteja inserida}
    function MidiaInserida: Boolean;
    {comprime arquivo}
    function CompressBD: Boolean;
    {grava arquivos}
    function GravaBackup(NDiscos: Integer): Boolean;
  end;

{Classe do Form}
type
  Tform_BackupBDDialog = class(TForm)
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
    BackupBD: TBackupBD;
    procedure EnableIHC(Executing: Boolean);
  public
    { Public declarations }
  end;

var
  form_BackupBDDialog: Tform_BackupBDDialog;

implementation

{$R *.DFM}

{-------------------- TBackupBD ----------------------------------}

constructor TBackupBD.Create;
begin
  inherited Create;
  LeConfig;
  DataBasePath := ExtractFilePath(Application.ExeName) + 'Database\';
  BackupSize := 0;
end;

procedure TBackupBD.LeConfig;
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
      if (not ValueExists('PastaBackup')) or
         (ReadString('PastaBackup') = '') then
        WriteString('PastaBackup','A:\');
      {lê config. do registro}
      BackupPath := ReadString('PastaBackup');
    finally
      CloseKey;
    end;
    Free;
  end;
end;

procedure TBackupBD.GravaConfig;
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
      WriteString('PastaBackup',BackupPath);
    finally
      CloseKey;
    end;
    Free;
  end;
end;

procedure TBackupBD.BrowsePath;
var TmpStr: String;
begin
  {abre diálogo de seleção da pasta}
  SelectDirectory('Selecione a Pasta onde será gravada a Cópia de Segurança ' +
               'do Banco de Dados do Sistema Biblioteca','Desktop',TmpStr);
  if TmpStr <> '' then
  begin
    BackupPath := TmpStr;
    if BackupPath[Length(BackupPath)] <> '\' then
      BackupPath := BackupPath + '\';
    GravaConfig;
  end;
end;

function TBackupBD.WRDiscoFree: Int64;
var Letra: String[1];
    F: TextFile;
begin
  {retorna a quantidade livre (Bytes) do disco do BackupPath}
  {retorna -1 se o disco não é válido,
  -(qtdespaço) se não é RW ou 2 se não é unidade local}
  Screen.Cursor := crHourGlass;
  Letra := UpperCase(Copy(BackupPath,1,1));
  {calcula espaço livre}
  if not (Ord(Letra[1]) in [65..90]) then {A..Z}
    Result := 2  {drive de rede, não dá para saber o espaço}
  else
    Result := DiskFree(Ord(Letra[1]) - 64);
  {testa gravação}
  if Result <> -1 then
  begin
    try
      {$I-}
      AssignFile(F,BackupPath + 'tmp.tmp');
      Rewrite(F);
      {$I+}
      if IOResult <> 0 then
        Result := Abs(Result) * (-1);
      {$I-}
      CloseFile(F);
      {$I+}
      DeleteFile(BackupPath + 'tmp.tmp');
    except
      Result := Abs(Result) * (-1);
    end;
  end;
  Screen.Cursor := crDefault;
end;

function TBackupBD.WRDiscoSize: Int64;
var Letra: String[1];
begin
  {retorna o tamanho (Bytes) do disco do BackupPath}
  {retorna -1 se o disco não é válido, 2 se não é unidade local}
  Screen.Cursor := crHourGlass;
  Letra := UpperCase(Copy(BackupPath,1,1));
  {calcula tamanho}
  if not (Ord(Letra[1]) in [65..90]) then {A..Z}
    Result := 2  {drive de rede, não dá para saber o espaço}
  else
    Result := DiskSize(Ord(Letra[1]) - 64);
  Screen.Cursor := crDefault;
end;

function TBackupBD.MidiaInserida: Boolean;
var Letra: String[1];
    TmpStr: String;
    sr: TSearchRec;
begin
  {verifica mídia}
  Letra := UpperCase(Copy(BackupPath,1,1));
  Result := True;
  ShortDateFormat := 'ddmmyyyy';
  TmpStr := BackupPath + DateToStr(Date) + '.*';
  ShortDateFormat := 'dd/mm/yyyy';
  while (WRDiscoFree < 0) or
        ((WRDiscoFree < BackupSize) and (WRDiscoFree < WRDiscoSize)) or
        (FindFirst(TmpStr,faAnyFile,sr) = 0) do
  begin
    with Application do
    begin
      if FindFirst(TmpStr,faAnyFile,sr) = 0 then
      begin
        FindClose(sr);
        if MessageBox(PChar(MSG_EXISTBAK + MSG_INSDISCO + Letra[1] +
                      MSG_INSDISCO2),
                      CAP_INSDISCO, MB_OKCANCELWARNING) = IDCANCEL then
        begin
          Result := False;
          exit;
        end;
      end
      else
      begin
        FindClose(sr);
        if MessageBox(PChar(MSG_INSDISCO + Letra[1] + MSG_INSDISCO2),
                      CAP_INSDISCO, MB_OKCANCELWARNING) = IDCANCEL then
        begin
          Result := False;
          exit;
        end;
      end;
    end;
  end;
end;

function TBackupBD.CompressBD: Boolean;
var Orig, Dest: TFileStream;
    ZComp: TZCompressionStream;
    Buf: Array [0..102399] of Byte; {100 KB}
    qtdBytes: Integer;
    F: File of Byte;
begin
  Result := True;
  Screen.Cursor := crHourGlass;
  {comprime o arquivo do BD, usando a ZLib}
  {comprimindo em arquivo Temp}
  try
    Orig := TFileStream.Create(DataBasePath + 'biblio.mdb',fmOpenRead);
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROLEBAK + E.Message),
                   CAP_ERROBAKALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  try
    Dest := TFileStream.Create(DataBasePath + 'biblio.tmp',fmCreate);
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROTMPBAK + E.Message),
                   CAP_ERROBAKALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  try
    ZComp := TZCompressionStream.Create(Dest,zcMax); {compressão máxima}
    repeat
      qtdBytes := Orig.Read(Buf,SizeOf(Buf));
      ZComp.Write(Buf,qtdBytes);
      {dispara evento OnProgress}
      if Assigned(FCompressEvent) then
        FCompressEvent(Self,Byte(Round(Orig.Position / Orig.Size * 100)),True);
    until qtdBytes = 0;
  except
    on E: Exception do
    begin
      Screen.Cursor := crDefault;
      with Application do
        MessageBox(PChar(MSG_ERROZIPBAK + E.Message),
                   CAP_ERROBAKALL,MB_OKICONSTOP);
      Result := False;
      exit;
    end;
  end;
  Screen.Cursor := crDefault;
  ZComp.Free;
  Dest.Free;
  Orig.Free;
  {calcula tamanho do arquivo}
  try
    AssignFile(F,DataBasePath + 'biblio.tmp');
    Reset(F);
    BackupSize := FileSize(F);
    CloseFile(F);
  except
    BackupSize := 0;
  end;
end;

function TBackupBD.GravaBackup(NDiscos: Integer): Boolean;
var Disco: Integer;
    Orig, Dest: TFileStream;
    Buf: Array [0..102399] of Byte; {100 KB}
    qtdBytes, TotalBytes: Integer;
    TmpStr: String;
    FreeSpace: Int64;
begin
  Result := True;
  Disco := 1;
  Orig := TFileStream.Create(DataBasePath + 'biblio.tmp',fmOpenRead);
  {dispara evento OnProgress}
  if Assigned(FCompressEvent) then
    FCompressEvent(Self,0,False);
  repeat
    if NDiscos > 1 then
    begin
      {pede a mídia}
      with Application do
      begin
        if MessageBox(PChar(MSG_INSDISCON + IntToStr(Disco) + ' de ' +
                      IntToStr(NDiscos) + MSG_INSDISCON2), CAP_INSDISCON,
                      MB_OKCANCELWARNING) = IDCANCEL then
        begin
          Result := False;
          Orig.Free;
          DeleteFile(DataBasePath + 'biblio.tmp');
          exit;
        end;
      end;
    end;
    {verifica se ela está pronta}
    if not MidiaInserida then
    begin
      Result := False;
      Orig.Free;
      DeleteFile(DataBasePath + 'biblio.tmp');
      exit;
    end;
    {gravando na mídia}
    Screen.Cursor := crHourGlass;
    ShortDateFormat := 'ddmmyyyy';
    TmpStr := IntToStr(Disco);
    if Length(TmpStr) = 1 then
      TmpStr := '00' + TmpStr;
    if Length(TmpStr) = 2 then
      TmpStr := '0' + TmpStr;
    TmpStr := BackupPath + DateToStr(Date) + '.' + TmpStr;
    ShortDateFormat := 'dd/mm/yyyy';
    FreeSpace := WRDiscoFree;
    Dest := TFileStream.Create(TmpStr,fmCreate);
    {primeiro byte: Volume / segundo byte: Numero de Volumes}
    TotalBytes := 2;
    Buf[0] := Byte(Disco);
    Buf[1] := Byte(NDiscos);
    Dest.Write(Buf,2);
    repeat
      qtdBytes := Orig.Read(Buf,SizeOf(Buf));
      Dest.Write(Buf,qtdBytes);
      TotalBytes := TotalBytes + qtdBytes;
      {dispara evento OnProgress}
      if Assigned(FCompressEvent) then
        FCompressEvent(Self,Byte(Round(Orig.Position / Orig.Size * 100)),False);
      if qtdBytes = 0 then
        break;
    until (TotalBytes + SizeOf(Buf)) > FreeSpace;
    Screen.Cursor := crDefault;
    Inc(Disco);
    Dest.Free;
  until Disco > NDiscos;
  Orig.Free;
  DeleteFile(DataBasePath + 'biblio.tmp');
end;

{-------------------- Tform_BackupBDDialog ---------------------------}

procedure Tform_BackupBDDialog.btn_ProcurarClick(Sender: TObject);
begin
  BackupBD.BrowsePath;
  Label_Pasta.Caption := BackupBD.BackupPath;
end;

procedure Tform_BackupBDDialog.btn_OKClick(Sender: TObject);
var
  NDiscos: Integer;
begin
  {criar backup}
  EnableIHC(True);
  {comprimindo}
  Label_Progresso.Caption := 'Comprimindo Arquivo...';
  Repaint;
  with BackupBD do
  begin
    if not CompressBD then
    begin
      EnableIHC(False);
      exit;
    end;
    {verificando espaço livre e n discos}
    Label_Progresso.Caption := 'Verificando espaço em disco...';
    Label_Porcento.Caption := '0 %';
    ProgressBar_Total.Position := 0;
    Repaint;
    NDiscos := 1;
    if WRDiscoFree <> 2 then {<> rede}
    begin
      if not MidiaInserida then
      begin
        EnableIHC(False);
        exit;
      end;
      Label_Porcento.Caption := '100 %';
      ProgressBar_Total.Position := 100;
      Repaint;
      NDiscos := Round(BackupSize / WRDiscoFree);
      if NDiscos < 1 then
        NDiscos := 1;
    end;
    {se mais de 1 disco, informa NDiscos}
    if NDiscos > 1 then
    begin
      with Application do
      begin
        if MessageBox(PChar(MSG_VDSKBAK + IntToStr(NDiscos) + MSG_VDSKBAK2),
                      CAP_VDSKBAK, MB_YESNOQUESTIONDEFYES) = IDNO then
        begin
          EnableIHC(False);
          exit;
        end;
      end;
    end;
    Label_Progresso.Caption := 'Gravando ' + IntToStr(NDiscos) + ' disco(s)...';
    Repaint;
    if GravaBackup(NDiscos) then
      Application.MessageBox(MSG_OKBAK,CAP_OKBAK,MB_OKINFORMATION);
    EnableIHC(False);
  end;
end;

procedure Tform_BackupBDDialog.FormCreate(Sender: TObject);
begin
  {inicia variáveis}
  BackupBD := TBackupBD.Create;
  BackupBD.OnProgress := BackupBDProgress;
  EnableIHC(False);
  Label_Pasta.Caption := BackupBD.BackupPath;
end;

procedure Tform_BackupBDDialog.FormDestroy(Sender: TObject);
begin
  {destrói o objeto BackupBD}
  BackupBD.Free;
end;

procedure Tform_BackupBDDialog.BackupBDProgress(Sender: TObject;
                                            Progresso: Byte; Compress: Boolean);
begin
  {exibe o progresso}
  Label_Porcento.Caption := IntToStr(Progresso) + ' %';
  ProgressBar_Total.Position := Progresso;
  Repaint;
end;

procedure Tform_BackupBDDialog.EnableIHC(Executing: Boolean);
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
