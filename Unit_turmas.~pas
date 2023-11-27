unit Unit_turmas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TForm_turmas = class(TForm)
    btn_novo: TBitBtn;
    btn_salvar: TBitBtn;
    btn_alterar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_fechar: TBitBtn;
    Label1: TLabel;
    edt_cod: TEdit;
    Label2: TLabel;
    edt_valor: TEdit;
    Label3: TLabel;
    edt_curso: TEdit;
    Label4: TLabel;
    edt_instrutor: TEdit;
    ADOQuery_aux: TADOQuery;
    btn_curso: TBitBtn;
    btn_instrutor: TBitBtn;
    btn_localizar: TBitBtn;
    procedure btn_cursoClick(Sender: TObject);
    procedure btn_instrutorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure edt_valorEnter(Sender: TObject);
    procedure edt_valorExit(Sender: TObject);
    procedure btn_localizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   operacao, pk, cod_curso, cod_instrutor : string;
   procedure desabilita_salvar(Sender: TObject);
   procedure habilita_salvar(Sender: TObject);
   procedure bloqueia_campos;
   procedure libera_campos;
   procedure limpa_campos;
   function formata_valor(valor, destino : string) : string;
  end;

var
  Form_turmas: TForm_turmas;

implementation

uses Unit_logon, Unit_pesquisa, Unit_pesquisa_turmas;

{$R *.dfm}

{ TForm_turmas }

