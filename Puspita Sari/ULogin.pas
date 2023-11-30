unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFLogin = class(TForm)
    PanelJudul: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EUsername: TEdit;
    EPassword: TEdit;
    BLogin: TButton;
    BPendaftaran: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BPendaftaranClick(Sender: TObject);
    procedure BLoginClick(Sender: TObject);
    procedure EPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

uses UDM, UPendaftaran, UMenu;

{$R *.dfm}
function Encrypt (const s:string;cryptint:Integer):string;
var
i:integer;
s2:string;
begin
if not (length(s)=0) then
  begin
  for i:=1 to length(s) do
    s2:=s2+chr(ord(s[i])+cryptint);
  result:=s2;
  end
end;

function Decrypt(const s:string;cryptint:Integer):string;
var
i:integer;
s2:string;
begin
if not (length(s)=0) then
  begin
  for i:=1 to length(s) do
    s2:=s2+chr(ord(s[i])-cryptint);
  result:=s2;
  end
end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TFLogin.FormShow(Sender: TObject);
begin
EUsername.Clear;
EPassword.Clear;
DM.tpengguna.Active:=false;
DM.tpengguna.CommandText:='select * from tpengguna';
DM.tpengguna.Active:=true;
end;

procedure TFLogin.BPendaftaranClick(Sender: TObject);
begin
FPendaftaran.Show;
FLogin.Hide;
end;

procedure TFLogin.BLoginClick(Sender: TObject);
var
username,password,level:string;
begin
username:=EUsername.Text;
password:=EPassword.Text;
if DM.tpengguna.Locate('username',username,[])=true then
  begin
  if (DM.tpengguna['password']=Encrypt(password,length(password))) and (DM.tpengguna['status']='Aktif') then
    begin
    level:=DM.tpengguna['level'];

    ShowMessage('Selamat Datang di '+PanelJudul.Caption);
    FMenu.LUsername.Caption:=username;
    FMenu.LLevel.Caption:=level;
    FMenu.LIdPengguna.Caption:=DM.tpengguna['ID'];

    if level='Admin' then
      begin
      FMenu.Master1.Visible:=true;
      FMenu.Transaksi1.Visible:=true;
      FMenu.PembelianProduk1.Visible:=true;
      FMenu.PenjualanProduk1.Visible:=true;
      FMenu.ProdukRusakHilang1.Visible:=true;

      FMenu.Laporan1.Visible:=true;
      FMenu.LaporanPelanggan1.Visible:=true;
      FMenu.LaporanSupplier1.Visible:=true;
      FMenu.LaporanPembelian1.Visible:=true;
      FMenu.LaporanPenjualan1.Visible:=true;
      FMenu.LaporanProdukRusakHilang1.Visible:=true;
      FMenu.LaporanLabaRugi1.Visible:=true;
      end
    else if level='Owner' then
      begin
      FMenu.Master1.Visible:=false;
      FMenu.Transaksi1.Visible:=false;
      FMenu.PembelianProduk1.Visible:=true;
      FMenu.PenjualanProduk1.Visible:=true;
      FMenu.ProdukRusakHilang1.Visible:=true;

      FMenu.Laporan1.Visible:=true;
      FMenu.LaporanPelanggan1.Visible:=true;
      FMenu.LaporanSupplier1.Visible:=true;
      FMenu.LaporanPembelian1.Visible:=true;
      FMenu.LaporanPenjualan1.Visible:=true;
      FMenu.LaporanProdukRusakHilang1.Visible:=true;
      FMenu.LaporanLabaRugi1.Visible:=true;
      end
    else if level='Karyawan' then
      begin
      FMenu.Master1.Visible:=false;
      FMenu.Transaksi1.Visible:=true;
      FMenu.PembelianProduk1.Visible:=false;
      FMenu.PenjualanProduk1.Visible:=false;
      FMenu.ProdukRusakHilang1.Visible:=true;

      FMenu.Laporan1.Visible:=false;
      FMenu.LaporanPelanggan1.Visible:=true;
      FMenu.LaporanSupplier1.Visible:=true;
      FMenu.LaporanPembelian1.Visible:=true;
      FMenu.LaporanPenjualan1.Visible:=true;
      FMenu.LaporanProdukRusakHilang1.Visible:=true;
      FMenu.LaporanLabaRugi1.Visible:=true;
      end
    else if level='Pelanggan' then
      begin
      FMenu.Master1.Visible:=false;
      FMenu.Transaksi1.Visible:=true;
      FMenu.PembelianProduk1.Visible:=false;
      FMenu.PenjualanProduk1.Visible:=true;
      FMenu.ProdukRusakHilang1.Visible:=false;

      FMenu.Laporan1.Visible:=false;
      FMenu.LaporanPelanggan1.Visible:=true;
      FMenu.LaporanSupplier1.Visible:=true;
      FMenu.LaporanPembelian1.Visible:=true;
      FMenu.LaporanPenjualan1.Visible:=true;
      FMenu.LaporanProdukRusakHilang1.Visible:=true;
      FMenu.LaporanLabaRugi1.Visible:=true;
      end
    else if level='Supplier' then
      begin
      FMenu.Master1.Visible:=false;
      FMenu.Transaksi1.Visible:=true;
      FMenu.PembelianProduk1.Visible:=true;
      FMenu.PenjualanProduk1.Visible:=false;
      FMenu.ProdukRusakHilang1.Visible:=false;

      FMenu.Laporan1.Visible:=false;
      FMenu.LaporanPelanggan1.Visible:=true;
      FMenu.LaporanSupplier1.Visible:=true;
      FMenu.LaporanPembelian1.Visible:=true;
      FMenu.LaporanPenjualan1.Visible:=true;
      FMenu.LaporanProdukRusakHilang1.Visible:=true;
      FMenu.LaporanLabaRugi1.Visible:=true;
      end      ;

    FMenu.Show;
    FLogin.Hide;
    end
  else
    ShowMessage('Password salah atau akun belum diaktivasi admin!');
  end
else
  ShowMessage('Username tidak terdaftar!Silahkan lakukan pendaftaran terlebih dahulu');
end;

procedure TFLogin.EPasswordKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then BLogin.Click;
end;

end.
