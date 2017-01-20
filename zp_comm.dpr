program zp_comm;

uses
  Forms,
  mainunit in 'mainunit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CommManager';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
