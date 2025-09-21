# Main keymap configuration
{ pkgs, ... }: {
  keymaps =
    # Import all keymap configurations and concatenate them
    (import ./nix.nix { inherit pkgs; }).keymaps ++
    (import ./ui.nix { inherit pkgs; }).keymaps ++
    (import ./git.nix { inherit pkgs; }).keymaps ++
    (import ./debug.nix { inherit pkgs; }).keymaps ++
    (import ./lsp.nix { inherit pkgs; }).keymaps ++
    (import ./diagnostics.nix { inherit pkgs; }).keymaps;
}