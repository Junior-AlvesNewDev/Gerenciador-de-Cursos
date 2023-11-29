object Form_pesquisa_turmas: TForm_pesquisa_turmas
  Left = 107
  Top = 186
  Width = 578
  Height = 370
  BorderIcons = [biSystemMenu]
  Caption = 'Pesquisa Turma'
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
    Width = 93
    Height = 13
    Caption = 'Campo da pesquisa'
  end
  object Label2: TLabel
    Left = 184
    Top = 8
    Width = 110
    Height = 13
    Caption = 'Texto a ser pesquisado'
  end
  object cb_campo: TComboBox
    Left = 16
    Top = 24
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'C'#243'digo Turma'
      'Nome Curso'
      'Nome Instrutor')
  end
  object edt_texto: TEdit
    Left = 184
    Top = 24
    Width = 177
    Height = 21
    TabOrder = 1
  end
  object btn_pesquisar: TBitBtn
    Left = 376
    Top = 24
    Width = 81
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 2
    OnClick = btn_pesquisarClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
  end
  object btn_limpar: TBitBtn
    Left = 472
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = btn_limparClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
  end
  object grid_pesquisa_turma: TDBGrid
    Left = 16
    Top = 64
    Width = 529
    Height = 201
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btn_selecionar: TBitBtn
    Left = 168
    Top = 288
    Width = 89
    Height = 25
    Caption = 'Selecionar'
    TabOrder = 5
    OnClick = btn_selecionarClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
      0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
      00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
      00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
      F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
      F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
      FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
      0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
      00337777FFFF77FF7733EEEE0000000003337777777777777333}
    NumGlyphs = 2
  end
  object btn_cancelar: TBitBtn
    Left = 280
    Top = 288
    Width = 89
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 6
    OnClick = btn_cancelarClick
    Kind = bkCancel
  end
  object ADOQuery_pesquisa_turma: TADOQuery
    Connection = Form_logon.ConexaoBD
    Parameters = <>
    Left = 24
    Top = 280
  end
  object ds_pesquisa_turma: TDataSource
    DataSet = ADOQuery_pesquisa_turma
    Left = 64
    Top = 280
  end
end
