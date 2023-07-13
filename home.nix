{ config, lib, pkgs, nixvim, ... }:
let
  username = if pkgs.stdenv.isDarwin then "vicz" else "reyhan";
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";  # Default path if system is not Linux or macOS
in
{
  fonts.fontconfig.enable = true;

  home = {
    sessionPath = [
      "${homeDirectory}/.local/bin"
    ];

    packages = with pkgs; [
      # System
      docker
      asciinema
      aspell
      aspellDicts.en
      tldr
      procs
      gtop
      gcc
      unstable.btop
      tree
      ripgrep
      file
      binutils
      fd
      highlight
      nix-index
      nixpkgs-fmt
      nixpkgs-review
      openssh
      zsh
      neovim

      # Git
      gitAndTools.gh
      git-crypt
      git-lfs

      # Golang
      go
      gopls
      golangci-lint
      gofumpt
      gotools

      # Nodejs
      nodejs
      nodePackages.node2nix
      typescript
      yarn

      # Python
      unstable.python39Packages.poetry-core
      (python39.withPackages (ps: with ps; [
        pip
        powerline
        pygments
        pynvim
      ]))

      # Fonts
      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" ];
      })
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      # Add packages only for Darwin (MacOS)
      xclip
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      # Add packages only for Linux
    ];
  };

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    fzf.enable = true;
    jq.enable = true;
    bat.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;
    ssh.enable = true;
    ssh.matchBlocks.id_ed.identitiesOnly = true;

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    go = {
      enable = true;
      package = pkgs.go;
      goPath = "${homeDirectory}/go";
      goBin = "${homeDirectory}/go/bin/";
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [ "git" "ssh-agent" ];
      oh-my-zsh.theme = "robbyrussell";

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      '';

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 =
              "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./config/zsh/plugins/p10k;
          # src = ./config/zsh/plugins/p10k;
          file = "p10k.zsh";
        }
      ];

      shellAliases = {
        l = "ls -CF";
        ll = "ls -alF";
        la = "ls -A";
        vim = "nvim";
        vi = "nvim";
      };

      initExtra = ''
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word

        ZSH_AUTOSUGGEST_STRATEGY=(completion history)
      '';
    };
  };
}
