program GeradorSenha;

uses
  Vcl.Forms,
  Main in 'src\Main.pas' {Principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gerador de Senhas';
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
