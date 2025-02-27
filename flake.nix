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
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
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
    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
    };
    lix-module = {   
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { darwin
    , nixpkgs
    , nixpkgs-unstable
    , lix-module
    , ...
    } @inputs:
    let
      mkSpecialArgs = { system }: {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        inherit inputs;
      };
    in
    {
      darwinConfigurations = {
        toloka-macbook = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = mkSpecialArgs {
            inherit system; 
          };
          modules = [
            lix-module.nixosModules.default
            ./modules/users/toloka.nix
            ./hosts/toloka-macbook
          ];
        };
      };
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = mkSpecialArgs { inherit system; };
          modules = [ 
            ./modules/users/personal.nix
            ./hosts/wsl
          ];
        };
        htpc = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = mkSpecialArgs { inherit system; };
          modules = [
            ./modules/users/personal.nix
            ./hosts/htpc
          ];
        };
      };
    };
}
