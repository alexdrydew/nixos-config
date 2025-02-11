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
      url = "path:flakes/kickstart-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { darwin
    , home-manager
    , nixpkgs
    , nixpkgs-unstable
    , nixos-wsl
    , vscode-server
    , ...
    } @inputs:
    let
      defaultUserConfig = import ./users/default.nix;
      mkSpecialArgs = { system, userConfig ? defaultUserConfig }: {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        inherit inputs userConfig;
      };
    in
    {
      darwinConfigurations = {
        toloka-macbook = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = mkSpecialArgs {
            inherit system; userConfig = import ./users/toloka.nix;
          };
          modules = [ ./hosts/toloka-macbook ];
        };
      };
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = mkSpecialArgs { inherit system; };
          modules = [ ./hosts/wsl ];
        };
      };
    };
}
