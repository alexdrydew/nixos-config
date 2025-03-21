{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  user = osConfig.userConfig.userName;
  inherit (osConfig.users.users.${user}) home;
in {
  programs.ssh = {
    enable = true;
    includes = [
      "${home}/.ssh/config_external"
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_ed25519"
          )
        ];
      };
    };
  };
}
