{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    globals.maplocalleader = ",";

    extraConfigLuaPre = ''
      vim.g.mapleader = " "
    '';

    options = {
      number = true;
      #  relativenumber = true;
      shiftwidth = 2;
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      foldnestmax = 2;
      fillchars = {
        eob = " ";
        fold = " ";
        foldopen = "";
        foldsep = " ";
        foldclose = "";
        vert = "▕";
        diff = "╱";
        msgsep = "‾";
      };
      breakindent = true; # wrap indent to match  line start
      clipboard = "unnamedplus"; # connection to the system clipboard
      cmdheight = 0; # hide command line unless needed
      completeopt = [ "menu" "menuone" "noselect" ]; # Options for insert mode completion
      copyindent = true; # copy the previous indentation on autoindenting
      cursorline = true; # highlight the text line of the cursor
      expandtab = true; # enable the use of space in tab
      fileencoding = "utf-8"; # file content encoding for the buffer
      history = 100; # number of commands to remember in a history table
      ignorecase = true; # case insensitive searching
      infercase = true; # infer cases in keyword completion
      laststatus = 3; # global statusline
      linebreak = true; # wrap lines at 'breakat'
      mouse = "a"; # enable mouse support
      preserveindent = true; # preserve indent structure as much as possible
      pumheight = 10; # height of the pop up menu
      showmode = false; # disable showing modes in command line
      showtabline = 2; # always display tabline
      signcolumn = "yes"; # always show the sign column
      smartcase = true; # case sensitive searching
      splitbelow = true; # splitting a new window below the current one
      splitright = true; # splitting a new window at the right of the current one
      tabstop = 2; # number of space in a tab
      termguicolors = true; # enable 24-bit RGB color in the TUI
      timeoutlen = 500; # shorten key timeout length a little bit for which-key
      title = true; # set terminal title to the filename and path
      undofile = true; # enable persistent undo
      updatetime = 300; # length of time to wait before triggering the plugin
      virtualedit = "block"; # allow going past end of line in visual block mode
      wrap = true; # disable wrapping of lines longer than the width of window
      writebackup = false; # disable making a backup before overwriting a file
    };

    clipboard.providers.wl-copy.enable = true;
  };
}