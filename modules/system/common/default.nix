{ ... }:
{
  imports = [
    ./overlays
    ./nix.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };
}
