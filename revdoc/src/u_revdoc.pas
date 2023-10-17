unit u_revdoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Buttons, ShellAPI, ImgList, ComCtrls, ToolWin, ExtCtrls;

type
  TForm_Revdoc = class(TForm)
    SaveDialog: TSaveDialog;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Grid_Revs: TStringGrid;
    Grid_Docs: TStringGrid;
    Panel3: TPanel;
    Label2: TLabel;
    ToolBar1: TToolBar;
    Button_Abrir: TToolButton;
    Button_Copiar: TToolButton;
    Button_Gerar: TToolButton;
    Button_Sobre: TToolButton;
    Button_Atualizar: TToolButton;
    Button_RevDoc: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure Grid_DocsClick(Sender: TObject);
    procedure Button_AbrirClick(Sender: TObject);
    procedure Button_CopiarClick(Sender: TObject);
    procedure Grid_RevsDblClick(Sender: TObject);
    procedure Button_GerarClick(Sender: TObject);
    procedure Button_SobreClick(Sender: TObject);
    procedure Button_RevDocClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Revdoc: TForm_Revdoc;

implementation

uses u_alteracoes, u_gerarwiz0, u_gerarwiz1, u_gerarwiz2, u_gerarwiz3,
  u_gerarwiz4, u_gerarwiz5, u_gerarwiz6, u_about, u_gerarwiz7;

{$R *.DFM}

procedure LeRevisao(NomeArq: String);
var F: TextFile;
    TmpStr: String;
begin
  with Form_RevDoc do
  begin
    //Lê os arquivos .rvd de cada revisão
    Grid_Revs.Cells[3,Grid_Revs.RowCount - 1] := '';
    TmpStr := Copy(ExtractFileName(NomeArq),Length(ExtractFileName(NomeArq)) - 4, 1);
    Grid_Revs.Cells[0,Grid_Revs.RowCount - 1] := UpperCase(TmpStr);
    Grid_Revs.Cells[2,Grid_Revs.RowCount - 1] := ExtractFileName(NomeArq);
    try
      AssignFile(F,NomeArq);
      Reset(F);
      repeat
        ReadLn(F,TmpStr);
      until UpperCase(TmpStr) = '[DATA]';
      ReadLn(F,TmpStr);
      Grid_Revs.Cells[1,Grid_Revs.RowCount - 1] := TmpStr;
      repeat
        ReadLn(F,TmpStr);
      until UpperCase(TmpStr) = '[ALTERACAO]';
      repeat
        ReadLn(F,TmpStr);
        Grid_Revs.Cells[3,Grid_Revs.RowCount - 1] := Grid_Revs.Cells[3,Grid_Revs.RowCount - 1] + ' ' + TmpStr;
      until Eof(F);
      CloseFile(F);
    except
      ShowMessage('Erro ao ler o arquivo ' + NomeArq);
    end;
  end;
end;

procedure TForm_Revdoc.FormShow(Sender: TObject);
var SearchRec: TSearchRec;
    AppDir: String;
    idx: Integer;
    F: TextFile;
    TmpStr: String;
    j, i: Integer;
