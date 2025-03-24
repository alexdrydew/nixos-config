{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "2025-03-2";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "bc0630e43be5699bb94dadc302c0d21615421d93";
    hash = "sha256-Gw0Bp2YeoESiBLs3NPnqke3xwEjuiQDDU1CPofrhtig=;";
  };
  doCheck = false;
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
