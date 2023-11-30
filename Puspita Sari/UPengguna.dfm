object FPengguna: TFPengguna
  Left = 220
  Top = 102
  Width = 928
  Height = 619
  BorderIcons = [biSystemMenu]
  Caption = 'Pengguna'
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
    Width = 912
    Height = 41
    Align = alTop
    Caption = 'Data Pengguna'
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
    Width = 912
    Height = 264
    Align = alTop
    Caption = 'Form Pengguna'
    Color = 16744703
    Enabled = False
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 338
      Top = 32
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nama Lengkap'
    end
    object Label2: TLabel
      Left = 376
      Top = 64
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Alamat'
    end
    object Label3: TLabel
      Left = 380
      Top = 96
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'No HP'
    end
    object Label4: TLabel
      Left = 360
      Top = 128
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Username'
    end
    object Label6: TLabel
      Left = 359
      Top = 160
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Password'
    end
    object Label7: TLabel
      Left = 383
      Top = 192
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Level'
    end
    object Label8: TLabel
      Left = 378
      Top = 224
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status'
    end
    object ENama: TEdit
      Left = 424
      Top = 32
      Width = 185
      Height = 22
      TabOrder = 0
    end
    object EAlamat: TEdit
      Left = 424
      Top = 64
      Width = 297
      Height = 22
      TabOrder = 1
    end
    object ENohp: TEdit
      Left = 424
      Top = 96
      Width = 121
      Height = 22
      TabOrder = 2
    end
    object EUsername: TEdit
      Left = 424
      Top = 128
      Width = 209
      Height = 22
      TabOrder = 3
    end
    object EPassword: TEdit
      Left = 424
      Top = 160
      Width = 209
      Height = 22
      PasswordChar = '*'
      TabOrder = 4
    end
    object CLevel: TComboBox
      Left = 424
      Top = 192
      Width = 145
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 5
      Items.Strings = (
        'Admin'
        'Owner'
        'Karyawan'
        'Pelanggan'
        'Supplier')
    end
    object CStatus: TComboBox
      Left = 424
      Top = 224
      Width = 145
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      ItemIndex = 0
      TabOrder = 6
      Text = 'Aktif'
      Items.Strings = (
        'Aktif'
        'Belum Aktif')
    end
    object BLihatPassword: TButton
      Left = 648
      Top = 160
      Width = 97
      Height = 25
      Caption = '&Lihat Password'
      TabOrder = 7
      OnClick = BLihatPasswordClick
    end
  end
  object GButton: TGroupBox
    Left = 0
    Top = 305
    Width = 912
    Height = 72
    Align = alTop
    Color = 16744703
    ParentColor = False
    TabOrder = 2
    object BSimpan: TBitBtn
      Left = 624
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Simpan'
      Enabled = False
      TabOrder = 0
      OnClick = BSimpanClick
    end
    object BTambah: TBitBtn
      Left = 176
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Tambah'
      TabOrder = 1
      OnClick = BTambahClick
    end
    object BUbah: TBitBtn
      Left = 288
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Ubah'
      Enabled = False
      TabOrder = 2
      OnClick = BUbahClick
    end
    object BHapus: TBitBtn
      Left = 400
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Hapus'
      Enabled = False
      TabOrder = 3
      OnClick = BHapusClick
    end
    object BBatal: TBitBtn
      Left = 512
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Batal'
      Enabled = False
      TabOrder = 4
      OnClick = BBatalClick
    end
    object BKeluar: TBitBtn
      Left = 736
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
    Top = 377
    Width = 912
    Height = 120
    Align = alTop
    DataSource = DM.dstpengguna
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
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nama'
        Width = 167
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'alamat'
        Width = 214
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nohp'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'username'
        Width = 122
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'level'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'status'
        Width = 100
        Visible = True
      end>
  end
  object GCari: TGroupBox
    Left = 0
    Top = 497
    Width = 912
    Height = 72
    Align = alTop
    Caption = 'Pencarian Data'
    Color = 16744703
    ParentColor = False
    TabOrder = 4
    object Label5: TLabel
      Left = 316
      Top = 32
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cari Nama Lengkap'
    end
    object ECari: TEdit
      Left = 424
      Top = 32
      Width = 209
      Height = 22
      TabOrder = 0
      OnChange = ECariChange
    end
    object BRefresh: TBitBtn
      Left = 648
      Top = 24
      Width = 97
      Height = 33
      Caption = '&Refresh'
      TabOrder = 1
      OnClick = BRefreshClick
    end
  end
end