begin
  //Apaga Tudo
  Grid_Revs.Rows[1].Clear;
  Grid_Revs.RowCount := 2;
  Grid_Docs.Rows[1].Clear;
  Grid_Docs.RowCount := 2;
  // Títulos das Colunas
  Grid_Docs.Cells[0,0] := 'Código Documento';
  Grid_Docs.Cells[1,0] := 'Nome Documento';
  Grid_Docs.Cells[2,0] := 'Título Documento';
  Grid_Revs.Cells[0,0] := 'Revisão';
  Grid_Revs.Cells[1,0] := 'Data';
  Grid_Revs.Cells[2,0] := 'Arquivo';
  Grid_Revs.Cells[3,0] := 'Alterações';
  // Recupera os documentos
  // Lê os diretórios
  AppDir := ExtractFilePath(Application.ExeName);
  if FindFirst(AppDir + '*.*',(faReadOnly + faDirectory),SearchRec) = 0 then
  begin
    if (FileGetAttr(AppDir + SearchRec.Name) and $10 = faDirectory) and
       (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
       (UpperCase(Copy(SearchRec.Name,1,6)) <> 'REVDOC') then
      Grid_Docs.Cells[0,1] := UpperCase(SearchRec.Name)
    else
    begin
      while FindNext(SearchRec) = 0 do
      begin
        if (FileGetAttr(AppDir + SearchRec.Name) and $10 = faDirectory) and
           (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
           (UpperCase(Copy(SearchRec.Name,1,6)) <> 'REVDOC') then
        begin
          Grid_Docs.Cells[0,1] := UpperCase(SearchRec.Name);
          break;
        end;
      end;
    end;
  end;
  while FindNext(SearchRec) = 0 do
  begin
    if (FileGetAttr(AppDir + SearchRec.Name) and $10 = faDirectory) and
       (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
       (UpperCase(Copy(SearchRec.Name,1,6)) <> 'REVDOC') then
    begin
      Grid_Docs.RowCount := Grid_Docs.RowCount + 1;
      Grid_Docs.Cells[0,Grid_Docs.RowCount - 1] := UpperCase(SearchRec.Name);
    end;
  end;
  FindClose(SearchRec);
  if Grid_Docs.Cells[0,1] = '' then exit;
  //Ordena nomes dos docs alfabeticamente
  for j := Grid_Docs.RowCount - 2 downto 1 do
  begin
    for i := 1 to j do
    begin
      if Grid_Docs.Cells[0,i] > Grid_Docs.Cells[0,i + 1] then
      begin
        TmpStr := Grid_Docs.Cells[0,i + 1];
        Grid_Docs.Cells[0,i + 1] := Grid_Docs.Cells[0,i];
        Grid_Docs.Cells[0,i] := TmpStr;
      end;
    end;
  end;
  //Lê as características dos docs
  for idx := 1 to Grid_Docs.RowCount - 1 do
  begin
    try
      AssignFile(F,AppDir + Grid_Docs.Cells[0,idx] + '\revdoc.rvd');
      Reset(F);
      ReadLn(F,TmpStr);
      Grid_Docs.Cells[1,idx] := TmpStr;
      ReadLn(F,TmpStr);
      Grid_Docs.Cells[2,idx] := TmpStr;
      CloseFile(F);
    except
      ShowMessage('Erro ao ler o arquivo ' + AppDir + Grid_Docs.Cells[0,idx] + '\revdoc.rvd');
    end;
  end;
  // Mostra as Revisões do Doc já selecionado
  if FindFirst(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\*.rvd',faAnyFile,SearchRec) = 0 then
  begin
    if SearchRec.Name <> 'revdoc.rvd' then
      LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name)
    else
    begin
      while FindNext(SearchRec) = 0 do
      begin
        if SearchRec.Name <> 'revdoc.rvd' then
        begin
          LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name);
          break;
        end;
      end;
    end;
  end;
  while FindNext(SearchRec) = 0 do
  begin
    if SearchRec.Name <> 'revdoc.rvd' then
    begin
      Grid_Revs.RowCount := Grid_Revs.RowCount + 1;
      LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name)
    end;
  end;
  FindClose(SearchRec);
end;

procedure TForm_Revdoc.Grid_DocsClick(Sender: TObject);
var SearchRec: TSearchRec;
    AppDir: String;
begin
  // Apaga o conteúdo do grid de revisões
  Grid_Revs.Rows[1].Clear;
  Grid_Revs.RowCount := 2;
  // Mostra as Revisões do Doc selecionado
  AppDir := ExtractFilePath(Application.ExeName);
  if FindFirst(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\*.rvd',faAnyFile,SearchRec) = 0 then
  begin
    if SearchRec.Name <> 'revdoc.rvd' then
      LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name)
    else
    begin
      while FindNext(SearchRec) = 0 do
      begin
        if SearchRec.Name <> 'revdoc.rvd' then
        begin
          LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name);
          break;
        end;
      end;
    end;
  end;
  while FindNext(SearchRec) = 0 do
  begin
    if SearchRec.Name <> 'revdoc.rvd' then
    begin
      Grid_Revs.RowCount := Grid_Revs.RowCount + 1;
      LeRevisao(AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\' + SearchRec.Name)
    end;
  end;
  FindClose(SearchRec);
end;

procedure TForm_Revdoc.Button_AbrirClick(Sender: TObject);
var NomeDoc: String;
    AppDir: String;
    ArqDir: String;
    SearchRec: TSearchRec;
    Erro: Longint;
begin
  //Abre o documento no aplicativo ao qual ele está associado
  if Grid_Revs.Cells[0,Grid_Revs.Row] = '' then
  begin
    ShowMessage('Não há uma revisão disponível para ser aberta');
    exit;
  end;
  AppDir := ExtractFilePath(Application.ExeName);
  ArqDir := AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\';
  NomeDoc := ArqDir + Copy(Grid_Revs.Cells[2,Grid_Revs.Row],1,Length(Grid_Revs.Cells[2,Grid_Revs.Row]) - 3) + '*';
  if FindFirst(NomeDoc,faAnyFile,SearchRec) <> 0 then
  begin
    ShowMessage('Erro ao abrir o arquivo ' + SearchRec.Name);
    FindClose(SearchRec);
    exit;
  end;
  if UpperCase(ExtractFileExt(SearchRec.Name)) = '.RVD' then
  begin
    repeat
      if FindNext(SearchRec) <> 0 then
      begin
        ShowMessage('Erro ao abrir o arquivo ' + SearchRec.Name);
        FindClose(SearchRec);
        exit;
      end;
    until UpperCase(ExtractFileExt(SearchRec.Name)) <> '.RVD';
  end;
  Repaint;
  Erro := ShellExecute(Application.Handle,PChar('open'),PChar(ArqDir + SearchRec.Name),PChar(''),PChar(ArqDir),0);
  if Erro < 33 then
    ShowMessage('Erro ' + IntToStr(Erro) + ' ao abrir o arquivo ' + ArqDir + SearchRec.Name);
  FindClose(SearchRec);
end;

procedure TForm_Revdoc.Button_CopiarClick(Sender: TObject);
var NomeDoc: String;
    AppDir: String;
    ArqDir: String;
    SearchRec: TSearchRec;
    Origem, Destino: String;
begin
  //Copia o documento para outro local
  if Grid_Revs.Cells[0,Grid_Revs.Row] = '' then
  begin
    ShowMessage('Não há uma revisão disponível para ser aberta');
    exit;
  end;
  AppDir := ExtractFilePath(Application.ExeName);
  ArqDir := AppDir + Grid_Docs.Cells[0,Grid_Docs.Row] + '\';
  NomeDoc := ArqDir + Copy(Grid_Revs.Cells[2,Grid_Revs.Row],1,Length(Grid_Revs.Cells[2,Grid_Revs.Row]) - 3) + '*';
  if FindFirst(NomeDoc,faAnyFile,SearchRec) <> 0 then
  begin
    ShowMessage('Erro ao abrir o arquivo ' + SearchRec.Name);
    FindClose(SearchRec);
    exit;
  end;
  if UpperCase(ExtractFileExt(SearchRec.Name)) = '.RVD' then
  begin
    if FindNext(SearchRec) <> 0 then
    begin
      ShowMessage('Erro ao abrir o arquivo ' + SearchRec.Name);
      FindClose(SearchRec);
      exit;
    end;
  end;
  Repaint;
  SaveDialog.Title := 'Copiar Documento Para...';
  SaveDialog.InitialDir := 'C:\';
  SaveDialog.FileName := SearchRec.Name;
  if not SaveDialog.Execute then exit;
  Origem := ArqDir + SearchRec.Name;
  FindClose(SearchRec);
  Destino := SaveDialog.FileName;
  FileSetAttr(Destino, faArchive);
  if not CopyFile(PChar(Origem),PChar(Destino),False) then
  begin
    ShowMessage('Erro ao copiar o arquivo ' + Origem + ' para o arquivo ' + Destino);
    exit;
  end;
  FileSetAttr(Destino, faArchive);
end;

procedure TForm_Revdoc.Grid_RevsDblClick(Sender: TObject);
begin
  //mostra os detalhes da revisão
  if Grid_Revs.Cells[0,Grid_Revs.Row] = '' then
  begin
    ShowMessage('Não há uma revisão disponível para ser aberta');
    exit;
  end;
  with Form_Alteracoes do
  begin
    Caption := 'Documento: ' +
               Grid_Docs.Cells[0,Grid_Docs.Row] + ' -  Revisão: ' +
               Grid_Revs.Cells[0,Grid_Revs.Row];
    Memo.Lines.Clear;
    Memo.Lines.Add('Código: ' + Grid_Docs.Cells[0,Grid_Docs.Row] + #13 + #10);
    Memo.Lines.Add('Nome: ' + Grid_Docs.Cells[1,Grid_Docs.Row] + #13 + #10);
    Memo.Lines.Add('Título: ' + Grid_Docs.Cells[2,Grid_Docs.Row] + #13 + #10);
    Memo.Lines.Add('Revisão: ' + Grid_Revs.Cells[0,Grid_Revs.Row] + #13 + #10);
    Memo.Lines.Add('Data: ' + Grid_Revs.Cells[1,Grid_Revs.Row] + #13 + #10);
    Memo.Lines.Add('Alteração: ' + Grid_Revs.Cells[3,Grid_Revs.Row]);
    ShowModal;
  end;
end;

procedure GeraEstrutura(BaseDir,Codigo,Revisao,Nome,Titulo,DataRev,Alteracao,Arquivo: String);
var SearchRec: TSearchRec;
    NovoArq: String;
    F: TextFile;
    TmpStr: String;
begin
  //Gera a estrutura de diretórios / copia-cria os arquivos
  //Cria o diretório do documento no BaseDir
  if FindFirst(BaseDir + '\' + Codigo,faReadOnly + faDirectory,SearchRec) = 0 then
  begin
    ShowMessage('O diretório ' + BaseDir + '\' + Codigo +
                ' já existe. Os arquivos dentro do diretório poderão ser sobreescritos');
  end
  else
  begin
    try
      MkDir(BaseDir + '\' + LowerCase(Codigo));
    except
      ShowMessage('Não foi possível criar o diretório ' + BaseDir + '\' + Codigo);
      FindClose(SearchRec);
      exit;
    end;
  end;
  FindClose(SearchRec);
  //copia o documento para o diretório, com o nome correto
  NovoArq := BaseDir + '\' + Codigo + '\' + LowerCase(Copy(Codigo,1,3)) +
              Copy(Codigo,5,2) + '_' + LowerCase(Revisao) +
              LowerCase(ExtractFileExt(Arquivo));
  if CopyFile(PChar(Arquivo),PChar(NovoArq),False) = False then
  begin
    ShowMessage('Ocorreu um erro ao copiar o arquivo ' + Arquivo + ' para ' + NovoArq);
    exit;
  end;
  //cria o revdoc.rvd
  try
    AssignFile(F, BaseDir + '\' + Codigo + '\revdoc.rvd');
    Rewrite(F);
    Writeln(F,Nome);
    Writeln(F,Titulo);
    CloseFile(F);
  except
    ShowMessage('Ocorreu um erro ao criar o arquivo ' + BaseDir + '\' + Codigo + '\revdoc.rvd');
    exit;
  end;
  //cria os arquivos da revisão .rvd
  try
    NovoArq := BaseDir + '\' + Codigo + '\' + LowerCase(Copy(Codigo,1,3)) +
               Copy(Codigo,5,2) + '_' + LowerCase(Revisao) + '.rvd';
    AssignFile(F, NovoArq);
    Rewrite(F);
    TmpStr := '[Data]';
    Writeln(F,TmpStr);
    Writeln(F,DataRev);
    TmpStr := '[Alteracao]';
    Writeln(F,TmpStr);
    Writeln(F,Alteracao);
    CloseFile(F);
  except
    ShowMessage('Ocorreu um erro ao criar o arquivo ' + NovoArq);
    exit;
  end;
  ShowMessage('A criação da Estrutura de Diretórios foi concluída com sucesso! ' +
              'Veja ' + BaseDir);
end;

procedure TForm_Revdoc.Button_GerarClick(Sender: TObject);
var BaseDir: String;
    Codigo: String;
    Revisao: String;
    Nome: String;
    Titulo: String;
    DataRev: String;
    Alteracao: String;
    Arquivo: String;
    i: Integer;
    ok: Integer;
    ProcuraDir: String;
    SearchRec: TSearchRec;

begin
  //chama a tela de carregamento do Wizard, que cria todos os forms do Wizard
  Form_GerarWiz0 := TForm_GerarWiz0.Create(Application);
  Form_GerarWiz0.ShowModal;
  Form_GerarWiz0.Free;
  //chama a tela de boas vindas
  if Form_GerarWiz1.ShowModal = mrCancel then
  begin
    Form_GerarWiz1.Free;
    Form_GerarWiz2.Free;
    Form_GerarWiz3.Free;
    Form_GerarWiz4.Free;
    Form_GerarWiz5.Free;
    Form_GerarWiz6.Free;
    Form_GerarWiz7.Free;
    exit;
  end;
  Form_GerarWiz1.Free;
  //chama a tela 1/6 - escolha do diretório base
  if Form_GerarWiz2.ShowModal = mrCancel then
  begin
    Form_GerarWiz2.Free;
    Form_GerarWiz3.Free;
    Form_GerarWiz4.Free;
    Form_GerarWiz5.Free;
    Form_GerarWiz6.Free;
    Form_GerarWiz7.Free;
    exit;
  end;
  BaseDir := Form_GerarWiz2.DirList.Directory;
  Form_GerarWiz2.Free;
  //chama a tela 2/6 - código e revisão do documento
  //repete até que não exista um documento igual já gravado
  repeat
    if Form_GerarWiz3.ShowModal = mrCancel then
    begin
      Form_GerarWiz3.Free;
      Form_GerarWiz4.Free;
      Form_GerarWiz5.Free;
      Form_GerarWiz6.Free;
      Form_GerarWiz7.Free;
      exit;
    end;
    Codigo := Form_GerarWiz3.Edit_Codigo.Text;
    Revisao := Form_GerarWiz3.Edit_Revisao.Text;
    ok := 0;
    ProcuraDir := ExtractFilePath(Application.ExeName) + Codigo + '\' +
                  Copy(Codigo,1,3) + Copy(Codigo,5,2) + '_' + Revisao + '.rvd';
    if FindFirst(ProcuraDir,faAnyFile,SearchRec) = 0 then
    begin
      ok := 1;
      ShowMessage('Já existe o Documento ' + Codigo + ' na Revisão ' + Revisao +
                  '. Especifique outro Documento ou outra Revisão');
    end;
    FindClose(SearchRec);
  until ok = 0;

  Form_GerarWiz3.Free;
  //se não existe o documento (em outras revisões) chama a tela 3/6 - nome e título do documento
  ok := 0;
  for i := 1 to Grid_Docs.RowCount - 1 do
  begin
    if Grid_Docs.Cells[0,i] = Codigo then
    begin
      ok := i;
      break;
    end;
  end;
  if ok <> 0 then
  begin
    Nome := Grid_Docs.Cells[1,ok];
    Titulo := Grid_Docs.Cells[2,ok];
    ShowMessage('O passo 3/6 do Assistente não será necessário, pois o documento ' +
                Codigo + ' já existe');
  end
  else
  begin
    if Form_GerarWiz4.ShowModal = mrCancel then
    begin
      Form_GerarWiz4.Free;
      Form_GerarWiz5.Free;
      Form_GerarWiz6.Free;
      Form_GerarWiz7.Free;
      exit;
    end;
    Nome := Form_GerarWiz4.Edit_Nome.Text;
    Titulo := Form_GerarWiz4.Edit_Titulo.Text;
    Form_GerarWiz4.Free;
  end;
  //chama a tela 4/6 - escolha data e alterações da revisão
  if Revisao = '0' then
    Form_GerarWiz5.Memo_Alteracao.Lines.Add('Liberação de Documento');
  if Form_GerarWiz5.ShowModal = mrCancel then
  begin
    Form_GerarWiz5.Free;
    Form_GerarWiz6.Free;
    Form_GerarWiz7.Free;
    exit;
  end;
  DataRev := DateToStr(Form_GerarWiz5.DT_Revisao.Date);
  Alteracao := Form_GerarWiz5.Memo_Alteracao.Lines.Text;
  Form_GerarWiz5.Free;
  //chama a tela 5/6 - procura o arquivo do documento
  if Form_GerarWiz6.ShowModal = mrCancel then
  begin
    Form_GerarWiz6.Free;
    Form_GerarWiz7.Free;
    exit;
  end;
  Arquivo := Form_GerarWiz6.Edit_Arquivo.Text;
  Form_GerarWiz6.Free;
  //chama a tela 6/6 - Conclusão do Wizard
  if Form_GerarWiz7.ShowModal = mrCancel then
  begin
    Form_GerarWiz7.Free;
    exit;
  end;
  Form_GerarWiz7.Free;
  Repaint;
  Screen.Cursor := crHourGlass;
  //Cria estrutura de diretórios / cria arquivos
  GeraEstrutura(BaseDir,Codigo,Revisao,Nome,Titulo,DataRev,Alteracao,Arquivo);
  Screen.Cursor := crDefault;
end;

procedure TForm_Revdoc.Button_SobreClick(Sender: TObject);
begin
  //mostra o AboutBox
  Form_About.Animate.FileName := ExtractFilePath(Application.ExeName) + 'about.avi';
  Form_About.ShowModal;
end;

procedure TForm_Revdoc.Button_RevDocClick(Sender: TObject);
begin
  //Abre a Pasta .\RevDoc1.0 no Windows Explorer
  ShellExecute(Application.Handle,PChar('explore'),
               PChar(ExtractFilePath(Application.ExeName) + 'RevDoc1.0'),
               PChar(''),PChar(''),SW_SHOWMAXIMIZED);
end;

end.
