{pkgs-stable, ...}: {
  home.packages = with pkgs-stable; [
    dockutil
    stirling-pdf
  ];
}
