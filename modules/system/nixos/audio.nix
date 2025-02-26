{ lib, config, ... }:
{
  options = {
    audio.enable = lib.mkEnableOption "audio" // { default = true; };
  };
  config = lib.mkIf config.audio.enable {
    services = {
      jack = {
        jackd.enable = true;
        alsa.enable = true;
        loopback.enable = false;
      };
    };
  };
}
