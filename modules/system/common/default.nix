{ ... }:
{
  imports = [
    ./overlays
    ./nix.nix
    ./ssh.nix
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
