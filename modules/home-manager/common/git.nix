{ osConfig, pkgs, ... }:
let
  name = osConfig.userConfig.userName;
  email = osConfig.userConfig.email;
in
{
  home.packages = with pkgs;
    [
      git
    ];
  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = false;
      pull.merge = true;
      rebase.autoStash = true;
    };
  };
}
