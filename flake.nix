{
  description = "My Darwin+Linux flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Firefox-bin overlay for Darwin
    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    # NUR
    nur.url = "github:nix-community/NUR";

    # Firefox add-ons
    # firefox-addons = {
    #   url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Nix colors
    # nix-colors.url = "github:misterio77/nix-colors";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nur,
    nix-homebrew,
    ...
  }: let
    globalConfigs = {
      username = "nick";
    };
    # Function to import all .nix files from a directory
    importOverlays = dir: let
      contents = builtins.readDir dir;
      overlayFiles = builtins.filter (name: builtins.match ".*\\.nix" name != null) (builtins.attrNames contents);
    in
      map (name: import (dir + "/${name}")) overlayFiles;

    nixpkgsConfig = {
      config.allowUnfree = true;
      overlays =
        [
          inputs.nixpkgs-firefox-darwin.overlay
          nur.overlay
        ]
        ++ (importOverlays ./overlays);
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#trantor
    darwinConfigurations."trantor" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit self globalConfigs;};
      modules = [
        ./hosts/trantor
        inputs.stylix.darwinModules.stylix
        # `home-manager` module
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          nixpkgs = nixpkgsConfig;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nick = import ./home.nix;

          home-manager.extraSpecialArgs = {
            inherit nur inputs;
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "nick";
            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
            };
            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."trantor".pkgs;
  };
}
