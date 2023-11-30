unit UUkuran;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids;

type
  TFUkuran = class(TForm)
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
  FUkuran: TFUkuran;

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

procedure TFUkuran.refreshdata;
begin
DM.tukuran.Active:=false;
DM.tukuran.CommandText:='select * from tukuran';
DM.tukuran.Active:=true;
end;

procedure TFUkuran.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMenu.Show;
Fukuran.Hide;
end;

procedure TFUkuran.FormShow(Sender: TObject);
begin
ENama.Clear;

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

procedure TFUkuran.BTambahClick(Sender: TObject);
begin
ENama.Clear;

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

procedure TFUkuran.BUbahClick(Sender: TObject);
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

procedure TFUkuran.BHapusClick(Sender: TObject);
begin
if DM.tukuran.IsEmpty=false then
  begin
  if messagedlg('Apakah anda ingin menghapus data ini?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes then
    begin
    DM.tukuran.Delete;
    ShowMessage('Berhasil menghapus data');
    BRefresh.Click;
    end
  end
end;

procedure TFUkuran.BRefreshClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFUkuran.BBatalClick(Sender: TObject);
begin
FormShow(Self);
end;

procedure TFUkuran.BSimpanClick(Sender: TObject);
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
      if DM.tukuran.Locate('nama',nama,[])=true then
        begin
        ShowMessage('Maaf nama ini sudah ada');
        ENama.SetFocus;
        end
      else
        begin
        DM.tukuran.Append;
        DM.tukuran['nama']:=nama;
        DM.tukuran.Post;
        ShowMessage('Selamat!Data baru berhasil disimpan!');
        BRefresh.Click;
        end
      end
    else if  BUbah.Enabled=true then
      begin
      DM.tukuran.Edit;
      DM.tukuran['nama']:=nama;
      DM.tukuran.Post;
      ShowMessage('Selamat!Data lama berhasil disimpan!');
      BRefresh.Click;
      end
    end
  end
end;

procedure TFUkuran.GridDataCellClick(Column: TColumn);
begin
if DM.tukuran.IsEmpty=false then
  begin
  ENama.Text:=DM.tukuran['nama'];

  BTambah.Enabled:=true;
  BUbah.Enabled:=true;
  BHapus.Enabled:=true;
  BBatal.Enabled:=true;
  BSimpan.Enabled:=false;
  BKeluar.Enabled:=true;
  
  end
end;

procedure TFUkuran.ECariChange(Sender: TObject);
begin
if ECari.Text<>'' then
  begin
  DM.tukuran.Active:=false;
  DM.tukuran.CommandText:='select * from tukuran where nama like '+QuotedStr('%'+ECari.Text+'%');
  DM.tukuran.Active:=true;
  end
end;

procedure TFUkuran.BKeluarClick(Sender: TObject);
begin
FMenu.Show;
FUkuran.Hide;
end;

end.
