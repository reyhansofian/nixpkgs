{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      indent = true;
    };

    plugins.ts-context-commentstring = {
      enable = true;
    };

    plugins.ts-autotag = {
      enable = true;
    };

    plugins.treesitter-textobjects = {
      enable = true;

      select = {
        enable = true;
        lookahead = true;

        keymaps = {
          "ak" = { query = "@block.outer"; desc = "around block"; };
          "ik" = { query = "@block.inner"; desc = "inside block"; };
          "ac" = { query = "@class.outer"; desc = "around class"; };
          "ic" = { query = "@class.inner"; desc = "inside class"; };
          "a?" = { query = "@conditional.outer"; desc = "around conditional"; };
          "i?" = { query = "@conditional.inner"; desc = "inside conditional"; };
          "af" = { query = "@function.outer"; desc = "around function "; };
          "if" = { query = "@function.inner"; desc = "inside function "; };
          "al" = { query = "@loop.outer"; desc = "around loop"; };
          "il" = { query = "@loop.inner"; desc = "inside loop"; };
          "aa" = { query = "@parameter.outer"; desc = "around argument"; };
          "ia" = { query = "@parameter.inner"; desc = "inside argument"; };
        };
      };

      move = {
        enable = true;

        gotoNextStart = {
          "]k" = { query = "@block.outer"; desc = "Next block start"; };
          "]f" = { query = "@function.outer"; desc = "Next function start"; };
          "]a" = { query = "@parameter.inner"; desc = "Next argument start"; };
        };

        gotoNextEnd = {
          "]K" = { query = "@block.outer"; desc = "Next block end"; };
          "]F" = { query = "@function.outer"; desc = "Next function end"; };
          "]A" = { query = "@parameter.inner"; desc = "Next argument end"; };
        };

        gotoPreviousStart = {
          "[k" = { query = "@block.outer"; desc = "Previous block start"; };
          "[f" = { query = "@function.outer"; desc = "Previous function start"; };
          "[a" = { query = "@parameter.inner"; desc = "Previous argument start"; };
        };

        gotoPreviousEnd = {
          "[K" = { query = "@block.outer"; desc = "Previous block end"; };
          "[F" = { query = "@function.outer"; desc = "Previous function end"; };
          "[A" = { query = "@parameter.inner"; desc = "Previous argument end"; };
        };
      };
    };
  };
}
