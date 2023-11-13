program Academico;

uses
  Forms,
  Unit_logon in 'Unit_logon.pas' {Form_logon},
  Unit_menu in 'Unit_menu.pas' {Form_menu},
  Unit_splash in 'Unit_splash.pas' {Splash};

{$R *.res}

begin
  Application.Initialize;

  Form_splash:= TForm_splash.Create(application);
  Form_splash.Show;
  Form_splash.Update;

  Application.CreateForm(TForm_logon, Form_logon);
  Application.CreateForm(TForm_menu, Form_menu);
  //Application.CreateForm(TSplash, Splash);

  Form_splash.Hide;
  Form_splash.Destroy;

  Application.Run;
end.
