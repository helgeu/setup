{
  pkgs,
  ...
}:
# AdoBoards.nvim - Official Neovim plugin for Azure DevOps boards
# https://github.com/Wotee/adoboards.nvim
pkgs.vimUtils.buildVimPlugin {
  pname = "adoboards.nvim";
  version = "2025-01-23";
  src = pkgs.fetchFromGitHub {
    owner = "Wotee";
    repo = "adoboards.nvim";
    rev = "main";
    sha256 = "sha256-kAF3DZejjh8Dy7bXSn1P//v7CmlroGST+3zDVmORFsQ=";
  };
}