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
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nur,
    ...
  }: let
    #globalConfigs = {
    #  username = "nick";
    #};
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
      specialArgs = {inherit self;};
      modules = [
        ./hosts/trantor.nix
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
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."trantor".pkgs;
  };
}
