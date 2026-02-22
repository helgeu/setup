# Debug and test keymaps - DAP, neotest
# Consolidated from: dap-core.nix, dap-ui.nix, neotest.nix, neotest-dap.nix, python-dap.nix
[
  # === Which-key group ===
  { mode = "n"; key = "<leader>d"; action = ""; desc = "+debug"; }

  # === DAP Core ===
  { mode = ["n"]; key = "<leader>da"; action = "<cmd>lua require('dap').run_with_args(vim.fn.input('Args: '))<cr>"; desc = "Run with Args"; }
  { mode = ["n"]; key = "<leader>db"; action = "<cmd>lua require('dap').toggle_breakpoint()<cr>"; desc = "Toggle Breakpoint"; }
  { mode = ["n"]; key = "<leader>dB"; action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"; desc = "Breakpoint Condition"; }
  { mode = ["n"]; key = "<leader>dc"; action = "<cmd>lua require('dap').continue()<cr>"; desc = "Run/Continue"; }
  { mode = ["n"]; key = "<leader>dC"; action = "<cmd>lua require('dap').run_to_cursor()<cr>"; desc = "Run to Cursor"; }
  { mode = ["n"]; key = "<leader>dg"; action = "<cmd>lua require('dap').goto_()<cr>"; desc = "Go to Line (No Execute)"; }
  { mode = ["n"]; key = "<leader>di"; action = "<cmd>lua require('dap').step_into()<cr>"; desc = "Step Into"; }
  { mode = ["n"]; key = "<leader>dj"; action = "<cmd>lua require('dap').down()<cr>"; desc = "Down"; }
  { mode = ["n"]; key = "<leader>dk"; action = "<cmd>lua require('dap').up()<cr>"; desc = "Up"; }
  { mode = ["n"]; key = "<leader>dl"; action = "<cmd>lua require('dap').run_last()<cr>"; desc = "Run Last"; }
  { mode = ["n"]; key = "<leader>do"; action = "<cmd>lua require('dap').step_out()<cr>"; desc = "Step Out"; }
  { mode = ["n"]; key = "<leader>dO"; action = "<cmd>lua require('dap').step_over()<cr>"; desc = "Step Over"; }
  { mode = ["n"]; key = "<leader>dP"; action = "<cmd>lua require('dap').pause()<cr>"; desc = "Pause"; }
  { mode = ["n"]; key = "<leader>dr"; action = "<cmd>lua require('dap').repl.toggle()<cr>"; desc = "Toggle REPL"; }
  { mode = ["n"]; key = "<leader>ds"; action = "<cmd>lua require('dap').session()<cr>"; desc = "Session"; }
  { mode = ["n"]; key = "<leader>dt"; action = "<cmd>lua require('dap').terminate()<cr>"; desc = "Terminate"; }
  { mode = ["n"]; key = "<leader>dw"; action = "<cmd>lua require('dap.ui.widgets').hover()<cr>"; desc = "Widgets"; }

  # === DAP UI ===
  { mode = ["n" "v"]; key = "<leader>de"; action = "<cmd>lua require('dapui').eval()<cr>"; desc = "Eval"; }
  { mode = ["n"]; key = "<leader>du"; action = "<cmd>lua require('dapui').toggle()<cr>"; desc = "Dap UI"; }

  # === Python DAP ===
  { key = "<leader>dPc"; action = "<cmd>lua require('dap-python').test_class()<cr>"; mode = ["n"]; desc = "Debug Class"; }
  { key = "<leader>dPt"; action = "<cmd>lua require('dap-python').test_method()<cr>"; mode = ["n"]; desc = "Debug Method"; }

  # === Neotest ===
  { key = "<leader>t"; action = "+test"; mode = ["n"]; desc = "+test"; }
  { key = "<leader>tl"; action = "<cmd>lua require('neotest').run.run_last()<cr>"; mode = ["n"]; desc = "Run Last (Neotest)"; }
  { key = "<leader>to"; action = "<cmd>lua require('neotest').output.open({ enter = true, auto_close = true })<cr>"; mode = ["n"]; desc = "Show Output (Neotest)"; }
  { key = "<leader>tO"; action = "<cmd>lua require('neotest').output_panel.toggle()<cr>"; mode = ["n"]; desc = "Toggle Output Panel (Neotest)"; }
  { key = "<leader>tr"; action = "<cmd>lua require('neotest').run.run()<cr>"; mode = ["n"]; desc = "Run Nearest (Neotest)"; }
  { key = "<leader>ts"; action = "<cmd>lua require('neotest').summary.toggle()<cr>"; mode = ["n"]; desc = "Toggle Summary (Neotest)"; }
  { key = "<leader>tS"; action = "<cmd>lua require('neotest').run.stop()<cr>"; mode = ["n"]; desc = "Stop (Neotest)"; }
  { key = "<leader>tt"; action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>"; mode = ["n"]; desc = "Run File (Neotest)"; }
  { key = "<leader>tT"; action = "<cmd>lua require('neotest').run.run(vim.uv.cwd())<cr>"; mode = ["n"]; desc = "Run All Test Files (Neotest)"; }
  { key = "<leader>tw"; action = "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>"; mode = ["n"]; desc = "Toggle Watch (Neotest)"; }

  # === Neotest DAP ===
  { key = "<leader>td"; action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>"; mode = ["n"]; desc = "Debug Nearest"; }
]
