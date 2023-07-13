return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"
    -- Include code and source with diagnostics message
    config.diagnostics_format = "[#{c}] #{m} (#{s})"
    config.sources = {
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.golangci_lint.with({
        command = { "nix-shell", "-p", "golangci-lint", "--run", "'gopls'"},
      }),
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.gofumpt.with({
        extra_args = { "-extra" },
      }),
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci", "-bn"},
      }),
    }
    return config
  end,
}