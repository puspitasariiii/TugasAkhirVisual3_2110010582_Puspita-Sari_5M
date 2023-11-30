unit URusakHilang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, ComCtrls;

type
  TFRusakHilang = class(TForm)
    Panel1: TPanel;
    GData: TGroupBox;
    GButton: TGroupBox;
    Label1: TLabel;
    ENoTransaksi: TEdit;
    BSimpan: TBitBtn;
    BTambah: TBitBtn;
    BUbah: TBitBtn;
    BHapus: TBitBtn;
    BBatal: TBitBtn;
    BKeluar: TBitBtn;
    GridData: TDBGrid;
    GCari: TGroupBox;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    DTanggal: TDateTimePicker;
    CProduk: TDBLookupComboBox;
    EJumlahBotol: TEdit;
    EJumlahDus: TEdit;
    ECari: TEdit;
    BRefresh: TBitBtn;
    Label8: TLabel;
    EKeterangan: TEdit;
    procedure refreshdata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BTambahClick(Sender: TObject);
    procedure BUbahClick(Sender: TObject);
    procedure BHapusClick(Sender: TObject);
    procedure BRefreshClick(Sender: TObject);
    procedure BBatalClick(Sender: TObject);
    procedure BSimpanClick(Sender: TObject);
    procedure GridDataCellClick(Column: TColumn);
    procedure BKeluarClick(Sender: TObject);
    procedure ECariChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRusakHilang: TFRusakHilang;

implementation

uses UDM, UMenu;

{$R *.dfm}

procedure TFRusakHilang.refreshdata;
begin
DM.tproduk.Active:=false;
DM.tproduk.CommandText:='select * from tproduk';
DM.tproduk.Active:=true;
DM.trusakhilang.Active:=false;
DM.trusakhilang.CommandText:='select * from trusakhilang';
DM.trusakhilang.Active:=true;
end;

procedure TFRusakHilang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
Frusakhilang.Hide;
end;

procedure TFRusakHilang.FormShow(Sender: TObject);
begin
DTanggal.Date:=Now();
ENoTransaksi.Clear;
CProduk.KeyValue:=1;
EJumlahBotol.Text:='0';
EJumlahDus.Text:='0';
EKeterangan.Clear;

BTambah.Enabled:=true;
BUbah.Enabled:=false;
BHapus.Enabled:=false;
BBatal.Enabled:=false;
BSimpan.Enabled:=false;
BKeluar.Enabled:=true;
BRefresh.Enabled:=true;

GData.Enabled:=false;
GridData.Enabled:=true;
GCari.Enabled:=true;

ECari.Clear;
refreshdata;
end;

procedure TFRusakHilang.BTambahClick(Sender: TObject);
var
kode:string;
nomorlama:integer;
begin
DTanggal.Date:=Now();
ENoTransaksi.Clear;
CProduk.KeyValue:=1;
EJumlahBotol.Text:='0';
EJumlahDus.Text:='0';
EKeterangan.Clear;

BTambah.Enabled:=true;
BUbah.Enabled:=false;
BHapus.Enabled:=false;
BBatal.Enabled:=true;
BSimpan.Enabled:=true;
BKeluar.Enabled:=false;
BRefresh.Enabled:=false;

GData.Enabled:=true;
GridData.Enabled:=false;
GCari.Enabled:=false;

ECari.Clear;
refreshdata;
DTanggal.SetFocus;

DM.trusakhilang.Active:=false;
DM.trusakhilang.CommandText:='select * from trusakhilang order by id asc';
DM.trusakhilang.Active:=true;

if DM.trusakhilang.IsEmpty=true then
  begin
  kode:='H00001';
  enotransaksi.Text:=kode;
  end
else
  begin
  DM.trusakhilang.Last;
  nomorlama:=StrToInt(copy(DM.trusakhilang['no_transaksi'],2,6));
  kode:='H'+Format('%.6d', [nomorlama+1]);
  enotransaksi.Text:=kode;
  end
end;

