# UI-related plugins configuration
{ pkgs, ... }: {
  plugins =
    # Import and merge all UI plugin configurations
    (import ./telescope.nix { inherit pkgs; }).plugins //
    (import ./neotree.nix { inherit pkgs; }).plugins //
    (import ./which-key.nix { inherit pkgs; }).plugins //
    (import ./mini-icons.nix { inherit pkgs; }).plugins;
}