unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm12 = class(TForm)
    Background: TImage;
    WarlockStand: TImage;
    WarlockCast: TImage;
    MageStand: TImage;
    MageCast: TImage;
    Iceblock: TImage;
    Coil: TImage;
    IceButton: TImage;
    Flag: TImage;
    Logo: TImage;
    Label1: TLabel;
    DuelDialog: TImage;
    DeathDialog: TImage;
    Timer1: TTimer;
    MageRIP: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure DuelDialogClick(Sender: TObject);
    procedure IceButtonClick(Sender: TObject);
  private
    fblock: boolean;
    freaction: integer;
    procedure win;
    procedure lose;
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.fmx}

procedure TForm12.DuelDialogClick(Sender: TObject);
begin
  DuelDialog.Visible := false;
  Timer1.Enabled := true;
  fblock := false;
  Logo.Visible := false;
  Label1.Visible := false;
  IceButton.Visible := true;
  Flag.Visible := true;
  DeathDialog.Visible := false;
  MageRIP.Visible := false;
  MageStand.Visible := true;
  MageCast.Visible := false;
  Iceblock.Visible := false;
end;

procedure TForm12.IceButtonClick(Sender: TObject);
begin
  fblock := true;
  MageStand.Visible := false;
  MageCast.Visible := true;
  Iceblock.Visible := true;
end;

procedure TForm12.lose;
begin
  Flag.Visible := false;
  MageStand.Visible := false;
  MageCast.Visible := false;
  Iceblock.Visible := false;
  MageRIP.Visible := true;
  DeathDialog.Visible := true;
  IceButton.Visible := false;
end;

procedure TForm12.Timer1Timer(Sender: TObject);
var
  lcoil: integer;
begin
  freaction := 0;
  Timer1.Enabled := false;
  randomize();
  lcoil := random(100);
  WarlockStand.Visible := false;
  WarlockCast.Visible := true;
  Application.ProcessMessages;
  Coil.Position.X := 184;
  if fblock then
  begin
    lcoil := 1;
    sleep(1000);
  end;
  if lcoil > 50 then
  begin
    Coil.Visible := true;
    while Coil.Position.X < 630 do
    begin
      if not fblock then
        inc(freaction);
      Coil.Position.X := Coil.Position.X + 3;
      sleep(1);
      Application.ProcessMessages;
    end;
    if fblock then
      win
    else
      lose;
  end
  else
  begin
    Coil.Visible := false;
    while Coil.Position.X < 630 do
    begin
      Coil.Position.X := Coil.Position.X + 3;
      sleep(1);
      Application.ProcessMessages;
    end;
    Coil.Position.X := 184;
    if fblock then
    begin
      MageStand.Visible := true;
      MageCast.Visible := false;
      Iceblock.Visible := false;
      Coil.Visible := true;
      while Coil.Position.X < 630 do
      begin
        Coil.Position.X := Coil.Position.X + 3;
        sleep(1);
        Application.ProcessMessages;
      end;
      Coil.Position.X := 184;
      lose;
    end
    else
    begin
      Timer1.Interval := 1000 * (random(3) + 1);
      Timer1.Enabled := true;
    end;
  end;
  Coil.Visible := false;
  WarlockStand.Visible := true;
  WarlockCast.Visible := false;
end;

procedure TForm12.win;
var
  I: integer;
begin
  DuelDialog.Visible := true;
  Flag.Visible := false;
  IceButton.Visible := false;
  for I := 0 to 100 do
  begin
    sleep(1);
    Application.ProcessMessages;
  end;
  MageStand.Visible := true;
  MageCast.Visible := false;
  Iceblock.Visible := false;
  label1.Text := '???????? ??????? '+inttostr(freaction)+' ?.???';
  label1.visible:=true;
end;

end.
