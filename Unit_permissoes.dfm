object Form_permissoes: TForm_permissoes
  Left = 223
  Top = 410
  Width = 394
  Height = 288
  BorderIcons = [biSystemMenu]
  Caption = 'Permiss'#245'es'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 96
    Height = 13
    Caption = 'Fun'#231#245'es do Sistema'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Permiss'#245'es'
  end
  object cb_funcoes: TComboBox
    Left = 16
    Top = 24
    Width = 305
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnEnter = cb_funcoesEnter
  end
  object btn_inserir: TBitBtn
    Left = 328
    Top = 24
    Width = 33
    Height = 25
    Caption = '+'
    TabOrder = 1
    OnClick = btn_inserirClick
  end
  object grid_permissoes: TDBGrid
    Left = 16
    Top = 72
    Width = 345
    Height = 120
    DataSource = ds_permissoes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btn_fechar: TBitBtn
    Left = 144
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btn_fecharClick
  end
  object btn_retirar: TBitBtn
    Left = 325
    Top = 208
    Width = 35
    Height = 25
    Caption = '-'
    TabOrder = 4
    OnClick = btn_retirarClick
  end
  object ADOQuery_permissoes: TADOQuery
    Connection = Form_logon.ConexaoBD
    Parameters = <>
    Left = 16
    Top = 208
  end
  object ds_permissoes: TDataSource
    DataSet = ADOQuery_permissoes
    Left = 48
    Top = 208
  end
  object ADOQuery_aux: TADOQuery
    Connection = Form_logon.ConexaoBD
    Parameters = <>
    Left = 272
    Top = 208
  end
end
