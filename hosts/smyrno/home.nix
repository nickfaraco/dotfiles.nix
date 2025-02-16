{ config, pkgs, lib, ... }:

{
  # Import the configuration common to all hosts
  imports = [
    ../shared/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nick";
  home.homeDirectory = "/home/nick";

  # Force stateVersion to be the one of the installed home-manager in WSL, rather than
  # the one in the common home.nix
  #home.stateVersion = lib.mkForce "24.11"; # Please read the comment before changing.
  
  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    # SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
