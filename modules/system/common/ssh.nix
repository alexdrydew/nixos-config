{ lib, config, ... }:
{
  options = {
    ssh-server.enable = lib.mkEnableOption "SSH server";
  };
   
  config = lib.mkIf config.ssh-server.enable {
    services = {
      openssh.enable = true;
    };
  };
}
