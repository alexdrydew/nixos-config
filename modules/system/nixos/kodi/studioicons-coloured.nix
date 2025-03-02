{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper }:

buildKodiAddon rec {
  pname = "studios.coloured";
  namespace = "resource.images.studios.coloured";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "XBMC-Addons";
    repo = namespace;
    rev = "27566796e6ff315c01983369788b7038aa405b4b";
    sha256 = "sha256-Y+XbdM4ECvWDaDIzhDfbOw9VqJUmuS5YPM+PFuKd/DY=";
  };

  propagatedBuildInputs = [
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.studios.coloured";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
