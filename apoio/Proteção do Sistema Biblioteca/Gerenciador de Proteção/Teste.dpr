program Teste;

uses
  Forms,
  unit_Protecao in 'unit_Protecao.pas' {form_Protecao},
  unit_CadCD in 'unit_CadCD.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
