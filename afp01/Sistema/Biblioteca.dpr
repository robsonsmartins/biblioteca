{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  Biblioteca.dpr

  Código-fonte principal do Programa.

  Data última revisão: 24/11/2001

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
  unit_PesquisaDialog in 'unit_PesquisaDialog.pas' {form_PesquisaDialog},
  unit_BackupDialog in 'unit_BackupDialog.pas' {form_BackupBDDialog},
  unit_RestoreDialog in 'unit_RestoreDialog.pas' {form_RestoreBDDialog},
  unit_SplashForm in 'unit_SplashForm.pas' {form_Splash},
  relatorio_usuario in 'relatorio_usuario.pas' {form_RelatorioUsuario},
  relatorio_acervoperdido in 'relatorio_acervoperdido.pas' {form_RelatorioAcervoPerdido},
  relatorio_fornecedor in 'relatorio_fornecedor.pas' {form_RelatorioFornecedor},
  relatorio_reserva in 'relatorio_reserva.pas' {form_RelatorioReserva},
  relatorio_retirada in 'relatorio_retirada.pas' {form_RelatorioRetirada},
  relatorio_acervo in 'relatorio_acervo.pas' {form_RelatorioAcervo},
  relatorio_DevUsuario in 'relatorio_DevUsuario.pas' {form_RelatorioDevUsuario},
  relatorio_DevAcervo in 'relatorio_DevAcervo.pas' {form_RelatorioDevAcervo},
  relatorio_AcervoRet in 'relatorio_AcervoRet.pas' {form_RelatorioAcervoRet},
  relatorio_UsuSusp in 'relatorio_UsuSusp.pas' {form_RelatorioUsuSusp},
  ZLibEx in '..\Comps\ZLib\ZLibEx.pas';

{$R *.RES}
begin
  {Só executa a Aplicação se não há outra instância rodando}
  if not SystemRunning then
  begin
    if not MinRes800x600 then
      Application.MessageBox(MSG_MINRES,CAP_MINRES,MB_OKICONSTOP)
    else
    begin
      Application.Initialize;
      Application.Title := 'Sistema Biblioteca';
      with Tform_Splash.Create(nil) do
      begin
        try
          Show;
          Update;
          Application.CreateForm(TDataModule_Biblio, DataModule_Biblio);
          Application.CreateForm(Tform_Desktop, form_Desktop);
        finally
          Free;
        end;
      end;
      Application.Run;
    end;
  end;
end.
