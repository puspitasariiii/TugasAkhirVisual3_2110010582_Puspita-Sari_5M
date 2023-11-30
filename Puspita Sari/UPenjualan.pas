unit UPenjualan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, ComCtrls;

type
  TFPenjualan = class(TForm)
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
  FPenjualan: TFPenjualan;

implementation

uses UDM, UMenu;

{$R *.dfm}

procedure TFPenjualan.refreshdata;
begin
if FMenu.LLevel.Caption='Pelanggan' then
  begin
  DM.tpengguna.Active:=false;
  DM.tpengguna.CommandText:='select * from tpengguna where ID like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpengguna.Active:=true;

  DM.tpenjualan.Active:=false;
  DM.tpenjualan.CommandText:='select * from tpenjualan where id_pengguna like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpenjualan.Active:=true;
  end
else
  begin
  DM.tpengguna.Active:=false;
  DM.tpengguna.CommandText:='select * from tpengguna where level like '+QuotedStr('Supplier');
  DM.tpengguna.Active:=true;
  DM.tpenjualan.Active:=false;
  DM.tpenjualan.CommandText:='select * from tpenjualan';
  DM.tpenjualan.Active:=true;
  end;
end;

procedure TFPenjualan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
Fpenjualan.Hide;
end;

procedure TFPenjualan.FormShow(Sender: TObject);
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

procedure TFPenjualan.BTambahClick(Sender: TObject);
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

DM.tpenjualan.Active:=false;
DM.tpenjualan.CommandText:='select * from tpenjualan order by id asc';
DM.tpenjualan.Active:=true;

if DM.tpenjualan.IsEmpty=true then
  begin
  kode:='J00001';
  ENoFaktur.Text:=kode;
  end
else
  begin
  DM.tpenjualan.Last;
  nomorlama:=StrToInt(copy(DM.tpenjualan['no_faktur'],2,6));
  kode:='J'+Format('%.6d', [nomorlama+1]);
  ENoFaktur.Text:=kode;
  end;
refreshdata;
end;

procedure TFPenjualan.BUbahClick(Sender: TObject);
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

procedure TFPenjualan.BHapusClick(Sender: TObject);
var
stok_botol_lama,stok_dus_lama,id_penjualan:integer;
begin
if DM.tpenjualan.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    id_penjualan:=DM.tpenjualan['ID'];
    stok_botol_lama:=DM.tpenjualan['jumlah_botol'];
    stok_dus_lama:=DM.tpenjualan['jumlah_dus'];    
    DM.tpenjualan.Delete;
    //update stok
    DM.tproduk.Locate('ID',id_penjualan,[]);
    DM.tproduk.Edit;
    DM.tproduk['stok_botol']:=DM.tproduk['stok_botol']+stok_botol_lama;
    DM.tproduk['stok_dus']:=DM.tproduk['stok_dus']+stok_dus_lama;
    DM.tproduk.Post;
    
    ShowMessage('Berhasil menghapus data');
    BRefresh.Click;
    end
  end
end;

