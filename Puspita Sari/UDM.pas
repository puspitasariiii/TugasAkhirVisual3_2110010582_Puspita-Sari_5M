unit UDM;

interface

uses
  SysUtils, Classes, DB, ADODB, XPMan, frxClass, frxDBSet, MemDS,
  VirtualTable;

type
  TDM = class(TDataModule)
    Koneksi: TADOConnection;
    Command: TADOCommand;
    tpengguna: TADODataSet;
    dstpengguna: TDataSource;
    XP: TXPManifest;
    Laporan: TfrxReport;
    frxpengguna: TfrxDBDataset;
    tukuran: TADODataSet;
    dsukuran: TDataSource;
    frxukuran: TfrxDBDataset;
    tproduk: TADODataSet;
    dsproduk: TDataSource;
    frxproduk: TfrxDBDataset;
    tprodukID: TAutoIncField;
    tproduknama: TWideStringField;
    tprodukid_ukuran: TSmallintField;
    tprodukberat: TFloatField;
    tprodukstok_botol: TIntegerField;
    tprodukstok_dus: TIntegerField;
    tprodukukuran: TStringField;
    tpembelian: TADODataSet;
    dspembelian: TDataSource;
    frxpembelian: TfrxDBDataset;
    tpembelianID: TAutoIncField;
    tpembelianno_faktur: TWideStringField;
    tpembeliantanggal: TDateTimeField;
    tpembelianid_produk: TIntegerField;
    tpembelianjumlah_botol: TIntegerField;
    tpembelianjumlah_dus: TIntegerField;
    tpembeliannama_produk: TStringField;
    tprodukharga_beli_botol: TFloatField;
    tprodukharga_beli_dus: TFloatField;
    tprodukharga_jual_botol: TFloatField;
    tprodukharga_jual_dus: TFloatField;
    tpembelianharga_beli_botol: TFloatField;
    tpembelianharga_beli_dus: TFloatField;
    tpembeliantotal_beli_botol: TFloatField;
    tpembeliantotal_beli_dus: TFloatField;
    tpembeliantotal_semua: TFloatField;
    tpembelianid_pengguna: TIntegerField;
    tpembeliannama_supplier: TStringField;
    tpenjualan: TADODataSet;
    dspenjualan: TDataSource;
    frxpenjualan: TfrxDBDataset;
    tpenjualanID: TAutoIncField;
    tpenjualanno_faktur: TWideStringField;
    tpenjualantanggal: TDateTimeField;
    tpenjualanid_pengguna: TIntegerField;
    tpenjualanid_produk: TIntegerField;
    tpenjualanjumlah_botol: TIntegerField;
    tpenjualanjumlah_dus: TIntegerField;
    tpenjualanharga_jual_botol: TFloatField;
    tpenjualanharga_jual_dus: TFloatField;
    tpenjualantotal_jual_botol: TFloatField;
    tpenjualantotal_jual_dus: TFloatField;
    tpenjualantotal_semua: TFloatField;
    tpenjualannama_pelanggan: TStringField;
    tpenjualannama_produk: TStringField;
    trusakhilang: TADODataSet;
    dsrusakhilang: TDataSource;
    frxrusakhilang: TfrxDBDataset;
    trusakhilangID: TAutoIncField;
    trusakhilangno_transaksi: TWideStringField;
    trusakhilangtanggal: TDateTimeField;
    trusakhilangid_produk: TIntegerField;
    trusakhilangjumlah_botol: TIntegerField;
    trusakhilangjumlah_dus: TIntegerField;
    trusakhilangketerangan: TWideStringField;
    trusakhilangharga_beli_botol: TFloatField;
    trusakhilangharga_beli_dus: TFloatField;
    trusakhilangtotal_beli_botol: TFloatField;
    trusakhilangtotal_beli_dus: TFloatField;
    trusakhilangtotal_semua: TFloatField;
    trusakhilangnama_produk: TStringField;
    VLabaRugi: TVirtualTable;
    frxlabarugi: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses ULogin, UMenu, UPendaftaran;

{$R *.dfm}

end.
