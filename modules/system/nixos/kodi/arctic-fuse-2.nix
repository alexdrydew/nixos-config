{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "arctic-fuse-2";
  namespace = "skin.arctic.fuse.2";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v2.8.4";
    sha256 = "sha256-6Jh2gEwRSoYsrBrLXV3OFIBVexcfNereyuaY+UvKdps=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];
  #
  # passthru = {
  #   pythonPath = "resources/lib";
  #   updateScript = addonUpdateScript {
  #     attrPath = "kodi.packages.invidious";
  #   };
  # };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
