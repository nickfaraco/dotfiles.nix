{...}: {
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
      # initExtra = ''
      #   # Map every git alias to g<alias>
      #   function g() {
      #     if [[ $# -eq 0 ]]; then
      #       git
      #     else
      #       local git_cmd=$(git config --get "alias.$1")
      #       if [[ -n "$git_cmd" ]]; then
      #         shift
      #         git "$git_cmd" "$@"
      #       else
      #         git "$@"
      #       fi
      #     fi
      #   }

      #   # Enable completion for the g function
      #   compdef g=git
      # '';
      initExtra = ''
        # Create explicit aliases for common git commands (map `git <alias>` to `g<alias>`)
        for cmd in $(git config --get-regexp ^alias\. | cut -d. -f2 | cut -d' ' -f1); do
          alias "g$cmd"="git $cmd"
        done

        # Enable completion
        compdef g=git
      '';
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
