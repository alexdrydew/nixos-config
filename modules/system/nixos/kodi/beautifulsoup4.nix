{
  lib,
  rel,
  buildKodiAddon,
  fetchzip,
  addonUpdateScript,
  certifi,
  chardet,
  idna,
  urllib3,
}:
buildKodiAddon rec {
  pname = "beautifulsoup4";
  namespace = "script.module.beautifulsoup4";
  version = "4.12.2";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-WkeJ0kv2FXksIql28UE4LO545mJs9RV9iolIVRuZ7y4=";
  };

  propagatedBuildInputs = [
  ];

  passthru = {
    pythonPath = "lib";
    updateScript = addonUpdateScript {
      attrPath = "kodi.packages.beautifulsoup4";
    };
  };

  meta = with lib; {
  };
}
