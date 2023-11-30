unit UPembelian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, ComCtrls;

type
  TFPembelian = class(TForm)
    Panel1: TPanel;
    GData: TGroupBox;
    GButton: TGroupBox;
    Label1: TLabel;
    ENoFaktur: TEdit;
    BSimpan: TBitBtn;
    BTambah: TBitBtn;
    BUbah: TBitBtn;
    BHapus: TBitBtn;
    BBatal: TBitBtn;
    BKeluar: TBitBtn;
    GridData: TDBGrid;
    GCari: TGroupBox;
    Label5: TLabel;
    BRefresh: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    DCari: TDateTimePicker;
    DTanggal: TDateTimePicker;
    Label7: TLabel;
    CPengguna: TDBLookupComboBox;
    CProduk: TDBLookupComboBox;
    EJumlahBotol: TEdit;
    EJumlahDus: TEdit;
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
    procedure DCariChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPembelian: TFPembelian;

implementation

uses UDM, UMenu;

{$R *.dfm}

procedure TFPembelian.refreshdata;
begin
if FMenu.LLevel.Caption='Supplier' then
  begin
  DM.tpengguna.Active:=false;
  DM.tpengguna.CommandText:='select * from tpengguna where ID like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpengguna.Active:=true;

  DM.tpembelian.Active:=false;
  DM.tpembelian.CommandText:='select * from tpembelian where id_pengguna like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpembelian.Active:=true;
  end
else
  begin
  DM.tpengguna.Active:=false;
  DM.tpengguna.CommandText:='select * from tpengguna where level like '+QuotedStr('Supplier');
  DM.tpengguna.Active:=true;
  DM.tpembelian.Active:=false;
  DM.tpembelian.CommandText:='select * from tpembelian';
  DM.tpembelian.Active:=true;
  end;
DM.tproduk.Active:=false;
DM.tproduk.CommandText:='select * from tproduk';
DM.tproduk.Active:=true;

end;

procedure TFPembelian.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
FPembelian.Hide;
end;

procedure TFPembelian.FormShow(Sender: TObject);
begin
DTanggal.Date:=Now();
ENoFaktur.Clear;
CPengguna.KeyValue:=1;
CProduk.KeyValue:=1;
EJumlahBotol.Text:='0';
EJumlahDus.Text:='0';

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

DCari.Date:=Now();
refreshdata;
end;

procedure TFPembelian.BTambahClick(Sender: TObject);
var
kode:string;
nomorlama:integer;
begin
DTanggal.Date:=Now();
ENoFaktur.Clear;
CPengguna.KeyValue:=1;
CProduk.KeyValue:=1;
EJumlahBotol.Text:='0';
EJumlahDus.Text:='0';

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

DCari.Date:=Now();
refreshdata;
DTanggal.SetFocus;

DM.tpembelian.Active:=false;
DM.tpembelian.CommandText:='select * from tpembelian order by id asc';
DM.tpembelian.Active:=true;

if DM.tpembelian.IsEmpty=true then
  begin
  kode:='B00001';
  ENoFaktur.Text:=kode;
  end
else
  begin
  DM.tpembelian.Last;
  nomorlama:=StrToInt(copy(DM.tpembelian['no_faktur'],2,6));
  kode:='B'+Format('%.6d', [nomorlama+1]);
  ENoFaktur.Text:=kode;
  end;
refreshdata;
end;

procedure TFPembelian.BUbahClick(Sender: TObject);
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

procedure TFPembelian.BHapusClick(Sender: TObject);
var
stok_botol_lama,stok_dus_lama,id_pembelian:integer;
begin
if DM.tpembelian.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    id_pembelian:=DM.tpembelian['ID'];
    stok_botol_lama:=DM.tpembelian['jumlah_botol'];
    stok_dus_lama:=DM.tpembelian['jumlah_dus'];    
    DM.tpembelian.Delete;
    //update stok
    DM.tproduk.Locate('ID',id_pembelian,[]);
    DM.tproduk.Edit;
    DM.tproduk['stok_botol']:=DM.tproduk['stok_botol']-stok_botol_lama;
    DM.tproduk['stok_dus']:=DM.tproduk['stok_dus']-stok_dus_lama;
    DM.tproduk.Post;
    
    ShowMessage('Berhasil menghapus data');
    BRefresh.Click;
    end
  end
end;