procedure TFPenjualan.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPenjualan.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPenjualan.BSimpanClick(Sender: TObject);
var
stok_botol_lama,stok_dus_lama,stok_botol_baru,stok_dus_baru,stok_botol_akhir,stok_dus_akhir:integer;
jual_botol_lama,jual_dus_lama:integer;
total_jual_botol,total_jual_dus,total_semua:real;
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
      DM.tpenjualan.Append;
      DM.tpenjualan['no_faktur']:=ENoFaktur.Text;
      DM.tpenjualan['tanggal']:=DateToStr(DTanggal.Date);
      DM.tpenjualan['id_pengguna']:=CPengguna.KeyValue;
      DM.tpenjualan['id_produk']:=CProduk.KeyValue;
      DM.tpenjualan['jumlah_botol']:=EJumlahBotol.Text;
      DM.tpenjualan['jumlah_dus']:=EJumlahDus.Text;
      DM.tpenjualan['harga_jual_botol']:=DM.tproduk['harga_jual_botol'];
      DM.tpenjualan['harga_jual_dus']:=DM.tproduk['harga_jual_dus'];
      total_jual_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_jual_botol']);
      total_jual_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_jual_dus']);
      total_semua:=total_jual_botol+total_jual_dus;
      DM.tpenjualan['total_jual_botol']:=total_jual_botol;
      DM.tpenjualan['total_jual_dus']:=total_jual_dus;
      DM.tpenjualan['total_semua']:=total_semua;
      DM.tpenjualan.Post;
            //update stok
      DM.tproduk.Locate('ID',CProduk.KeyValue,[]);
      stok_botol_lama:=DM.tproduk['stok_botol'];
      stok_dus_lama:=DM.tproduk['stok_dus'];
      stok_botol_baru:=StrToInt(EJumlahBotol.Text);
      stok_dus_baru:=StrToInt(EJumlahDus.Text);
      stok_botol_akhir:=stok_botol_lama-stok_botol_baru-jual_botol_lama;
      stok_dus_akhir:=stok_dus_lama-stok_dus_baru-jual_dus_lama;
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

      jual_botol_lama:=StrToInt(DM.tpenjualan['jumlah_botol']);
      jual_dus_lama:=StrToInt(DM.tpenjualan['jumlah_dus']);
        if ((stok_botol_lama+jual_botol_lama)-StrToInt(EJumlahBotol.Text)<0) then
        ShowMessage('Maaf stok botol tidak cukup untuk produk ini')
      else if ((stok_dus_lama+jual_dus_lama)-StrToInt(EJumlahDus.Text)<0) then
        ShowMessage('Maaf stok dus tidak cukup untuk produk ini')
      else
        begin
        DM.tpenjualan.Edit;
        DM.tpenjualan['no_faktur']:=ENoFaktur.Text;
        DM.tpenjualan['tanggal']:=DateToStr(DTanggal.Date);
        DM.tpenjualan['id_pengguna']:=CPengguna.KeyValue;
        DM.tpenjualan['id_produk']:=CProduk.KeyValue;
        DM.tpenjualan['jumlah_botol']:=EJumlahBotol.Text;
        DM.tpenjualan['jumlah_dus']:=EJumlahDus.Text;
        DM.tpenjualan['harga_jual_botol']:=DM.tproduk['harga_jual_botol'];
        DM.tpenjualan['harga_jual_dus']:=DM.tproduk['harga_jual_dus'];
        total_jual_botol:=StrToInt(EJumlahBotol.Text)*StrToInt(DM.tproduk['harga_jual_botol']);
        total_jual_dus:=StrToInt(EJumlahDus.Text)*StrToInt(DM.tproduk['harga_jual_dus']);
        total_semua:=total_jual_botol+total_jual_dus;
        DM.tpenjualan['total_jual_botol']:=total_jual_botol;
        DM.tpenjualan['total_jual_dus']:=total_jual_dus;
        DM.tpenjualan['total_semua']:=total_semua;
        DM.tpenjualan.Post;

        //update stok
        stok_botol_lama:=DM.tproduk['stok_botol'];
        stok_dus_lama:=DM.tproduk['stok_dus'];
        stok_botol_baru:=StrToInt(EJumlahBotol.Text);
        stok_dus_baru:=StrToInt(EJumlahDus.Text);
        stok_botol_akhir:=stok_botol_lama+jual_botol_lama-stok_botol_baru;
        stok_dus_akhir:=stok_dus_lama+jual_dus_lama-stok_dus_baru;
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

procedure TFPenjualan.GridDataCellClick(Column: TColumn);
begin
if DM.tpenjualan.IsEmpty=false then
  begin
  DTanggal.Date:=DM.tpenjualan['tanggal'];
  CPengguna.KeyValue:=DM.tpenjualan['id_pengguna'];
  CProduk.KeyValue:=DM.tpenjualan['id_produk'];
  ENoFaktur.Text:=DM.tpenjualan['no_faktur'];
  EJumlahBotol.Text:=DM.tpenjualan['jumlah_botol'];
  EJumlahDus.Text:=DM.tpenjualan['jumlah_dus'];

  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFPenjualan.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
FPenjualan.Hide;
end;

procedure TFPenjualan.DCariChange(Sender: TObject);
begin
if FMenu.LLevel.Caption='Pelanggan' then
  begin
  DM.tpenjualan.Active:=false;
  DM.tpenjualan.CommandText:='select * from tpenjualan where tanggal like '+QuotedStr('%'+DateToStr(DCari.Date)+'%')+' and id_pengguna like '+QuotedStr(FMenu.LIdPengguna.Caption);
  DM.tpenjualan.Active:=true;
  end
else
  begin
  DM.tpenjualan.Active:=false;
  DM.tpenjualan.CommandText:='select * from tpenjualan where tanggal like '+QuotedStr('%'+DateToStr(DCari.Date)+'%');
  DM.tpenjualan.Active:=true;
  end
end;

end.
