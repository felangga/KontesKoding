unit tebakangka;

// by : fcomputer. 2013

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, FreeButton, XPMan;

type
  TfrmMain = class(TForm)
    imgBackground: TImage;
    lblJudul: TLabel;
    tmrJudul: TTimer;
    cmdMain: TFreeButton;
    XPManifest1: TXPManifest;
    lblAngka: TLabel;
    lblBackground: TLabel;
    cmdTidak: TFreeButton;
    cmdYa: TFreeButton;
    lblHasil: TLabel;
    lblHeader: TLabel;
    lblSerius: TLabel;
    cmdCobaLagi: TFreeButton;
    cmdReady: TFreeButton;
    lblPick: TLabel;
    lblSeeNumber: TLabel;
    cmdExit: TFreeButton;
    lblfcomputer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmrJudulTimer(Sender: TObject);
    procedure cmdMainClick(Sender: TObject);
    procedure cmdYaClick(Sender: TObject);
    procedure cmdTidakClick(Sender: TObject);
    procedure cmdReadyClick(Sender: TObject);
    procedure cmdCobaLagiClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure Tampilkan (data : String);
    procedure tampilHasil();
  end;

CONST AngkaMax  = 60;  // Angka Maksimal

var
  frmMain     : TfrmMain;
  i,Angka,idx : integer;
  jawab       : array[0..(AngkaMax div 10)] of integer; // Tampungan jawaban dalam array sebelum dijumlahkan
                                                        // Isi array menyesuaikan Angka Maksimal
implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Atur ukuran form supaya bisa fullscreen
  Width := Screen.Width;
  Height := Screen.Height;

  lblJudul.Left       := (frmMain.Width - lblJudul.Width) div 2;
  lblfcomputer.Top    := frmMain.Height - lblfcomputer.Height - 10;
  cmdMain.Left        := frmMain.Width;
  
  cmdYa.Visible       := False;
  cmdTidak.Visible    := False;
  cmdReady.Visible    := False;
  cmdCobaLagi.Visible := False;
  cmdExit.Left        := frmMain.Width - cmdExit.Width - 10;

end;

procedure TfrmMain.tmrJudulTimer(Sender: TObject);
begin
   // Tulisan turun dari atas
   lblJudul.Top := lblJudul.Top + 10;
   if (lblJudul.Top >= ((frmMain.Height - lblJudul.Height ) div 2)-30) then
   begin
     cmdMain.Left := (frmMain.Width - cmdMain.Width) div 2;
     cmdMain.Top  := (lblJudul.Top + lblJudul.Height) + 50;
     tmrJudul.Enabled := false;
   end;
   lblJudul.Refresh;
end;

procedure TfrmMain.Tampilkan (data : String);
begin
  cmdReady.Visible        := False;

  lblAngka.Caption        := data;
  lblAngka.Top            := (frmMain.Height - lblAngka.Height) div 2;
  lblAngka.Left           := (frmMain.Width - lblAngka.Width) div 2;
  lblAngka.Visible        := True;

  lblBackground.Caption   := data;
  lblBackground.Top       := lblAngka.Top + 1;
  lblBackground.Left      := lblAngka.Left + 1;
  lblBackground.Visible   := True;

  cmdYa.Top               := (lblAngka.Top + lblAngka.Height);
  cmdTidak.Top            := (cmdYa.Top + cmdYa.Height) + 10;
  cmdYa.Left              := (lblAngka.Left + lblAngka.Width) - cmdYa.Width;
  cmdTidak.Left           := cmdYa.Left;
  cmdYa.Visible           := True;
  cmdTidak.Visible        := True;
end;

function generateTabelAngka(angkaAwal : Integer) : String;
begin
  // Angka awal
  i := angkaAwal;
  // Generate angka sampai angka maksimal
  while (i <= AngkaMax) do begin
    // jika habis dibagi angkaAwal*2 maka tidak usah ditampilkan
    if (i mod (angkaAwal*2)) <> 0 then
    begin
      Result := Result + IntToStr(i) + ' ';

      //Ketika angka kurang dari 10 ditambahi spasi biar tampilan rapi
      if (i < 10) then Result := Result + '  ';
      Inc(i);
    end
  else
    Inc(i,angkaAwal); // Jika habis dibagi (angkaAwal*2) maka urutan ditambah angkaAwal
   end;
end;

