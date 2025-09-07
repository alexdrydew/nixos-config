{
  pkgs,
  options,
  neovim-nightly-overlay,
  ...
}: let
  inherit (pkgs.lib.generators) mkLuaInline;
in {
  imports = [
    ./languages
    ./keybindings.nix
    ./plugins
    ./debugger.nix
  ];

  config = {
    vim = {
      package = neovim-nightly-overlay.packages.${pkgs.system}.neovim;
      extraPlugins = with pkgs.vimPlugins; {
        vim-sleuth = {package = vim-sleuth;};
        copilot-lua = {package = copilot-lua;};
        copilot-lualine = {package = copilot-lualine;};
        telescope-ui-select-nvim = {package = telescope-ui-select-nvim;};
        telescope-fzf-native-nvim = {package = telescope-fzf-native-nvim;};
        nvim-spectre = {package = nvim-spectre;};
        tailwind-tools-nvim = {
          package = tailwind-tools-nvim;
        };
        nvim-lsp-file-operations = {
          package = nvim-lsp-file-operations;
        };
      };
      ui = {
        noice = {
          enable = true;
          setupOpts = {
            notify.enabled = false;
          };
        };
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
        foldcolumn = "1";
        foldlevel = 99;
        # start at everything folded except the first level
        foldlevelstart = 1;
        foldenable = true;
        fillchars = "eob: ,fold: ,foldopen:,foldclose:";
        foldmethod = "expr";
        foldexpr = "v:lua.vim.treesitter.foldexpr()";
        foldtext = "";
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
      git.git-conflict = {
        enable = true;
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
            "cmp-nvim-lsp"
            "luasnip"
            "cmp-path"
          ];
          setupOpts = {
            experimental = {
              # ghost_text = true;
            };
          };
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
        cmp.enable = false;
        setupOpts = {
          panel.enabled = false;
          suggestion = {
            enabled = true;
            auto_trigger = true;
          };
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
      utility = {
        images = {
          image-nvim = {
            enable = true;
            setupOpts = {
              backend = "kitty";
              hijackFilePatterns = [
                "*.png"
                "*.jpg"
                "*.jpeg"
                "*.gif"
                "*.webp"
                "*.svg"
              ];
            };
          };
        };
      };
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      withNodeJs = true; # for node remote plugins
    };
  };
}
