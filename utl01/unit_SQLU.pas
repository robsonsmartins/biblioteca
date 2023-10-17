unit unit_SQLU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DBCtrls, Db, ADODB,
  ComCtrls;

type
  Tform_Principal = class(TForm)
    qry: TADOQuery;
    dtsrc: TDataSource;
    DBGrid1: TDBGrid;
    Memo: TMemo;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    Sair1: TMenuItem;
    N1: TMenuItem;
    od: TOpenDialog;
    sb: TStatusBar;
    Conectar1: TMenuItem;
    odudl: TOpenDialog;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    btn_Abrir: TBitBtn;
    btn_Exec: TBitBtn;
    procedure Sair1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure btn_AbrirClick(Sender: TObject);
    procedure btn_ExecClick(Sender: TObject);
    procedure Conectar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Principal: Tform_Principal;

implementation

{$R *.DFM}

procedure Tform_Principal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure Tform_Principal.Abrir1Click(Sender: TObject);
begin
  if od.Execute then
    Memo.Lines.LoadFromFile(od.FileName);
end;

procedure Tform_Principal.btn_AbrirClick(Sender: TObject);
begin
  qry.Close;
  qry.SQL.Text := Memo.Lines.Text;
  qry.Open;
  sb.SimpleText := 'Registros: ' + IntToStr(qry.RecordCount);
end;

procedure Tform_Principal.btn_ExecClick(Sender: TObject);
begin
  qry.Close;
  qry.SQL.Text := Memo.Lines.Text;
  qry.ExecSQL;
  sb.SimpleText := 'Registros afetados: ' + IntToStr(qry.RowsAffected);
end;

procedure Tform_Principal.Conectar1Click(Sender: TObject);
begin
  if odudl.Execute then
    qry.ConnectionString := 'FILE NAME=' + odudl.FileName;
end;

procedure Tform_Principal.FormCreate(Sender: TObject);
begin
  qry.ConnectionString :=
    'FILE NAME=' + ExtractFilePath(Application.ExeName) + 'sqlu.udl';
end;

end.
