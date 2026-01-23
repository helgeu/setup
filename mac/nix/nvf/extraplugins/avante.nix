{
  pkgs,
  ...
}:
# Avante.nvim - Cursor-like AI assistant with approval workflow
# https://github.com/yetone/avante.nvim
pkgs.vimUtils.buildVimPlugin {
  pname = "avante.nvim";
  version = "2025-01-23";
  src = pkgs.fetchFromGitHub {
    owner = "yetone";
    repo = "avante.nvim";
    rev = "main";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  doCheck = false;
}
