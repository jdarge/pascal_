program MOP;
uses
  SysUtils, Crt, Unix;  

const
  AudioFileName = 'test.wav';  
  MP3FileName = 'test.mp3';   
  // VolumeControlCommand = 'amixer sset Master 15%'; 

var
  CommandLine: string;
  ExitCode: Integer;
  Key: Char;

procedure HandleSignal(Sig: cint); cdecl;
begin
  ExecuteProcess('/bin/sh', ['-c', 'pkill aplay']);
  writeln('Audio playback stopped.');
  Halt(0);
end;

begin
  if not FileExists(AudioFileName) then
  begin
    if FileExists(MP3FileName) then
    begin
      CommandLine := 'ffmpeg -i ' + MP3FileName + ' ' + AudioFileName;
      ExitCode := ExecuteProcess('/bin/sh', ['-c', CommandLine]);

      if ExitCode = 0 then
        writeln('Conversion from MP3 to WAV completed successfully.')
      else
      begin
        writeln('Error converting MP3 to WAV. Exit code: ', ExitCode);
        Halt(1);
      end;
    end
    else
    begin
      writeln('Neither "test.wav" nor "test.mp3" exists.');
      Halt(1); 
    end;
  end;

  // CommandLine := VolumeControlCommand;
  // ExitCode := ExecuteProcess('/bin/sh', ['-c', CommandLine]);

  if ExitCode = 0 then
    writeln('Volume set successfully.')
  else
  begin
    writeln('Error setting volume. Exit code: ', ExitCode);
    Halt(1); 
  end;

  CommandLine := 'aplay ' + AudioFileName + ' &';
  ExecuteProcess('/bin/sh', ['-c', CommandLine]);

  writeln('Press "q" to stop audio playback.');

  repeat
    Key := ReadKey;
    if Key = 'q' then
    begin
      ExecuteProcess('/bin/sh', ['-c', 'pkill aplay']);
      writeln('Audio playback stopped.');
    end;
  until Key = 'q';

  writeln('Exiting the program.');
end.
