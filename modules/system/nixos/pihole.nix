{config, ...}: {
  virtualisation.containers.enable = true;
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      pihole = {
        image = "docker://pihole/pihole:latest";
        ports = [
          "53:53/tcp"
          "53:53/udp"
          "80:80/tcp"
          "443:443/tcp"
          # DHCP
          "67:67/udp"
          "123:123/udp"
        ];

        environment = {
          TZ = config.userConfig.timeZone;
          FTLCONF_webserver_api_password = "correct horse battery staple";
          FTLCONF_dns_listeningMode = "all";
        };

        capabilities = {
          NET_ADMIN = true;
          SYS_TIME = true;
          SYS_NICE = true;
        };

        autoStart = true;
      };
    };
  };
}
