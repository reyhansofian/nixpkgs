{ config, lib, pkgs, ... }:
let
  username = if pkgs.stdenv.isDarwin then "vicz" else "reyhan";
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";  # Default path if system is not Linux or macOS
in
{

  # imports = [
  #   ./dotfiles/bashrc.nix
  #   ./dotfiles/fish.nix
  #   ./dotfiles/git.nix
  #   ./dotfiles/tmux.nix
  #   ./dotfiles/neovim.nix
  #   ../../services/nixos-vscode-ssh-fix.nix
  #   ../../services/nixos-hm-auto-update.nix
  # ];

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      docker
      asciinema
      aspell
      aspellDicts.en
      tldr
      procs
      gitAndTools.gh
      git-crypt
      git-lfs
      gtop
      unstable.btop
      go
      gopls
      tree
      ripgrep
      file
      binutils
      fd
      highlight
      nix-index
      yarn
      nixpkgs-fmt
      nixpkgs-review
      nodejs
      nodePackages.node2nix
      typescript
      openssh
      unstable.python39Packages.poetry-core
      zsh

      (python39.withPackages (ps: with ps; [
        pip
        powerline
        pygments
        pynvim
      ]))
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
          src = lib.cleanSource ./configs/zsh/plugins/p10k;
          # src = ./configs/zsh/plugins/p10k;
          file = "p10k.zsh";
        }
      ];

      shellAliases = {
        l = "ls -CF";
        ll = "ls -alF";
        la = "ls -A";
      };

      initExtra = ''
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word

        ZSH_AUTOSUGGEST_STRATEGY=(completion history)
      '';
    };
  };
}
