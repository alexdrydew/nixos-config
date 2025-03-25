{ config, ... }: {
  home.file."raycast/kitty-python.sh" = {
    text = ''
      #!/bin/bash

      # Required parameters:
      # @raycast.schemaVersion 1
      # @raycast.title kitty python
      # @raycast.mode silent

      # Optional parameters:
      # @raycast.icon 🤖
      # @raycast.packageName kitty

      ${config.home.profileDirectory}/bin/kitty --session ${config.home.homeDirectory}/.kitty-sessions/toloka-python.sh
    '';
    executable = true;
  };
}
