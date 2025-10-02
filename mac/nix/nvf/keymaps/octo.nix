# Octo GitHub Utility Keymaps
# Part of lazyvim.plugins.extras.util.octo
[
  # octo.nvim keymaps
  {
    key = "<leader>gi";
    action = "<cmd>Octo issue list<cr>";
    mode = ["n"];
    options = {
      desc = "List Issues (Octo)";
    };
  }
  {
    key = "<leader>gI";
    action = "<cmd>Octo issue search<cr>";
    mode = ["n"];
    options = {
      desc = "Search Issues (Octo)";
    };
  }
  {
    key = "<leader>gp";
    action = "<cmd>Octo pr list<cr>";
    mode = ["n"];
    options = {
      desc = "List PRs (Octo)";
    };
  }
  {
    key = "<leader>gP";
    action = "<cmd>Octo pr search<cr>";
    mode = ["n"];
    options = {
      desc = "Search PRs (Octo)";
    };
  }
  {
    key = "<leader>gr";
    action = "<cmd>Octo repo list<cr>";
    mode = ["n"];
    options = {
      desc = "List Repos (Octo)";
    };
  }
  {
    key = "<leader>gS";
    action = "<cmd>Octo search<cr>";
    mode = ["n"];
    options = {
      desc = "Search (Octo)";
    };
  }
  {
    key = "<localleader>a";
    action = "+assignee (Octo)";
    mode = ["n"];
    options = {
      desc = "+assignee (Octo)";
    };
  }
  {
    key = "<localleader>c";
    action = "+comment/code (Octo)";
    mode = ["n"];
    options = {
      desc = "+comment/code (Octo)";
    };
  }
  {
    key = "<localleader>g";
    action = "+goto_issue (Octo)";
    mode = ["n"];
    options = {
      desc = "+goto_issue (Octo)";
    };
  }
  {
    key = "<localleader>i";
    action = "+issue (Octo)";
    mode = ["n"];
    options = {
      desc = "+issue (Octo)";
    };
  }
  {
    key = "<localleader>l";
    action = "+label (Octo)";
    mode = ["n"];
    options = {
      desc = "+label (Octo)";
    };
  }
  {
    key = "<localleader>p";
    action = "+pr (Octo)";
    mode = ["n"];
    options = {
      desc = "+pr (Octo)";
    };
  }
  {
    key = "<localleader>pr";
    action = "+rebase (Octo)";
    mode = ["n"];
    options = {
      desc = "+rebase (Octo)";
    };
  }
  {
    key = "<localleader>ps";
    action = "+squash (Octo)";
    mode = ["n"];
    options = {
      desc = "+squash (Octo)";
    };
  }
  {
    key = "<localleader>r";
    action = "+react (Octo)";
    mode = ["n"];
    options = {
      desc = "+react (Octo)";
    };
  }
  {
    key = "<localleader>v";
    action = "+review (Octo)";
    mode = ["n"];
    options = {
      desc = "+review (Octo)";
    };
  }
]