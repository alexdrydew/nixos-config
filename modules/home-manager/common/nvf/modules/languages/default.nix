{ ... }:
{
  imports = [
    ./python.nix
  ];
  config = {
    vim = {
      languages = {
        nix = {
          enable = true;
        };
      };
    };
  };
}
