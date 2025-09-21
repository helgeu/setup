# Debug-related keymaps
{ pkgs, ... }: {
  keymaps = [
    {
      key = "<leader>db";
      action = ":DapToggleBreakpoint<CR>";
      mode = "n";
      options.desc = "Toggle breakpoint";
    }
    {
      key = "<leader>dc";
      action = ":DapContinue<CR>";
      mode = "n";
      options.desc = "Start/Continue debugging";
    }
    {
      key = "<leader>di";
      action = ":DapStepInto<CR>";
      mode = "n";
      options.desc = "Step into";
    }
    {
      key = "<leader>do";
      action = ":DapStepOver<CR>";
      mode = "n";
      options.desc = "Step over";
    }
    {
      key = "<leader>dO";
      action = ":DapStepOut<CR>";
      mode = "n";
      options.desc = "Step out";
    }
    {
      key = "<leader>dt";
      action = ":DapTerminate<CR>";
      mode = "n";
      options.desc = "Terminate debug session";
    }
  ];
}