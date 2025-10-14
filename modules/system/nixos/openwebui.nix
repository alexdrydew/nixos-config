{
  config,
  lib,
  ...
}: let
  volumePath = "/persist/volumes/open-webui";
in {
  options.services.openwebui = {
    enable = lib.mkEnableOption "openwebui";
  };
  config = lib.mkIf config.services.openwebui.enable {
    networking.firewall.allowedTCPPorts = [
      3000
    ];
    systemd.tmpfiles.rules = [
      "d ${volumePath} 0755 root root -"
    ];
    virtualisation.containers.enable = true;
    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        openwebui = {
          image = "ghcr.io/open-webui/open-webui:main";
          ports = [
            "3000:8080/tcp"
          ];

          volumes = [
            "${volumePath}:/app/backend/data"
          ];

          capabilities = {
            NET_ADMIN = true;
            SYS_TIME = true;
            SYS_NICE = true;
          };

          autoStart = true;
        };
      };
    };
  };
}
