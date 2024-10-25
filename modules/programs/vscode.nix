{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = true;
    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions;
      [
        # Theming

        # Languages
        ms-python.python
        ms-python.debugpy

        tamasfe.even-better-toml

        jnoortheen.nix-ide
        bbenoist.nix

        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # {
        #   name = "gruvbox-material";
        #   publisher = "sainnhe";
        #   version = "6.5.2";
        #   sha256 = "sha256-D+SZEQQwjZeuyENOYBJGn8tqS3cJiWbEkmEqhNRY/i4=";
        # }
      ];

    userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;

      # "workbench.colorTheme" = "Gruvbox Material Dark"; # managed by Stylix

      #### NixIDE
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {"command" = ["alejandra"];};
          "nixpkgs" = {
            "expr" = "import <nixpkgs> { }";
          };
          # "options" = {
          #   "nixos" = {
          #     "expr" = "(builtins.getFlake \"/PATH/TO/FLAKE\").nixosConfigurations.CONFIGNAME.options";
          #   };
          #   "home_manager" = {
          #     "expr" = "(builtins.getFlake \"/PATH/TO/FLAKE\").homeConfigurations.CONFIGNAME.options";
          #   };
          # };
        };
      };
    };

    # Keybindings
    keybindings = [
      {
        key = "ctrl+shift+x";
        command = "workbench.action.terminal.toggleTerminal";
      }
      {
        key = "cmd+shift+x";
        command = "workbench.action.terminal.toggleTerminal";
      }
      {
        key = "ctrl+y";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "cmd+y";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+7";
        command = "-editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+d";
        command = "workbench.action.toggleSidebarVisibility";
      }
      {
        key = "ctrl+b";
        command = "-workbench.action.toggleSidebarVisibility";
      }
    ];
  };

  home.packages = with pkgs; [
    # Nix Language
    nixd
    alejandra
  ];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
