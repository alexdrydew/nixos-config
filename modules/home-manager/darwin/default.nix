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
        ../common/zsh.nix
        ../common/git.nix
        ../common/ssh.nix
        ../common/gh.nix
        ../common/packages.nix
        ../common/nixCats.nix
        ../common/alacritty
        ./sketchybar
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = { inherit userConfig; inherit pkgs-unstable; inherit inputs; };
  };
}
