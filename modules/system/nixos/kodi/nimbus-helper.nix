
{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper, xbmcswift2 }:

buildKodiAddon rec {
  pname = "nimbus";
  namespace = "script.nimbus.helper";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ivarbrandt";
    repo = namespace;
    rev = "b64d78db1cf7926c6f38e39caf93753d32d18a48";
    sha256 = "sha256-U3/8pRJfPwY1XVoZ9DjJkV9X7QMZhdoVVq9GqJVkY/g=";
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
