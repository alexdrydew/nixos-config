{pkgs, ...}: let
  yaml = pkgs.formats.yaml {};
in {
  imports = [
    ./aider.nix
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./gh.nix
    ./packages.nix
    ./kitty
    ./vscode.nix
    ./k9s.nix
    ./nvf
    ./moonlight.nix
    ./claude-code.nix
  ];

  home = {
    file = {
      ".aider.conf.yml12".source = yaml.generate "test" {};
    };
  };
}
