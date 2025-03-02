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
  pname = "soupsieve";
  namespace = "script.module.soupsieve";
  version = "2.4.1";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-psyHOczqYhPo32bdb0thK9SXTJKfEoxnsvjG5Vj40hA=";
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
