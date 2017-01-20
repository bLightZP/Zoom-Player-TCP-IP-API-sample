program zp_comm;

uses
  Forms,
  mainunit in 'mainunit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ZP Comm Example';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
