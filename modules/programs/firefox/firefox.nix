# using this overlay https://github.com/bandithedoge/nixpkgs-firefox-darwin
# and css adapted from https://github.com/scientiac/scifox/tree/immersive
{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # IMPORTANT: use a package provided by the overlay (ends with `-bin`)
    # see overlay.nix in the repo for all possible packages
    package = pkgs.firefox-bin; # Use pkgs.firefox-bin for Firefox, pkgs.librewolf for Librewolf or pkgs.floorp-bin for Floorp

    # https://mozilla.github.io/policy-templates/
    policies = {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = false;
      DisableTelemetry = true;
      DisableFirefoxAccounts = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        Pocket = true;
        Snippets = false;
        TopSites = false;
        Highlights = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;

      # http://kb.mozillazine.org/Category:Preferences
      settings = {
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "browser.startup.page" = 3; # reopen last tab group at startup
        "browser.startup.homepage" = "about:home";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.sessionstore.enabled" = true;
        "browser.sessionstore.resume_from_crash" = true;
        "browser.sessionstore.resume_session_once" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 524288; # 512 MB
        "browser.sessionstore.interval" = 15000; # 15 seconds
        "browser.tabs.drawInTitlebar" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.addons" = false;
        "browser.urlbar.suggest.pocket" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.newtabpage.pinned" = [
          {
            title = "youtube";
            url = "https://www.youtube.com/";
          }
          {
            title = "search.nixos";
            url = "https://search.nixos.org/";
          }
          {
            title = "gitlab";
            url = "http://www.gitlab.com/";
          }
          {
            title = "github";
            url = "https://www.github.com/";
          }
          {
            title = "chatgpt";
            url = "https://chatgpt.com/";
          }
          {
            title = "claude";
            url = "https://claude.ai/";
          }
        ];
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "general.smoothScroll" = true;
        "uc.tweak.hide-tabs-bar" = true;
        "uc.tweak.hide-forward-button" = true;
        "uc.tweak.rounded-corners" = true;
        "uc.tweak.floating-tabs" = true;
        "layout.css.color-mix.enabled" = true;
        "layout.css.light-dark.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-vpx.enabled" = true;
        "full-screen-api.ignore-widgets" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.firstparty.isolate" = true;
        "media.peerconnection.enabled" = false; # Disables WebRTC
        "dom.battery.enabled" = false;

      };
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
          "Google".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
        };
      };
      bookmarks = [
        {
          name = "NixOS";
          tags = [ "nix" "os" ];
          keyword = "nixos";
          url = "https://nixos.org/";
        }
        {
          name = "Home Manager";
          tags = [ "nix" "config" ];
          url = "https://nix-community.github.io/home-manager/";
        }
        {
          name = "JourNix blog";
          tags = [ "nix" "config" ];
          url = "https://journix.dev/";
        }
        {
          name = "Development";
          toolbar = true;
          bookmarks = [
            {
              name = "GitHub";
              url = "https://github.com/";
            }
            {
              name = "Stack Overflow";
              url = "https://stackoverflow.com/";
            }
          ];
        }
      ];
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        # https-everywhere
        privacy-badger
        proton-pass
        zotero-connector
        duckduckgo-privacy-essentials
        sidebery
        sponsorblock
        istilldontcareaboutcookies
        adaptive-tab-bar-colour

      ];

      userChrome = (builtins.readFile ./userChrome.css);
      userContent = (builtins.readFile ./userContent.css);

    };
  };
}
