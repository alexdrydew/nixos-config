{lib, ...}: {
  options.wallpaper.file = lib.mkOption {
    type = lib.types.path;
    default = ./default.jpg;
    description = "Path to the wallpaper image file.";
  };

  config.wallpaper.file = ./frieren.jpg;
}
