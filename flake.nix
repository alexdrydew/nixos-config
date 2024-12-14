{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, nixpkgs-unstable, disko, nixos-wsl } @inputs:
    let
      defaultUserConfig = import ./modules/users/default-user.nix;
      mkSpecialArgs = { system, userConfig ? defaultUserConfig }: {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        userConfig = defaultUserConfig;
      };
    in
    {
      darwinConfigurations = {
        toloka-macbook = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = mkSpecialArgs { inherit system; userConfig = import ./modules/users/toloka-user.nix; };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = defaultUserConfig.userName;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/darwin
          ];
        };
      };
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = mkSpecialArgs { inherit system; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.${defaultUserConfig.userName} = import ./modules/nixos/home-manager.nix;
              };
            }
            nixos-wsl.nixosModules.default
            ./hosts/wsl
          ];
        };
      };
    };
}
