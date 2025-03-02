{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "module.infotagger";
  namespace = "script.module.infotagger";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jurialmunkey";
    repo = namespace;
    tag = "v0.0.8";
    sha256 = "sha256-Ns1OjrYLKz4znXRxqUErDLcmC0HBjBFVYI9GFqDVurY=";
  };

  propagatedBuildInputs = [
    requests
    inputstream-adaptive
    inputstreamhelper
    xbmcswift2
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.infotagger";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
