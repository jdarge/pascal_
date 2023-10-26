program MPVLauncher;

uses
  SysUtils, Classes, Process;

var
  SongPath: String;
  PlayerProcess: TProcess;

begin
  if FileExists('/usr/bin/mpv') then
  begin
    Write('Enter file path to the audio file: ');
    ReadLn(SongPath);

    if FileExists(SongPath) then
    begin
      PlayerProcess := TProcess.Create(nil);
      PlayerProcess.Executable := '/usr/bin/mpv';
      PlayerProcess.Parameters.Add(SongPath);
      PlayerProcess.Options := PlayerProcess.Options + [poWaitOnExit];

      WriteLn('Playing la musica. Press Enter to stop.');
      PlayerProcess.Execute;

      ReadLn;

      PlayerProcess.Terminate(0);

      PlayerProcess.Free;
    end
    else
    begin
      WriteLn('File not found: ', SongPath);
    end;
  end
  else
  begin
    WriteLn('mpv is not installed.');
  end;
end.
