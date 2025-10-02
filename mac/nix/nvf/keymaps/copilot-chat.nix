# CopilotChat.nvim Keymaps
# LazyVim keymaps for CopilotChat.nvim - 6 keymaps

[
  {
    mode = ["n"];
    key = "<c-s>";
    action = "<cmd>lua require('CopilotChat').submit_prompt()<cr>";
    desc = "Submit Prompt";
  }
  {
    mode = ["n" "v"];
    key = "<leader>a";
    action = "";
    desc = "+ai";
  }
  {
    mode = ["n" "v"];
    key = "<leader>aa";
    action = "<cmd>CopilotChatToggle<cr>";
    desc = "Toggle (CopilotChat)";
  }
  {
    mode = ["n" "v"];
    key = "<leader>ap";
    action = "<cmd>lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions())<cr>";
    desc = "Prompt Actions (CopilotChat)";
  }
  {
    mode = ["n" "v"];
    key = "<leader>aq";
    action = "<cmd>lua local input = vim.fn.input('Quick Chat: '); if input ~= '' then require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer }) end<cr>";
    desc = "Quick Chat (CopilotChat)";
  }
  {
    mode = ["n" "v"];
    key = "<leader>ax";
    action = "<cmd>CopilotChatReset<cr>";
    desc = "Clear (CopilotChat)";
  }
]