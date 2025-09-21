# UI navigation keymaps
{ pkgs, ... }: {
  keymaps = [
    # File explorer
    {
      key = "<C-n>";
      action = ":Neotree toggle<CR>";
      mode = "n";
      options.desc = "Toggle file explorer";
    }
    {
      key = "<leader>e";
      action = ":Neotree focus<CR>";
      mode = "n";
      options.desc = "Focus file explorer";
    }

    # Telescope
    {
      key = "<leader>ff";
      action = ":Telescope find_files<CR>";
      mode = "n";
      options.desc = "Find files";
    }
    {
      key = "<leader>fg";
      action = ":Telescope live_grep<CR>";
      mode = "n";
      options.desc = "Live grep";
    }
    {
      key = "<leader>fb";
      action = ":Telescope buffers<CR>";
      mode = "n";
      options.desc = "Find buffers";
    }
    {
      key = "<leader>fh";
      action = ":Telescope help_tags<CR>";
      mode = "n";
      options.desc = "Find help";
    }
  ];
}