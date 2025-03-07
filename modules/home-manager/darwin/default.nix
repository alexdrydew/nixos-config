{ config, pkgs-unstable, inputs, ... }:
let
  user = config.userConfig.userName;
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { ... }: {
      imports = [
        ../common
        ./firefox.nix
        ./sketchybar
        ./packages.nix
        ./unnaturalscrollwheels.nix
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = { inherit pkgs-unstable; inherit inputs; };
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
