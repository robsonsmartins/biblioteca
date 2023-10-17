{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001

  unit_SplashForm.pas

  Tela de Splash do Sistema Biblioteca

  Data última revisão: 24/11/2001

*****************************************************************************}

unit unit_SplashForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls;

type
  Tform_Splash = class(TForm)
    Image_Splash: TImage;
    Shape_Splash: TShape;
    Label_Titulo: TLabel;
    Label_Versao: TLabel;
    Label_Aguarde: TLabel;
    Label_FBAI: TLabel;
    Label_Nomes: TLabel;
    Label_Grupo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Splash: Tform_Splash;

implementation

{$R *.DFM}

end.
