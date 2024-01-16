{
  programs.nixvim = {
    extraConfigLuaPre = ''
      --- Run a git command from the AstroNvim installation directory
      ---@param args string|string[] the git arguments
      ---@return string|nil # The result of the command or nil if unsuccessful
      function git_cmd(args, ...)
        if type(args) == "string" then args = { args } end
        return cmd(vim.list_extend({ "git", "-C", "$HOME" }, args), ...)
      end

      --- Get the first worktree that a file belongs to
      ---@param file string? the file to check, defaults to the current file
      ---@param worktrees table<string, string>[]? an array like table of worktrees with entries `toplevel` and `gitdir`, default retrieves from `vim.g.git_worktrees`
      ---@return table<string, string>|nil # a table specifying the `toplevel` and `gitdir` of a worktree or nil if not found
      function git_file_worktree(file, worktrees)
        worktrees = worktrees or vim.g.git_worktrees
        if not worktrees then return end
        file = file or vim.fn.expand "%"
        for _, worktree in ipairs(worktrees) do
          if
            cmd({
              "git",
              "--work-tree",
              worktree.toplevel,
              "--git-dir",
              worktree.gitdir,
              "ls-files",
              "--error-unmatch",
              file,
            }, false)
          then
            return worktree
          end
        end
      end
    '';
  };
}
