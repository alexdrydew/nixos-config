{ pkgs, lib, userConfig, ... }:

let
  name = userConfig.userName;
  user = userConfig.userName;
  email = userConfig.email;
in
{
  # Shared shell configuration

  gh = {
    enable = true;
    extensions = [ ];
  };
}

