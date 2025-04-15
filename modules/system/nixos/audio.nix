{
  lib,
  config,
  ...
}: {
  options = {
    audio.enable = lib.mkEnableOption "audio" // {default = true;};
  };
  config = lib.mkIf config.audio.enable {
    services = {
      pipewire = {
        enable = true;
        audio.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
    };
    security.rtkit.enable = true;
  };
}
