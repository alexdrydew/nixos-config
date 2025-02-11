{ ... }: {
  imports = [
    ../common/zsh.nix
    ../common/git.nix
    ../common/ssh.nix
    ../common/gh.nix
    ../common/packages.nix
    ../common/nixCats
    ../common/kitty
  ];
}
