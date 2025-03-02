{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "font.robotocjksc";
  namespace = "resource.font.robotocjksc";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v0.0.3";
    sha256 = "sha256-s/h/KKlGYGMvf7RdI9ONk4S+NCzlaDX5w3CdNfbC2KE=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.robotocjksc";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
