{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [pkgs.marksman];
    settings = {
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursorline = true;
        true-color = true;
        rulers = [80 120];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "╎";
          render = true;
        };
        statusline = {
          left = ["mode" "spinner" "version-control" "file-name"];
        };
        lsp = {
          display-messages = true;
          auto-signature-help = false;
        };
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = ["collapse_selection" "keep_primary_selection"];
        # navigate buffers
        A."," = "goto_previous_buffer";
        A."." = "goto_next_buffer";
        A.w = ":buffer-close";
        A."'" = "repeat_last_motion";
        A.x = "extend_to_line_bounds";
        X = ["extend_line_up" "extend_to_line_bounds"];
      };
      keys.select = {
        A.x = "extend_to_line_bounds";
        X = ["extend_line_up" "extend_to_line_bounds"];
      };
    };
  };
}
