object FUkuran: TFUkuran
  Left = 220
  Top = 102
  Width = 716
  Height = 445
  BorderIcons = [biSystemMenu]
  Caption = 'Data Ukuran'
  Color = 16744703
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 41
    Align = alTop
    Caption = 'Data Ukuran'
    Color = 16744703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object GData: TGroupBox
    Left = 0
    Top = 41
    Width = 700
    Height = 88
    Align = alTop
    Caption = 'Form Input'
    Color = 16744703
    Enabled = False
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 217
      Top = 40
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nama Ukuran'
    end
    object ENama: TEdit
      Left = 296
      Top = 40
      Width = 185
      Height = 22
      TabOrder = 0
    end
  end
  object GButton: TGroupBox
    Left = 0
    Top = 129
    Width = 700
    Height = 72
    Align = alTop
    Color = 16744703
    ParentColor = False
    TabOrder = 2
    object BSimpan: TBitBtn
      Left = 472
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Simpan'
      Enabled = False
      TabOrder = 0
      OnClick = BSimpanClick
    end
    object BTambah: TBitBtn
      Left = 24
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Tambah'
      TabOrder = 1
      OnClick = BTambahClick
    end
    object BUbah: TBitBtn
      Left = 136
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Ubah'
      Enabled = False
      TabOrder = 2
      OnClick = BUbahClick
    end
    object BHapus: TBitBtn
      Left = 248
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Hapus'
      Enabled = False
      TabOrder = 3
      OnClick = BHapusClick
    end
    object BBatal: TBitBtn
      Left = 360
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Batal'
      Enabled = False
      TabOrder = 4
      OnClick = BBatalClick
    end
    object BKeluar: TBitBtn
      Left = 584
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Keluar'
      TabOrder = 5
      OnClick = BKeluarClick
    end
  end
  object GridData: TDBGrid
    Left = 0
    Top = 201
    Width = 700
    Height = 120
    Align = alTop
    DataSource = DM.dsukuran
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = GridDataCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nama'
        Width = 587
        Visible = True
      end>
  end
  object GCari: TGroupBox
    Left = 0
    Top = 321
    Width = 700
    Height = 72
    Align = alTop
    Caption = 'Pencarian Data'
    Color = 16744703
    ParentColor = False
    TabOrder = 4
    object Label5: TLabel
      Left = 140
      Top = 32
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cari Nama Lengkap'
    end
    object ECari: TEdit
      Left = 248
      Top = 32
      Width = 209
      Height = 22
      TabOrder = 0
      OnChange = ECariChange
    end
    object BRefresh: TBitBtn
      Left = 472
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Refresh'
      TabOrder = 1
      OnClick = BRefreshClick
    end
  end
end
