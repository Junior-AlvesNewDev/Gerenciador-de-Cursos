unit Unit_logon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  TForm_logon = class(TForm)
    Label1: TLabel;
    edt_uauraio: TEdit;
    Senha: TLabel;
    edt_senha: TEdit;
    btn_ok: TBitBtn;
    btn_fechar: TBitBtn;
    logon: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_logon: TForm_logon;

implementation

{$R *.dfm}

end.
