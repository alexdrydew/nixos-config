# TODO: fix
{ buildPythonPackage
, fetchurl
, setuptools
}:

buildPythonPackage {
  pname = "tlk";
  version = "1.7.26";
  pyproject = true;

  src = fetchurl {
    url = "https://pkgs.dev.azure.com/toloka/_apis/packaging/feeds/47f4e901-5306-4783-8339-c0f58febdda1/pypi/packages/tlk/versions/1.7.26/tlk-1.7.26-py3-none-any.whl/content";
    hash = "sha256-aXae9/x0HVp4KqydCf5/+p5PlSKUQ5cE3iVeD08rtf0=";
  };

  build-system = [ setuptools ];

  dependencies = [ ];

  # Could not contact DNS servers
  doCheck = false;

  pythonImportsCheck = [ "tlk" ];
}
