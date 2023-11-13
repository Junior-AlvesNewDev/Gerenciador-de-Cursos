unit Unit_menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_menu: TForm_menu;

implementation

{$R *.dfm}

end.
