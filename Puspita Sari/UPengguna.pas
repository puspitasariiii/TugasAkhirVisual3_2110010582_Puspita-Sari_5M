unit UPengguna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids;

type
  TFPengguna = class(TForm)
    Panel1: TPanel;
    GData: TGroupBox;
    GButton: TGroupBox;
    Label1: TLabel;
    ENama: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    Label6: TLabel;
    Label7: TLabel;
    EAlamat: TEdit;
    ENohp: TEdit;
    EUsername: TEdit;
    EPassword: TEdit;
    CLevel: TComboBox;
    Label8: TLabel;
    CStatus: TComboBox;
    BLihatPassword: TButton;
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
    procedure BLihatPasswordClick(Sender: TObject);
    procedure BKeluarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPengguna: TFPengguna;

implementation

uses UDM, UMenu;

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

procedure TFPengguna.refreshdata;
begin
DM.tpengguna.Active:=false;
DM.tpengguna.CommandText:='select * from tpengguna';
DM.tpengguna.Active:=true;
EUsername.Enabled:=true;
end;

procedure TFPengguna.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
FPengguna.Hide;
end;

procedure TFPengguna.FormShow(Sender: TObject);
begin
ENama.Clear;
EAlamat.Clear;
ENohp.Clear;
CStatus.ItemIndex:=0;
EUsername.Clear;
EPassword.PasswordChar:='*';
EPassword.Clear;
CLevel.ItemIndex:=0;
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

procedure TFPengguna.BTambahClick(Sender: TObject);
begin
ENama.Clear;
EAlamat.Clear;
ENohp.Clear;
CStatus.ItemIndex:=0;
EUsername.Clear;
EPassword.Clear;
EPassword.PasswordChar:='*';
CLevel.ItemIndex:=0;
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

procedure TFPengguna.BUbahClick(Sender: TObject);
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

EUsername.Enabled:=false;
ENama.SetFocus;
end;

procedure TFPengguna.BHapusClick(Sender: TObject);
begin
if DM.tpengguna.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    if DM.tpengguna['ID']='1' then ShowMessage('Maaf tidak bisa menghapus data pengguna Administrator')
    else
      begin
      DM.tpengguna.Delete;
      ShowMessage('Berhasil menghapus data');
      BRefresh.Click;
      end
    end
  end
end;

procedure TFPengguna.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPengguna.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFPengguna.BSimpanClick(Sender: TObject);
var
nama,alamat,nohp,username,password,level,status:string;
begin
if messagedlg('Apakah anda ingin menyimpan data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
  begin
  nama:=ENama.Text;
  alamat:=EAlamat.Text;
  nohp:=ENohp.Text;
  status:=CStatus.Text;
  username:=EUsername.Text;
  password:=EPassword.Text;
  level:=CLevel.Text;
  if (nama='') or (alamat='') or (nohp='') or (username='') or (password='') then
    begin
    ShowMessage('Mohon lengkapi form sebelum disimpan!');
    ENama.SetFocus;
    end
  else
    begin
    if BTambah.Enabled=true then
      begin
      if DM.tpengguna.Locate('username',username,[])=true then
        begin
        ShowMessage('Maaf username ini sudah ada');
        EUsername.SetFocus;
        end
      else
        begin
        DM.tpengguna.Append;
        DM.tpengguna['nama']:=nama;
        DM.tpengguna['alamat']:=alamat;
        DM.tpengguna['nohp']:=nohp;                
        DM.tpengguna['username']:=username;
        DM.tpengguna['password']:=Encrypt(password,length(password));
        DM.tpengguna['level']:=level;
        DM.tpengguna['status']:=status;        
        DM.tpengguna.Post;
        ShowMessage('Selamat!Data baru berhasil disimpan!');
        BRefresh.Click;
        end
      end
    else if  BUbah.Enabled=true then
      begin
      DM.tpengguna.Edit;
      DM.tpengguna['nama']:=nama;
      DM.tpengguna['alamat']:=alamat;
      DM.tpengguna['nohp']:=nohp;
      DM.tpengguna['username']:=username;
      DM.tpengguna['password']:=Encrypt(password,length(password));
      DM.tpengguna['level']:=level;
      DM.tpengguna['status']:=status;      
      DM.tpengguna.Post;
      ShowMessage('Selamat!Data lama berhasil disimpan!');
      BRefresh.Click;
      end
    end
  end
end;

procedure TFPengguna.GridDataCellClick(Column: TColumn);
var
level,status:string;
indek:integer;
begin
if DM.tpengguna.IsEmpty=false then
  begin
  level:=DM.tpengguna['level'];
  status:=DM.tpengguna['status'];  
  ENama.Text:=DM.tpengguna['nama'];
  EAlamat.Text:=DM.tpengguna['alamat'];
  ENohp.Text:=DM.tpengguna['nohp'];    
  EUsername.Text:=DM.tpengguna['username'];
  EPassword.Text:=Decrypt(DM.tpengguna['password'],length(DM.tpengguna['password']));
  if level='Admin' then CLevel.ItemIndex:=0;
  if level='Owner' then CLevel.ItemIndex:=1;
  if level='Karyawan' then CLevel.ItemIndex:=2;
  if level='Pelanggan' then CLevel.ItemIndex:=3;
  if level='Supplier' then CLevel.ItemIndex:=4;  
  if status='Aktif' then CStatus.ItemIndex:=0;
  if status='Belum Aktif' then CStatus.ItemIndex:=1;

  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFPengguna.ECariChange(Sender: TObject);
begin
if ECari.Text<>'' then
  begin
  DM.tpengguna.Active:=false;
  DM.tpengguna.CommandText:='select * from tpengguna where nama like '+QuotedStr('%'+ECari.Text+'%');
  DM.tpengguna.Active:=true;
  end
end;

procedure TFPengguna.BLihatPasswordClick(Sender: TObject);
begin
EPassword.PasswordChar:=#0;
end;

procedure TFPengguna.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
FPengguna.Hide;
end;

end.
