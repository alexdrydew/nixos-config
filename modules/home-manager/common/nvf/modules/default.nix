{
  pkgs,
  options,
  neovim-nightly-overlay,
  ...
}: {
  imports = [
    ./languages
    ./keybindings.nix
    ./plugins
    ./debugger.nix
  ];

  config = {
    vim = {
      package = neovim-nightly-overlay.packages.${pkgs.system}.neovim;
      startPlugins = with pkgs.vimPlugins; [
        vim-sleuth
        copilot-lua
        copilot-lualine
        telescope-ui-select-nvim
        telescope-fzf-native-nvim
        nvim-spectre
      ];
      ui = {
        noice.enable = true;
      };
      luaPackages = [
        "jsregexp" # for luasnip
      ];
      vimAlias = true;
      filetree.neo-tree = {
        enable = true;
      };
      theme = {
        enable = true;
        name = "rose-pine";
        style = "main";
      };
      options = {
        mouse = "a";
        signcolumn = "yes";
        splitright = true;
        splitbelow = true;
        shiftwidth = 4;
      };
      scrollOffset = 10;
      lineNumberMode = "number";
      undoFile.enable = true;
      comments.comment-nvim.enable = true;
      git.gitsigns = {
        enable = true;
        setupOpts.signs = {
          add = {text = "▌";};
          change = {text = "▌";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          changedelete = {text = "~";};
        };
      };
      binds.whichKey = {
        enable = true;
      };
      telescope = {
        enable = true;
        setupOpts.defaults = {
          file_ignore_patterns = [
            ".aider*"
            ".venv*"
          ];
          layout_config.horizontal.prompt_position = "bottom";
        };
      };
      formatter = {
        conform-nvim = {
          enable = true;
          setupOpts.formatters_by_ft = {
            lua = ["stylua"];
            python = ["ruff_fix" "ruff_format" "ruff_organize_imports"];
          };
        };
      };
      autocomplete = {
        nvim-cmp = {
          enable = true;
          sourcePlugins = [
            "copilot-cmp"
            "cmp-nvim-lsp"
            "luasnip"
            "cmp-path"
          ];
        };
      };
      notes = {
        todo-comments = {
          enable = true;
        };
      };
      mini = {
        ai.enable = true;
        surround.enable = true;
      };
      statusline.lualine = {
        enable = true;
        componentSeparator = {
          left = "";
          right = "";
        };
        sectionSeparator = {
          left = "";
          right = "";
        };
        activeSection = {
          c = [
            ''
              {
                "filename",
                path = 1, -- relative path
              }
            ''
          ];
          x =
            [
              ''
                {
                  "copilot"
                }
              ''
            ]
            ++ options.vim.statusline.lualine.activeSection.x.default;
        };
      };
      assistant.copilot = {
        enable = true;
        cmp.enable = true;
        setupOpts = {
          panel.enabled = false;
          suggestion.enabled = false;
          copilot_node_command = "node";
        };
      };
      visuals = {
        indent-blankline = {
          enable = true;
        };
      };
      autopairs.nvim-autopairs = {
        enable = true;
      };
      useSystemClipboard = true;
    };
  };
}
