{
  programs.nixvim = {
    autoGroups = {
      large_buf = { clear = true; };
      checktime = { clear = true; };
      create_dir = { clear = true; };
      terminal_settings = { clear = true; };
      bufferline = { clear = true; };
      highlighturl = { clear = true; };
      auto_view = { clear = true; };
      q_close_windows = { clear = true; };
      highlightyank = { clear = true; };
      unlist_quickfist = { clear = true; };
      auto_quit = { clear = true; };
      indent_blankline_refresh_scroll = { clear = true; };
      neotree_start = { clear = true; };
      neotree_refresh = { clear = true; };
    };

    autoCmd = [
      {
        event = [ "BufReadPre" ];
        group = "large_buf";
        desc = "Disable certain functionality on very large files";
        callback = {
          __raw = ''
            function(args)
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
              vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
                or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
            end
          '';
        };
      }
      {
        event = [ "FocusGained" "TermClose" "TermLeave" ];
        group = "checktime";
        desc = "Check if buffers changed on editor focus";
        command = "checktime";
      }
      {
        event = [ "BufWritePre" ];
        group = "create_dir";
        desc = "Automatically create parent directories if they don't exist when saving a file";
        callback = {
          __raw = ''
            function(args)
              if args.match:match "^%w%w+://" then return end
              vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
            end
          '';
        };
      }
      {
        event = [ "TermOpen" ];
        group = "terminal_settings";
        desc = "Disable custom statuscolumn for terminals to fix neovim/neovim#25472";
        callback = {
          __raw = ''
            function() vim.opt_local.statuscolumn = nil end
          '';
        };
      }
      {
        event = [ "TermOpen" ];
        group = "terminal_settings";
        desc = "Disable foldcolumn and signcolumn for terminals";
        callback = {
          __raw = ''
            function()
              vim.opt_local.foldcolumn = "0"
              vim.opt_local.signcolumn = "no"
            end
          '';
        };
      }
      {
        event = [ "BufAdd" "BufEnter" "TabNewEntered" ];
        group = "bufferline";
        desc = "Update buffers when adding new buffers";
        callback = {
          __raw = ''
            function(args)
              if not vim.t.bufs then vim.t.bufs = {} end
              if not buffer_is_valid(args.buf) then return end
              if args.buf ~= current_buf then
                last_buf = buffer_is_valid(current_buf) and current_buf or nil
                current_buf = args.buf
              end
              local bufs = vim.t.bufs
              if not vim.tbl_contains(bufs, args.buf) then
                table.insert(bufs, args.buf)
                vim.t.bufs = bufs
              end
              vim.t.bufs = vim.tbl_filter(buffer_is_valid, vim.t.bufs)
            end
          '';
        };
      }
      {
        event = [ "BufDelete" "TermClose" ];
        group = "bufferline";
        desc = "Update buffers when deleting buffers";
        callback = {
          __raw = ''
            function(args)
              local removed
              local bnr
              for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
                local bufs = vim.t[tab].bufs
                if bufs then
                  for i, bufnr in ipairs(bufs) do
                    if bufnr == args.buf then
                      removed = true
                      bnr = args.buf
                      table.remove(bufs, i)
                      vim.t[tab].bufs = bufs
                      break
                    end
                  end
                end
              end
              vim.t.bufs = vim.tbl_filter(buffer_is_valid, vim.t.bufs)
              vim.cmd.redrawtabline()
            end
          '';
        };
      }
      {
        event = [ "VimEnter" "FileType" "BufEnter" "WinEnter" ];
        group = "highlighturl";
        desc = "URL Highlighting";
        callback = {
          __raw = ''
            function() set_url_match() end
          '';
        };
      }
      {
        event = [ "BufWinLeave" "BufWritePost" "WinLeave" ];
        group = "auto_view";
        desc = "Save view with mkview for real files";
        callback = {
          __raw = ''
            function(args)
              if vim.b[args.buf].view_activated then vim.cmd.mkview { mods = { emsg_silent = true } } end
            end
          '';
        };
      }
      {
        event = [ "BufWinEnter" ];
        group = "auto_view";
        desc = "Try to load file view if available and enable view saving for real files";
        callback = {
          __raw = ''
            function(args)
              if not vim.b[args.buf].view_activated then
                local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
                local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
                local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
                if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
                  vim.b[args.buf].view_activated = true
                  vim.cmd.loadview { mods = { emsg_silent = true } }
                end
              end
            end
          '';
        };
      }
      {
        event = [ "BufWinEnter" ];
        group = "q_close_windows";
        desc = "Make q close help, man, quickfix, dap floats";
        callback = {
          __raw = ''
            function(args)
              local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
              if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
                vim.keymap.set("n", "q", "<cmd>close<cr>", {
                  desc = "Close window",
                  buffer = args.buf,
                  silent = true,
                  nowait = true,
                })
              end
            end
          '';
        };
      }
      {
        event = [ "TextYankPost" ];
        group = "highlightyank";
        desc = "Highlight yanked text";
        pattern = [ "*" ];
        callback = {
          __raw = ''
            function() vim.highlight.on_yank() end
          '';
        };
      }
      {
        event = [ "FileType" ];
        group = "unlist_quickfist";
        desc = "Unlist quickfist buffers";
        pattern = [ "qf" ];
        callback = {
          __raw = ''
            function() vim.opt_local.buflisted = false end
          '';
        };
      }
      {
        event = [ "BufEnter" ];
        group = "auto_quit";
        desc = "Quit NixVim if more than one window is open and only sidebar windows are list";
        callback = {
          __raw = ''
            function()
              local wins = vim.api.nvim_tabpage_list_wins(0)
              -- Both neo-tree and aerial will auto-quit if there is only a single window left
              if #wins <= 1 then return end
              local sidebar_fts = { aerial = true, ["neo-tree"] = true }
              for _, winid in ipairs(wins) do
                if vim.api.nvim_win_is_valid(winid) then
                  local bufnr = vim.api.nvim_win_get_buf(winid)
                  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                  -- If any visible windows are not sidebars, early return
                  if not sidebar_fts[filetype] then
                    return
                  -- If the visible window is a sidebar
                  else
                    -- only count filetypes once, so remove a found sidebar from the detection
                    sidebar_fts[filetype] = nil
                  end
                end
              end
              if #vim.api.nvim_list_tabpages() > 1 then
                vim.cmd.tabclose()
              else
                vim.cmd.qall()
              end
            end
          '';
        };
      }
      {
        event = [ "WinScrolled" ];
        group = "indent_blankline_refresh_scroll";
        desc = "Refresh indent blankline on window scroll";
        callback = {
          __raw = ''
            function()
              -- TODO: remove neovim version check when dropping support for Neovim 0.8
              if vim.fn.has "nvim-0.9" ~= 1 or (vim.v.event.all and vim.v.event.all.leftcol ~= 0) then
                pcall(vim.cmd.IndentBlanklineRefresh)
              end
            end
          '';
        };
      }
      {
        event = [ "BufEnter" ];
        group = "neotree_start";
        desc = "Open Neo-Tree on startup with directory";
        callback = {
          __raw = ''
            function()
              if package.loaded["neo-tree"] then
                vim.api.nvim_del_augroup_by_name "neotree_start"
              else
                local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
                if stats and stats.type == "directory" then
                  vim.api.nvim_del_augroup_by_name "neotree_start"
                  require "neo-tree"
                end
              end
            end
          '';
        };
      }
    ];
  };
}
