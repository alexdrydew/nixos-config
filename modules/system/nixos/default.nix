{ userConfig, pkgs-unstable, inputs, ... }:

let
  user = userConfig.userName;
in
{
  imports = [
    ../common
    ../../home-manager/nixos
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit userConfig; inherit pkgs-unstable; inherit inputs; };
    users.${user} = { ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "24.05";
      };
    };
  };
}
