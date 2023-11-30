unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, Menus;

type
  TFMenu = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    LUsername: TLabel;
    LLevel: TLabel;
    MainMenu1: TMainMenu;
    Master1: TMenuItem;
    Transaksi1: TMenuItem;
    Laporan1: TMenuItem;
    Pengaturan1: TMenuItem;
    UbahPassword1: TMenuItem;
    Keluar1: TMenuItem;
    DataPengguna1: TMenuItem;
    DataProduk1: TMenuItem;
    DataUkuran1: TMenuItem;
    PembelianProduk1: TMenuItem;
    PenjualanProduk1: TMenuItem;
    ProdukRusakHilang1: TMenuItem;
    LaporanPelanggan1: TMenuItem;
    LaporanSupplier1: TMenuItem;
    LaporanProduk1: TMenuItem;
    LaporanPembelian1: TMenuItem;
    LaporanPenjualan1: TMenuItem;
    LaporanProdukRusakHilang1: TMenuItem;
    LaporanLabaRugi1: TMenuItem;
    LIdPengguna: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataPengguna1Click(Sender: TObject);
    procedure DataUkuran1Click(Sender: TObject);
    procedure DataProduk1Click(Sender: TObject);
    procedure PembelianProduk1Click(Sender: TObject);
    procedure PenjualanProduk1Click(Sender: TObject);
    procedure ProdukRusakHilang1Click(Sender: TObject);
    procedure LaporanPelanggan1Click(Sender: TObject);
    procedure LaporanSupplier1Click(Sender: TObject);
    procedure LaporanProduk1Click(Sender: TObject);
    procedure LaporanPembelian1Click(Sender: TObject);
    procedure LaporanPenjualan1Click(Sender: TObject);
    procedure LaporanProdukRusakHilang1Click(Sender: TObject);
    procedure LaporanLabaRugi1Click(Sender: TObject);
    procedure Keluar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMenu: TFMenu;

implementation

uses UDM, ULogin, UPendaftaran, UPengguna, UUkuran, UProduk, UPembelian,
  UPenjualan, URusakHilang;

{$R *.dfm}

procedure TFMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FLogin.Show;
FMenu.Hide;
end;

procedure TFMenu.DataPengguna1Click(Sender: TObject);
begin
FPengguna.Show;
FMenu.Hide;
end;

procedure TFMenu.DataUkuran1Click(Sender: TObject);
begin
FUkuran.Show;
FMenu.Hide;
end;

procedure TFMenu.DataProduk1Click(Sender: TObject);
begin
FProduk.Show;
FMenu.Hide;
end;

procedure TFMenu.PembelianProduk1Click(Sender: TObject);
begin
FPembelian.Show;
FMenu.Hide;
end;

procedure TFMenu.PenjualanProduk1Click(Sender: TObject);
begin
FPenjualan.Show;
FMenu.Hide;
end;

procedure TFMenu.ProdukRusakHilang1Click(Sender: TObject);
begin
FRusakHilang.Show;
FMenu.Hide;
end;

procedure TFMenu.LaporanPelanggan1Click(Sender: TObject);
begin
DM.tpengguna.Active:=false;
DM.tpengguna.CommandText:='select * From tpengguna where level like '+QuotedStr('Pelanggan');
DM.tpengguna.Active:=true;
if DM.tpengguna.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LPelanggan.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanSupplier1Click(Sender: TObject);
begin
DM.tpengguna.Active:=false;
DM.tpengguna.CommandText:='select * From tpengguna where level like '+QuotedStr('Supplier');
DM.tpengguna.Active:=true;
if DM.tpengguna.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LSupplier.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanProduk1Click(Sender: TObject);
begin
DM.tproduk.Active:=false;
DM.tproduk.CommandText:='select * From tproduk';
DM.tproduk.Active:=true;
if DM.tproduk.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LProduk.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanPembelian1Click(Sender: TObject);
begin
DM.tpembelian.Active:=false;
DM.tpembelian.CommandText:='select * from tpembelian';
DM.tpembelian.Active:=true;
if DM.tpembelian.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LPembelian.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanPenjualan1Click(Sender: TObject);
begin
DM.tpenjualan.Active:=false;
DM.tpenjualan.CommandText:='select * from tpenjualan';
DM.tpenjualan.Active:=true;
if DM.tpenjualan.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LPenjualan.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanProdukRusakHilang1Click(Sender: TObject);
begin
DM.trusakhilang.Active:=false;
DM.trusakhilang.CommandText:='select * from trusakhilang';
DM.trusakhilang.Active:=true;
if DM.trusakhilang.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LRusakHilang.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.LaporanLabaRugi1Click(Sender: TObject);
var
totalpenjualan,totalpembelian,totalrusakhilang,totallabarugi:integer;
keterangan:string;
begin
DM.tpenjualan.Active:=false;
DM.tpenjualan.CommandText:='select * from tpenjualan';
DM.tpenjualan.Active:=true;
totalpenjualan:=0;
if DM.tpenjualan.IsEmpty=false then
  begin
  repeat
  totalpenjualan:=totalpenjualan+DM.tpenjualan['total_semua'];
  DM.tpenjualan.Next;
  until DM.tpenjualan.Eof=true;
  end;
DM.tpembelian.Active:=false;
DM.tpembelian.CommandText:='select * from tpembelian';
DM.tpembelian.Active:=true;
totalpembelian:=0;
if DM.tpembelian.IsEmpty=false then
  begin
  repeat
  totalpembelian:=totalpembelian+DM.tpembelian['total_semua'];
  DM.tpembelian.Next;
  until DM.tpembelian.Eof=true;
  end;
DM.trusakhilang.Active:=false;
DM.trusakhilang.CommandText:='select * from trusakhilang';
DM.trusakhilang.Active:=true;
totalrusakhilang:=0;
if DM.trusakhilang.IsEmpty=false then
  begin
  repeat
  totalrusakhilang:=totalrusakhilang+DM.trusakhilang['total_semua'];
  DM.trusakhilang.Next;
  until DM.trusakhilang.Eof=true;
  end;
totallabarugi:=totalpenjualan-(totalpembelian+totalrusakhilang);
if totallabarugi<0 then keterangan:='Rugi' else keterangan:='Laba';

if DM.VLabaRugi.IsEmpty=false then
  begin
  repeat
  DM.VLabaRugi.Delete;
  until DM.VLabaRugi.IsEmpty=true;
  end;

  DM.VLabaRugi.Append;
  DM.VLabaRugi['total_penjualan']:=totalpenjualan;
  DM.VLabaRugi['total_pembelian']:=totalpembelian;
  DM.VLabaRugi['total_rusakhilang']:=totalrusakhilang;
  DM.VLabaRugi['total_labarugi']:=totallabarugi;
  DM.VLabaRugi['keterangan']:=keterangan;
  DM.VLabaRugi.Post;

if DM.VLabaRugi.IsEmpty=true then
  ShowMessage('Maaf data tidak ditemukan')
else
  begin
  DM.Laporan.LoadFromFile('LLabaRugi.fr3');
  DM.Laporan.ShowReport();
  end;
end;

procedure TFMenu.Keluar1Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
