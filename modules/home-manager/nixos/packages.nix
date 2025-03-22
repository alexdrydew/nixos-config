{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      chromium
      rustdesk
    ];
  };
}
