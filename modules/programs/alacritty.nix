{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      # font = { # managed by Stylix
      #   normal.family = "FiraCode Nerd Font Mono";
      #   size = 13;
      # };
      selection.save_to_clipboard = true;
      window = {
        dimensions = {
          lines = 50;
          columns = 150;
        };
        padding = {
          x = 15;
          y = 25;
        };
        dynamic_padding = true;
        decorations = "Transparent";
        # opacity = 0.9; # managed by Stylix
        blur = true;
        dynamic_title = true;
      };
      # colors = with config.colorScheme.palette; { # managed by Stylix
      #   bright = {
      #     black = "0x${base00}";
      #     blue = "0x${base0D}";
      #     cyan = "0x${base0C}";
      #     green = "0x${base0B}";
      #     magenta = "0x${base0E}";
      #     red = "0x${base08}";
      #     white = "0x${base06}";
      #     yellow = "0x${base09}";
      #   };
      #   cursor = {
      #     cursor = "0x${base06}";
      #     text = "0x${base06}";
      #   };
      #   normal = {
      #     black = "0x${base00}";
      #     blue = "0x${base0D}";
      #     cyan = "0x${base0C}";
      #     green = "0x${base0B}";
      #     magenta = "0x${base0E}";
      #     red = "0x${base08}";
      #     white = "0x${base06}";
      #     yellow = "0x${base0A}";
      #   };
      #   primary = {
      #     background = "0x${base00}";
      #     foreground = "0x${base06}";
      #   };
      # };
      keyboard.bindings = [
        {
          key = "K";
          mods = "Control";
          chars = "\\u000c";
        }
      ];
    };
  };
}
