{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      # settings.operators = { gc = "Comments"; };
      settings.triggers = [ {__unkeyed-1 = "<leader>";} ];
      settings.plugins.registers = true;
      settings.spec = [
        {
          __unkeyed-1 = "<c-h>";
          __unkeyed-2 = "<c-w>h";
          desc = "Move top";
        }
        {
          __unkeyed-1 = "<c-j>";
          __unkeyed-2 = "<c-w>j";
          desc = "Move down";
        }
        {
          __unkeyed-1 = "<c-k>";
          __unkeyed-2 = "<c-w>k";
          desc = "Move left";
        }
        {
          __unkeyed-1 = "<c-l>";
          __unkeyed-2 = "<c-w>l";
          desc = "Move right";
        }

        {
          __unkeyed-1 = "<up>";
          __unkeyed-2 = "<cmd>resize +1<CR>";
          desc =  "resize window up";
        }
        {
          __unkeyed-1 = "<down>";
          __unkeyed-2 = "<cmd>resize -1<CR>";
          desc =  "resize window down";
        }
        {
          __unkeyed-1 = "<left>";
          __unkeyed-2 = "<cmd>vertical resize -1<CR>";
          desc =  "resize window right";
        }
        {
          __unkeyed-1 = "<right>";
          __unkeyed-2 = "<cmd>vertical resize +1<CR>";
          desc =  "resize window left";
        }

        # Comments
        # "<leader>/" = [ "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" "Toggle comment" ];

        # Standard operations
        {
          __unkeyed-1 = "<C-s>";
          __unkeyed-2 = "<cmd>w!<cr>";
          desc = "Force save";
        }
        {
          __unkeyed-1 = "<C-q>";
          __unkeyed-2 = "<cmd>qa!<cr>";
          desc = "Force quit";
        }
        {
          __unkeyed-1 = "<leader>w";
          __unkeyed-2 = "<cmd>w<cr>";
          desc = "󰨣 Save";
        }
        {
          __unkeyed-1 = "<leader>q";
          __unkeyed-2 = "<cmd>confirm q<cr>";
          desc =  "Quit";
        }
        {
          __unkeyed-1 = "<leader>Q";
          __unkeyed-2 = "<cmd>confirm qall<cr>";
          desc =  "Quit all";
        }
        {
          __unkeyed-1 = "|";
          __unkeyed-2 = "<cmd>vsplit<cr>";
          desc =  "Vertical Split";
        }
        {
          __unkeyed-1 = "\\";
          __unkeyed-2 = "<cmd>split<cr>";
          desc =  "Horizontal Split";
        }
        {
          __unkeyed-1 = "<leader>h";
          __unkeyed-2 = "<cmd>nohl<cr>";
          desc =  "Clear highlight";
        }

        # Find using Telescope
        {
          __unkeyed-1 = "<leader>f";
          __unkeyed-2 = "";
          desc =  " Find";
        }
        {
          __unkeyed-1 = "<leader>f'";
          __unkeyed-2 = "<cmd>lua require('telescope.builtin').marks()<cr>";
          desc =  "Find marks";
        }
        {
          __unkeyed-1 = "<leader>fw";
          __unkeyed-2 = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
          desc =  "Find words";
        }
        {
          __unkeyed-1 = "<leader>fc";
          __unkeyed-2 = "<cmd>lua require('telescope.builtin').grep_string()<cr>";
          desc =  "Find word under cursor";
        }
        {
          __unkeyed-1 = "<leader>ff";
          __unkeyed-2 = "<cmd>lua require('telescope.builtin').find_files()<cr>";
          desc =  "Find files";
        }

        # NeoTree
        {
          __unkeyed-1 = "<leader>e";
          __unkeyed-2 = "<cmd>Neotree toggle<cr>";
          desc =  "Toggle Explorer";
        }

        # Buffer menu
        {
          __unkeyed-1 = "<leader>b";
          __unkeyed-2 = "";
          desc =  "Buffers";
        }
        {
          __unkeyed-1 = "<leader>bc";
          __unkeyed-2 = "<cmd>lua buffer_close_all(true)<cr>";
          desc =  "Close all buffers except current";
        }
        {
          __unkeyed-1 = "<leader>bC";
          __unkeyed-2 = "<cmd>lua buffer_close_all()<cr>";
          desc =  "Close all buffers";
        }

        # Manage Buffer
        {
          __unkeyed-1 = "<leader>c";
          __unkeyed-2 = "<cmd>lua buffer_close()<cr>";
          desc = "Close current buffer";
        } 
        {
          __unkeyed-1 = "<leader>C";
          __unkeyed-2 = "<cmd>lua buffer_close(0, true)<cr>";
          desc = "Force close buffer";
        }
        {
          __unkeyed-1 = "[b";
          __unkeyed-2 = "<cmd>bp<cr>";
          desc =  "Previous Buffer";
        }
        {
          __unkeyed-1 = "]b";
          __unkeyed-2 = "<cmd>bn<cr>";
          desc =  "Next Buffer";
        }
        #">b" = [
        #  "<cmd>lua buffer_move(vim.v.count > 0 and vim.v.count or 1)<cr>"
        #  "Move buffer tab right"
        #];
        #"<b" = [
        #  "<cmd>lua buffer_move(-(vim.v.count > 0 and vim.v.count or 1))<cr>"
        #  "Move buffer tab left"
        #];

        # Lsp-saga
        {
          __unkeyed-1 = "[e";
          __unkeyed-2 = "<cmd>Lspsaga diagnostic_jump_next<cr>";
          desc =  "Next Diagnostic";
        }
        {
          __unkeyed-1 = "]e";
          __unkeyed-2 = "<cmd>Lspsaga diagnostic_jump_prev<cr>";
          desc =  "Previous Diagnostic";
        }
        {
          __unkeyed-1 = "K";
          __unkeyed-2 = "<cmd>Lspsaga hover_doc<cr>";
          desc =  "Code Hover";
        }
        {
          __unkeyed-1 = "F";
          __unkeyed-2 = "<cmd>lua vim.lsp.buf.format({ async = true }) <cr>";
          desc =  "Format the current buffer";
        }
        {
          __unkeyed-1 = "gi";
          __unkeyed-2 = "<cmd>Lspsaga finder imp<cr>";
          desc =  "Find implementation";
        }
        {
          __unkeyed-1 = "gn";
          __unkeyed-2 = "<cmd>Lspsaga incoming_calls<cr>";
          desc =  "Incoming Calls";
        }
        {
          __unkeyed-1 = "gt";
          __unkeyed-2 = "<cmd>Lspsaga outgoing_calls<cr>";
          desc =  "Outgoing Calls";
        }
        {
          __unkeyed-1 = "gD";
          __unkeyed-2 = "<cmd>Lspsaga goto_definition<cr>";
          desc =  "Go to Definition";
        }
        {
          __unkeyed-1 = "gd";
          __unkeyed-2 = "<cmd>Lspsaga peek_definition<cr>";
          desc =  "Peek Definition";
        }
        {
          __unkeyed-1 = "gr";
          __unkeyed-2 = "<cmd>Lspsaga rename<cr>";
          desc =  "Code Rename";
        }
        {
          __unkeyed-1 = "gs";
          __unkeyed-2 = ''<cmd>lua require("wtf").search() <cr>'';
          desc =  "Search diagnostic with Google";
        }
        # "<leader>p" = [ "<cmd>Lspsaga finder<cr>" "Code Finder" ];
        {
          __unkeyed-1 = "<leader>a";
          __unkeyed-2 = "<cmd>Lspsaga code_action<cr>";
          desc =  "Code Action";
        }
        {
          __unkeyed-1 = "<c-a>";
          __unkeyed-2 = "<cmd>Lspsaga code_action<cr>";
          desc =  "Code Action";
        }

        # Telescope
      ];
    };
  };
}
