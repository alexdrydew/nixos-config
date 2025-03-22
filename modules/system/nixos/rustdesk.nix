{ config, ... }: {
  config = lib.mkIf config.services.rustdesk-server.enable {
    services.rustdesk-server = {
      openFirewall = true;
    };
  };
}
