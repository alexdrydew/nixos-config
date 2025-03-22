{...}: {
  # ai! this is nixos module, enable this only if rustdesk-server.enable = true is defined in config
  services.rustdesk-server = {
    enable = true;
    openFirewall = true;
  };
}
