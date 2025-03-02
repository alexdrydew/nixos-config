{ lib, buildKodiAddon, fetchpatch, fetchFromGitHub, addonUpdateScript, requests, inputstream-adaptive, inputstreamhelper }:

buildKodiAddon rec {
  pname = "weathericons.white";
  namespace = "resource.images.weathericons.white";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "XBMC-Addons";
    repo = namespace;
    rev = "40eff629343040898e0e0bb4e3e6981551bd7664";
    sha256 = "sha256-8rmyydyvchQqylWx3mIC2VQ6BZ7NPDDYcmqY3e+lNuo=";
  };

  propagatedBuildInputs = [
  ];

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.weathericons.white";
  };

  meta = with lib; {
    homepage = "https://github.com/jurialmunkey/skin.arctic.fuse.2";
    description = "";
  };
}
