# Kulala REST Utility Keymaps
# Part of lazyvim.plugins.extras.util.rest
[
  # kulala.nvim keymaps
  {
    key = "<leader>R";
    action = "+Rest";
    mode = ["n"];
    desc = "+Rest";
  }
  {
    key = "<leader>Rb";
    action = "<cmd>lua require('kulala').scratchpad()<cr>";
    mode = ["n"];
    desc = "Open scratchpad";
  }
  {
    key = "<leader>Rc";
    action = "<cmd>lua require('kulala').copy()<cr>";
    mode = ["n"];
    desc = "Copy as cURL";
  }
  {
    key = "<leader>RC";
    action = "<cmd>lua require('kulala').from_curl()<cr>";
    mode = ["n"];
    desc = "Paste from curl";
  }
  {
    key = "<leader>Rg";
    action = "<cmd>lua require('kulala').download_graphql_schema()<cr>";
    mode = ["n"];
    desc = "Download GraphQL schema";
  }
  {
    key = "<leader>Ri";
    action = "<cmd>lua require('kulala').inspect()<cr>";
    mode = ["n"];
    desc = "Inspect current request";
  }
  {
    key = "<leader>Rn";
    action = "<cmd>lua require('kulala').jump_next()<cr>";
    mode = ["n"];
    desc = "Jump to next request";
  }
  {
    key = "<leader>Rp";
    action = "<cmd>lua require('kulala').jump_prev()<cr>";
    mode = ["n"];
    desc = "Jump to previous request";
  }
  {
    key = "<leader>Rq";
    action = "<cmd>lua require('kulala').close()<cr>";
    mode = ["n"];
    desc = "Close window";
  }
  {
    key = "<leader>Rr";
    action = "<cmd>lua require('kulala').replay()<cr>";
    mode = ["n"];
    desc = "Replay the last request";
  }
  {
    key = "<leader>Rs";
    action = "<cmd>lua require('kulala').run()<cr>";
    mode = ["n"];
    desc = "Send the request";
  }
  {
    key = "<leader>RS";
    action = "<cmd>lua require('kulala').show_stats()<cr>";
    mode = ["n"];
    desc = "Show stats";
  }
  {
    key = "<leader>Rt";
    action = "<cmd>lua require('kulala').toggle_view()<cr>";
    mode = ["n"];
    desc = "Toggle headers/body";
  }
]