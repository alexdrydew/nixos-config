{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "texturemaker";
  namespace = "script.texturemaker";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v0.2.10";
    sha256 = "sha256-GtUDNc0qatGzgSqQdDJgZnrhI1f+SPyoG9Og+oRFxRM=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.texturemaker";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}

