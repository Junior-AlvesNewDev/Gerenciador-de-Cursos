unit Unit_instrutores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TForm_instrutores = class(TForm)
    btn_novo: TBitBtn;
    btn_salvar: TBitBtn;
    btn_alterar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_fechar: TBitBtn;
    edt_cod: TEdit;
    edt_nome: TEdit;
    edt_idade: TEdit;
    edt_telefone: TEdit;
    edt_sexo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOQuery_aux: TADOQuery;
    btn_localizar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_localizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   operacao, pk : string;
   procedure desabilita_salvar(Sender: TObject);
   procedure habilita_salvar(Sender: TObject);
   procedure bloqueia_campos;
   procedure libera_campos;
   procedure limpa_campos;
  end;

var
  Form_instrutores: TForm_instrutores;

implementation

uses Unit_logon, Unit_pesquisa, Unit_cursos;

{$R *.dfm}

{ TForm_instrutores }

procedure TForm_instrutores.bloqueia_campos;
var i : integer;
begin
  for i := 1 to form_instrutores.ComponentCount -1 do
  begin
    if form_instrutores.Components[i] is TEdit then
    begin
      (form_instrutores.Components[i] as TEdit).Enabled := False;
      (form_instrutores.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;

end;

procedure TForm_instrutores.desabilita_salvar(Sender: TObject);
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

procedure TForm_instrutores.habilita_salvar(Sender: TObject);
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

procedure TForm_instrutores.libera_campos;
var i: integer;
begin
  for i:= 1 to Form_instrutores.ComponentCount -1 do
  begin
    if Form_instrutores.Components[i] is TEdit then
    begin
      if(Form_instrutores.Components[i] as TEdit).Name <> 'edt_cod' then
      begin
      (Form_instrutores.Components[i] as TEdit).Enabled:= True;
      (Form_instrutores.Components[i] as TEdit).Color:= clWindow;
      end;
    end;
  end;
end;

procedure TForm_instrutores.limpa_campos;
var i : integer;
begin
  for i := 1 to form_instrutores.ComponentCount -1 do
  begin
    if form_instrutores.Components[i] is TEdit then
    begin
      (form_instrutores.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TForm_instrutores.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);
end;

procedure TForm_instrutores.btn_novoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(sender);
end;

procedure TForm_instrutores.btn_salvarClick(Sender: TObject);
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
       adoquery_aux.SQL.Text := 'INSERT INTO INSTRUTORES '+
                                '(NOME, IDADE, TELEFONE, SEXO) VALUES '+
                                '(' + QuotedStr(edt_nome.Text) +
                                ',' + edt_idade.Text +
                                ',' + QuotedStr(edt_telefone.Text) +
                                ',' + QuotedStr(edt_sexo.Text) + ')'

     else if operacao = 'alterar' then
       adoquery_aux.SQL.Text := ' UPDATE INSTRUTORES SET '+
                                ' NOME ='+  QuotedStr(edt_nome.Text) +
                                ', IDADE ='+ edt_idade.Text +
                                ', TELEFONE ='+  QuotedStr(edt_telefone.Text) +
                                ', SEXO ='+  QuotedStr(edt_sexo.Text) +
                                ' WHERE COD_INSTRUTOR = '+ pk;

     Form_logon.ConexaoBD.BeginTrans;
     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'PK_Instrutores') = 'Sim' then
           ShowMessage('Instrutor já cadastrado !')
         else if Form_logon.ErroBD(E.Message, 'FK_Turmas_Instrutores') = 'Sim' then
           Showmessage('Existem turmas cadastradas para este Instrutor!')
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
       adoquery_aux.SQL.Text := 'SELECT COD_INSTRUTOR FROM INSTRUTORES '+
                                'WHERE NOME = ' + QuotedStr(edt_nome.Text) +
                                'AND IDADE =' + edt_idade.Text +
                                'AND TELEFONE = ' + QuotedStr(edt_telefone.Text) +
                                'AND SEXO = ' + QuotedStr(edt_sexo.Text);
     ADOQuery_aux.Open;
     pk := ADOQuery_aux.fieldbyname('COD_INSTRUTOR').AsString;
     ADOQuery_aux.Close;
   end;
   desabilita_salvar(sender);
   bloqueia_campos;
   edt_cod.Text := pk;
  end;
 end;
end;

procedure TForm_instrutores.btn_alterarClick(Sender: TObject);
begin
  if pk = '' then
    Showmessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(sender);
  end;
end;

procedure TForm_instrutores.btn_cancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;

    desabilita_salvar(sender);
    bloqueia_campos;
end;

procedure TForm_instrutores.btn_excluirClick(Sender: TObject);
var deuerro : boolean;
begin
  if pk = '' then
    Showmessage('Impossível excluir!')
  else
   begin
     adoquery_aux.SQL.Text := ' DELETE FROM INSTRUTORES ' +
                              ' WHERE COD_INSTRUTOR = ' + pk;
     Form_logon.ConexaoBD.BeginTrans;

     try
       ADOQuery_aux.ExecSQL;
       deuerro := false;
     except
       on E : Exception do
       begin
         deuerro := true;
         if Form_logon.ErroBD(E.Message, 'FK_Turmas_Instrutores') = 'Sim' then
           Showmessage('Existem turmas cadastradas para este instrutor!')
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

procedure TForm_instrutores.btn_fecharClick(Sender: TObject);
begin
 Close;
end;

procedure TForm_instrutores.btn_localizarClick(Sender: TObject);
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(sender);

  Form_pesquisa.sql_pesquisa:='SELECT * FROM INSTRUTORES ';
  Form_pesquisa.ShowModal;
  if Form_pesquisa.chave <> '' then
  begin
    pk := Form_pesquisa.chave;
    ADOQuery_aux.SQL.Text := ' SELECT * FROM INSTRUTORES '+
                             ' WHERE COD_INSTRUTOR = ' + pk;
    ADOQuery_aux.Open;
    edt_cod.Text := ADOQuery_aux.fieldbyname('COD_INSTRUTOR').AsString;
    edt_nome.Text := ADOQuery_aux.Fieldbyname('NOME').AsString;
    edt_idade.Text := ADOQuery_aux.fieldbyname('IDADE').AsString;
    edt_telefone.Text := ADOQuery_aux.fieldbyname('TELEFONE').AsString;
    edt_sexo.Text := ADOQuery_aux.fieldbyname('SEXO').AsString;
  end;
end;

end.
