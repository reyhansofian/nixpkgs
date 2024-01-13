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

        "<c-s>" = [ "<cmd>w<cr>" "Save" ];
        "<leader>w" = [ "<cmd>w<cr>" "💾 Save" ];
        "<up>" = [ "<cmd>resize +1<CR>" "resize window up" ];
        "<down>" = [ "<cmd>resize -1<CR>" "resize window down" ];
        "<left>" = [ "<cmd>vertical resize -1<CR>" "resize window right" ];
        "<right>" = [ "<cmd>vertical resize +1<CR>" "resize window left" ];

        # Find
        "<leader>f" = [ "" "🔍 Find" ];
        "<leader>fw" = [ "<cmd>Telescope<cr>" "Find with Telescope" ];

        # NeoTree
        "<leader>e" = [ "<cmd>Neotree toggle<cr>" "Toggle Explorer" ];

        # Buffer Switch
        "[b" = [ "<cmd>bp<cr>" "Previous Buffer" ];
        "]b" = [ "<cmd>bn<cr>" "Next Buffer" ];
      };
    };
  };
}
