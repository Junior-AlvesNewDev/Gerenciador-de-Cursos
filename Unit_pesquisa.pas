unit Unit_pesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons;

type
  TForm_pesquisa = class(TForm)
    edt_nome: TEdit;
    Label1: TLabel;
    btn_pesquisar: TBitBtn;
    btn_limpar: TBitBtn;
    ds_pesquisa: TDataSource;
    ADOQuery_pesquisa: TADOQuery;
    grid_pesquisa: TDBGrid;
    btn_selecionar: TBitBtn;
    btn_cancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    //procedure FormClick(Sender: TObject);
    procedure btn_pesquisarClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_selecionarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    chave, chave_aux, sql_pesquisa : string;
  end;

var
  Form_pesquisa: TForm_pesquisa;

implementation

uses Unit_logon;

{$R *.dfm}

procedure TForm_pesquisa.FormShow(Sender: TObject);
begin
  edt_nome.Clear;
end;



procedure TForm_pesquisa.btn_pesquisarClick(Sender: TObject);
begin
  if edt_nome.Text = '' then
    Showmessage('Digite o nome ou parte do nome!')
  else if sql_pesquisa = '' then
    ShowMessage('Impossível pesquisar !')
  else
   begin
    ADOQuery_pesquisa.Close;
    ADOQuery_pesquisa.SQL.Text := sql_pesquisa + ' WHERE NOME LIKE ' +
                                                 QuotedStr(edt_nome.Text + '%');
    ADOQuery_pesquisa.Open;
   end; 
end;

procedure TForm_pesquisa.btn_limparClick(Sender: TObject);
begin
  chave := '';
  edt_nome.Clear;
  ADOQuery_pesquisa.Close;
end;

procedure TForm_pesquisa.btn_selecionarClick(Sender: TObject);
begin
  if ADOQuery_pesquisa.Active = false then
    ShowMessage('Impossível Selecionar')
  else
  begin
    chave := ADOQuery_pesquisa.Fields.Fields[0].AsString;
    chave_aux := ADOQuery_pesquisa.Fields.Fields[1].AsString;
    ADOQuery_pesquisa.Close;
    Close;
  end;
end;

procedure TForm_pesquisa.btn_cancelarClick(Sender: TObject);
begin
  chave:= '';
  ADOQuery_pesquisa.Close;
  Close;
end;

end.
