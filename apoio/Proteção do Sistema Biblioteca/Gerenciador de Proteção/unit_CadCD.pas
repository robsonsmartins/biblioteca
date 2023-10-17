unit unit_CadCD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Db, ADODB, Buttons;

type
  TForm1 = class(TForm)
    tbl_Protecao: TADOTable;
    ds_Protecao: TDataSource;
    nvg_Protecao: TDBNavigator;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    cbx_Drive: TComboBox;
    Button1: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}
uses unit_Protecao;


procedure TForm1.FormCreate(Sender: TObject);
begin
  cbx_Drive.ItemIndex := 3;
  tbl_Protecao.Active := True;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  dbedit1.Text := GetSerial(cbx_Drive.Items[cbx_Drive.ItemIndex]);
  Edit1.Text := GeraChave(DBEdit5.Text + dbedit1.Text);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ConsisteChave(DBEdit5.Text + DBEdit1.Text,Edit1.Text) then
    showmessage('ok')
  else
    showmessage('erro');
end;

end.
