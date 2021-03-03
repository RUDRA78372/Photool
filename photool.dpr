program photool;

{$APPTYPE CONSOLE}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$R *.res}

uses
  System.SysUtils, fmx.objects, System.ansistrings;

var
  Img: Timage;
  W, H: Integer;

begin
  try
    if Paramstr(1) <> '' then
    begin
      Img := Timage.Create(nil);
      Img.bitmap.LoadFromFile(Paramstr(paramcount - 1));

      if Paramstr(1) = '-resize' then
      begin
        for var I := 2 to paramcount do
        begin
          if (Pos('-w', CmdLine) <> 0) and (Copy(Paramstr(I), 1, 2) = '-w') then
            W := StrToInt(ReplaceText(Paramstr(I), '-w', ''));
          if (Pos('-h', CmdLine) <> 0) and (Copy(Paramstr(I), 1, 2) = '-h') then
            H := StrToInt(ReplaceText(Paramstr(I), '-h', ''));
        end;
        Img.bitmap.reSize(W, H);
        Img.bitmap.SaveToFile(Paramstr(paramcount));
      end;
      if Paramstr(1) = '-convert' then
        Img.bitmap.SaveToFile(Paramstr(paramcount));
      Img.Free;
    end
    else
    begin
    Writeln('Photo tool - by 78372');
    Writeln('Options:');
    Writeln('         -resize (Resizes the images)');
    Writeln('         -convert (Converts image to another format)');
    Writeln('Use -w and -h to set the width and height for resizing your image');

    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
