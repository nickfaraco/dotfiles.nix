{globalConfigs, ...}: {
  config = {
    services.aerospace = {
      enable = false;
      settings = {
        gaps = {
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 32;
          outer.right = 8;
          inner.vertical = 8;
          inner.horizontal = 8;
        };
        mode.main.binding = {
          # Focus windows
          alt-n = "focus left";
          alt-a = "focus down";
          alt-u = "focus up";
          alt-i = "focus right";
          # Move window position
          alt-shift-n = "move left";
          alt-shift-a = "move down";
          alt-shift-u = "move up";
          alt-shift-i = "move right";
          # Change layout
          alt-x = "layout tiles horizontal vertical";
          alt-o = "layout accordion horizontal vertical";
          alt-f = "layout floating tiling";
          # Toggle floating or tile on focused window
          cmd-ctrl-shift-alt-f = "layout floating tiling";
          # Join the focused node to other node
          alt-shift-cmd-n = "join-with left";
          alt-shift-cmd-a = "join-with down";
          alt-shift-cmd-u = "join-with up";
          alt-shift-cmd-i = "join-with right";
          # Resize focused window
          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";
          # Navigate Workspaces
          alt-h = "workspace 1";
          alt-t = "workspace 2";
          alt-s = "workspace 3";
          alt-r = "workspace 4";
          # Move focused window to workspace
          alt-shift-h = "move-node-to-workspace 1";
          alt-shift-t = "move-node-to-workspace 2";
          alt-shift-s = "move-node-to-workspace 3";
          alt-shift-r = "move-node-to-workspace 4";
          # Navigate workspace back and forth
          alt-tab = "workspace-back-and-forth";
          # Enter Service Mode
          alt-shift-period = "mode service";
        };
        mode.service.binding = {
          # Reload config
          esc = ["reload-config" "mode main"];
          # Reset layout
          r = ["flatten-workspace-tree" "mode main"];
          # Close all windows but focused
          backspace = ["close-all-windows-but-current" "mode main"];
        };
        exec-on-workspace-change = [
          "/bin/bash"
          "-c"
          "sketchybar --trigger aerospace_workspace_change FOCUSED=$AEROSPACE_FOCUSED_WORKSPACE"
        ];
        on-focused-monitor-changed = [
          "move-mouse monitor-lazy-center"
        ];
      };
    };

    services.sketchybar = {
      enable = false;
    };

    home-manager.users."${globalConfigs.username}".xdg.configFile."sketchybar/".source = ./sketchybar;
  };
}
