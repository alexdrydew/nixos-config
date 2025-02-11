{ userConfig, pkgs-unstable, inputs, ... }:
let
  user = userConfig.userName;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { ... }: {
      imports = [
        ../common
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };
    };
    extraSpecialArgs = { inherit userConfig; inherit pkgs-unstable; inherit inputs; };
  };
}
