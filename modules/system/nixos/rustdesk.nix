{
  config,
  lib,
  ...
}: {
  options = {
    rustdesk-server.enable = lib.mkEnableOption "RustDesk Server";
  };
  config = lib.mkIf config.rustdesk-server.enable {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
    };
  };
}
