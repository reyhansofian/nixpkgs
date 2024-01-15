{
  programs.nixvim = {
    extraConfigLuaPre = ''
      local function bool2str(bool) return bool and "on" or "off" end
      local function ui_notify(silent, ...) return not silent and require("notify").notify(...) end

      --- Change the number display modes
      ---@param silent? boolean if true then don't sent a notification
      function ui_change_number(silent)
        local number = vim.wo.number -- local to window
        local relativenumber = vim.wo.relativenumber -- local to window
        if not number and not relativenumber then
          vim.wo.number = true
        elseif number and not relativenumber then
          vim.wo.relativenumber = true
        elseif number and relativenumber then
          vim.wo.number = false
        else -- not number and relativenumber
          vim.wo.relativenumber = false
        end
        ui_notify(
          silent,
          string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber))
        )
      end
    '';
  };
}