procedure TForm_turmas.bloqueia_campos;
var i : integer;
begin
  for i := 1 to form_turmas.ComponentCount -1 do
  begin
    if form_turmas.Components[i] is TEdit then
    begin
      (form_turmas.Components[i] as TEdit).Enabled := False;
      (form_turmas.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TForm_turmas.desabilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := True;
  btn_salvar.Enabled := False;
  btn_alterar.Enabled := True;
  btn_cancelar.Enabled := False;
  btn_excluir.Enabled := True;

  btn_curso.Enabled := False;
  btn_instrutor.Enabled := False;

  if Sender = btn_novo then
    operacao := 'novo'
  else if Sender = btn_salvar then
    operacao := 'salvar'
  else if Sender = btn_alterar then
    operacao := 'alterar'
  else if Sender = btn_cancelar then
    operacao := 'cancelar'
  else if Sender = btn_excluir then
    operacao := 'excluir';
end;

procedure TForm_turmas.habilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := False;
  btn_salvar.Enabled := True;
  btn_alterar.Enabled := False;
  btn_cancelar.Enabled := True;
  btn_excluir.Enabled := False;

  btn_curso.Enabled := False;
  btn_instrutor.Enabled := False;

  if Sender = btn_novo then
    operacao := 'novo'
  else if Sender = btn_salvar then
    operacao := 'salvar'
  else if Sender = btn_alterar then
    operacao := 'alterar'
  else if Sender = btn_cancelar then
    operacao := 'cancelar'
  else if Sender = btn_excluir then
    operacao := 'excluir';
end;

procedure TForm_turmas.libera_campos;
var i : integer;
  nome_obj : string;
begin
  for i := 1 to Form_turmas.ComponentCount -1 do
  begin
    if Form_turmas.Components[i] is TEdit then
    begin
      nome_obj := (Form_turmas.Components[i] as TEdit).Name;
      if(nome_obj <> 'edt_curso') and (nome_Obj <> 'edt_instrutor') then
      begin
        (Form_turmas.Components[i] as TEdit).Enabled := True;
        (Form_turmas.Components[i] as TEdit).Color := clWindow;
      end;  
    end;
  end;
end;


procedure TForm_turmas.limpa_campos;
var i : integer;
begin
  for i := 1 to form_turmas.ComponentCount -1 do
  begin
    if form_turmas.Components[i] is TEdit then
    begin
      (form_turmas.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TForm_turmas.btn_cursoClick(Sender: TObject);
begin
  edt_curso.Clear;
  Form_pesquisa.sql_pesquisa:='SELECT * FROM CURSOS ';
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    cod_curso := Form_pesquisa.chave;
    ADOQuery_aux.SQL.Text := ' SELECT NOME FROM CURSOS '+
                             ' WHERE COD_CURSO = '+ QuotedStr(cod_curso);
    ADOQuery_aux.Open;
    edt_curso.Text := ADOQuery_aux.fieldbyname('NOME').AsString;
  end;
end;

procedure TForm_turmas.btn_instrutorClick(Sender: TObject);
begin
  edt_instrutor.Clear;
  Form_pesquisa.sql_pesquisa:='SELECT * FROM INSTRUTORES ';
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    cod_instrutor := Form_pesquisa.chave;
    ADOQuery_aux.SQL.Text := ' SELECT NOME FROM INSTRUTORES '+
                             ' WHERE COD_INSTRUTOR = '+ QuotedStr(cod_instrutor);
    ADOQuery_aux.Open;
    edt_instrutor.Text := ADOQuery_aux.fieldbyname('NOME').AsString;
  end;
end;

procedure TForm_turmas.FormShow(Sender: TObject);
begin
  pk := '';
  cod_curso  := '';
  cod_instrutor  := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);
end;

procedure TForm_turmas.btn_novoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  cod_curso  := '';
  cod_instrutor  := '';
  habilita_salvar(sender);
end;

procedure TForm_turmas.btn_alterarClick(Sender: TObject);
begin
    if pk = '' then
    Showmessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(sender);
  end;
end;

procedure TForm_turmas.btn_cancelarClick(Sender: TObject);
begin
    if operacao = 'novo' then
    limpa_campos;

    desabilita_salvar(sender);
    bloqueia_campos;
end;

procedure TForm_turmas.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_turmas.btn_salvarClick(Sender: TObject);
var deuerro : boolean;
begin
  if (edt_cod.Text='') or (edt_valor.Text='') or
     (cod_curso='') or (cod_instrutor='') then
   begin
    Showmessage('Preencha todos os campos !');
   end
  else
   begin
     if operacao = 'novo' then
       adoquery_aux.SQL.Text := 'INSERT INTO TURMAS VALUES ' +
                                '(' + QuotedStr(edt_cod.Text) +								
                                ',' + QuotedStr(cod_curso) +
                                ',' + cod_instrutor +
                                ',' + formata_valor(edt_valor.Text,'B') + ')'

     else if operacao = 'alterar' then
       adoquery_aux.SQL.Text := ' UPDATE TURMAS SET '+
                                ' COD_TURMA ='+  QuotedStr(edt_cod.Text) +
                                ', COD_CURSO ='+ QuotedStr(cod_curso) +
                                ', COD_INSTRUTOR ='+  cod_instrutor +
                                ', VALOR_AULA ='+ formata_valor(edt_valor.Text,'B') +
                                ' WHERE COD_TURMA = '+ QuotedStr(pk);

     Form_logon.ConexaoBD.BeginTrans;
     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'PK_TURMAS') = 'Sim' then
           ShowMessage('Turma já cadastrado !')
         else if Form_logon.ErroBD(E.Message, 'FK_Turmas_Cursos') = 'Sim' then
           Showmessage('Curso inválido!')
         else if Form_logon.ErroBD(E.Message, 'FK_Turmas_Instrutores') = 'Sim' then
           Showmessage('Instrutor inválido!')
         else if Form_logon.ErroBD(E.Message, 'FK_Matricula_Turmas') = 'Sim' then
           Showmessage('Existem alunos matriculados nesta turma!')	
         else if Form_logon.ErroBD(E.Message, 'FK_Aulas_Turmas') = 'Sim' then
           Showmessage('Existem aulas cadastradas para esta turma!')
		else
          Showmessage('Ocorreu o seguinte erro: ' + E.Message);		
      end;
   end;

   if deuerro = true then
    begin
     Form_logon.ConexaoBD.RollbackTrans;
    end
   else
    begin
     Form_logon.ConexaoBD.CommitTrans;
	   pk := edt_cod.Text;
     desabilita_salvar(sender);
     bloqueia_campos;
  end;
 end;
end;

