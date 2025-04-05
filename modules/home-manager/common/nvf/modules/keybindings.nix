{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
  # lspMappings = config.vim.lsp.mappings;
in {
  config = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      autocomplete = {
        nvim-cmp = {
          mappings = {
            next = "<C-n>";
            previous = "<C-p>";
            scrollDocsUp = "<C-b>";
            scrollDocsDown = "<C-f>";
            confirm = "<C-CR>";
          };
        };
      };
      assistant.copilot = {
        mappings = {
          panel = {
            accept = null;
            jumpNext = null;
            jumpPrev = null;
            open = null;
            refresh = null;
          };
          suggestion = {
            accept = null;
            acceptLine = null;
            acceptWord = null;
            dismiss = null;
            next = null;
            prev = null;
          };
        };
      };
      treesitter.mappings = {
        incrementalSelection = {
          incrementByNode = null;
          incrementByScope = null;
          decrementByNode = null;
        };
      };
      telescope = {
        mappings = {
          helpTags = "<leader>sh";
          findFiles = "<leader>sf";
          liveGrep = "<leader>sg";
          diagnostics = "<leader>sd";
          resume = "<leader>sr";
          buffers = "<leader><leader>";
          lspDefinitions = "gd";
          lspReferences = "gr";
          lspImplementations = "gI";
          lspTypeDefinitions = "<leader>D";
          lspDocumentSymbols = "<leader>ds";
          lspWorkspaceSymbols = "<leader>ws";
        };
      };
      lsp = {
        mappings = {
          renameSymbol = "<leader>rn";
          codeAction = "<leader>ca";
          hover = "K";
          goToDeclaration = "gD";
          previousDiagnostic = "[d";
          nextDiagnostic = "]d";
          openDiagnosticFloat = "<leader>e";
          goToType = "gt";
        };
      };
      keymaps = [
        {
          key = "<Esc>";
          mode = ["n"];
          action = "<cmd>nohlsearch<CR>";
          silent = true;
        }
        (mkKeymap "n" "<leader>q" "vim.diagnostic.setloclist" {desc = "Open diagnostic [Q]uickfix list";})
        (mkKeymap "t" "<Esc><Esc>" "<C-\\><C-n>" {desc = "Exit terminal mode";})
        (mkKeymap "n" "<C-h>" "<C-w><C-h>" {desc = "Move focus to the left window";})
        (mkKeymap "n" "<C-l>" "<C-w><C-l>" {desc = "Move focus to the right window";})
        (mkKeymap "n" "<C-j>" "<C-w><C-j>" {desc = "Move focus to the lower window";})
        (mkKeymap "n" "<C-k>" "<C-w><C-k>" {desc = "Move focus to the upper window";})
        # TODO: keymaps for which-key
        (mkKeymap "n" "\\" "<cmd>Neotree position=float reveal<cr>" {})
        # Telescope
        (mkKeymap "n" "<leader>sk" "<cmd>Telescope keymaps<cr>" {desc = "[S]earch [K]eymaps";})
        (mkKeymap "n" "<leader>ss" "<cmd>Telescope builtin<cr>" {desc = "[S]earch [S]elect Telescope";})
        (mkKeymap "n" "<leader>sw" "<cmd>Telescope grep_string<cr>" {desc = "[S]earch current [W]ord";})
        (mkKeymap "n" "<leader>s/" "<cmd>Telescope live_grep grep_open_files=true<cr>" {desc = "[S]earch [/] in Open Files";})
        (mkKeymap "n" "<leader>sn" "<cmd>Telescope find_files cwd=vim.fn.stdpath('config')<cr>" {desc = "[S]earch [N]eovim files";})
        (mkKeymap "n" "<leader>s." "<cmd>Telescope old_files<cr>" {desc = "[S]earch Recent Files ('.' for repeat)";})
      ];
    };
  };
}
