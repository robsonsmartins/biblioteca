program RevDoc;

uses
  Forms,
  u_revdoc in 'u_revdoc.pas' {Form_Revdoc},
  u_alteracoes in 'u_alteracoes.pas' {Form_Alteracoes},
  u_gerarwiz1 in 'u_gerarwiz1.pas' {Form_GerarWiz1},
  u_gerarwiz6 in 'u_gerarwiz6.pas' {Form_GerarWiz6},
  u_gerarwiz2 in 'u_gerarwiz2.pas' {Form_GerarWiz2},
  u_gerarwiz3 in 'u_gerarwiz3.pas' {Form_GerarWiz3},
  u_gerarwiz4 in 'u_gerarwiz4.pas' {Form_GerarWiz4},
  u_gerarwiz5 in 'u_gerarwiz5.pas' {Form_GerarWiz5},
  u_gerarwiz0 in 'u_gerarwiz0.pas' {Form_GerarWiz0},
  u_novapasta in 'u_novapasta.pas' {Form_NovaPasta},
  u_about in 'u_about.pas' {Form_About},
  u_gerarwiz7 in 'u_gerarwiz7.pas' {Form_GerarWiz7};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'RevDoc - Controle de Revisão de Documentos - Projeto Biblioteca';
  Application.CreateForm(TForm_Revdoc, Form_Revdoc);
  Application.CreateForm(TForm_Alteracoes, Form_Alteracoes);
  Application.CreateForm(TForm_About, Form_About);
  Application.Run;
end.
