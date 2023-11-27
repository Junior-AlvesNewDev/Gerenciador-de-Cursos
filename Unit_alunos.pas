unit Unit_alunos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Buttons;

type
  TForm_alunos = class(TForm)
    btn_novo: TBitBtn;
    btn_salvar: TBitBtn;
    btn_alterar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_fechar: TBitBtn;
    ADOQuery_aux: TADOQuery;
    Label1: TLabel;
    edt_cod: TEdit;
    edt_nome: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edt_idade: TEdit;
    Label4: TLabel;
    edt_telefone: TEdit;
    Label5: TLabel;
    edt_sexo: TEdit;
    btn_localizar: TBitBtn;
    btn_cancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
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
  end;

var
  Form_alunos: TForm_alunos;

implementation

uses Unit_logon, Unit_pesquisa, Unit_menu;

{$R *.dfm}

{ TForm_alunos }

procedure TForm_alunos.bloqueia_campos;
var i : integer;
begin
  for i := 1 to form_alunos.ComponentCount -1 do
  begin
    if form_alunos.Components[i] is TEdit then
    begin
      (form_alunos.Components[i] as TEdit).Enabled := False;
      (form_alunos.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;

end;

procedure TForm_alunos.desabilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := True;
  btn_salvar.Enabled := False;
  btn_alterar.Enabled := True;
  btn_cancelar.Enabled := False;
  btn_excluir.Enabled := True;

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

procedure TForm_alunos.habilita_salvar(Sender: TObject);
begin
  btn_novo.Enabled := False;
  btn_salvar.Enabled := True;
  btn_alterar.Enabled := False;
  btn_cancelar.Enabled := True;
  btn_excluir.Enabled := False;

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

procedure TForm_alunos.libera_campos;
var i: integer;
begin
  for i:= 1 to Form_alunos.ComponentCount -1 do
  begin
    if Form_alunos.Components[i] is TEdit then
    begin
      if(Form_alunos.Components[i] as TEdit).Name <> 'edt_cod' then
      begin
      (Form_alunos.Components[i] as TEdit).Enabled:= True;
      (Form_alunos.Components[i] as TEdit).Color:= clWindow;
      end;
    end;
  end;
end;

procedure TForm_alunos.limpa_campos;
var i : integer;
begin
  for i := 1 to form_alunos.ComponentCount -1 do
  begin
    if form_alunos.Components[i] is TEdit then
    begin
      (form_alunos.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TForm_alunos.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);
end;

procedure TForm_alunos.btn_novoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(sender);
end;

procedure TForm_alunos.btn_alterarClick(Sender: TObject);
begin
  if pk = '' then
    Showmessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(sender);
  end;  
end;

procedure TForm_alunos.btn_cancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;

    desabilita_salvar(sender);
    bloqueia_campos;
end;

procedure TForm_alunos.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_alunos.btn_salvarClick(Sender: TObject);
var deuerro : boolean;
begin
  if (edt_nome.Text='') or (edt_idade.Text='') or
     (edt_telefone.Text='') or (edt_sexo.Text='') then
   begin
    Showmessage('Preencha todos os campos !');
   end
  else
   begin
     if operacao = 'novo' then
       adoquery_aux.SQL.Text := 'INSERT INTO ALUNOS '+
                                '(NOME, IDADE, TELEFONE, SEXO) VALUES '+
                                '(' + QuotedStr(edt_nome.Text) +
                                ',' + edt_idade.Text +
                                ',' + QuotedStr(edt_telefone.Text) +
                                ',' + QuotedStr(edt_sexo.Text) + ')'

     else if operacao = 'alterar' then
       adoquery_aux.SQL.Text := ' UPDATE ALUNOS SET '+
                                ' NOME ='+  QuotedStr(edt_nome.Text) +
                                ', IDADE ='+ edt_idade.Text +
                                ', TELEFONE ='+  QuotedStr(edt_telefone.Text) +
                                ', SEXO ='+  QuotedStr(edt_sexo.Text) +
                                ' WHERE COD_ALUNO = '+ pk;

     Form_logon.ConexaoBD.BeginTrans;
     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'PK_Alunos') = 'Sim' then
           ShowMessage('Aluno já cadastrado !')
         else if Form_logon.ErroBD(E.Message, 'FK_Matriculas_Alunos') = 'Sim' then
           Showmessage('Existem matriculas cadastradas para este aluno!')
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
     if operacao = 'novo' then
     begin
       adoquery_aux.SQL.Text := 'SELECT COD_ALUNO FROM ALUNOS '+
                                'WHERE NOME = ' + QuotedStr(edt_nome.Text) +
                                'AND IDADE =' + edt_idade.Text +
                                'AND TELEFONE = ' + QuotedStr(edt_telefone.Text) +
                                'AND SEXO = ' + QuotedStr(edt_sexo.Text);
     ADOQuery_aux.Open;
     pk := ADOQuery_aux.fieldbyname('COD_ALUNO').AsString;
     ADOQuery_aux.Close;
   end;
   desabilita_salvar(sender);
   bloqueia_campos;
   edt_cod.Text := pk;
  end;
 end;
end;

procedure TForm_alunos.btn_excluirClick(Sender: TObject);
var deuerro : boolean;
begin
  if pk = '' then
    Showmessage('Impossível excluir!')
  else
   begin
     adoquery_aux.SQL.Text := ' DELETE FROM ALUNOS ' +
                              ' WHERE COD_ALUNO = ' + pk;
     Form_logon.ConexaoBD.BeginTrans;

     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'FK_Matriculas_Alunos') = 'Sim' then
           Showmessage('Existem Matriculas cadastradas para este aluno!')
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
    desabilita_salvar(sender);
    limpa_campos;
    bloqueia_campos;
   end;
 end;
end; 

procedure TForm_alunos.btn_localizarClick(Sender: TObject);
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);

  Form_pesquisa.sql_pesquisa:='SELECT * FROM ALUNOS ';
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    pk := Form_pesquisa.chave;
    ADOQuery_aux.SQL.Text := ' SELECT * FROM ALUNOS '+
                             ' WHERE COD_ALUNO = ' + pk;
    ADOQuery_aux.Open;
    edt_cod.Text := ADOQuery_aux.fieldbyname('COD_ALUNO').AsString;
    edt_nome.Text := ADOQuery_aux.Fieldbyname('NOME').AsString;
    edt_idade.Text := ADOQuery_aux.fieldbyname('IDADE').AsString;
    edt_telefone.Text := ADOQuery_aux.fieldbyname('TELEFONE').AsString;
    edt_sexo.Text := ADOQuery_aux.fieldbyname('SEXO').AsString;
  end;
end;

end.
