{
  pkgs,
  self,
  config,
  globalConfigs,
  ...
}: {
  users.users.nick.home = "/Users/nick";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    neovim
    alacritty
    mkalias
    raycast
    fastfetch
    starship
    wezterm
    tree
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Nix settings
  nix = {
    package = pkgs.nix;
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"]; # Necessary for using flakes on this system.
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Use aliases instead of symbolic links for the apps to be found by Spotlight
  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  imports = [
    ../../modules/stylix.nix
    ./homebrew.nix
  ];

  # Manage system settings
  security.pam.enableSudoTouchIdAuth = true;
  system = {
    defaults = {
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        # ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 1; # size of the finder sidebar icons
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        "com.apple.trackpad.scaling" = 2.0; # faster trackpad tracking
      };
      dock = {
        autohide = true;
        autohide-delay = 0.1;
        # dashboard-in-overlay = false;
        mineffect = "scale";
        minimize-to-application = true;
        mru-spaces = false;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.firefox-bin}/Applications/Firefox.app"
          "/Applications/Safari.app"
        ];
        persistent-others = [
          "/Users/${globalConfigs.username}/Documents"
          "/Users/${globalConfigs.username}/Downloads"
        ];
        show-recents = false;
        showhidden = true;
        tilesize = 48;
        wvous-bl-corner = 3; # show application windows from bottom-left corner
        wvous-br-corner = 4; # show desktop from bottom-right corner
        wvous-tl-corner = 2; # show mission control from bottom-left corner
        wvous-tr-corner = 14; # quick note from bottom-left corner
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # search in current folder by default
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXSortFoldersFirst = true;
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 300;
      };
      trackpad.Clicking = true; # enable trackpad tap to click
      trackpad.TrackpadRightClick = true;
    };
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
    startup.chime = false;
  };
}
