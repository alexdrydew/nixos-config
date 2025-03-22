{ config, inputs, ... }:

let
  user = config.userConfig.userName;
in
{
  imports = [
    ../../modules/system/nixos
    inputs.nixos-wsl.nixosModules.default
    inputs.vscode-server.nixosModules.default
    # run `systemctl --user enable auto-fix-vscode-server.service`
    ({ ... }: {
      services.vscode-server = {
        enable = true;
        enableFHS = true;
      };
    })
  ];

  home-manager.sharedModules = [
    {
      # WSL uses host VSCode
      vscode.enable = false;
      home.packageSets.graphical = false;
      kitty.enable = false;
    }
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
  networking.enableIPv6 = false;
  hardware.nvidia.enable = true;

  system.stateVersion = "21.05";
}
