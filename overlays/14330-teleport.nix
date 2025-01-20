final: prev: {
  teleport = prev.teleport.overrideAttrs
    (old: {
      version = "14.3.30";
      vendorHash = "sha256-uj/XY/TwDOAassmBWvpcUfkcVtj1U33Qs1FuhVZ+A4E=";
      src = prev.fetchFromGitHub {
        owner = "gravitational";
        repo = "teleport";
        rev = "v14.3.30";
        hash = "sha256-QE5D9vVZHvsfUi0Kvp/t3SVsHvgnODg4wr4lLMt/b4Y=";
      };
    });
}
