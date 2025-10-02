{ pkgs, ... }: {
  config = {
    extraConfigLua = ''
      -- F# specific setup
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fsharp", "fs", "fsi", "fsx" },
        callback = function()
          -- F# Interactive (REPL) mappings
          local opts = { noremap = true, silent = true, buffer = true }
          vim.keymap.set("n", "<leader>fsi", "<cmd>split term://dotnet fsi<CR>", opts)
          vim.keymap.set("v", "<leader>fse", ":'<,'>w !dotnet fsi<CR>", opts)
          vim.keymap.set("n", "<leader>fsl", "<cmd>. w !dotnet fsi<CR>", opts)
        end
      })
    '';

    plugins = {
      lsp = {
        servers = {
          fsautocomplete = {
            enable = true;
            cmd = [ "${pkgs.vscode-extensions.ionide.ionide-fsharp}/share/vscode/extensions/ionide.ionide-fsharp/fsac/fsautocomplete" ];
            extraOptions = {
              capabilities = {
                definitionProvider = true;
                documentHighlightProvider = true;
                completionProvider = {
                  resolveProvider = true;
                  triggerCharacters = [ "." ];
                };
                signatureHelpProvider = {
                  triggerCharacters = [ "(" " " ];
                };
                documentSymbolProvider = true;
                workspaceSymbolProvider = true;
                codeActionProvider = true;
                AutomaticWorkspaceInit = true;
              };
            };
          };
        };
      };
    };
  };
}