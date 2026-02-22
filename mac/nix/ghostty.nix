# Ghostty terminal configuration
# Kept in sync with iterm2.nix - update both when changing settings
# NOTE: Ghostty installed via Homebrew (not nixpkgs - macOS not supported)
{ pkgs, lib, ... }:
let
  # Shared settings (edit these to update both terminals)
  font = "MesloLGM Nerd Font Mono";
  fontSize = 12;
  columns = 180;
  rows = 50;
in {
  # Ghostty config file (app installed via Homebrew cask in system/*.nix)
  home.file.".config/ghostty/config" = lib.mkIf pkgs.stdenv.isDarwin {
    text = ''
      # Theme (built-in, matches iTerm2 Dracula profile)
      theme = Dracula

      # Font
      font-family = ${font}
      font-size = ${toString fontSize}

      # Window size
      window-width = ${toString columns}
      window-height = ${toString rows}

      # macOS: Option key sends Alt/Meta (like iTerm2 "Option Key Sends = 2")
      macos-option-as-alt = true

      # Behavior
      mouse-hide-while-typing = true
      copy-on-select = clipboard
      confirm-close-surface = false

      # Visual
      window-decoration = true
      macos-titlebar-style = tabs
    '';
  };
}
