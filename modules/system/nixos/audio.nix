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
        extraConfig.pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
      };
    };
    security.rtkit.enable = true;
  };
}
