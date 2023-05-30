unit LogUtils;

interface

uses
  System.IOUtils,
  System.SysUtils;

Type
  TLogUtils = Class
  public
    class procedure LogError(const aMessage: string);
  End;

implementation

class procedure TLogUtils.LogError(const aMessage: string);
begin
  TFile.AppendAllText('log.txt', Format('%s: %s', [DateTimeToStr(Now), aMessage]));
end;

end.
