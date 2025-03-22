{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      sbar-lua = prev.callPackage ./sbarlua.nix {};
    })
  ];

  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
  };
}
