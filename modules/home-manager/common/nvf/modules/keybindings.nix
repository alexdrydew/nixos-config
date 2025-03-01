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
            confirm = "<CR>";
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
          # TODO: keymaps
          findFiles = "<leader>sf";
          # TODO: builtin
          # TODO: grep string
          liveGrep = "<leader>sg";
          diagnostics = "<leader>sd";
          resume = "<leader>sr";
          # TODO: oldfiles
          buffers = "<leader><leader>";
          # TODO: current buffer fuzzy find
          #TODO: <leader>s/
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
        (mkKeymap "n" "\\" "<cmd>Neotree reveal<cr>" {})
      ];
    };
  };
}
