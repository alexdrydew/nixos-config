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
      signal = {
        enable = true;
        relayHosts = ["127.0.0.1"];
      };
      relay.enable = false;
    };
  };
}
