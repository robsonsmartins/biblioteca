unit u_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, MPlayer, OleCtnrs, StdCtrls, Buttons;

type
  TForm_About = class(TForm)
    Panel1: TPanel;
    Animate: TAnimate;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_About: TForm_About;

implementation

{$R *.DFM}

procedure TForm_About.FormShow(Sender: TObject);
begin
  //Ativa a animação
  Animate.Active := True;
end;

end.
