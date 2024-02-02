{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      operators = { gc = "Comments"; };
      triggers = [ "<leader>" ];
      plugins.registers = true;
      registrations = {
        "<c-h>" = [ "<c-w>h" "Move top" ];
        "<c-j>" = [ "<c-w>j" "Move down" ];
        "<c-k>" = [ "<c-w>k" "Move left" ];
        "<c-l>" = [ "<c-w>l" "Move right" ];

        "<up>" = [ "<cmd>resize +1<CR>" "resize window up" ];
        "<down>" = [ "<cmd>resize -1<CR>" "resize window down" ];
        "<left>" = [ "<cmd>vertical resize -1<CR>" "resize window right" ];
        "<right>" = [ "<cmd>vertical resize +1<CR>" "resize window left" ];

        # Comments
        # "<leader>/" = [ "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" "Toggle comment" ];

        # Standard operations
        "<C-s>" = [ "<cmd>w!<cr>" "Force save" ];
        "<C-q>" = [ "<cmd>qa!<cr>" "Force quit" ];
        "<leader>w" = [ "<cmd>w<cr>" "󰨣 Save" ];
        "<leader>q" = [ "<cmd>confirm q<cr>" "Quit" ];
        "<leader>Q" = [ "<cmd>confirm qall<cr>" "Quit all" ];
        "|" = [ "<cmd>vsplit<cr>" "Vertical Split" ];
        "\\" = [ "<cmd>split<cr>" "Horizontal Split" ];
        "<leader>h" = [ "<cmd>nohl<cr>" "Clear highlight" ];

        # Find using Telescope
        "<leader>f" = [ "" " Find" ];
        "<leader>f'" = [ "<cmd>lua require('telescope.builtin').marks()<cr>" "Find marks" ];
        "<leader>fw" = [ "<cmd>lua require('telescope.builtin').live_grep()<cr>" "Find words" ];
        "<leader>fc" = [ "<cmd>lua require('telescope.builtin').grep_string()<cr>" "Find word under cursor" ];
        "<leader>ff" = [ "<cmd>lua require('telescope.builtin').find_files()<cr>" "Find files" ];

        # NeoTree
        "<leader>e" = [ "<cmd>Neotree toggle<cr>" "Toggle Explorer" ];

        # Buffer menu
        "<leader>b" = [ "" "Buffers" ];
        "<leader>bc" = [ "<cmd>lua buffer_close_all(true)<cr>" "Close all buffers except current" ];
        "<leader>bC" = [ "<cmd>lua buffer_close_all()<cr>" "Close all buffers" ];

        # Manage Buffer
        "<leader>c" = [
          "<cmd>lua buffer_close()<cr>"
          "Close current buffer"
        ];
        "<leader>C" = [
          "<cmd>lua buffer_close(0, true)<cr>"
          "Force close buffer"
        ];
        "[b" = [ "<cmd>bp<cr>" "Previous Buffer" ];
        "]b" = [ "<cmd>bn<cr>" "Next Buffer" ];
        #">b" = [
        #  "<cmd>lua buffer_move(vim.v.count > 0 and vim.v.count or 1)<cr>"
        #  "Move buffer tab right"
        #];
        #"<b" = [
        #  "<cmd>lua buffer_move(-(vim.v.count > 0 and vim.v.count or 1))<cr>"
        #  "Move buffer tab left"
        #];

        # Lsp-saga
        "[e" = [ "<cmd>Lspsaga diagnostic_jump_next<cr>" "Next Diagnostic" ];
        "]e" = [ "<cmd>Lspsaga diagnostic_jump_prev<cr>" "Previous Diagnostic" ];
        "K" = [ "<cmd>Lspsaga hover_doc<cr>" "Code Hover" ];
        "F" = [ "<cmd>lua vim.lsp.buf.format({ async = true }) <cr>" "Format the current buffer" ];
        "gi" = [ "<cmd>Lspsaga finder imp<cr>" "Find implementation" ];
        "gn" = [ "<cmd>Lspsaga incoming_calls<cr>" "Incoming Calls" ];
        "gt" = [ "<cmd>Lspsaga outgoing_calls<cr>" "Outgoing Calls" ];
        "gD" = [ "<cmd>Lspsaga goto_definition<cr>" "Go to Definition" ];
        "gd" = [ "<cmd>Lspsaga peek_definition<cr>" "Peek Definition" ];
        "gr" = [ "<cmd>Lspsaga rename<cr>" "Code Rename" ];
        "gs" = [ ''<cmd>lua require("wtf").search() <cr>'' "Search diagnostic with Google" ];
        # "<leader>p" = [ "<cmd>Lspsaga finder<cr>" "Code Finder" ];
        "<leader>a" = [ "<cmd>Lspsaga code_action<cr>" "Code Action" ];
        "<c-a>" = [ "<cmd>Lspsaga code_action<cr>" "Code Action" ];

        # Telescope
      };
    };
  };
}
