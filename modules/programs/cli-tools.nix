{ pkgs, lib, ... }: {

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "ls" = "eza --color=auto --icons=always";
        "la" = "ls -ah";
        "ll" = "ls -lh";
        "lv" = "ls -la";
      };
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        scan_timeout = 10;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      enableZshIntegration = true;
    };

    # tmux = {
    #   enable = true;
    #   enableFzf = true;
    #   enableMouse = true;
    #   enableSensible = true;
    # };

  };
}
