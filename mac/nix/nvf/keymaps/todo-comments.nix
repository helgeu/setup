# Todo-comments.nvim Keymaps
# LazyVim keymaps for todo-comments.nvim - 6 keymaps

[
  {
    mode = ["n"];
    key = "<leader>st";
    action = "<cmd>TodoTelescope<cr>";
    desc = "Todo";
  }
  {
    mode = ["n"];
    key = "<leader>sT";
    action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
    desc = "Todo/Fix/Fixme";
  }
  {
    mode = ["n"];
    key = "<leader>xt";
    action = "<cmd>Trouble todo toggle<cr>";
    desc = "Todo (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>xT";
    action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
    desc = "Todo/Fix/Fixme (Trouble)";
  }
  {
    mode = ["n"];
    key = "[t";
    action = "<cmd>lua require('todo-comments').jump_prev()<cr>";
    desc = "Previous Todo Comment";
  }
  {
    mode = ["n"];
    key = "]t";
    action = "<cmd>lua require('todo-comments').jump_next()<cr>";
    desc = "Next Todo Comment";
  }
]