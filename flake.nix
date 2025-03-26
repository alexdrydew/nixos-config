{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = rec {
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
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    rustaceanvim = {
      url = "github:mrcjkb/rustaceanvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    darwin,
    nixpkgs,
    nixpkgs-unstable,
    lix-module,
    ...
  } @ inputs: let
    # TODO: hacky, cleanup
    overlays = import ./modules/system/common/overlays/default.nix {inherit inputs;};
    mkSpecialArgs = {system}: {
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        inherit (overlays.nixpkgs) overlays;
      };
      pkgs-stable = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        inherit (overlays.nixpkgs) overlays;
      };
      inherit inputs;
    };
  in {
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
        specialArgs = mkSpecialArgs {inherit system;};
        modules = [
          ./modules/users/personal.nix
          ./hosts/wsl
        ];
      };
      htpc = nixpkgs-unstable.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = mkSpecialArgs {inherit system;};
        modules = [
          ./modules/users/personal.nix
          ./hosts/htpc
        ];
      };
    };
  };
}
