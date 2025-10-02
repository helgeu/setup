# Yanky.nvim Keymaps
# LazyVim keymaps for yanky.nvim - 18 keymaps

[
  {
    mode = ["n" "x"];
    key = "<leader>p";
    action = "<cmd>YankyRingHistory<cr>";
    desc = "Open Yank History";
  }
  {
    mode = ["n"];
    key = "<p";
    action = "<Plug>(YankyPutIndentAfterLinewise)";
    desc = "Put and Indent Left";
  }
  {
    mode = ["n"];
    key = "<P";
    action = "<Plug>(YankyPutIndentBeforeLinewise)";
    desc = "Put Before and Indent Left";
  }
  {
    mode = ["n"];
    key = "=p";
    action = "<Plug>(YankyPutAfterFilter)";
    desc = "Put After Applying a Filter";
  }
  {
    mode = ["n"];
    key = "=P";
    action = "<Plug>(YankyPutBeforeFilter)";
    desc = "Put Before Applying a Filter";
  }
  {
    mode = ["n"];
    key = ">p";
    action = "<Plug>(YankyPutIndentAfterShiftRight)";
    desc = "Put and Indent Right";
  }
  {
    mode = ["n"];
    key = ">P";
    action = "<Plug>(YankyPutIndentBeforeShiftRight)";
    desc = "Put Before and Indent Right";
  }
  {
    mode = ["n"];
    key = "[p";
    action = "<Plug>(YankyPutIndentBeforeLinewise)";
    desc = "Put Indented Before Cursor (Linewise)";
  }
  {
    mode = ["n"];
    key = "[P";
    action = "<Plug>(YankyPutIndentBeforeLinewise)";
    desc = "Put Indented Before Cursor (Linewise)";
  }
  {
    mode = ["n"];
    key = "[y";
    action = "<Plug>(YankyCycleForward)";
    desc = "Cycle Forward Through Yank History";
  }
  {
    mode = ["n"];
    key = "]p";
    action = "<Plug>(YankyPutIndentAfterLinewise)";
    desc = "Put Indented After Cursor (Linewise)";
  }
  {
    mode = ["n"];
    key = "]P";
    action = "<Plug>(YankyPutIndentAfterLinewise)";
    desc = "Put Indented After Cursor (Linewise)";
  }
  {
    mode = ["n"];
    key = "]y";
    action = "<Plug>(YankyCycleBackward)";
    desc = "Cycle Backward Through Yank History";
  }
  {
    mode = ["n" "x"];
    key = "gp";
    action = "<Plug>(YankyGPutAfter)";
    desc = "Put Text After Selection";
  }
  {
    mode = ["n" "x"];
    key = "gP";
    action = "<Plug>(YankyGPutBefore)";
    desc = "Put Text Before Selection";
  }
  {
    mode = ["n" "x"];
    key = "p";
    action = "<Plug>(YankyPutAfter)";
    desc = "Put Text After Cursor";
  }
  {
    mode = ["n" "x"];
    key = "P";
    action = "<Plug>(YankyPutBefore)";
    desc = "Put Text Before Cursor";
  }
  {
    mode = ["n" "x"];
    key = "y";
    action = "<Plug>(YankyYank)";
    desc = "Yank Text";
  }
]