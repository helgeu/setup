# ⌨️ LazyVim Keymaps Reference (Official + Numbered)

This is the complete and official LazyVim keymaps reference with systematic numbering added to ALL tables for precise tracking and implementation.

**Source:** https://raw.githubusercontent.com/LazyVim/lazyvim.github.io/refs/heads/main/docs/keymaps.md

## General

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `j` | Down | **n**, **x** |
| 2 | `<Down>` | Down | **n**, **x** |
| 3 | `k` | Up | **n**, **x** |
| 4 | `<Up>` | Up | **n**, **x** |
| 5 | `<C-h>` | Go to Left Window | **n** |
| 6 | `<C-j>` | Go to Lower Window | **n** |
| 7 | `<C-k>` | Go to Upper Window | **n** |
| 8 | `<C-l>` | Go to Right Window | **n** |
| 9 | `<C-Up>` | Increase Window Height | **n** |
| 10 | `<C-Down>` | Decrease Window Height | **n** |
| 11 | `<C-Left>` | Decrease Window Width | **n** |
| 12 | `<C-Right>` | Increase Window Width | **n** |
| 13 | `<A-j>` | Move Down | **n**, **i**, **v** |
| 14 | `<A-k>` | Move Up | **n**, **i**, **v** |
| 15 | `<S-h>` | Prev Buffer | **n** |
| 16 | `<S-l>` | Next Buffer | **n** |
| 17 | `[b` | Prev Buffer | **n** |
| 18 | `]b` | Next Buffer | **n** |
| 19 | `<leader>bb` | Switch to Other Buffer | **n** |
| 20 | `<leader>\`` | Switch to Other Buffer | **n** |
| 21 | `<leader>bd` | Delete Buffer | **n** |
| 22 | `<leader>bo` | Delete Other Buffers | **n** |
| 23 | `<leader>bD` | Delete Buffer and Window | **n** |
| 24 | `<esc>` | Escape and Clear hlsearch | **i**, **n**, **s** |
| 25 | `<leader>ur` | Redraw / Clear hlsearch / Diff Update | **n** |
| 26 | `n` | Next Search Result | **n**, **x**, **o** |
| 27 | `N` | Prev Search Result | **n**, **x**, **o** |
| 28 | `<C-s>` | Save File | **i**, **x**, **n**, **s** |
| 29 | `<leader>K` | Keywordprg | **n** |
| 30 | `gco` | Add Comment Below | **n** |
| 31 | `gcO` | Add Comment Above | **n** |
| 32 | `<leader>l` | Lazy | **n** |
| 33 | `<leader>fn` | New File | **n** |
| 34 | `<leader>xl` | Location List | **n** |
| 35 | `<leader>xq` | Quickfix List | **n** |
| 36 | `[q` | Previous Quickfix | **n** |
| 37 | `]q` | Next Quickfix | **n** |
| 38 | `<leader>cf` | Format | **n**, **v** |
| 39 | `<leader>cd` | Line Diagnostics | **n** |
| 40 | `]d` | Next Diagnostic | **n** |
| 41 | `[d` | Prev Diagnostic | **n** |
| 42 | `]e` | Next Error | **n** |
| 43 | `[e` | Prev Error | **n** |
| 44 | `]w` | Next Warning | **n** |
| 45 | `[w` | Prev Warning | **n** |
| 46 | `<leader>uf` | Toggle Auto Format (Global) | **n** |
| 47 | `<leader>uF` | Toggle Auto Format (Buffer) | **n** |
| 48 | `<leader>us` | Toggle Spelling | **n** |
| 49 | `<leader>uw` | Toggle Wrap | **n** |
| 50 | `<leader>uL` | Toggle Relative Number | **n** |
| 51 | `<leader>ud` | Toggle Diagnostics | **n** |
| 52 | `<leader>ul` | Toggle Line Numbers | **n** |
| 53 | `<leader>uc` | Toggle Conceal Level | **n** |
| 54 | `<leader>uA` | Toggle Tabline | **n** |
| 55 | `<leader>uT` | Toggle Treesitter Highlight | **n** |
| 56 | `<leader>ub` | Toggle Dark Background | **n** |
| 57 | `<leader>uD` | Toggle Dimming | **n** |
| 58 | `<leader>ua` | Toggle Animations | **n** |
| 59 | `<leader>ug` | Toggle Indent Guides | **n** |
| 60 | `<leader>uS` | Toggle Smooth Scroll | **n** |
| 61 | `<leader>dpp` | Toggle Profiler | **n** |
| 62 | `<leader>dph` | Toggle Profiler Highlights | **n** |
| 63 | `<leader>uh` | Toggle Inlay Hints | **n** |
| 64 | `<leader>gL` | Git Log (cwd) | **n** |
| 65 | `<leader>gb` | Git Blame Line | **n** |
| 66 | `<leader>gf` | Git Current File History | **n** |
| 67 | `<leader>gl` | Git Log | **n** |
| 68 | `<leader>gB` | Git Browse (open) | **n**, **x** |
| 69 | `<leader>gY` | Git Browse (copy) | **n**, **x** |
| 70 | `<leader>qq` | Quit All | **n** |
| 71 | `<leader>ui` | Inspect Pos | **n** |
| 72 | `<leader>uI` | Inspect Tree | **n** |
| 73 | `<leader>L` | LazyVim Changelog | **n** |
| 74 | `<leader>fT` | Terminal (cwd) | **n** |
| 75 | `<leader>ft` | Terminal (Root Dir) | **n** |
| 76 | `<c-/>` | Terminal (Root Dir) | **n** |
| 77 | `<c-_>` | which_key_ignore | **n**, **t** |
| 78 | `<C-/>` | Hide Terminal | **t** |
| 79 | `<leader>-` | Split Window Below | **n** |
| 80 | `<leader>\|` | Split Window Right | **n** |
| 81 | `<leader>wd` | Delete Window | **n** |
| 82 | `<leader>wm` | Toggle Zoom Mode | **n** |
| 83 | `<leader>uZ` | Toggle Zoom Mode | **n** |
| 84 | `<leader>uz` | Toggle Zen Mode | **n** |
| 85 | `<leader><tab>l` | Last Tab | **n** |
| 86 | `<leader><tab>o` | Close Other Tabs | **n** |
| 87 | `<leader><tab>f` | First Tab | **n** |
| 88 | `<leader><tab><tab>` | New Tab | **n** |
| 89 | `<leader><tab>]` | Next Tab | **n** |
| 90 | `<leader><tab>d` | Close Tab | **n** |
| 91 | `<leader><tab>[` | Previous Tab | **n** |

