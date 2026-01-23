{
  pkgs,
  ...
}: {
  # AdoBoards-TUI integration for NVF
  # Since adoboards is a standalone TUI, we integrate it via extraPlugins
  # Returns the extraPlugins attribute set
  
  adoboards-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "adoboards-nvim";
      version = "1.0.0";
      src = pkgs.writeTextDir "plugin/adoboards.lua" ''
        -- AdoBoards TUI integration for Neovim
        -- Launches adoboards in a terminal split
        
        local M = {}
        
        -- Launch adoboards in a horizontal split
        function M.open_horizontal()
          vim.cmd('split')
          vim.cmd('terminal adoboards')
          vim.cmd('startinsert')
        end
        
        -- Launch adoboards in a vertical split
        function M.open_vertical()
          vim.cmd('vsplit')
          vim.cmd('terminal adoboards')
          vim.cmd('startinsert')
        end
        
        -- Launch adoboards in a new tab
        function M.open_tab()
          vim.cmd('tabnew')
          vim.cmd('terminal adoboards')
          vim.cmd('startinsert')
        end
        
        -- Launch adoboards in fullscreen
        function M.open_fullscreen()
          vim.cmd('enew')
          vim.cmd('terminal adoboards')
          vim.cmd('startinsert')
        end
        
        -- Export functions globally
        _G.AdoBoards = M
        
        -- Create user commands
        vim.api.nvim_create_user_command('AdoBoards', M.open_horizontal, {})
        vim.api.nvim_create_user_command('AdoBoardsV', M.open_vertical, {})
        vim.api.nvim_create_user_command('AdoBoardsTab', M.open_tab, {})
        vim.api.nvim_create_user_command('AdoBoardsFullscreen', M.open_fullscreen, {})
      '';
    };
  };
}