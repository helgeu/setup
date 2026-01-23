{
  pkgs,
  ...
}:
# CopilotChat.nvim - GitHub Copilot Chat integration
# https://github.com/CopilotC-Nvim/CopilotChat.nvim
pkgs.vimUtils.buildVimPlugin {
  pname = "CopilotChat.nvim";
  version = "2025-01-23";
  src = pkgs.fetchFromGitHub {
    owner = "CopilotC-Nvim";
    repo = "CopilotChat.nvim";
    rev = "main";
    sha256 = "sha256-MKGkcgyIwRDQs31yqaNrTvJOJlL5FErQjbINeJPlkiQ=";
  };
  doCheck = false;
}
