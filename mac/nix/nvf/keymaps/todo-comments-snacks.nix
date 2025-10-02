# Todo Comments Snacks Picker Keymaps
# Part of lazyvim.plugins.extras.editor.snacks_picker
[
  # todo-comments.nvim keymaps for snacks picker
  {
    key = "<leader>st";
    action = "<cmd>lua Snacks.picker.todo_comments()<cr>";
    mode = ["n"];
    desc = "Todo";
  }
  {
    key = "<leader>sT";
    action = "<cmd>lua Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })<cr>";
    mode = ["n"];
    desc = "Todo/Fix/Fixme";
  }
]