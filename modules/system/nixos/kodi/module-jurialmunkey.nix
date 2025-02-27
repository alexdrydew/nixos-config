{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "module.jurialmunkey";
  namespace = "script.module.jurialmunkey";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v0.2.10";
    sha256 = "sha256-sN33k2kIG/YsIQUm9KIZ/lOIuZ71TNUDJMTntT0CM2Q=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.jurialmunkey";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}

