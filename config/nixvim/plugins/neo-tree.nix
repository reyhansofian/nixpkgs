{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      buffers.followCurrentFile.enabled = true;
      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;

      sourceSelector = {
        winbar = true;
        contentLayout = "focus";
        sources = [
          {
            source = "filesystem";
            displayName = " File";
          }
          {
            source = "buffers";
            displayName = "󰈙 Bufs";
          }
          {
            source = "git_status";
            displayName = "󰊢 Git";
          }
          {
            source = "diagnostics";
            displayName = "󰒡 Diagnostic";
          }
        ];
      };

      filesystem = {
        followCurrentFile.enabled = true;
        hijackNetrwBehavior = "open_current";
        useLibuvFileWatcher = true;
      };

      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;

      window = {
        width = 30;
        mappings = {
          "<space>" = { };
          "[b" = {
            command = "prev_source";
          };
          "]b" = {
            command = "next_source";
          };
          # "F" = {
          #   command = ''
          #     require("telescope.nvim") and find_in_dir or nil
          #   '';
          # };
          # "O" = "system_open";
          # "Y" = "copy_selector";
          # "h" = "parent_or_close";
          # "l" = "child_or_open";
          # "o" = "open";
        };
      };

      eventHandlers = {
        neo_tree_buffer_enter = ''
          function(_) vim.opt_local.signcolumn = "auto" end
        '';
      };
    };
  };
}
