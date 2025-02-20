{ lib, ... }:
{
  options.userConfig = with lib; {
    userName = mkOption {
      type = types.str;
    };
    hostName = mkOption {
      type = types.str;
    };
    email = mkOption {
      type = types.str;
    };
    timeZone = mkOption {
      type = types.str;
    };
    keys = mkOption {
      type = types.str;
    };
  };
}
