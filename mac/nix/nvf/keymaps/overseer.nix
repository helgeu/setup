# Overseer.nvim Keymaps
# LazyVim keymaps for overseer.nvim - 7 keymaps

[
  {
    mode = ["n"];
    key = "<leader>ob";
    action = "<cmd>OverseerBuild<cr>";
    desc = "Task builder";
  }
  {
    mode = ["n"];
    key = "<leader>oc";
    action = "<cmd>OverseerClearCache<cr>";
    desc = "Clear cache";
  }
  {
    mode = ["n"];
    key = "<leader>oi";
    action = "<cmd>OverseerInfo<cr>";
    desc = "Overseer Info";
  }
  {
    mode = ["n"];
    key = "<leader>oo";
    action = "<cmd>OverseerRun<cr>";
    desc = "Run task";
  }
  {
    mode = ["n"];
    key = "<leader>oq";
    action = "<cmd>OverseerQuickAction<cr>";
    desc = "Action recent task";
  }
  {
    mode = ["n"];
    key = "<leader>ot";
    action = "<cmd>OverseerTaskAction<cr>";
    desc = "Task action";
  }
  {
    mode = ["n"];
    key = "<leader>ow";
    action = "<cmd>OverseerToggle<cr>";
    desc = "Task list";
  }
]