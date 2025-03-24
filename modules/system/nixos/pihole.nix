{
  config,
  pkgs,
  ...
}: {
  virtualisation.containers.enable = true;
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "docker://pihole/pihole:latest";
      # Expose / map ports
      ports = ["53:53/tcp" "53:53/udp" "80:80/tcp" "443:443/tcp"];

      # Uncomment if using Pi-hole as your DHCP server:
      # {
      #   hostPort      = "67";
      #   containerPort = "67";
      #   protocol      = "udp";
      # }

      # Uncomment if using Pi-hole as your NTP server:
      # {
      #   hostPort      = "123";
      #   containerPort = "123";
      #   protocol      = "udp";
      # }

      # Mount local directories into the container
      volumes = [
        "/var/lib/pihole/etc-pihole:/etc/pihole"
        # Uncomment if you use a custom /etc/dnsmasq.d
        # {
        #   source = "/var/lib/pihole/etc-dnsmasq.d";
        #   target = "/etc/dnsmasq.d";
        # }
      ];

      # Define environment variables
      environment = {
        TZ = "Europe/London";
        FTLCONF_webserver_api_password = "correct horse battery staple";
        FTLCONF_dns_listeningMode = "all";
      };

      # Pass the required capabilities
      capabilities = {
        NET_ADMIN = true;
        SYS_TIME = true;
        SYS_NICE = true;
      };

      # Let systemd restart if the container stops or fails
      # restartPolicy = "always";
      autoStart = true;
    };
  };
}
