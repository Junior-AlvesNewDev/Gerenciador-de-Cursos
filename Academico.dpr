program Academico;

uses
  Forms,
  Unit_logon in 'Unit_logon.pas' {Form_logon},
  Unit_menu in 'Unit_menu.pas' {Form_menu},
  Unit_splash in 'Unit_splash.pas' {Form_splash},
  Unit_usuarios in 'Unit_usuarios.pas' {Form_usuarios},
  Unit_pesquisa in 'Unit_pesquisa.pas' {Form_pesquisa},
  Unit_permissoes in 'Unit_permissoes.pas' {Form_permissoes},
  Unit_cursos in 'Unit_cursos.pas' {Form_cursos},
  Unit_instrutores in 'C:\Program Files (x86)\Common Files\Borland Shared\Images\Buttons\Unit_instrutores.pas' {Form_instrutores};

{$R *.res}

begin
  Application.Initialize;

  Form_splash:= TForm_splash.Create(application);
  Form_splash.Show;
  Form_splash.Update;

  Application.CreateForm(TForm_logon, Form_logon);
  Application.CreateForm(TForm_usuarios, Form_usuarios);
  Application.CreateForm(TForm_pesquisa, Form_pesquisa);
  Application.CreateForm(TForm_permissoes, Form_permissoes);
  Application.CreateForm(TForm_cursos, Form_cursos);
  Application.CreateForm(TForm_instrutores, Form_instrutores);
  //Application.CreateForm(TSplash, Splash);

  if form_logon.autenticacao = false then
    Application.Terminate;

  Form_splash.Hide;
  Form_splash.Destroy;

  Application.Run;
end.
