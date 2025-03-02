{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "skinvariables";
  namespace = "script.skinvariables";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v2.1.28";
    sha256 = "sha256-oHvVAiFBOnNHFh+FMFc7w0OnmwoMtrfbPkBFUxWNYBY=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.skinvariables";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