procedure TFRusakHilang.BUbahClick(Sender: TObject);
begin
BTambah.Enabled:=false;
BUbah.Enabled:=true;
BHapus.Enabled:=false;
BBatal.Enabled:=true;
BSimpan.Enabled:=true;
BKeluar.Enabled:=false;
BRefresh.Enabled:=false;

GData.Enabled:=true;
GridData.Enabled:=false;
GCari.Enabled:=false;
DTanggal.SetFocus;
end;

procedure TFRusakHilang.BHapusClick(Sender: TObject);
var
stok_botol_lama,stok_dus_lama,id_rusakhilang:integer;
begin
if DM.trusakhilang.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    id_rusakhilang:=DM.trusakhilang['ID'];
    stok_botol_lama:=DM.trusakhilang['jumlah_botol'];
    stok_dus_lama:=DM.trusakhilang['jumlah_dus'];    
    DM.trusakhilang.Delete;
    //update stok
    DM.tproduk.Locate('ID',id_rusakhilang,[]);
    DM.tproduk.Edit;
    DM.tproduk['stok_botol']:=DM.tproduk['stok_botol']+stok_botol_lama;
    DM.tproduk['stok_dus']:=DM.tproduk['stok_dus']+stok_dus_lama;
    DM.tproduk.Post;
    
    ShowMessage('Berhasil menghapus data');
    BRefresh.Click;
    end
  end
end;

