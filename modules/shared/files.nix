{ pkgs, config, ... }:

{
  ".common_env" = {
    text = builtins.readFile ./config/common_env.sh;
  };
}
