{
  config,
  pkgs,
  ...
}: {
  # Other configuration...

  # Chromium configuration
  programs.chromium = {
    enable = true;
  };

  # Other configuration...
}
