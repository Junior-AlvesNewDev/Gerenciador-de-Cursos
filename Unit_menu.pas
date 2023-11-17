unit Unit_menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, DB, ADODB;

type
  TForm_menu = class(TForm)
    btn_cadinstrutores: TBitBtn;
    btn_cadturmas: TBitBtn;
    btn_cadalunos: TBitBtn;
    btn_matriculas: TBitBtn;
    btn_aulas: TBitBtn;
    btn_frequencias: TBitBtn;
    btn_paginstrutores: TBitBtn;
    btn_relatorios: TBitBtn;
    btn_controle: TBitBtn;
    Fechar: TBitBtn;
    btn_cadcursos: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    ADOQuery_aux: TADOQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure permissoes;
  end;

var
  Form_menu: TForm_menu;

implementation

uses Unit_logon;

{$R *.dfm}

procedure TForm_menu.FormShow(Sender: TObject);
begin
  permissoes;
end;

procedure TForm_menu.permissoes;
begin
  ADOQuery_aux.SQL.Text := ' SELECT COD_FUNCAO FROM PERMISSOES ' +
                           ' WHERE USUARIO = ' + QuotedStr (Form_logon.usuario_logado);

  ADOQuery_aux.Open;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'CADCUR', [loCaseInsensitive]) then
    btn_cadcursos.Enabled := True
  else
    btn_cadcursos.Enabled := False;

   if ADOQuery_aux.Locate('COD_FUNCAO', 'CADINS', [loCaseInsensitive]) then
    btn_cadinstrutores.Enabled := True
  else
    btn_cadinstrutores.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'CADTUR', [loCaseInsensitive]) then
    btn_cadturmas.Enabled := True
  else
    btn_cadturmas.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'CADALU', [loCaseInsensitive]) then
    btn_cadalunos.Enabled := True
  else
    btn_cadalunos.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'CADMAT', [loCaseInsensitive]) then
    btn_matriculas.Enabled := True
  else
    btn_matriculas.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'LANAUL', [loCaseInsensitive]) then
    btn_aulas.Enabled := True
  else
    btn_aulas.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'LANFRE', [loCaseInsensitive]) then
    btn_frequencias.Enabled := True
  else
    btn_frequencias.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'PAGINS', [loCaseInsensitive]) then
    btn_paginstrutores.Enabled := True
  else
    btn_paginstrutores.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'RELATO', [loCaseInsensitive]) then
    btn_relatorios.Enabled := True
  else
    btn_relatorios.Enabled := False;

  if ADOQuery_aux.Locate('COD_FUNCAO', 'CONTRO', [loCaseInsensitive]) then
    btn_controle.Enabled := True
  else
    btn_controle.Enabled := False;

  ADOQuery_aux.Close;
end;

end.
