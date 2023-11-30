object FRusakHilang: TFRusakHilang
  Left = 240
  Top = 94
  Width = 716
  Height = 662
  BorderIcons = [biSystemMenu]
  Caption = 'Produk Rusak Hilang'
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
    Caption = 'Produk Rusak Hilang'
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
    Height = 232
    Align = alTop
    Caption = 'Form Input'
    Color = 16744703
    Enabled = False
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 218
      Top = 24
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'No Transaksi'
    end
    object Label2: TLabel
      Left = 227
      Top = 88
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pilih Produk'
    end
    object Label3: TLabel
      Left = 137
      Top = 120
      Width = 144
      Height = 14
      Alignment = taRightJustify
      Caption = 'Jumlah Rusak/Hilang Per Botol'
    end
    object Label4: TLabel
      Left = 244
      Top = 56
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tanggal'
    end
    object Label6: TLabel
      Left = 142
      Top = 152
      Width = 139
      Height = 14
      Alignment = taRightJustify
      Caption = 'Jumlah Rusak/Hilang Per Dus'
    end
    object Label8: TLabel
      Left = 225
      Top = 184
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Keterangan'
    end
    object ENoTransaksi: TEdit
      Left = 296
      Top = 24
      Width = 185
      Height = 22
      Enabled = False
      TabOrder = 0
    end
    object DTanggal: TDateTimePicker
      Left = 296
      Top = 56
      Width = 186
      Height = 22
      Date = 45259.565993101850000000
      Time = 45259.565993101850000000
      TabOrder = 1
    end
    object CProduk: TDBLookupComboBox
      Left = 296
      Top = 88
      Width = 217
      Height = 22
      KeyField = 'ID'
      ListField = 'nama'
      ListSource = DM.dsproduk
      TabOrder = 2
    end
    object EJumlahBotol: TEdit
      Left = 296
      Top = 120
      Width = 121
      Height = 22
      TabOrder = 3
    end
    object EJumlahDus: TEdit
      Left = 296
      Top = 152
      Width = 121
      Height = 22
      TabOrder = 4
    end
    object EKeterangan: TEdit
      Left = 296
      Top = 184
      Width = 273
      Height = 22
      TabOrder = 5
    end
  end
  object GButton: TGroupBox
    Left = 0
    Top = 273
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
    Top = 345
    Width = 700
    Height = 176
    Align = alTop
    DataSource = DM.dsrusakhilang
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
        FieldName = 'no_transaksi'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tanggal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nama_produk'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'jumlah_botol'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'jumlah_dus'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'keterangan'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'total_semua'
        Visible = True
      end>
  end
  object GCari: TGroupBox
    Left = 0
    Top = 521
    Width = 700
    Height = 72
    Align = alTop
    Caption = 'Pencarian Data'
    Color = 16744703
    ParentColor = False
    TabOrder = 4
    object Label5: TLabel
      Left = 155
      Top = 32
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cari Keterangan'
    end
    object ECari: TEdit
      Left = 264
      Top = 32
      Width = 185
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
