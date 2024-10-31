{...}: {
  # I'd rather not have telemetry on my package manager.
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # uninstall apps that are removed from this list (masApps need to be removed manually anyway)
      upgrade = true;
    };
    taps = [
      # `brew tap`
      "homebrew/cask" # this is necessary for this to work
      # `brew tap` with custom Git URL and arguments
      # {
      #   name = "user/tap-repo";
      #   clone_target = "https://user@bitbucket.org/user/homebrew-tap-repo.git";
      #   force_auto_update = true;
      # }
    ];
    brews = [
      "mas"
    ];
    # caskArgs = {
    #   appdir = "/Applications";
    #   require_sha = true;
    # };
    casks = [
      "unnaturalscrollwheels" # Enable natural scrolling in the trackpad but regular scroll on an external mouse
      "monitorcontrol" # Brightness and volume controls for external monitors.
      "aldente" # battery safeguard
      "calibre" # ebook manager
      "superproductivity" # task management
    ];
    masApps = {
      ## use `mas search <appname>` in the CLI to find the IDs
      # Office apps
      "Microsoft Word" = 462054704;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      # Team stuff
      OneDrive = 823766827;
      "Microsoft OneNote" = 784801555;
      "Microsoft Outlook" = 985367838;
      # Meetings
      "Microsoft Teams" = 1113153706;
      "Zoom Workplace" = 546505307;
      Webex = 833967564;
      # Remote desktop
      "Windows App" = 1295203466;
    };
  };
}
