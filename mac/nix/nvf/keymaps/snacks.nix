# Snacks.nvim Keymaps
# LazyVim keymaps for snacks.nvim - 51 keymaps

[
  {
    mode = ["n"];
    key = "<leader><space>";
    action = "<cmd>lua Snacks.picker.files()<cr>";
    desc = "Find Files (Root Dir)";
  }
  {
    mode = ["n"];
    key = "<leader>,";
    action = "<cmd>lua Snacks.picker.buffers()<cr>";
    desc = "Buffers";
  }
  {
    mode = ["n"];
    key = "<leader>.";
    action = "<cmd>lua Snacks.scratch()<cr>";
    desc = "Toggle Scratch Buffer";
  }
  {
    mode = ["n"];
    key = "<leader>/";
    action = "<cmd>lua Snacks.picker.grep()<cr>";
    desc = "Grep (Root Dir)";
  }
  {
    mode = ["n"];
    key = "<leader>:";
    action = "<cmd>lua Snacks.picker.command_history()<cr>";
    desc = "Command History";
  }
  {
    mode = ["n"];
    key = "<leader>dps";
    action = "<cmd>lua Snacks.profiler.scratch()<cr>";
    desc = "Profiler Scratch Buffer";
  }
  {
    mode = ["n"];
    key = "<leader>e";
    action = "<cmd>lua Snacks.explorer()<cr>";
    desc = "Explorer Snacks (root dir)";
  }
  {
    mode = ["n"];
    key = "<leader>E";
    action = "<cmd>lua Snacks.explorer({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Explorer Snacks (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>fb";
    action = "<cmd>lua Snacks.picker.buffers()<cr>";
    desc = "Buffers";
  }
  {
    mode = ["n"];
    key = "<leader>fB";
    action = "<cmd>lua Snacks.picker.buffers({ show_all = true })<cr>";
    desc = "Buffers (all)";
  }
  {
    mode = ["n"];
    key = "<leader>fc";
    action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<cr>";
    desc = "Find Config File";
  }
  {
    mode = ["n"];
    key = "<leader>fe";
    action = "<cmd>lua Snacks.explorer()<cr>";
    desc = "Explorer Snacks (root dir)";
  }
  {
    mode = ["n"];
    key = "<leader>fE";
    action = "<cmd>lua Snacks.explorer({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Explorer Snacks (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>ff";
    action = "<cmd>lua Snacks.picker.files()<cr>";
    desc = "Find Files (Root Dir)";
  }
  {
    mode = ["n"];
    key = "<leader>fF";
    action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Find Files (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>fg";
    action = "<cmd>lua Snacks.picker.git_files()<cr>";
    desc = "Find Files (git-files)";
  }
  {
    mode = ["n"];
    key = "<leader>fp";
    action = "<cmd>lua Snacks.picker.projects()<cr>";
    desc = "Projects";
  }
  {
    mode = ["n"];
    key = "<leader>fr";
    action = "<cmd>lua Snacks.picker.recent()<cr>";
    desc = "Recent";
  }
  {
    mode = ["n"];
    key = "<leader>fR";
    action = "<cmd>lua Snacks.picker.recent({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Recent (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>gd";
    action = "<cmd>lua Snacks.picker.git_diff()<cr>";
    desc = "Git Diff (hunks)";
  }
  {
    mode = ["n"];
    key = "<leader>gs";
    action = "<cmd>lua Snacks.picker.git_status()<cr>";
    desc = "Git Status";
  }
  {
    mode = ["n"];
    key = "<leader>gS";
    action = "<cmd>lua Snacks.picker.git_stash()<cr>";
    desc = "Git Stash";
  }
  {
    mode = ["n"];
    key = "<leader>n";
    action = "<cmd>lua Snacks.notifier.show_history()<cr>";
    desc = "Notification History";
  }
  {
    mode = ["n"];
    key = "<leader>S";
    action = "<cmd>lua Snacks.scratch.select()<cr>";
    desc = "Select Scratch Buffer";
  }
  {
    mode = ["n"];
    key = "<leader>s\"";
    action = "<cmd>lua Snacks.picker.registers()<cr>";
    desc = "Registers";
  }
  {
    mode = ["n"];
    key = "<leader>s/";
    action = "<cmd>lua Snacks.picker.search_history()<cr>";
    desc = "Search History";
  }
  {
    mode = ["n"];
    key = "<leader>sa";
    action = "<cmd>lua Snacks.picker.autocmds()<cr>";
    desc = "Autocmds";
  }
  {
    mode = ["n"];
    key = "<leader>sb";
    action = "<cmd>lua Snacks.picker.lines()<cr>";
    desc = "Buffer Lines";
  }
  {
    mode = ["n"];
    key = "<leader>sB";
    action = "<cmd>lua Snacks.picker.grep_buffers()<cr>";
    desc = "Grep Open Buffers";
  }
  {
    mode = ["n"];
    key = "<leader>sc";
    action = "<cmd>lua Snacks.picker.command_history()<cr>";
    desc = "Command History";
  }
  {
    mode = ["n"];
    key = "<leader>sC";
    action = "<cmd>lua Snacks.picker.commands()<cr>";
    desc = "Commands";
  }
  {
    mode = ["n"];
    key = "<leader>sd";
    action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
    desc = "Diagnostics";
  }
  {
    mode = ["n"];
    key = "<leader>sD";
    action = "<cmd>lua Snacks.picker.diagnostics({ buf = 0 })<cr>";
    desc = "Buffer Diagnostics";
  }
  {
    mode = ["n"];
    key = "<leader>sg";
    action = "<cmd>lua Snacks.picker.grep()<cr>";
    desc = "Grep (Root Dir)";
  }
  {
    mode = ["n"];
    key = "<leader>sG";
    action = "<cmd>lua Snacks.picker.grep({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Grep (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>sh";
    action = "<cmd>lua Snacks.picker.help()<cr>";
    desc = "Help Pages";
  }
  {
    mode = ["n"];
    key = "<leader>sH";
    action = "<cmd>lua Snacks.picker.highlights()<cr>";
    desc = "Highlights";
  }
  {
    mode = ["n"];
    key = "<leader>si";
    action = "<cmd>lua Snacks.picker.icons()<cr>";
    desc = "Icons";
  }
  {
    mode = ["n"];
    key = "<leader>sj";
    action = "<cmd>lua Snacks.picker.jumps()<cr>";
    desc = "Jumps";
  }
  {
    mode = ["n"];
    key = "<leader>sk";
    action = "<cmd>lua Snacks.picker.keymaps()<cr>";
    desc = "Keymaps";
  }
  {
    mode = ["n"];
    key = "<leader>sl";
    action = "<cmd>lua Snacks.picker.loclist()<cr>";
    desc = "Location List";
  }
  {
    mode = ["n"];
    key = "<leader>sm";
    action = "<cmd>lua Snacks.picker.marks()<cr>";
    desc = "Marks";
  }
  {
    mode = ["n"];
    key = "<leader>sM";
    action = "<cmd>lua Snacks.picker.man()<cr>";
    desc = "Man Pages";
  }
  {
    mode = ["n"];
    key = "<leader>sp";
    action = "<cmd>lua Snacks.picker.files({ cwd = require('lazy.core.config').options.root })<cr>";
    desc = "Search for Plugin Spec";
  }
  {
    mode = ["n"];
    key = "<leader>sq";
    action = "<cmd>lua Snacks.picker.qflist()<cr>";
    desc = "Quickfix List";
  }
  {
    mode = ["n"];
    key = "<leader>sR";
    action = "<cmd>lua Snacks.picker.resume()<cr>";
    desc = "Resume";
  }
  {
    mode = ["n"];
    key = "<leader>su";
    action = "<cmd>lua Snacks.picker.undo()<cr>";
    desc = "Undotree";
  }
  {
    mode = ["n" "x"];
    key = "<leader>sw";
    action = "<cmd>lua Snacks.picker.grep_word()<cr>";
    desc = "Visual selection or word (Root Dir)";
  }
  {
    mode = ["n" "x"];
    key = "<leader>sW";
    action = "<cmd>lua Snacks.picker.grep_word({ cwd = vim.fn.getcwd() })<cr>";
    desc = "Visual selection or word (cwd)";
  }
  {
    mode = ["n"];
    key = "<leader>uC";
    action = "<cmd>lua Snacks.picker.colorschemes()<cr>";
    desc = "Colorschemes";
  }
  {
    mode = ["n"];
    key = "<leader>un";
    action = "<cmd>lua Snacks.notifier.hide()<cr>";
    desc = "Dismiss All Notifications";
  }
]