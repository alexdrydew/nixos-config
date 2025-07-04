# https://github.com/nix-darwin/nix-darwin/pull/1275 but use main user instead of separate "colima" user
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.colima;
  user = config.users.users.${config.userConfig.userName};
  group = config.users.groups."_colima";
  colimaEditor = pkgs.writeShellScript "colima-editor" ''
    cat ${./colima.yaml} > "$1"
  '';
in {
  options.services.colima = {
    enable = mkEnableOption "Colima, a macOS container runtime";

    enableDockerCompatability = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Create a symlink from Colima's socket to /var/run/docker.sock, and set
        its permissions so that users part of the _colima group can use it.
      '';
    };

    package = mkPackageOption pkgs "colima" {};

    stateDir = lib.mkOption {
      type = types.path;
      # default = "/var/lib/colima";
      default = "/Users/alexdrydew";
      description = "State directory of the Colima process.";
    };

    logFile = mkOption {
      type = types.path;
      default = "/var/log/colima.log";
      description = "Combined stdout and stderr of the colima process. Set to /dev/null to disable.";
    };

    groupMembers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        List of users that should be added to the _colima group.
        Only has effect with enableDockerCompatability enabled.
      '';
    };
  };

  config = mkMerge [
    (mkIf cfg.enableDockerCompatability {
      assertions = [
        {
          assertion = cfg.enable;
          message = "services.colima.enableDockerCompatability doesn't make sense without enabling services.colima.enable";
        }
      ];

      launchd.daemons.colima-docker-compat = {
        script = ''
          set -euo pipefail
          if [ -S "${cfg.stateDir}/.colima/default/docker.sock" ]; then
            chmod g+rw "${cfg.stateDir}/.colima/default/docker.sock"
            ln -sf "${cfg.stateDir}/.colima/default/docker.sock" /var/run/docker.sock
          fi
        '';

        serviceConfig = {
          RunAtLoad = true;
          StartInterval = 5;
          EnvironmentVariables.PATH = "/usr/bin:/bin:/usr/sbin:/sbin";
        };
      };

      users.groups."_colima".members = cfg.groupMembers;

      environment.systemPackages = [
        pkgs.docker
        pkgs.docker-buildx
      ];
    })

    (mkIf cfg.enable {
      environment.systemPackages = [
        cfg.package
      ];

      launchd.daemons.colima = {
        script = ''
          EDITOR=${colimaEditor} exec ${getExe cfg.package} start \
            --edit \
            --foreground \
            --very-verbose
        '';

        serviceConfig = {
          KeepAlive = true;
          RunAtLoad = true;
          StandardErrorPath = cfg.logFile;
          StandardOutPath = cfg.logFile;
          GroupName = group.name;
          UserName = user.name;
          WorkingDirectory = cfg.stateDir;
          EnvironmentVariables = {
            PATH = "${pkgs.colima}/bin:${pkgs.docker}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
            COLIMA_HOME = "${cfg.stateDir}/.colima";
          };
        };
      };

      system.activationScripts.preActivation.text = ''
        touch '${cfg.logFile}'
        chown ${toString user.uid}:${toString user.gid} '${cfg.logFile}'
      '';
    })
  ];
}
