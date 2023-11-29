unit Unit_matriculas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TForm_matriculas = class(TForm)
    btn_novo: TBitBtn;
    btn_salvar: TBitBtn;
    btn_alterar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_fechar: TBitBtn;
    Label1: TLabel;
    edt_aluno: TEdit;
    Label2: TLabel;
    edt_turma: TEdit;
    ADOQuery_aux: TADOQuery;
    btn_aluno: TBitBtn;
    btn_turma: TBitBtn;
    btn_localizar: TBitBtn;
    procedure btn_alunoClick(Sender: TObject);
    procedure btn_turmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_localizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   pk_aluno, pk_turma, operacao, cod_aluno, cod_turma : string;
   procedure desabilita_salvar(Sender: TObject);
   procedure habilita_salvar(Sender: TObject);
   procedure bloqueia_campos;
   procedure libera_campos;
   procedure limpa_campos;
  end;

var
  Form_matriculas: TForm_matriculas;

implementation

uses Unit_logon, Unit_pesquisa_turmas, Unit_pesquisa;

{$R *.dfm}

{ TForm_matriculas }

procedure TForm_matriculas.bloqueia_campos;
var i : integer;
begin
  for i := 1 to form_matriculas.ComponentCount -1 do
  begin
    if form_matriculas.Components[i] is TEdit then
    begin
      (form_matriculas.Components[i] as TEdit).Enabled := False;
      (form_matriculas.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TForm_matriculas.desabilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := True;
  btn_salvar.Enabled := False;
  btn_alterar.Enabled := True;
  btn_cancelar.Enabled := False;
  btn_excluir.Enabled := True;

  btn_aluno.Enabled := False;
  btn_turma.Enabled := False;  

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

procedure TForm_matriculas.habilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := False;
  btn_salvar.Enabled := True;
  btn_alterar.Enabled := False;
  btn_cancelar.Enabled := True;
  btn_excluir.Enabled := False;

  btn_aluno.Enabled := True;
  btn_turma.Enabled := True;

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

procedure TForm_matriculas.libera_campos;
var
  i : integer;
  nome_obj : string;
begin
  for i := 0 to Form_matriculas.ComponentCount -1 do
  begin
    if Form_matriculas.Components[i] is TEdit then
    begin
      nome_obj := (Form_matriculas.Components[i] as TEdit).Name;
      if (nome_obj <> 'edt_aluno') and (nome_obj <> 'edt_turma') then
      begin
        (Form_matriculas.Components[i] as TEdit).Enabled := True;
        (Form_matriculas.Components[i] as TEdit).Color := clWindow;
      end;
    end;
  end;
end;  

procedure TForm_matriculas.limpa_campos;
var i : integer;
begin
  for i := 1 to form_matriculas.ComponentCount -1 do
  begin
    if form_matriculas.Components[i] is TEdit then
      (form_matriculas.Components[i] as TEdit).Clear;
  end;
end;

procedure TForm_matriculas.btn_alunoClick(Sender: TObject);
begin
  edt_aluno.Clear;
  Form_pesquisa.sql_pesquisa:='SELECT * FROM ALUNOS ';
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    cod_aluno := Form_pesquisa.chave;
    ADOQuery_aux.SQL.Text := ' SELECT NOME FROM ALUNOS '+
                             ' WHERE COD_ALUNO = '+ cod_aluno;
    ADOQuery_aux.Open;
    edt_aluno.Text := ADOQuery_aux.fieldbyname('NOME').AsString;
  end;
end;

procedure TForm_matriculas.btn_turmaClick(Sender: TObject);
begin
  edt_turma.Clear;
  Form_pesquisa_turmas.ShowModal;

  if Form_pesquisa_turmas.chave <> '' then
  begin
    cod_turma := Form_pesquisa_turmas.chave;
    edt_turma.Text := cod_turma;
  end;  
end;

procedure TForm_matriculas.FormShow(Sender: TObject);
begin
  pk_aluno := '';
  pk_turma := '';
  cod_aluno  := '';
  cod_turma := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);
end;

procedure TForm_matriculas.btn_novoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk_aluno := '';
  pk_turma := '';
  cod_aluno  := '';
  cod_turma := '';
  operacao := '';
  habilita_salvar(sender);
