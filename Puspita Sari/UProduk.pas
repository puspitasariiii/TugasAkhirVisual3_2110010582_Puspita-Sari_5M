unit UProduk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls;

type
  TFProduk = class(TForm)
    Panel1: TPanel;
    GData: TGroupBox;
    GButton: TGroupBox;
    Label1: TLabel;
    ENama: TEdit;
    BSimpan: TBitBtn;
    BTambah: TBitBtn;
    BUbah: TBitBtn;
    BHapus: TBitBtn;
    BBatal: TBitBtn;
    BKeluar: TBitBtn;
    GridData: TDBGrid;
    GCari: TGroupBox;
    Label5: TLabel;
    ECari: TEdit;
    BRefresh: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    CUkuran: TDBLookupComboBox;
    EBerat: TEdit;
    Label4: TLabel;
    EBeliBotol: TEdit;
    Label6: TLabel;
    EBeliDus: TEdit;
    Label7: TLabel;
    EJualBotol: TEdit;
    Label8: TLabel;
    EJualDus: TEdit;
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
    procedure ECariChange(Sender: TObject);
    procedure BKeluarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProduk: TFProduk;

implementation

uses UDM, UMenu;

{$R *.dfm}

procedure TFProduk.refreshdata;
begin
DM.tproduk.Active:=false;
DM.tproduk.CommandText:='select * from tproduk';
DM.tproduk.Active:=true;
DM.tukuran.Active:=false;
DM.tukuran.CommandText:='select * from tukuran';
DM.tukuran.Active:=true;
end;

procedure TFProduk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
FProduk.Hide;
end;

procedure TFProduk.FormShow(Sender: TObject);
begin
ENama.Clear;
CUkuran.KeyValue:=1;
EBerat.Text:='0';
EBeliBotol.Text:='0';
EBeliDus.Text:='0';
EJualBotol.Text:='0';
EJualDus.Text:='0';

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

procedure TFProduk.BTambahClick(Sender: TObject);
begin
ENama.Clear;
CUkuran.KeyValue:=1;
EBerat.Text:='0';
EBeliBotol.Text:='0';
EBeliDus.Text:='0';
EJualBotol.Text:='0';
EJualDus.Text:='0';

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
ENama.SetFocus;
end;

procedure TFProduk.BUbahClick(Sender: TObject);
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
ENama.SetFocus;
end;

procedure TFProduk.BHapusClick(Sender: TObject);
begin
if DM.tproduk.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    DM.tproduk.Delete;
    ShowMessage('Berhasil menghapus data');
    BRefresh.Click;
    end
  end
end;

procedure TFProduk.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFProduk.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFProduk.BSimpanClick(Sender: TObject);
var
nama :string;
begin
if messagedlg('Apakah anda ingin menyimpan data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
  begin
  nama:=ENama.Text;

  if (nama='') then
    begin
    ShowMessage('Mohon lengkapi form sebelum disimpan!');
    ENama.SetFocus;
    end
  else
    begin
    if BTambah.Enabled=true then
      begin
      if DM.tproduk.Locate('nama',nama,[])=true then
        begin
        ShowMessage('Maaf nama ini sudah ada');
        ENama.SetFocus;
        end
      else
        begin
        DM.tproduk.Append;
        DM.tproduk['nama']:=nama;
        DM.tproduk['id_ukuran']:=CUkuran.KeyValue;
        DM.tproduk['berat']:=EBerat.Text;
        DM.tproduk['stok_botol']:='0';
        DM.tproduk['stok_dus']:='0';
        DM.tproduk['harga_beli_botol']:=EBeliBotol.Text;
        DM.tproduk['harga_beli_dus']:=EBeliDus.Text;
        DM.tproduk['harga_jual_botol']:=EJualBotol.Text;
        DM.tproduk['harga_jual_dus']:=EJualDus.Text;        
        DM.tproduk.Post;
        ShowMessage('Selamat!Data baru berhasil disimpan!');
        BRefresh.Click;
        end
      end
    else if  BUbah.Enabled=true then
      begin
      DM.tproduk.Edit;
      DM.tproduk['nama']:=nama;
      DM.tproduk['id_ukuran']:=CUkuran.KeyValue;
      DM.tproduk['berat']:=EBerat.Text;
      DM.tproduk['stok_botol']:='0';
      DM.tproduk['stok_dus']:='0';
      DM.tproduk['harga_beli_botol']:=EBeliBotol.Text;
      DM.tproduk['harga_beli_dus']:=EBeliDus.Text;
      DM.tproduk['harga_jual_botol']:=EJualBotol.Text;
      DM.tproduk['harga_jual_dus']:=EJualDus.Text; 
      DM.tproduk.Post;
      ShowMessage('Selamat!Data lama berhasil disimpan!');
      BRefresh.Click;
      end
    end
  end
end;

procedure TFProduk.GridDataCellClick(Column: TColumn);
begin
if DM.tproduk.IsEmpty=false then
  begin
  ENama.Text:=DM.tproduk['nama'];
  CUkuran.KeyValue:=DM.tproduk['id_ukuran'];
  EBerat.Text:=DM.tproduk['berat'];

  EBeliBotol.Text:=DM.tproduk['harga_beli_botol'];
  EBeliDus.Text:=DM.tproduk['harga_beli_dus'];
  EJualBotol.Text:=DM.tproduk['harga_jual_botol'];
  EJualDus.Text:=DM.tproduk['harga_jual_dus']; 


  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFProduk.ECariChange(Sender: TObject);
begin
if ECari.Text<>'' then
  begin
  DM.tproduk.Active:=false;
  DM.tproduk.CommandText:='select * from tproduk where nama like '+QuotedStr('%'+ECari.Text+'%');
  DM.tproduk.Active:=true;
  end
end;

procedure TFProduk.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
FProduk.Hide;
end;

end.
