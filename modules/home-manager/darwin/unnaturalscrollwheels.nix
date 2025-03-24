{pkgs-stable, ...}: {
  home.packages = with pkgs-stable; [
    unnaturalscrollwheels
  ];
}
