unit Unit_logon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, DB, ADODB;

type
  TForm_logon = class(TForm)
    Label1: TLabel;
    edt_usuario: TEdit;
    Senha: TLabel;
    edt_senha: TEdit;
    btn_fechar: TBitBtn;
    logon: TImage;
    ConexaoBD: TADOConnection;
    ADOQuery_aux: TADOQuery;
    btn_ok: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    usuario_logado, senha_usuario : string;

    function autenticacao : boolean;
    function validacao(usuario, senha : string) : boolean;
    function criptografa (texto : string) : string;
    function descriptografa (texto : string) : string;
  end;

var
  Form_logon: TForm_logon;

implementation

uses Unit_menu;

{$R *.dfm}

{ TForm_logon }

function TForm_logon.autenticacao: boolean;
begin
  ConexaoBD.ConnectionString := ' Provider=SQLOLEDB.1; '+
                                ' Initial Catalog=Academico; '+
                                ' Data Source=DESKTOP-AGQ6ITR ';
  try
    ConexaoBD.Open('sa', '1');
    result := True;
  except
    Showmessage('Não foi possivel se conectar ao servidor !');
    result := False;
  end;
end;

function TForm_logon.criptografa(texto: string): string;
var
    i : integer;
    cripto : string;
    cod_ascii : string;
begin
  cripto := '';

  for i := length(texto) downto 1 do
  begin
    cod_ascii := IntToStr(Ord(texto[i]));
    cod_ascii := StringOfChar ('0',3-length(cod_ascii)) + cod_ascii;
    cripto := cripto + cod_ascii;
  end;

  result:= cripto;
end;

function TForm_logon.descriptografa(texto: string): string;
var
    i : integer;
    descripto : string;
    cod_ascii : integer;
begin
  i:= length(texto)+1;

  while i>1 do
  begin
  i:= i - 3;
    cod_ascii := StrToInt(copy(texto,i,3));
    descripto := descripto + Chr(cod_ascii);
  end;

  result := descripto;
end;

function TForm_logon.validacao(usuario, senha: string): boolean;
begin
  ADOQuery_aux.SQL.Text:=' SELECT SENHA FROM USUARIOS '+
                         ' WHERE USUARIO = ' + QuotedStr(usuario);
  ADOQuery_aux.Open;

  if ADOQuery_aux.IsEmpty then
   begin
    Showmessage('Usuário não cadastrado!');
    Result := false;
   end
  else
   begin
    senha_usuario := ADOQuery_aux.fieldbyname('SENHA').AsString;
    senha_usuario := descriptografa(senha_usuario);
    if senha_usuario <> senha then
     begin
      ShowMessage('Senha não confere!');
      result := false;
     end
    else
     begin
      usuario_logado := usuario;
      Result := true;
     end;
    end;

    ADOQuery_aux.Close;

end;

//procedure TForm_logon.btn_okClick(Sender: TObject);
//begin
  // if validacao(edt_usuario.Text, edt_senha.Text) = true then
   //begin
    // hide;
     //Form_menu.showmodal;
   //end;
//end;

procedure TForm_logon.btn_okClick(Sender: TObject);
begin
  try
   if validacao(edt_usuario.Text, edt_senha.Text) = true then
   begin
     hide;

     if (form_menu = nil) Then
     begin
      Application.CreateForm(TForm_menu, Form_menu);
     end;

     Form_menu.showmodal;
   end;
  except
    on E: Exception do
      ShowMessage('Erro' + E.Message);
  end;
end;


procedure TForm_logon.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

end.
