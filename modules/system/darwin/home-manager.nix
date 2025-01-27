{ userConfig, pkgs-unstable, inputs, ... }:
let
  user = userConfig.userName;
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      imports = [
        ../../home-manager/common/zsh.nix
        ../../home-manager/common/git.nix
        ../../home-manager/common/ssh.nix
        ../../home-manager/common/gh.nix
        ../../home-manager/common/packages.nix
        ../../home-manager/common/nixCats.nix
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = { inherit userConfig; inherit pkgs-unstable; inherit inputs; };
  };
}
