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
    inputs.home-manager.darwinModules.home-manager
    ./wallpaper
  ];

  system.primaryUser = user;
  ids.gids.nixbld = 350;

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {...}: {
      imports = [
        ../common
        ./firefox.nix
        # ./sketchybar
        ./packages.nix
        ./unnaturalscrollwheels.nix
        ./raycast.nix
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

  # TODO: figure out how to do it inside home-manager
  # WARN: relies on desktoppr being installed in homebrew
  system.activationScripts.postActivation.text = ''
    echo >&2 "Switching wallpapers..."
    /usr/local/bin/desktoppr 0 ${config.wallpaper.file}
  '';
}