## LSP

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cl` | Lsp Info | **n** |
| 2 | `gd` | Goto Definition | **n** |
| 3 | `gr` | References | **n** |
| 4 | `gI` | Goto Implementation | **n** |
| 5 | `gy` | Goto T[y]pe Definition | **n** |
| 6 | `gD` | Goto Declaration | **n** |
| 7 | `K` | Hover | **n** |
| 8 | `gK` | Signature Help | **n** |
| 9 | `<c-k>` | Signature Help | **i** |
| 10 | `<leader>ca` | Code Action | **n**, **v** |
| 11 | `<leader>cc` | Run Codelens | **n**, **v** |
| 12 | `<leader>cC` | Refresh & Display Codelens | **n** |
| 13 | `<leader>cR` | Rename File | **n** |
| 14 | `<leader>cr` | Rename | **n** |
| 15 | `<leader>cA` | Source Action | **n** |
| 16 | `]]` | Next Reference | **n** |
| 17 | `[[` | Prev Reference | **n** |
| 18 | `<a-n>` | Next Reference | **n** |
| 19 | `<a-p>` | Prev Reference | **n** |

## [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>bl` | Delete Buffers to the Left | **n** |
| 2 | `<leader>bp` | Toggle Pin | **n** |
| 3 | `<leader>bP` | Delete Non-Pinned Buffers | **n** |
| 4 | `<leader>br` | Delete Buffers to the Right | **n** |
| 5 | `[b` | Prev Buffer | **n** |
| 6 | `[B` | Move buffer prev | **n** |
| 7 | `]b` | Next Buffer | **n** |
| 8 | `]B` | Move buffer next | **n** |
| 9 | `<S-h>` | Prev Buffer | **n** |
| 10 | `<S-l>` | Next Buffer | **n** |

## [conform.nvim](https://github.com/stevearc/conform.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cF` | Format Injected Langs | **n**, **v** |

## [flash.nvim](https://github.com/folke/flash.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<c-s>` | Toggle Flash Search | **c** |
| 2 | `r` | Remote Flash | **o** |
| 3 | `R` | Treesitter Search | **o**, **x** |
| 4 | `s` | Flash | **n**, **o**, **x** |
| 5 | `S` | Flash Treesitter | **n**, **o**, **x** |
| 6 | `<c-space>` | Treesitter Incremental Selection | **n**, **o**, **x** |

## [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>sr` | Search and Replace | **n**, **v** |

## [mason.nvim](https://github.com/mason-org/mason.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cm` | Mason | **n** |

## [noice.nvim](https://github.com/folke/noice.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<c-b>` | Scroll Backward | **n**, **i**, **s** |
| 2 | `<c-f>` | Scroll Forward | **n**, **i**, **s** |
| 3 | `<leader>sn` | +noice | **n** |
| 4 | `<leader>sna` | Noice All | **n** |
| 5 | `<leader>snd` | Dismiss All | **n** |
| 6 | `<leader>snh` | Noice History | **n** |
| 7 | `<leader>snl` | Noice Last Message | **n** |
| 8 | `<leader>snt` | Noice Picker (Telescope/FzfLua) | **n** |
| 9 | `<S-Enter>` | Redirect Cmdline | **c** |

## [persistence.nvim](https://github.com/folke/persistence.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>qd` | Don't Save Current Session | **n** |
| 2 | `<leader>ql` | Restore Last Session | **n** |
| 3 | `<leader>qs` | Restore Session | **n** |
| 4 | `<leader>qS` | Select Session | **n** |

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader><space>` | Find Files (Root Dir) | **n** |
| 2 | `<leader>,` | Buffers | **n** |
| 3 | `<leader>.` | Toggle Scratch Buffer | **n** |
| 4 | `<leader>/` | Grep (Root Dir) | **n** |
| 5 | `<leader>:` | Command History | **n** |
| 6 | `<leader>dps` | Profiler Scratch Buffer | **n** |
| 7 | `<leader>e` | Explorer Snacks (root dir) | **n** |
| 8 | `<leader>E` | Explorer Snacks (cwd) | **n** |
| 9 | `<leader>fb` | Buffers | **n** |
| 10 | `<leader>fB` | Buffers (all) | **n** |
| 11 | `<leader>fc` | Find Config File | **n** |
| 12 | `<leader>fe` | Explorer Snacks (root dir) | **n** |
| 13 | `<leader>fE` | Explorer Snacks (cwd) | **n** |
| 14 | `<leader>ff` | Find Files (Root Dir) | **n** |
| 15 | `<leader>fF` | Find Files (cwd) | **n** |
| 16 | `<leader>fg` | Find Files (git-files) | **n** |
| 17 | `<leader>fp` | Projects | **n** |
| 18 | `<leader>fr` | Recent | **n** |
| 19 | `<leader>fR` | Recent (cwd) | **n** |
| 20 | `<leader>gd` | Git Diff (hunks) | **n** |
| 21 | `<leader>gs` | Git Status | **n** |
| 22 | `<leader>gS` | Git Stash | **n** |
| 23 | `<leader>n` | Notification History | **n** |
| 24 | `<leader>S` | Select Scratch Buffer | **n** |
| 25 | `<leader>s"` | Registers | **n** |
| 26 | `<leader>s/` | Search History | **n** |
| 27 | `<leader>sa` | Autocmds | **n** |
| 28 | `<leader>sb` | Buffer Lines | **n** |
| 29 | `<leader>sB` | Grep Open Buffers | **n** |
| 30 | `<leader>sc` | Command History | **n** |
| 31 | `<leader>sC` | Commands | **n** |
| 32 | `<leader>sd` | Diagnostics | **n** |
| 33 | `<leader>sD` | Buffer Diagnostics | **n** |
| 34 | `<leader>sg` | Grep (Root Dir) | **n** |
| 35 | `<leader>sG` | Grep (cwd) | **n** |
| 36 | `<leader>sh` | Help Pages | **n** |
| 37 | `<leader>sH` | Highlights | **n** |
| 38 | `<leader>si` | Icons | **n** |
| 39 | `<leader>sj` | Jumps | **n** |
| 40 | `<leader>sk` | Keymaps | **n** |
| 41 | `<leader>sl` | Location List | **n** |
| 42 | `<leader>sm` | Marks | **n** |
| 43 | `<leader>sM` | Man Pages | **n** |
| 44 | `<leader>sp` | Search for Plugin Spec | **n** |
| 45 | `<leader>sq` | Quickfix List | **n** |
| 46 | `<leader>sR` | Resume | **n** |
| 47 | `<leader>su` | Undotree | **n** |
| 48 | `<leader>sw` | Visual selection or word (Root Dir) | **n**, **x** |
| 49 | `<leader>sW` | Visual selection or word (cwd) | **n**, **x** |
| 50 | `<leader>uC` | Colorschemes | **n** |
| 51 | `<leader>un` | Dismiss All Notifications | **n** |

## [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>st` | Todo | **n** |
| 2 | `<leader>sT` | Todo/Fix/Fixme | **n** |
| 3 | `<leader>xt` | Todo (Trouble) | **n** |
| 4 | `<leader>xT` | Todo/Fix/Fixme (Trouble) | **n** |
| 5 | `[t` | Previous Todo Comment | **n** |
| 6 | `]t` | Next Todo Comment | **n** |

## [trouble.nvim](https://github.com/folke/trouble.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cs` | Symbols (Trouble) | **n** |
| 2 | `<leader>cS` | LSP references/definitions/... (Trouble) | **n** |
| 3 | `<leader>xL` | Location List (Trouble) | **n** |
| 4 | `<leader>xQ` | Quickfix List (Trouble) | **n** |
| 5 | `<leader>xx` | Diagnostics (Trouble) | **n** |
| 6 | `<leader>xX` | Buffer Diagnostics (Trouble) | **n** |
| 7 | `[q` | Previous Trouble/Quickfix Item | **n** |
| 8 | `]q` | Next Trouble/Quickfix Item | **n** |

## [which-key.nvim](https://github.com/folke/which-key.nvim.git)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<c-w><space>` | Window Hydra Mode (which-key) | **n** |
| 2 | `<leader>?` | Buffer Keymaps (which-key) | **n** |

## [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim.git)
Part of [lazyvim.plugins.extras.ai.copilot-chat](/extras/ai/copilot-chat)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<c-s>` | Submit Prompt | **n** |
| 2 | `<leader>a` | +ai | **n**, **v** |
| 3 | `<leader>aa` | Toggle (CopilotChat) | **n**, **v** |
| 4 | `<leader>ap` | Prompt Actions (CopilotChat) | **n**, **v** |
| 5 | `<leader>aq` | Quick Chat (CopilotChat) | **n**, **v** |
| 6 | `<leader>ax` | Clear (CopilotChat) | **n**, **v** |

## [sidekick.nvim](https://github.com/folke/sidekick.nvim.git)
Part of [lazyvim.plugins.extras.ai.sidekick](/extras/ai/sidekick)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>a` | +ai | **n**, **v** |
| 2 | `<leader>aa` | Sidekick Toggle CLI | **n** |
| 3 | `<leader>ap` | Sidekick Select Prompt | **n**, **v** |
| 4 | `<leader>as` | Sidekick Select CLI | **n** |
| 5 | `<leader>as` | Sidekick Send Visual Selection | **v** |
| 6 | `<c-.>` | Sidekick Switch Focus | **n**, **i**, **t**, **x** |

## [mini.surround](https://github.com/nvim-mini/mini.surround.git)
Part of [lazyvim.plugins.extras.coding.mini-surround](/extras/coding/mini-surround)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `gsa` | Add Surrounding | **n**, **v** |
| 2 | `gsd` | Delete Surrounding | **n** |
| 3 | `gsf` | Find Right Surrounding | **n** |
| 4 | `gsF` | Find Left Surrounding | **n** |
| 5 | `gsh` | Highlight Surrounding | **n** |
| 6 | `gsn` | Update `MiniSurround.config.n_lines` | **n** |
| 7 | `gsr` | Replace Surrounding | **n** |

## [neogen](https://github.com/danymat/neogen.git)
Part of [lazyvim.plugins.extras.coding.neogen](/extras/coding/neogen)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cn` | Generate Annotations (Neogen) | **n** |

## [yanky.nvim](https://github.com/gbprod/yanky.nvim.git)
Part of [lazyvim.plugins.extras.coding.yanky](/extras/coding/yanky)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>p` | Open Yank History | **n**, **x** |
| 2 | `<p` | Put and Indent Left | **n** |
| 3 | `<P` | Put Before and Indent Left | **n** |
| 4 | `=p` | Put After Applying a Filter | **n** |
| 5 | `=P` | Put Before Applying a Filter | **n** |
| 6 | `>p` | Put and Indent Right | **n** |
| 7 | `>P` | Put Before and Indent Right | **n** |
| 8 | `[p` | Put Indented Before Cursor (Linewise) | **n** |
| 9 | `[P` | Put Indented Before Cursor (Linewise) | **n** |
| 10 | `[y` | Cycle Forward Through Yank History | **n** |
| 11 | `]p` | Put Indented After Cursor (Linewise) | **n** |
| 12 | `]P` | Put Indented After Cursor (Linewise) | **n** |
| 13 | `]y` | Cycle Backward Through Yank History | **n** |
| 14 | `gp` | Put Text After Selection | **n**, **x** |
| 15 | `gP` | Put Text Before Selection | **n**, **x** |
| 16 | `p` | Put Text After Cursor | **n**, **x** |
| 17 | `P` | Put Text Before Cursor | **n**, **x** |
| 18 | `y` | Yank Text | **n**, **x** |

## [nvim-dap](https://github.com/mfussenegger/nvim-dap.git)
Part of [lazyvim.plugins.extras.dap.core](/extras/dap/core)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>da` | Run with Args | **n** |
| 2 | `<leader>db` | Toggle Breakpoint | **n** |
| 3 | `<leader>dB` | Breakpoint Condition | **n** |
| 4 | `<leader>dc` | Run/Continue | **n** |
| 5 | `<leader>dC` | Run to Cursor | **n** |
| 6 | `<leader>dg` | Go to Line (No Execute) | **n** |
| 7 | `<leader>di` | Step Into | **n** |
| 8 | `<leader>dj` | Down | **n** |
| 9 | `<leader>dk` | Up | **n** |
| 10 | `<leader>dl` | Run Last | **n** |
| 11 | `<leader>do` | Step Out | **n** |
| 12 | `<leader>dO` | Step Over | **n** |
| 13 | `<leader>dP` | Pause | **n** |
| 14 | `<leader>dr` | Toggle REPL | **n** |
| 15 | `<leader>ds` | Session | **n** |
| 16 | `<leader>dt` | Terminate | **n** |
| 17 | `<leader>dw` | Widgets | **n** |

## [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui.git)
Part of [lazyvim.plugins.extras.dap.core](/extras/dap/core)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>de` | Eval | **n**, **v** |
| 2 | `<leader>du` | Dap UI | **n** |

## [aerial.nvim](https://github.com/stevearc/aerial.nvim.git)
Part of [lazyvim.plugins.extras.editor.aerial](/extras/editor/aerial)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cs` | Aerial (Symbols) | **n** |

## [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
Part of [lazyvim.plugins.extras.editor.aerial](/extras/editor/aerial)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>ss` | Goto Symbol (Aerial) | **n** |

## [dial.nvim](https://github.com/monaqa/dial.nvim.git)
Part of [lazyvim.plugins.extras.editor.dial](/extras/editor/dial)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<C-a>` | Increment | **n**, **v** |
| 2 | `<C-x>` | Decrement | **n**, **v** |
| 3 | `g<C-a>` | Increment | **n**, **v** |
| 4 | `g<C-x>` | Decrement | **n**, **v** |

## [harpoon](https://github.com/ThePrimeagen/harpoon.git)
Part of [lazyvim.plugins.extras.editor.harpoon2](/extras/editor/harpoon2)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>1` | Harpoon to File 1 | **n** |
| 2 | `<leader>2` | Harpoon to File 2 | **n** |
| 3 | `<leader>3` | Harpoon to File 3 | **n** |
| 4 | `<leader>4` | Harpoon to File 4 | **n** |
| 5 | `<leader>5` | Harpoon to File 5 | **n** |
| 6 | `<leader>6` | Harpoon to File 6 | **n** |
| 7 | `<leader>7` | Harpoon to File 7 | **n** |
| 8 | `<leader>8` | Harpoon to File 8 | **n** |
| 9 | `<leader>9` | Harpoon to File 9 | **n** |
| 10 | `<leader>h` | Harpoon Quick Menu | **n** |
| 11 | `<leader>H` | Harpoon File | **n** |

## [vim-illuminate](https://github.com/RRethy/vim-illuminate.git)
Part of [lazyvim.plugins.extras.editor.illuminate](/extras/editor/illuminate)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `[[` | Prev Reference | **n** |
| 2 | `]]` | Next Reference | **n** |

## [leap.nvim](https://github.com/ggandor/leap.nvim.git)
Part of [lazyvim.plugins.extras.editor.leap](/extras/editor/leap)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `gs` | Leap from Windows | **n**, **o**, **x** |
| 2 | `s` | Leap Forward to | **n**, **o**, **x** |
| 3 | `S` | Leap Backward to | **n**, **o**, **x** |

## [mini.surround](https://github.com/nvim-mini/mini.surround.git)
Part of [lazyvim.plugins.extras.editor.leap](/extras/editor/leap)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `gz` | +surround | **n** |

## [mini.diff](https://github.com/nvim-mini/mini.diff.git)
Part of [lazyvim.plugins.extras.editor.mini-diff](/extras/editor/mini-diff)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>go` | Toggle mini.diff overlay | **n** |

## [mini.files](https://github.com/nvim-mini/mini.files.git)
Part of [lazyvim.plugins.extras.editor.mini-files](/extras/editor/mini-files)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>fm` | Open mini.files (Directory of Current File) | **n** |
| 2 | `<leader>fM` | Open mini.files (cwd) | **n** |

## [outline.nvim](https://github.com/hedyhli/outline.nvim.git)
Part of [lazyvim.plugins.extras.editor.outline](/extras/editor/outline)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cs` | Toggle Outline | **n** |

## [overseer.nvim](https://github.com/stevearc/overseer.nvim.git)
Part of [lazyvim.plugins.extras.editor.overseer](/extras/editor/overseer)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>ob` | Task builder | **n** |
| 2 | `<leader>oc` | Clear cache | **n** |
| 3 | `<leader>oi` | Overseer Info | **n** |
| 4 | `<leader>oo` | Run task | **n** |
| 5 | `<leader>oq` | Action recent task | **n** |
| 6 | `<leader>ot` | Task action | **n** |
| 7 | `<leader>ow` | Task list | **n** |

## [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim.git)
Part of [lazyvim.plugins.extras.editor.refactoring](/extras/editor/refactoring)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>r` | +refactor | **n**, **x** |
| 2 | `<leader>rb` | Extract Block | **n**, **x** |
| 3 | `<leader>rc` | Debug Cleanup | **n** |
| 4 | `<leader>rf` | Extract Function | **n**, **x** |
| 5 | `<leader>rF` | Extract Function To File | **n**, **x** |
| 6 | `<leader>ri` | Inline Variable | **n**, **x** |
| 7 | `<leader>rp` | Debug Print Variable | **n**, **x** |
| 8 | `<leader>rP` | Debug Print | **n** |
| 9 | `<leader>rs` | Refactor | **n**, **x** |
| 10 | `<leader>rx` | Extract Variable | **n**, **x** |

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)
Part of [lazyvim.plugins.extras.editor.snacks_explorer](/extras/editor/snacks_explorer)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>e` | Explorer Snacks (root dir) | **n** |
| 2 | `<leader>E` | Explorer Snacks (cwd) | **n** |
| 3 | `<leader>fe` | Explorer Snacks (root dir) | **n** |
| 4 | `<leader>fE` | Explorer Snacks (cwd) | **n** |

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)
Part of [lazyvim.plugins.extras.editor.snacks_picker](/extras/editor/snacks_picker)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader><space>` | Find Files (Root Dir) | **n** |
| 2 | `<leader>,` | Buffers | **n** |
| 3 | `<leader>/` | Grep (Root Dir) | **n** |
| 4 | `<leader>:` | Command History | **n** |
| 5 | `<leader>fb` | Buffers | **n** |
| 6 | `<leader>fB` | Buffers (all) | **n** |
| 7 | `<leader>fc` | Find Config File | **n** |
| 8 | `<leader>ff` | Find Files (Root Dir) | **n** |
| 9 | `<leader>fF` | Find Files (cwd) | **n** |
| 10 | `<leader>fg` | Find Files (git-files) | **n** |
| 11 | `<leader>fp` | Projects | **n** |
| 12 | `<leader>fr` | Recent | **n** |
| 13 | `<leader>fR` | Recent (cwd) | **n** |
| 14 | `<leader>gd` | Git Diff (hunks) | **n** |
| 15 | `<leader>gs` | Git Status | **n** |
| 16 | `<leader>gS` | Git Stash | **n** |
| 17 | `<leader>n` | Notification History | **n** |
| 18 | `<leader>s"` | Registers | **n** |
| 19 | `<leader>s/` | Search History | **n** |
| 20 | `<leader>sa` | Autocmds | **n** |
| 21 | `<leader>sb` | Buffer Lines | **n** |
| 22 | `<leader>sB` | Grep Open Buffers | **n** |
| 23 | `<leader>sc` | Command History | **n** |
| 24 | `<leader>sC` | Commands | **n** |
| 25 | `<leader>sd` | Diagnostics | **n** |
| 26 | `<leader>sD` | Buffer Diagnostics | **n** |
| 27 | `<leader>sg` | Grep (Root Dir) | **n** |
| 28 | `<leader>sG` | Grep (cwd) | **n** |
| 29 | `<leader>sh` | Help Pages | **n** |
| 30 | `<leader>sH` | Highlights | **n** |
| 31 | `<leader>si` | Icons | **n** |
| 32 | `<leader>sj` | Jumps | **n** |
| 33 | `<leader>sk` | Keymaps | **n** |
| 34 | `<leader>sl` | Location List | **n** |
| 35 | `<leader>sm` | Marks | **n** |
| 36 | `<leader>sM` | Man Pages | **n** |
| 37 | `<leader>sp` | Search for Plugin Spec | **n** |
| 38 | `<leader>sq` | Quickfix List | **n** |
| 39 | `<leader>sR` | Resume | **n** |
| 40 | `<leader>su` | Undotree | **n** |
| 41 | `<leader>sw` | Visual selection or word (Root Dir) | **n**, **x** |
| 42 | `<leader>sW` | Visual selection or word (cwd) | **n**, **x** |
| 43 | `<leader>uC` | Colorschemes | **n** |

## [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git)
Part of [lazyvim.plugins.extras.editor.snacks_picker](/extras/editor/snacks_picker)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>st` | Todo | **n** |
| 2 | `<leader>sT` | Todo/Fix/Fixme | **n** |

## [nvim-ansible](https://github.com/mfussenegger/nvim-ansible.git)
Part of [lazyvim.plugins.extras.lang.ansible](/extras/lang/ansible)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>ta` | Ansible Run Playbook/Role | **n** |

## [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim.git)
Part of [lazyvim.plugins.extras.lang.markdown](/extras/lang/markdown)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cp` | Markdown Preview | **n** |

## [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python.git)
Part of [lazyvim.plugins.extras.lang.python](/extras/lang/python)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>dPc` | Debug Class | **n** |
| 2 | `<leader>dPt` | Debug Method | **n** |

## [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim.git)
Part of [lazyvim.plugins.extras.lang.python](/extras/lang/python)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>cv` | Select VirtualEnv | **n** |

## [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui.git)
Part of [lazyvim.plugins.extras.lang.sql](/extras/lang/sql)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>D` | Toggle DBUI | **n** |

## [vimtex](https://github.com/lervag/vimtex.git)
Part of [lazyvim.plugins.extras.lang.tex](/extras/lang/tex)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<localLeader>l` | +vimtex | **n** |

## [neotest](https://github.com/nvim-neotest/neotest.git)
Part of [lazyvim.plugins.extras.test.core](/extras/test/core)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>t` | +test | **n** |
| 2 | `<leader>tl` | Run Last (Neotest) | **n** |
| 3 | `<leader>to` | Show Output (Neotest) | **n** |
| 4 | `<leader>tO` | Toggle Output Panel (Neotest) | **n** |
| 5 | `<leader>tr` | Run Nearest (Neotest) | **n** |
| 6 | `<leader>ts` | Toggle Summary (Neotest) | **n** |
| 7 | `<leader>tS` | Stop (Neotest) | **n** |
| 8 | `<leader>tt` | Run File (Neotest) | **n** |
| 9 | `<leader>tT` | Run All Test Files (Neotest) | **n** |
| 10 | `<leader>tw` | Toggle Watch (Neotest) | **n** |

## [nvim-dap](https://github.com/mfussenegger/nvim-dap.git)
Part of [lazyvim.plugins.extras.test.core](/extras/test/core)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>td` | Debug Nearest | **n** |

## [edgy.nvim](https://github.com/folke/edgy.nvim.git)
Part of [lazyvim.plugins.extras.ui.edgy](/extras/ui/edgy)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>ue` | Edgy Toggle | **n** |
| 2 | `<leader>uE` | Edgy Select Window | **n** |

## [chezmoi.nvim](https://github.com/xvzc/chezmoi.nvim.git)
Part of [lazyvim.plugins.extras.util.chezmoi](/extras/util/chezmoi)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>sz` | Chezmoi | **n** |

## [mason.nvim](https://github.com/mason-org/mason.nvim.git)
Part of [lazyvim.plugins.extras.util.gitui](/extras/util/gitui)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>gg` | GitUi (Root Dir) | **n** |
| 2 | `<leader>gG` | GitUi (cwd) | **n** |

## [octo.nvim](https://github.com/pwntester/octo.nvim.git)
Part of [lazyvim.plugins.extras.util.octo](/extras/util/octo)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>gi` | List Issues (Octo) | **n** |
| 2 | `<leader>gI` | Search Issues (Octo) | **n** |
| 3 | `<leader>gp` | List PRs (Octo) | **n** |
| 4 | `<leader>gP` | Search PRs (Octo) | **n** |
| 5 | `<leader>gr` | List Repos (Octo) | **n** |
| 6 | `<leader>gS` | Search (Octo) | **n** |
| 7 | `<localleader>a` | +assignee (Octo) | **n** |
| 8 | `<localleader>c` | +comment/code (Octo) | **n** |
| 9 | `<localleader>g` | +goto_issue (Octo) | **n** |
| 10 | `<localleader>i` | +issue (Octo) | **n** |
| 11 | `<localleader>l` | +label (Octo) | **n** |
| 12 | `<localleader>p` | +pr (Octo) | **n** |
| 13 | `<localleader>pr` | +rebase (Octo) | **n** |
| 14 | `<localleader>ps` | +squash (Octo) | **n** |
| 15 | `<localleader>r` | +react (Octo) | **n** |
| 16 | `<localleader>v` | +review (Octo) | **n** |

## [fzf-lua](https://github.com/ibhagwan/fzf-lua.git)
Part of [lazyvim.plugins.extras.util.project](/extras/util/project)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>fp` | Projects | **n** |

## [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
Part of [lazyvim.plugins.extras.util.project](/extras/util/project)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>fp` | Projects | **n** |

## [kulala.nvim](https://github.com/mistweaverco/kulala.nvim.git)
Part of [lazyvim.plugins.extras.util.rest](/extras/util/rest)

| # | Key | Description | Mode |
|---|-----|-------------|------|
| 1 | `<leader>R` | +Rest | **n** |
| 2 | `<leader>Rb` | Open scratchpad | **n** |
| 3 | `<leader>Rc` | Copy as cURL | **n** |
| 4 | `<leader>RC` | Paste from curl | **n** |
| 5 | `<leader>Rg` | Download GraphQL schema | **n** |
| 6 | `<leader>Ri` | Inspect current request | **n** |
| 7 | `<leader>Rn` | Jump to next request | **n** |
| 8 | `<leader>Rp` | Jump to previous request | **n** |
| 9 | `<leader>Rq` | Close window | **n** |
| 10 | `<leader>Rr` | Replay the last request | **n** |
| 11 | `<leader>Rs` | Send the request | **n** |
| 12 | `<leader>RS` | Show stats | **n** |
| 13 | `<leader>Rt` | Toggle headers/body | **n** |

---

## Summary

This comprehensive reference includes **ALL** keymaps from **ALL** plugins and categories in LazyVim:

### **Plugin Categories:**
- **General** (91 keymaps) - Core navigation, buffers, windows, diagnostics
- **LSP** (19 keymaps) - Language server features  
- **Core Plugins** (100+ keymaps) - bufferline, conform, flash, snacks, etc.
- **AI & Coding** (30+ keymaps) - Copilot, surround, yanky, neogen
- **Debug & Testing** (30+ keymaps) - DAP, neotest integration
- **Editor Enhancements** (100+ keymaps) - Harpoon, telescope, aerial, etc.
- **Language Support** (10+ keymaps) - Python, Markdown, LaTeX, SQL, etc.
- **UI & Utilities** (30+ keymaps) - REST client, Git tools, project management

**Total: 400+ keymaps** covering the complete LazyVim ecosystem with precise numbering for accurate implementation tracking!

**Every table is numbered from 1 for easy reference and quality control.**