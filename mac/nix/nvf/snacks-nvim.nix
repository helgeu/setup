{
  enable = true;
  setupOpts = {
    bigfile.enable = true;
    dashboard = {
      enable = true;
      preset = {
        keys = [
          { icon = " "; key = "f"; desc = "Find File"; action = ":lua Snacks.picker.files()"; }
          { icon = " "; key = "n"; desc = "New File"; action = ":ene | startinsert"; }
          { icon = " "; key = "g"; desc = "Find Text"; action = ":lua Snacks.picker.grep()"; }
          { icon = " "; key = "r"; desc = "Recent Files"; action = ":lua Snacks.picker.recent()"; }
          { icon = " "; key = "c"; desc = "Config"; action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })"; }
          { icon = " "; key = "s"; desc = "Restore Session"; action = ":lua require('persistence').load()"; }
          { icon = "󰒲 "; key = "p"; desc = "Projects"; action = ":lua Snacks.picker.projects()"; }
          { icon = " "; key = "q"; desc = "Quit"; action = ":qa"; }
        ];
      };
      sections = [
        { section = "header"; }
        { section = "keys"; gap = 1; padding = 1; }
        # Note: "startup" section removed - requires lazy.nvim which NVF doesn't use
      ];
    };
    explorer.enable = true;
    image = {
      enabled = true;
      doc = {
        enabled = true;
        inline = true;
        float = true;
      };
    };
    indent.enable = true;
    input.enable = true;
    picker = {
      enable = true;
      sources = {
        projects = {
          confirm = "load_session";  # Try to restore session when selecting project
        };
      };
    };
    notifier.enable = true;
    project.enable = true;
    quickfile.enable = true;
    scope.enable = true;
    statuscolumn.enable = true;
    words.enable = true;
  };
}
