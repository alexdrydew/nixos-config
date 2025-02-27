{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchzip,
  SDL2,
  SDL2_image,
  SDL2_ttf,
  SDL2_mixer,
  libxml2,
  inih,
  fmt,
  spdlog,
  cmake,
  pkg-config,
  ...
}:
stdenv.mkDerivation rec {
  pname = "big-launcher";
  version = "0.1.0";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    SDL2
    SDL2_image
    SDL2_ttf
    SDL2_mixer
    libxml2
    inih
    fmt
    spdlog
  ];

  src = fetchFromGitHub {
    owner = "complexlogic";
    repo = "big-launcher";
    rev = "f8935c068b40c94610f3707c288675b2184558cb";
    sha256 = "sha256-T8kBHgSsBGmBR6Ro2No3P/PLQhzUogTz+b1b6eS7yjg=";
  };

  assets = fetchzip {
    url = "https://github.com/complexlogic/big-launcher/files/10326572/assets.zip";
    sha256 = "sha256-qYPvXTkhWKmZOuwrsQNIQbA7zOiqS4gdVsSnsXVdO6Y=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $TMP/source/build/big-launcher $out/bin
    cp $TMP/source/build/config.ini $out/bin
    cp $TMP/source/build/layout.xml $out/bin

    mkdir -p $out/bin/assets
    cp -r ${assets}/* $out/bin/assets
  '';

  meta = {
  };
}
