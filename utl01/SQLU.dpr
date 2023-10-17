program SQLU;

uses
  Forms,
  unit_SQLU in 'unit_SQLU.pas' {form_Principal};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SQL Utility';
  Application.CreateForm(Tform_Principal, form_Principal);
  Application.Run;
end.
