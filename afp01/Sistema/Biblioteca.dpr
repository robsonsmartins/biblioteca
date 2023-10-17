{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Biblioteca.dpr

  Código-fonte principal do Programa.

  Data última revisão: 05/11/2001

*****************************************************************************}

program Biblioteca;

uses
  Forms,
  unit_Desktop in 'unit_Desktop.pas' {form_Desktop},
  unit_AcervoPerdidoDialog in 'unit_AcervoPerdidoDialog.pas' {form_AcervoPerdidoDialog},
  unit_AparenciaDialog in 'unit_AparenciaDialog.pas' {form_AparenciaDialog},
  unit_BibliotecaExplorer in 'unit_BibliotecaExplorer.pas' {form_BibliotecaExplorer},
  unit_CadastroAcervo in 'unit_CadastroAcervo.pas' {form_CadastroAcervo},
  unit_CadastroFornecedores in 'unit_CadastroFornecedores.pas' {form_CadastroFornecedores},
  unit_CadastroOpcoesDialog in 'unit_CadastroOpcoesDialog.pas' {form_CadastroOpcoesDialog},
  unit_CadastroUsuarios in 'unit_CadastroUsuarios.pas' {form_CadastroUsuarios},
  unit_ContasDialog in 'unit_ContasDialog.pas' {form_ContasDialog},
  unit_EscolhaRelatorios in 'unit_EscolhaRelatorios.pas' {form_EscolhaRelatorios},
  unit_LoginDialog in 'unit_LoginDialog.pas' {form_LoginDialog},
  unit_PainelDeControle in 'unit_PainelDeControle.pas' {form_PainelDeControle},
  unit_ReservaDialog in 'unit_ReservaDialog.pas' {form_ReservaDialog},
  unit_RetiradaDialog in 'unit_RetiradaDialog.pas' {form_RetiradaDialog},
  unit_Comum in 'unit_Comum.pas',
  unit_DatabaseClasses in 'unit_DatabaseClasses.pas' {DataModule_Biblio: TDataModule},
  unit_PesquisaDialog in 'unit_PesquisaDialog.pas' {form_PesquisaDialog};

{$R *.RES}
begin
  {Só executa a Aplicação se não há outra instância rodando}
  if not SystemRunning then
  begin
    Application.Initialize;
    Application.Title := 'Sistema Biblioteca';
    Application.CreateForm(TDataModule_Biblio, DataModule_Biblio);
    Application.CreateForm(Tform_Desktop, form_Desktop);
    Application.Run;
  end;
end.
