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
      userConfig = import ./hosts/user.nix;
      linuxSystems = {
        linux-pc = "x86_64-linux";
      };
      darwinSystems =
        {
          toloka-macbook = "aarch64-darwin";
        };
      wslSystems =
        {
          wsl = "x86_64-linux";
        };
      mkSpecialArgs = system: inputs // {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        inherit userConfig;
      };
    in
    {
      darwinConfigurations = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames darwinSystems) (systemName:
        let
          system = darwinSystems."${systemName}";
        in
        darwin.lib.darwinSystem {
          system = system;
          specialArgs = mkSpecialArgs system;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = userConfig.userName;
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
        }
      );

      nixosConfigurations = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames linuxSystems)
        (systemName:
          let
            system = linuxSystems."${systemName}";
          in
          nixpkgs.lib.nixosSystem rec {
            inherit system;
            specialArgs = mkSpecialArgs system;
            modules = [
              disko.nixosModules.disko
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = specialArgs;
                  users.${userConfig.userName} = import ./modules/nixos/home-manager.nix;
                };
              }
              ./hosts/nixos
            ];
          }) // nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames wslSystems) (systemName:
        let
          system = wslSystems."${systemName}";
        in
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = mkSpecialArgs system;
          modules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.${userConfig.userName} = import ./modules/nixos/home-manager.nix;
              };
            }
            nixos-wsl.nixosModules.default
            ./hosts/wsl
          ];
        });
    };
}