procedure TfrmMain.cmdMainClick(Sender: TObject);
begin
  // Hilangkan tampilan menu utama
  lblJudul.Visible := False;
  cmdMain.Visible  := False;

  lblPick.Caption  := 'THINK ONE NUMBER 1 - ' + IntToStr(AngkaMax);
  lblPick.Top      := ((frmMain.Height - lblPick.Height) div 2)-10;
  lblPick.Left     := (frmMain.Width - lblPick.Width) div 2;
  lblPick.Visible  := True;
  cmdReady.Top     := lblPick.Top + lblPick.Height + 20;
  cmdReady.Left    := (frmMain.Width - cmdReady.Width) div 2;
  cmdReady.Visible := True;
end;

procedure TfrmMain.cmdYaClick(Sender: TObject);
begin
  jawab[idx] := Angka;
  Inc(idx);

  Angka := Angka*2;
  Tampilkan(generateTabelAngka(Angka));

  // Ulangi terus sampai habis kemungkinan
  if (Angka > AngkaMax) then tampilHasil;
end;

procedure TfrmMain.cmdTidakClick(Sender: TObject);
begin
  Angka := Angka*2;
  Tampilkan(generateTabelAngka(Angka));

  // Ulangi terus sampai habis kemungkinan
  if (Angka > AngkaMax) then tampilHasil;
end;

procedure TfrmMain.tampilHasil();
var Hasilnya, i : Integer;
begin
  Hasilnya             := 0;
  lblSeeNumber.Visible := False;

  lblAngka.Visible     := False;
  cmdYa.Visible        := False;
  cmdTidak.Visible     := False;

  lblHasil.Top         := (frmMain.Height - lblHasil.Height) div 2;
  lblHeader.Top        := lblHasil.Top - 50;
  lblHeader.Left       := (frmMain.Width - lblHeader.Width) div 2;
  lblSerius.Top        := (lblHasil.Top + lblHasil.Height) + 5;
  lblSerius.Left       := (frmMain.Width - lblSerius.Width) div 2;
  lblHeader.Visible    := True;
  cmdCobaLagi.Top      := (lblSerius.Top + lblSerius.Height) + 20;
  cmdCobaLagi.Left     := (frmMain.Width - cmdCobaLagi.Width) div 2;

  // Animasi random
  for i := 0 to 32 do begin
    lblHasil.Caption := IntToStr(Random(AngkaMax));
    Application.ProcessMessages;
    Sleep(100);
    lblHasil.Left    := (frmMain.Width - lblHasil.Width) div 2;
    lblHasil.Visible     := True;
  end;

  // Kalkulasi data dalam array
  for i := 0 to idx do Hasilnya := Hasilnya + jawab[i];

  // Hasil tidak mungkin
  if (Hasilnya = 0) OR (Hasilnya > AngkaMax) then begin
    lblHasil.Caption   := '--';
    lblSerius.Visible   := True;
  end
 else
    lblHasil.Caption   := IntToStr(Hasilnya); // Tampilkan hasilnya

  cmdCobaLagi.Visible  := True;
end;

procedure TfrmMain.cmdReadyClick(Sender: TObject);
begin
  lblPick.Visible := False;
  lblSeeNumber.Visible := True;

   // Generate angka tabel pertama
  Angka := 1;
  Tampilkan(generateTabelAngka(Angka));
end;

procedure TfrmMain.cmdCobaLagiClick(Sender: TObject);
var i : integer;
begin
  // reset isi jawaban
  for i := 0 to idx do jawab[i] := 0;
  idx   := 0;

  // Hilangkan semua tampilan
  lblSerius.Visible:= False;
  lblHeader.Visible:= False;
  lblHasil.Visible := False;

  lblPick.Top      := ((frmMain.Height - lblPick.Height) div 2)-10;
  lblPick.Left     := (frmMain.Width - lblPick.Width) div 2;
  lblPick.Visible  := True;
  cmdReady.Top     := lblPick.Top + lblPick.Height + 20;
  cmdReady.Left    := (frmMain.Width - cmdReady.Width) div 2;
  cmdReady.Visible := True;
  cmdCobaLagi.Visible := False;
end;

procedure TfrmMain.cmdExitClick(Sender: TObject);
begin
  if (MessageBox(0,'Do you want to exit?', 'Exit Game?',MB_YESNO + MB_ICONQUESTION) = 6) then
    Halt;
end;

end.
