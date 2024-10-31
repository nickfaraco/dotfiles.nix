{pkgs, ...}: let
  # put a shell script into the nix store
  gitIdentity =
    pkgs.writeShellScriptBin "git-identity" (builtins.readFile ./git-identity);
in {
  # we will use the excellent fzf in our `git-identity` script, so let's make sure it's available
  # let's add the gitIdentity script to the path as well
  home.packages = with pkgs; [
    gitIdentity
    fzf
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      # extremely important, otherwise git will attempt to guess a default user identity. see `man git-config` for more details
      user.useConfigOnly = true;

      push.followTags = true;

      # the `work` identity
      user.work.name = "Niccolò Faraco";
      user.work.email = "niccolo.faraco@polimi.it";

      # the `personal` identity
      user.personal.name = "Niccolò Faraco";
      user.personal.email = "faraco.nic@gmail.com";
    };
    # This is optional, as `git identity` will call the `git-identity` script by itself, however
    # setting it up explicitly as an alias gives you autocomplete
    aliases = {
      # Commit author (uses custom script)
      identity = "! git-identity";
      id = "! git-identity";

      # Status
      st = "status -sb"; # Short status with branch info

      # Branching
      co = "checkout";
      cob = "checkout -b";
      br = "branch";
      bd = "branch -d";
      bD = "branch -D";

      # Committing
      cm = "commit -m";
      ca = "commit --amend";
      can = "commit --amend --no-edit";

      # Staging
      a = "add";
      aa = "add --all";
      ap = "add --patch"; # Interactive staging
      unstage = "reset HEAD --";

      # Logs
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ll = "log --pretty=format:'%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]' --decorate --numstat";
      last = "log -1 HEAD --stat";

      # Diff
      df = "diff";
      dfc = "diff --cached";

      # Remote
      ps = "push";
      psf = "push --force-with-lease";
      pl = "pull";
      plr = "pull --rebase";

      # Stash
      ss = "stash save";
      sp = "stash pop";
      sl = "stash list";

      # Reset
      rs = "reset";
      rsh = "reset --hard";
      rss = "reset --soft";

      # Merge/Rebase
      rb = "rebase";
      rbi = "rebase -i";
      rbc = "rebase --continue";
      rba = "rebase --abort";

      # Utility
      cp = "cherry-pick";
      root = "rev-parse --show-toplevel"; # Show repository root directory
      aliases = "config --get-regexp alias"; # List all aliases
    };
    ignores = [
      ".DS_Store"
    ];
  };
}
