unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, StdCtrls, Controls,
  ExtCtrls, Menus, Windows, lazutf8sysutils, uPascalTZ;

type

  { TForm1 }

  TForm1 = class(TForm)
    IdleTimer1: TIdleTimer;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure ReLayout;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  tz: TPascalTZ;
  reparented: boolean;

const
  CRLF = #13 + #10;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ReLayout();
var
  r1, r2: TRect;
  h: hWND;
begin
  h := Windows.FindWindow('Shell_TrayWnd', nil);
  if h = 0 then
    exit;

  Windows.GetWindowRect(h, r1);
  if not reparented then begin
    Windows.SetParent(self.Handle, h);
    reparented := true;
  end;

  h := Windows.FindWindowEx(h, 0, 'ReBarWindow32', nil);
  if h = 0 then
    exit;

  h := Windows.FindWindowEx(h, 0, 'TIPBand', 'TIPBand');
  if h = 0 then
    exit;

  Windows.GetWindowRect(h, r2);

  r2.Top -= r1.Top;
  r2.Left -= r1.Left;
  r2.Bottom -= r1.Top;
  r2.Right -= r1.Left;

  self.Left := r2.Left;
  if r2.Top > r2.Left then
  begin
    Label1.Align := alTop;
    self.Left := 0;
    self.Top := r2.Top - Label1.Height;
    self.Width := r2.Right - r2.Left;
    self.Height := Label1.Height;
  end else begin
    Label1.Align := alLeft;
    self.Left := r2.Left - Label1.Width;
    self.Top := 0;
    self.Width := Label1.Width;
    self.Height := r2.Bottom - r2.Top;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ex: long;
begin
  ex := GetWindowLong(self.Handle, GWL_EXSTYLE);
  SetWindowLong(self.Handle, GWL_EXSTYLE, ex or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);

  reparented := false;
  ReLayout;
end;

procedure TForm1.IdleTimer1Timer(Sender: TObject);
var
  t, lt: TDateTime;
  s: string;
begin
  t := NowUTC();
  s := 'GMT ' + FormatDateTime('hh:nn', t);

  lt := tz.GMTToLocalTime(t, 'America/Los_Angeles');
  s += CRLF + 'PDT ' + FormatDateTime('hh:nn', lt);

  lt := tz.GMTToLocalTime(t, 'Asia/Shanghai');
  s += CRLF + 'CST ' + FormatDateTime('hh:nn', lt);

  Label1.Caption := s;
  Label1.Visible := true;

  ReLayout;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  self.Close;
  Application.Terminate;
end;

initialization
  tz := TPascalTZ.Create;
  tz.DatabasePath := 'tzdata';
end.
