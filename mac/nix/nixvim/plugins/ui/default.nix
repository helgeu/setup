# UI-related plugins configuration
{ pkgs, ... }: {
  plugins =
    # Import and merge all UI plugin configurations
  # snacks replaces telescope and neotree
    (import ./which-key.nix { inherit pkgs; }).plugins //
    (import ./mini-icons.nix { inherit pkgs; }).plugins;
}