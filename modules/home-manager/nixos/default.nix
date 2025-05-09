{
  config,
  pkgs-unstable,
  pkgs-stable,
  inputs,
  ...
}: let
  user = config.userConfig.userName;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {...}: {
      imports = [
        ../common
        ./plasma-manager.nix
        ./big-launcher.nix
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = {
      inherit pkgs-unstable;
      inherit pkgs-stable;
      inherit inputs;
    };
  };
}