procedure TFRusakHilang.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFRusakHilang.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFRusakHilang.BSimpanClick(Sender: TObject);
var
stok_botol_lama,stok_dus_lama,stok_botol_baru,stok_dus_baru,stok_botol_akhir,stok_dus_akhir:integer;
beli_botol_lama,beli_dus_lama:integer;
total_beli_botol,total_beli_dus,total_semua:real;
begin
if messagedlg('Apakah anda ingin menyimpan data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
  begin
  if (EJumlahBotol.Text='') or (EJumlahDus.Text='') then
    begin
    ShowMessage('Mohon lengkapi form sebelum disimpan!');
    EJumlahBotol.SetFocus;
    end
  else
    begin
    if BTambah.Enabled=true then
      begin
      DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
      stok_botol_lama:=DM.tproduk['stok_botol'];
      stok_dus_lama:=DM.tproduk['stok_dus'];
      if (stok_botol_lama-StrToInt(EJumlahBotol.Text)<0) then
        ShowMessage('Maaf stok botol tidak cukup untuk produk ini')
      else if (stok_dus_lama-StrToInt(EJumlahDus.Text)<0) then
        ShowMessage('Maaf stok dus tidak cukup untuk produk ini')
      else
      begin
      DM.trusakhilang.Append;
      DM.trusakhilang['no_transaksi']:=enotransaksi.Text;
      DM.trusakhilang['tanggal']:=DateToStr(DTanggal.Date);
      DM.trusakhilang['id_produk']:=CProduk.KeyValue;
      DM.trusakhilang['jumlah_botol']:=EJumlahBotol.Text;
      DM.trusakhilang['jumlah_dus']:=EJumlahDus.Text;
      DM.trusakhilang['keterangan']:=EKeterangan.Text;      
      DM.trusakhilang['harga_beli_botol']:=DM.tproduk['harga_beli_botol'];
      DM.trusakhilang['harga_beli_dus']:=DM.tproduk['harga_beli_dus'];
      total_beli_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_beli_botol']);
      total_beli_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_beli_dus']);
      total_semua:=total_beli_botol+total_beli_dus;
      DM.trusakhilang['total_beli_botol']:=total_beli_botol;
      DM.trusakhilang['total_beli_dus']:=total_beli_dus;
      DM.trusakhilang['total_semua']:=total_semua;
      DM.trusakhilang.Post;
            //update stok
      DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
      stok_botol_lama:=DM.tproduk['stok_botol'];
      stok_dus_lama:=DM.tproduk['stok_dus'];
      stok_botol_baru:=StrToInt(EJumlahBotol.Text);
      stok_dus_baru:=StrToInt(EJumlahDus.Text);
      stok_botol_akhir:=stok_botol_lama-stok_botol_baru-beli_botol_lama;
      stok_dus_akhir:=stok_dus_lama-stok_dus_baru-beli_dus_lama;
      DM.tproduk.Edit;
      DM.tproduk['stok_botol']:=stok_botol_akhir;
      DM.tproduk['stok_dus']:=stok_dus_akhir;
      DM.tproduk.Post;

      ShowMessage('Selamat!Data baru berhasil disimpan!');
      BRefresh.Click;
      end
    end
    else if  BUbah.Enabled=true then
      begin
      DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
      stok_botol_lama:=DM.tproduk['stok_botol'];
      stok_dus_lama:=DM.tproduk['stok_dus'];

      beli_botol_lama:=StrToInt(DM.trusakhilang['jumlah_botol']);
      beli_dus_lama:=StrToInt(DM.trusakhilang['jumlah_dus']);
        if ((stok_botol_lama+beli_botol_lama)-StrToInt(EJumlahBotol.Text)<0) then
        ShowMessage('Maaf stok botol tidak cukup untuk produk ini')
      else if ((stok_dus_lama+beli_dus_lama)-StrToInt(EJumlahDus.Text)<0) then
        ShowMessage('Maaf stok dus tidak cukup untuk produk ini')
      else
        begin
        DM.trusakhilang.Edit;
        DM.trusakhilang['no_transaksi']:=enotransaksi.Text;
        DM.trusakhilang['tanggal']:=DateToStr(DTanggal.Date);
        DM.trusakhilang['id_produk']:=CProduk.KeyValue;
        DM.trusakhilang['jumlah_botol']:=EJumlahBotol.Text;
        DM.trusakhilang['jumlah_dus']:=EJumlahDus.Text;
        DM.trusakhilang['keterangan']:=EKeterangan.Text;        
        DM.trusakhilang['harga_beli_botol']:=DM.tproduk['harga_beli_botol'];
        DM.trusakhilang['harga_beli_dus']:=DM.tproduk['harga_beli_dus'];
        total_beli_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_beli_botol']);
        total_beli_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_beli_dus']);
        total_semua:=total_beli_botol+total_beli_dus;
        DM.trusakhilang['total_beli_botol']:=total_beli_botol;
        DM.trusakhilang['total_beli_dus']:=total_beli_dus;
        DM.trusakhilang['total_semua']:=total_semua;
        DM.trusakhilang.Post;

        //update stok
        stok_botol_lama:=DM.tproduk['stok_botol'];
        stok_dus_lama:=DM.tproduk['stok_dus'];
        stok_botol_baru:=StrToInt(EJumlahBotol.Text);
        stok_dus_baru:=StrToInt(EJumlahDus.Text);
        stok_botol_akhir:=stok_botol_lama+beli_botol_lama-stok_botol_baru;
        stok_dus_akhir:=stok_dus_lama+beli_dus_lama-stok_dus_baru;
        DM.tproduk.Edit;
        DM.tproduk['stok_botol']:=stok_botol_akhir;
        DM.tproduk['stok_dus']:=stok_dus_akhir;
        DM.tproduk.Post;
        ShowMessage('Selamat!Data lama berhasil disimpan!');
        BRefresh.Click;
        end
      end
  end
 end
end;

procedure TFRusakHilang.GridDataCellClick(Column: TColumn);
begin
if DM.trusakhilang.IsEmpty=false then
  begin
  DTanggal.Date:=DM.trusakhilang['tanggal'];
  CProduk.KeyValue:=DM.trusakhilang['id_produk'];
  enotransaksi.Text:=DM.trusakhilang['no_transaksi'];
  EJumlahBotol.Text:=DM.trusakhilang['jumlah_botol'];
  EJumlahDus.Text:=DM.trusakhilang['jumlah_dus'];

  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFRusakHilang.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
Frusakhilang.Hide;
end;

procedure TFRusakHilang.ECariChange(Sender: TObject);
begin
DM.trusakhilang.Active:=false;
DM.trusakhilang.CommandText:='select * from trusakhilang where keterangan like '+QuotedStr('%'+ECari.Text+'%');
DM.trusakhilang.Active:=true;
end;

end.
