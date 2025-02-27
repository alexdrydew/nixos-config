{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "nimbus";
  namespace = "skin.nimbus";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ivarbrandt";
    repo = namespace;
    rev = "6f65d89fa0cf3022cc321557788a62222f599105";
    sha256 = "sha256-JOylbQZQX2iVI+lJ53zOSL2R9EEQb7ZKHrP4HnS/2nI=";
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
