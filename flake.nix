{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, nixpkgs-unstable, nixos-wsl, vscode-server, ... } @inputs:
    let
      defaultUserConfig = import ./modules/users/default.nix;
      mkSpecialArgs = { system, userConfig ? defaultUserConfig }: {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        userConfig = defaultUserConfig;
        inherit inputs;
      };
    in
    {
      darwinConfigurations = {
        toloka-macbook = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = mkSpecialArgs {
            inherit system; userConfig = import ./modules/users/toloka.nix;
          };
          modules = [
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
            vscode-server.nixosModules.default
            # run `systemctl --user enable auto-fix-vscode-server.service`
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
              services.vscode-server.enableFHS = true;
            })
            ./hosts/wsl
          ];
        };
      };
    };
}
