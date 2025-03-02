{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  name = "local-hightlight-nvim";
  src = fetchFromGitHub {
    owner = "tzachar";
    repo = "local-highlight.nvim";
    rev = "e0d725738561ab6051fcfa5e5664e4974a5dd78d";
    hash = "sha256-e9EhvTuFqv0hq76W9Tz4Q1OEqtEN/D3TTtwU+djG1aw=";
  };
}