end;

procedure TForm_matriculas.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_matriculas.btn_cancelarClick(Sender: TObject);
begin
    if operacao = 'novo' then
    limpa_campos;

    desabilita_salvar(sender);
    bloqueia_campos;
end;

procedure TForm_matriculas.btn_alterarClick(Sender: TObject);
begin
    if (pk_turma = '') or (pk_aluno = '') then
    Showmessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(sender);
  end; 
end;

procedure TForm_matriculas.btn_salvarClick(Sender: TObject);
var deuerro : boolean;
begin
  if (cod_aluno='') or (edt_turma.Text='') then
   begin
    Showmessage('Informe todos os campos !');
   end
  else
   begin
     if operacao = 'novo' then
       adoquery_aux.SQL.Text := 'INSERT INTO MATRICULAS VALUES '+
                                '(' + QuotedStr(cod_turma) +
                                ',' + cod_aluno + ')'

     else if operacao = 'alterar' then
       adoquery_aux.SQL.Text := ' UPDATE MATRICULAS SET '+
                                ' COD_TURMA ='+  QuotedStr(cod_turma) +
                                ', COD_ALUNO ='+ cod_aluno +
                                ' WHERE COD_TURMA = '+ QuotedStr(pk_turma) +
                                ' AND COD_ALUNO = '+ pk_aluno;

     Form_logon.ConexaoBD.BeginTrans;
     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'PK_Matriculas') = 'Sim' then
           ShowMessage('Matriculas já cadastrado !')
         else if Form_logon.ErroBD(E.Message, 'FK_Frequencias_Matriculas') = 'Sim' then
           Showmessage('Existem frequencias lançadas para esta Matricula!')
         else
           ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
   end;

   if deuerro = true then
    begin
     Form_logon.ConexaoBD.RollbackTrans;
    end
   else
    begin
     Form_logon.ConexaoBD.CommitTrans;
     pk_turma := cod_turma;
     pk_aluno := cod_aluno;
     desabilita_salvar(sender);
     bloqueia_campos;
  end;
 end;
end;

procedure TForm_matriculas.btn_excluirClick(Sender: TObject);
var deuerro : boolean;
begin
  if (pk_turma = '' ) or (pk_aluno = '') then
    Showmessage('Impossível excluir!')
  else
   begin
     adoquery_aux.SQL.Text := ' DELETE FROM MATRICULAS ' +
                              ' WHERE COD_TURMA = ' + QuotedStr(pk_turma) +
                              ' AND COD_ALUNO = ' + cod_aluno;
     Form_logon.ConexaoBD.BeginTrans;

     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'FK_Matriculas_Alunos') = 'Sim' then
           Showmessage('Existem frequencias lançadas para esta matricula!')
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
    pk_turma := '';
    pk_aluno := '';
    cod_turma := '';
    cod_aluno := '';
    desabilita_salvar(sender);
    limpa_campos;
    bloqueia_campos;
   end;
 end;
end;

procedure TForm_matriculas.btn_localizarClick(Sender: TObject);
var sql : string;
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);

  sql := 'SELECT MATRICULAS.COD_TURMA, '+
         '       MATRICULAS.COD_ALUNO, '+
         '       ALUNOS.NOME '+
         'FROM MATRICULAS '+
         'INNER JOIN ALUNOS '+
         'ON MATRICULAS.COD_ALUNO = ALUNOS.COD_ALUNO ';

  Form_pesquisa.sql_pesquisa:= sql;
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    pk_turma := Form_pesquisa.chave;
    pk_aluno := Form_pesquisa.chave_aux;
    ADOQuery_aux.SQL.Text := sql +
                              ' WHERE COD_TURMA = ' + QuotedStr(pk_turma) +
                              ' AND MATRICULAS.COD_ALUNO = ' + pk_aluno;
    ADOQuery_aux.Open;
    edt_aluno.Text := ADOQuery_aux.Fieldbyname('NOME').AsString;
    edt_turma.Text := pk_turma;
    cod_turma := pk_turma;
    cod_aluno := pk_aluno;
  end;
end;

end.
