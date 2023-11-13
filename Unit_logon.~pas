unit Unit_logon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, DB, ADODB;

type
  TForm_logon = class(TForm)
    Label1: TLabel;
    edt_uauraio: TEdit;
    Senha: TLabel;
    edt_senha: TEdit;
    btn_ok: TBitBtn;
    btn_fechar: TBitBtn;
    logon: TImage;
    ConexaoBD: TADOConnection;
    ADOQuery_aux: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    usuario_logado, senha_usuario : string;

    function autenticacao : boolean;
    function validacao(usuario, senha : string) : boolean;
  end;

var
  Form_logon: TForm_logon;

implementation

{$R *.dfm}

{ TForm_logon }

function TForm_logon.autenticacao: boolean;
begin
  ConexaoBD.ConnectionString := ' Provider=SQLOLEDB.1; '+
                                ' Initial Catalog=Academico; '+
                                ' Data Source=DESKTOP-AGQ6ITR ';
  try
    ConexaoBD.Open('admin_academico', 'sysacademico');
    result := true;
  except
    Showmessage('Não foi possivel se conectar ao servidor !');
    result := False;
  end;
end;

function TForm_logon.validacao(usuario, senha: string): boolean;
begin
  ADOQuery_aux.SQL.Text:=' SELECT SENHA FROM USUARIOS '+
                         ' WHERE USUARIO = ' + QuotedStr(usuario);
  ADOQuery_aux.Open;

  if ADOQuery_aux.IsEmpty then
   begin
    ShowMessage('Usuário não cadastrado!');
    Result := False;
   end
  else
   begin
    senha_usuario := ADOQuery_aux.fielbyname('SENHA').AsString;
    if senha_usuario <> senha then
     begin
      ShowMessage('Senha não confere!');
      result := False;
     end
    else
     begin
      usuario_logado := usuario;
      Result := True;
     end;
    end;

    ADOQuery_aux.Close;

end;

end.
