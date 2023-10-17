unit u_gerarwiz0;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TForm_gerarwiz0 = class(TForm)
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    Timer: TTimer;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_gerarwiz0: TForm_gerarwiz0;

implementation

uses u_gerarwiz1, u_gerarwiz2, u_gerarwiz3, u_gerarwiz4, u_gerarwiz5,
  u_gerarwiz6, u_gerarwiz7;

{$R *.DFM}

var PodeFechar: Boolean = False;

procedure CriaForm (Numero: Integer);
begin
  case Numero of
    1: Form_GerarWiz1 := TForm_GerarWiz1.Create(Application);
    2: Form_GerarWiz2 := TForm_GerarWiz2.Create(Application);
    3: Form_GerarWiz3 := TForm_GerarWiz3.Create(Application);
    4: Form_GerarWiz4 := TForm_GerarWiz4.Create(Application);
    5: Form_GerarWiz5 := TForm_GerarWiz5.Create(Application);
    6: Form_GerarWiz6 := TForm_GerarWiz6.Create(Application);
    7: Form_GerarWiz7 := TForm_GerarWiz7.Create(Application);
  end;
end;

procedure TForm_gerarwiz0.FormShow(Sender: TObject);
begin
  Timer.Enabled := True;
  PodeFechar := False;
end;

procedure TForm_gerarwiz0.TimerTimer(Sender: TObject);
begin
  //cria cada form num evento de tempo
  ProgressBar.Position := ProgressBar.Position + 1;
  CriaForm(ProgressBar.Position);
  if ProgressBar.Position >= 7 then
  begin
    Timer.Enabled := False;
    PodeFechar := True;
    Close;
  end;
end;

procedure TForm_gerarwiz0.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not PodeFechar then Action := caNone;
end;

end.
