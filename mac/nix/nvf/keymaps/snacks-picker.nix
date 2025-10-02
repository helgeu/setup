# Snacks Picker Keymaps
# Part of lazyvim.plugins.extras.editor.snacks_picker
[
  # snacks.nvim picker keymaps
  {
    key = "<leader><space>";
    action = "<cmd>lua Snacks.picker.files()<cr>";
    mode = ["n"];
    options = {
      desc = "Find Files (Root Dir)";
    };
  }
  {
    key = "<leader>,";
    action = "<cmd>lua Snacks.picker.buffers()<cr>";
    mode = ["n"];
    options = {
      desc = "Buffers";
    };
  }
  {
    key = "<leader>/";
    action = "<cmd>lua Snacks.picker.grep()<cr>";
    mode = ["n"];
    options = {
      desc = "Grep (Root Dir)";
    };
  }
  {
    key = "<leader>:";
    action = "<cmd>lua Snacks.picker.command_history()<cr>";
    mode = ["n"];
    options = {
      desc = "Command History";
    };
  }
  {
    key = "<leader>fb";
    action = "<cmd>lua Snacks.picker.buffers()<cr>";
    mode = ["n"];
    options = {
      desc = "Buffers";
    };
  }
  {
    key = "<leader>fB";
    action = "<cmd>lua Snacks.picker.buffers({ show_all_buffers = true })<cr>";
    mode = ["n"];
    options = {
      desc = "Buffers (all)";
    };
  }
  {
    key = "<leader>fc";
    action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<cr>";
    mode = ["n"];
    options = {
      desc = "Find Config File";
    };
  }
  {
    key = "<leader>ff";
    action = "<cmd>lua Snacks.picker.files()<cr>";
    mode = ["n"];
    options = {
      desc = "Find Files (Root Dir)";
    };
  }
  {
    key = "<leader>fF";
    action = "<cmd>lua Snacks.picker.files({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    options = {
      desc = "Find Files (cwd)";
    };
  }
  {
    key = "<leader>fg";
    action = "<cmd>lua Snacks.picker.git_files()<cr>";
    mode = ["n"];
    options = {
      desc = "Find Files (git-files)";
    };
  }
  {
    key = "<leader>fp";
    action = "<cmd>lua Snacks.picker.projects()<cr>";
    mode = ["n"];
    options = {
      desc = "Projects";
    };
  }
  {
    key = "<leader>fr";
    action = "<cmd>lua Snacks.picker.recent()<cr>";
    mode = ["n"];
    options = {
      desc = "Recent";
    };
  }
  {
    key = "<leader>fR";
    action = "<cmd>lua Snacks.picker.recent({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    options = {
      desc = "Recent (cwd)";
    };
  }
  {
    key = "<leader>gd";
    action = "<cmd>lua Snacks.picker.git_diff()<cr>";
    mode = ["n"];
    options = {
      desc = "Git Diff (hunks)";
    };
  }
  {
    key = "<leader>gs";
    action = "<cmd>lua Snacks.picker.git_status()<cr>";
    mode = ["n"];
    options = {
      desc = "Git Status";
    };
  }
  {
    key = "<leader>gS";
    action = "<cmd>lua Snacks.picker.git_stash()<cr>";
    mode = ["n"];
    options = {
      desc = "Git Stash";
    };
  }
  {
    key = "<leader>n";
    action = "<cmd>lua Snacks.picker.notifications()<cr>";
    mode = ["n"];
    options = {
      desc = "Notification History";
    };
  }
  {
    key = "<leader>s\"";
    action = "<cmd>lua Snacks.picker.registers()<cr>";
    mode = ["n"];
    options = {
      desc = "Registers";
    };
  }
  {
    key = "<leader>s/";
    action = "<cmd>lua Snacks.picker.search_history()<cr>";
    mode = ["n"];
    options = {
      desc = "Search History";
    };
  }
  {
    key = "<leader>sa";
    action = "<cmd>lua Snacks.picker.autocmds()<cr>";
    mode = ["n"];
    options = {
      desc = "Autocmds";
    };
  }
  {
    key = "<leader>sb";
    action = "<cmd>lua Snacks.picker.lines()<cr>";
    mode = ["n"];
    options = {
      desc = "Buffer Lines";
    };
  }
  {
    key = "<leader>sB";
    action = "<cmd>lua Snacks.picker.grep_buffers()<cr>";
    mode = ["n"];
    options = {
      desc = "Grep Open Buffers";
    };
  }
  {
    key = "<leader>sc";
    action = "<cmd>lua Snacks.picker.command_history()<cr>";
    mode = ["n"];
    options = {
      desc = "Command History";
    };
  }
  {
    key = "<leader>sC";
    action = "<cmd>lua Snacks.picker.commands()<cr>";
    mode = ["n"];
    options = {
      desc = "Commands";
    };
  }
  {
    key = "<leader>sd";
    action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
    mode = ["n"];
    options = {
      desc = "Diagnostics";
    };
  }
  {
    key = "<leader>sD";
    action = "<cmd>lua Snacks.picker.diagnostics({ buf = 0 })<cr>";
    mode = ["n"];
    options = {
      desc = "Buffer Diagnostics";
    };
  }
  {
    key = "<leader>sg";
    action = "<cmd>lua Snacks.picker.grep()<cr>";
    mode = ["n"];
    options = {
      desc = "Grep (Root Dir)";
    };
  }
  {
    key = "<leader>sG";
    action = "<cmd>lua Snacks.picker.grep({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    options = {
      desc = "Grep (cwd)";
    };
  }
  {
    key = "<leader>sh";
    action = "<cmd>lua Snacks.picker.help()<cr>";
    mode = ["n"];
    options = {
      desc = "Help Pages";
    };
  }
  {
    key = "<leader>sH";
    action = "<cmd>lua Snacks.picker.highlights()<cr>";
    mode = ["n"];
    options = {
      desc = "Highlights";
    };
  }
  {
    key = "<leader>si";
    action = "<cmd>lua Snacks.picker.icons()<cr>";
    mode = ["n"];
    options = {
      desc = "Icons";
    };
  }
  {
    key = "<leader>sj";
    action = "<cmd>lua Snacks.picker.jumps()<cr>";
    mode = ["n"];
    options = {
      desc = "Jumps";
    };
  }
  {
    key = "<leader>sk";
    action = "<cmd>lua Snacks.picker.keymaps()<cr>";
    mode = ["n"];
    options = {
      desc = "Keymaps";
    };
  }
  {
    key = "<leader>sl";
    action = "<cmd>lua Snacks.picker.loclist()<cr>";
    mode = ["n"];
    options = {
      desc = "Location List";
    };
  }
  {
    key = "<leader>sm";
    action = "<cmd>lua Snacks.picker.marks()<cr>";
    mode = ["n"];
    options = {
      desc = "Marks";
    };
  }
  {
    key = "<leader>sM";
    action = "<cmd>lua Snacks.picker.man()<cr>";
    mode = ["n"];
    options = {
      desc = "Man Pages";
    };
  }
  {
    key = "<leader>sp";
    action = "<cmd>lua Snacks.picker.lazy()<cr>";
    mode = ["n"];
    options = {
      desc = "Search for Plugin Spec";
    };
  }
  {
    key = "<leader>sq";
    action = "<cmd>lua Snacks.picker.qflist()<cr>";
    mode = ["n"];
    options = {
      desc = "Quickfix List";
    };
  }
  {
    key = "<leader>sR";
    action = "<cmd>lua Snacks.picker.resume()<cr>";
    mode = ["n"];
    options = {
      desc = "Resume";
    };
  }
  {
    key = "<leader>su";
    action = "<cmd>lua Snacks.picker.undo()<cr>";
    mode = ["n"];
    options = {
      desc = "Undotree";
    };
  }
  {
    key = "<leader>sw";
    action = "<cmd>lua Snacks.picker.grep_word()<cr>";
    mode = ["n" "x"];
    options = {
      desc = "Visual selection or word (Root Dir)";
    };
  }
  {
    key = "<leader>sW";
    action = "<cmd>lua Snacks.picker.grep_word({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n" "x"];
    options = {
      desc = "Visual selection or word (cwd)";
    };
  }
  {
    key = "<leader>uC";
    action = "<cmd>lua Snacks.picker.colorschemes()<cr>";
    mode = ["n"];
    options = {
      desc = "Colorschemes";
    };
  }
]