procedure TFPembelian.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPembelian.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPembelian.BSimpanClick(Sender: TObject);
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
      DM.tpembelian.Append;
      DM.tpembelian['no_faktur']:=ENoFaktur.Text;
      DM.tpembelian['tanggal']:=DateToStr(DTanggal.Date);
      DM.tpembelian['id_pengguna']:=CPengguna.KeyValue;
      DM.tpembelian['id_produk']:=CProduk.KeyValue;
      DM.tpembelian['jumlah_botol']:=EJumlahBotol.Text;
      DM.tpembelian['jumlah_dus']:=EJumlahDus.Text;
      DM.tpembelian['harga_beli_botol']:=DM.tproduk['harga_beli_botol'];
      DM.tpembelian['harga_beli_dus']:=DM.tproduk['harga_beli_dus'];
      total_beli_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_beli_botol']);
      total_beli_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_beli_dus']);
      total_semua:=total_beli_botol+total_beli_dus;
      DM.tpembelian['total_beli_botol']:=total_beli_botol;
      DM.tpembelian['total_beli_dus']:=total_beli_dus;
      DM.tpembelian['total_semua']:=total_semua;
      DM.tpembelian.Post;
      //update stok
      DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
      stok_botol_lama:=DM.tproduk['stok_botol'];
      stok_dus_lama:=DM.tproduk['stok_dus'];
      stok_botol_baru:=StrToInt(EJumlahBotol.Text);
      stok_dus_baru:=StrToInt(EJumlahDus.Text);
      stok_botol_akhir:=stok_botol_lama+stok_botol_baru+beli_botol_lama;
      stok_dus_akhir:=stok_dus_lama+stok_dus_baru+beli_dus_lama;
      DM.tproduk.Edit;
      DM.tproduk['stok_botol']:=stok_botol_akhir;
      DM.tproduk['stok_dus']:=stok_dus_akhir;
      DM.tproduk.Post;

      ShowMessage('Selamat!Data baru berhasil disimpan!');
      BRefresh.Click;
      end
  else if  BUbah.Enabled=true then
    begin
    DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
    beli_botol_lama:=StrToInt(DM.tpembelian['jumlah_botol']);
    beli_dus_lama:=StrToInt(DM.tpembelian['jumlah_dus']);
    DM.tpembelian.Edit;
    DM.tpembelian['no_faktur']:=ENoFaktur.Text;
    DM.tpembelian['tanggal']:=DateToStr(DTanggal.Date);
    DM.tpembelian['id_pengguna']:=CPengguna.KeyValue;    
    DM.tpembelian['id_produk']:=CProduk.KeyValue;
    DM.tpembelian['jumlah_botol']:=EJumlahBotol.Text;
    DM.tpembelian['jumlah_dus']:=EJumlahDus.Text;
    DM.tpembelian['harga_beli_botol']:=DM.tproduk['harga_beli_botol'];
    DM.tpembelian['harga_beli_dus']:=DM.tproduk['harga_beli_dus'];
    total_beli_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_beli_botol']);
    total_beli_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_beli_dus']);
    total_semua:=total_beli_botol+total_beli_dus;
    DM.tpembelian['total_beli_botol']:=total_beli_botol;
    DM.tpembelian['total_beli_dus']:=total_beli_dus;
    DM.tpembelian['total_semua']:=total_semua;
    DM.tpembelian.Post;

    //update stok
    stok_botol_lama:=DM.tproduk['stok_botol'];
    stok_dus_lama:=DM.tproduk['stok_dus'];
    stok_botol_baru:=StrToInt(EJumlahBotol.Text);
    stok_dus_baru:=StrToInt(EJumlahDus.Text);
    stok_botol_akhir:=stok_botol_lama-beli_botol_lama+stok_botol_baru;
    stok_dus_akhir:=stok_dus_lama-beli_dus_lama+stok_dus_baru;
    DM.tproduk.Edit;
    DM.tproduk['stok_botol']:=stok_botol_akhir;
    DM.tproduk['stok_dus']:=stok_dus_akhir;
    DM.tproduk.Post;
    
    ShowMessage('Selamat!Data lama berhasil disimpan!');
    BRefresh.Click;
    end
  end
 end
end;

procedure TFPembelian.GridDataCellClick(Column: TColumn);
begin
if DM.tpembelian.IsEmpty=false then
  begin
  DTanggal.Date:=DM.tpembelian['tanggal'];
  CPengguna.KeyValue:=DM.tpembelian['id_pengguna'];
  CProduk.KeyValue:=DM.tpembelian['id_produk'];
  ENoFaktur.Text:=DM.tpembelian['no_faktur'];
  EJumlahBotol.Text:=DM.tpembelian['jumlah_botol'];
  EJumlahDus.Text:=DM.tpembelian['jumlah_dus'];

  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFPembelian.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
FPembelian.Hide;
end;

procedure TFPembelian.DCariChange(Sender: TObject);
begin
if FMenu.LLevel.Caption='Supplier' then
  begin
  DM.tpembelian.Active:=false;
  DM.tpembelian.CommandText:='select * from tpembelian where tanggal like '+QuotedStr('%'+DateToStr(DCari.Date)+'%')+' and id_pengguna like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpembelian.Active:=true;
  end
else
  begin
  DM.tpembelian.Active:=false;
  DM.tpembelian.CommandText:='select * from tpembelian where tanggal like '+QuotedStr('%'+DateToStr(DCari.Date)+'%');
  DM.tpembelian.Active:=true;
  end
end;

end.
