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
        "cat" = "bat";
      };
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
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      enableZshIntegration = true;
    };

    bash = {
      enable = true;
      profileExtra = "exec zsh\n"; # make bash load Zsh, useful on WSL or wherever we cannot change the default system shell
    };

    ssh = {
      enable = true;
      extraConfig = ''
        IdentityFile ~/.ssh/id_ed25519
      '';
      matchBlocks.gh = {
        user = "git";
        hostname = "github.com";
      };
    };
  };
}