procedure TForm_turmas.btn_excluirClick(Sender: TObject);
var deuerro : boolean;
begin
  if pk = '' then
    Showmessage('Impossível excluir!')
  else
   begin
     adoquery_aux.SQL.Text := ' DELETE FROM TURMAS ' +
                              ' WHERE COD_TURMA = ' + QuotedStr(pk);
     Form_logon.ConexaoBD.BeginTrans;

     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'FK_Matriculas_Turmas') = 'Sim' then
           Showmessage('Existem alunos matriculados nesta turma!')
         else if Form_logon.ErroBD(E.Message, 'FK_Aulas_Turmas') = 'Sim' then
           Showmessage('Existem aulas cadastradas para esta turma!')
		 else   
		   ShowMessage('ocorreu o seguinte erro: ' + E.Message);
     end;
   end;

   if deuerro = true then
   begin
    Form_logon.ConexaoBD.RollbackTrans;
   end
  else
   begin
    Form_logon.ConexaoBD.CommitTrans;
    pk := '';
   	cod_curso := '';
  	cod_instrutor := '';
    desabilita_salvar(sender);
    limpa_campos;
    bloqueia_campos;
   end;
 end;
end;

function TForm_turmas.formata_valor(valor, destino: string): string;
var
  valor_formatado : string;
  i : integer;
begin
  //Verifica os parametros
  if (valor='') or (destino='') then
  begin
    result := '';
    exit;
  end;
  valor_formatado := valor;
  //Apaga os caracteres do simbolo monetario e o ponto
  Delete(valor_formatado,pos('R', valor_formatado),1);
  Delete(valor_formatado,pos('$', valor_formatado),1);
  Delete(valor_formatado,pos('.', valor_formatado),1);
  //Tira os espaços
  valor_formatado := trim(valor_formatado);
  //Retorna o valor formatado de acordocom o destino
  if destino = 'T' then
      result := FormatCurr('R$ #,##0.00', StrToCurr(valor_formatado))
  else if destino = 'E' then
    result := valor_formatado
  else if destino = 'B' then
   begin
     //Varre a string para substituir a virgula por ponto
     for i:=1 to Length(valor_formatado) do
     begin
       if valor_formatado[i] = ',' then
         valor_formatado[i] := '.';
     end;
     result := valor_formatado;
   end;
end;

procedure TForm_turmas.edt_valorEnter(Sender: TObject);
begin
  edt_valor.Text := formata_valor(edt_valor.Text,'E');
end;

procedure TForm_turmas.edt_valorExit(Sender: TObject);
begin
  edt_valor.Text := formata_valor(edt_valor.Text,'T');
end;

procedure TForm_turmas.btn_localizarClick(Sender: TObject);
var sql : string;
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);

  Form_pesquisa_turmas.ShowModal;
  if Form_pesquisa_turmas.chave <> '' then
  begin
    pk := Form_pesquisa_turmas.chave;

    sql := ' SELECT TURMAS.COD_TURMA, TURMAS.VALOR_AULA, ' +
           '        CURSOS.NOME AS CURSO, CURSOS.COD_CURSO, ' +
           '        INSTRUTORES.NOME AS INSTRUTOR, INSTRUTORES.COD_INSTRUTOR ' +
           'FROM TURMAS ' +
           'INNER JOIN CURSOS '+
           ' ON TURMAS.COD_CURSO = CURSOS.COD_CURSO '+
           'INNER JOIN INSTRUTORES '+
           ' ON TURMAS.COD_INSTRUTOR = INSTRUTORES.COD_INSTRUTOR ' +
           ' WHERE TURMAS.COD_TURMA = ' + QuotedStr(pk);

    ADOQuery_aux.SQL.Text := sql;
    ADOQuery_aux.Open;

    edt_cod.Text := ADOQuery_aux.fieldbyname('COD_TURMA').AsString;
    edt_valor.Text := ADOQuery_aux.fieldbyname('VALOR_AULA').AsString;
    edt_valor.Text := formata_valor(edt_valor.Text,'T');
    edt_curso.Text := ADOQuery_aux.fieldbyname('CURSO').AsString;
    edt_instrutor.Text := ADOQuery_aux.fieldbyname('INSTRUTOR').AsString;
    cod_curso := ADOQuery_aux.fieldbyname('COD_CURSO').AsString;
    cod_instrutor := ADOQuery_aux.fieldbyname('COD_INSTRUTOR').AsString;
  end;  
end;

end.
