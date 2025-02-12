{ ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./gh.nix
    ./packages.nix
    ./nixCats
    ./kitty
    ./vscode.nix
    ./k9s.nix
  ];
}
