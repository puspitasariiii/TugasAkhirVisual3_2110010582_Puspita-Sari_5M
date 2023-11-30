object FProduk: TFProduk
  Left = 220
  Top = 102
  Width = 716
  Height = 578
  BorderIcons = [biSystemMenu]
  Caption = 'Data Produk'
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
    Caption = 'Data Produk'
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
    Height = 144
    Align = alTop
    Caption = 'Form Pengguna'
    Color = 16744703
    Enabled = False
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 58
      Top = 32
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nama Produk'
    end
    object Label2: TLabel
      Left = 87
      Top = 64
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ukuran'
    end
    object Label3: TLabel
      Left = 71
      Top = 96
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Berat (Kg)'
    end
    object Label4: TLabel
      Left = 338
      Top = 32
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Harga Beli Per Botol'
    end
    object Label6: TLabel
      Left = 343
      Top = 56
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Harga Beli Per Dus'
    end
    object Label7: TLabel
      Left = 336
      Top = 80
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Harga Jual Per Botol'
    end
    object Label8: TLabel
      Left = 341
      Top = 104
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Harga Jual Per Dus'
    end
    object ENama: TEdit
      Left = 136
      Top = 32
      Width = 185
      Height = 22
      TabOrder = 0
    end
    object CUkuran: TDBLookupComboBox
      Left = 136
      Top = 64
      Width = 145
      Height = 22
      KeyField = 'ID'
      ListField = 'nama'
      ListSource = DM.dsukuran
      TabOrder = 1
    end
    object EBerat: TEdit
      Left = 136
      Top = 96
      Width = 121
      Height = 22
      TabOrder = 2
      Text = 'EBerat'
    end
    object EBeliBotol: TEdit
      Left = 448
      Top = 32
      Width = 185
      Height = 22
      TabOrder = 3
    end
    object EBeliDus: TEdit
      Left = 448
      Top = 56
      Width = 185
      Height = 22
      TabOrder = 4
    end
    object EJualBotol: TEdit
      Left = 448
      Top = 80
      Width = 185
      Height = 22
      TabOrder = 5
    end
    object EJualDus: TEdit
      Left = 448
      Top = 104
      Width = 185
      Height = 22
      TabOrder = 6
    end
  end
  object GButton: TGroupBox
    Left = 0
    Top = 185
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
    Top = 257
    Width = 700
    Height = 192
    Align = alTop
    DataSource = DM.dsproduk
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ukuran'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'berat'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'stok_botol'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'stok_dus'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'harga_beli_botol'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'harga_beli_dus'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'harga_jual_botol'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'harga_jual_dus'
        Visible = True
      end>
  end
  object GCari: TGroupBox
    Left = 0
    Top = 449
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
