program tzbar;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, uPascalTZ_Types, Windows;

{$R *.res}

var
  ex: LONG;
  h: HWND;
begin
  Application.Title := 'tzbarapp';
  RequireDerivedFormResource := True;
  Application.Initialize;

  // Remove taskbar icon
  h := FindWindow(nil, PChar(Application.Title));
  ex := GetWindowLong(h, GWL_EXSTYLE);
  SetWindowLong(h, GWL_EXSTYLE, ex or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

