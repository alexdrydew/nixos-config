{pkgs-stable, ...}: {
  home.packages = with pkgs-stable; [
    moonlight-qt
  ];
}
