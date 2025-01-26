{ inputs, ... }:
{
  nixpkgs.overlays =
    # Apply each overlay found in the /overlays directory
    let path = ./.;
    in with builtins;
    map (n: import (path + ("/" + n)))
      (filter
        (n: (match ".*\\.nix" n != null ||
        pathExists (path + ("/" + n + "/default.nix"))) &&
        n != "default.nix")
        (attrNames (readDir path))) ++ [ inputs.rust-overlay.overlays.default ];
}
