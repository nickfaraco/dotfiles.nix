{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions;
      [
        # Theming

        ## Languages
        # Python
        ms-python.python
        ms-python.debugpy
        # Latex
        james-yu.latex-workshop
        # TOML
        tamasfe.even-better-toml
        # Nix
        jnoortheen.nix-ide
        bbenoist.nix
        # Markdown
        yzhang.markdown-all-in-one
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "texpresso-basic";
          publisher = "DominikPeters";
          version = "1.5.1";
          sha256 = "sha256-EjtSL/V43o77gaiTK8Qa6SLdh0D4Lk+TaWRbCQPKTek=";
        }
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
      "latex-workshop.latex.tools" = [
        {
          "name" = "latexmk";
          "command" = "latexmk";
          "args" = [
            "-synctex=1"
            "-interaction=nonstopmode"
            "-file-line-error"
            "-pdf"
            "-outdir=%OUTDIR%"
            "%DOC%"
          ];
        }
      ];
      "latex-workshop.latex.recipes" = [
        {
          "name" = "latexmk 🔃";
          "tools" = ["latexmk"];
        }
      ];
      "latex-workshop.view.pdf.viewer" = "tab";
      "latex-workshop.intellisense.citation.backend" = "biblatex";
      "latex-workshop.latex.autoBuild.run" = "never";
      "latex-workshop.latex.autoClean.run" = "never";
      "latex-workshop.latex.outDir" = "%DIR%/build";
      "texpresso.useEditorTheme" = true;
      "texpresso.command" = "${pkgs.texpresso}/bin/texpresso";
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
