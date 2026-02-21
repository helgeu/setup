{config, pkgs, lib, ...}: let
  configPath =
    if pkgs.stdenv.isDarwin
    then "Library/Application Support/adoboards/default-config.toml"
    else ".config/adoboards/default-config.toml";
in {
  # AdoBoards configuration managed by Nix
  home.file."${configPath}" = {
    text = ''
      # AdoBoards Configuration
      # Your display name in Azure DevOps
      me = "Helge Rene Urholm"

      # Board configurations
      # Uncomment and fill in your Azure DevOps details
      # Find these from your ADO URL: https://dev.azure.com/<organization>/<project>
      
      # [[boards]]
      organization = "imdidev"
      project = "Bosettingsprosjekt"
      team = "Bosetting - Bosetting utvikling"

      # Iteration configurations
      [[iterations]]
      organization = "imdidev"
      project = "Bosettingsprosjekt"
      team = "Bosetting - Bosetting utvikling"
      iteration = "Sprint 23"

      # Hotkeys configuration (optional - these are the defaults)
      # [hotkeys.list_view]
      # quit = ["q", "Esc"]
      # next = ["j", "Down"]
      # previous = ["k", "Up"]
      # jump_to_top = ["gg"]
      # jump_to_end = ["G"]
      # open = ["Enter"]
      # hover = ["K"]
      # refresh = ["r"]
      # full_refresh = ["R"]
      # edit_config = ["c"]
      # next_board = [">"]
      # previous_board = ["<"]
      # search = ["/"]
      # open_browser = ["o"]
      # assigned_to_me_filter = ["m"]
      # work_item_type_filter = ["t"]

      # [hotkeys.item_view]
      # quit = ["q"]
      # open_browser = ["o"]
      # edit = ["e"]
    '';
    force = true;
  };
}
