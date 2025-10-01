{
  pkgs,
  lib,
  ...
}: {
  config = {
    vim = {
      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      # DAG entry after all plugin code so 'dap' is available
      luaConfigRC.debugpy_just_my_code = lib.nvim.dag.entryAfter ["lazyConfigs" "pluginConfigs"] ''
        local ok, dap = pcall(require, 'dap')
        if not ok then return end

        local function enforce()
          if dap.configurations and dap.configurations.python then
            for _, cfg in ipairs(dap.configurations.python) do
              if cfg.type == 'debugpy' or cfg.type == 'python' then
                cfg.justMyCode = false
              end
            end
          end
        end

        -- 1) set immediately (covers built-in debugpy)
        enforce()

        -- 2) set again once python configs are registered by nvim-dap-python
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'python',
          callback = enforce,
        })

        -- 3) last guard: enforce right before a run
        local orig_run = dap.run
        dap.run = function(config, ...)
          if (config.type == 'python' or config.type == 'debugpy')
             and config.justMyCode == nil then
            config.justMyCode = false
          end
          return orig_run(config, ...)
        end
      '';

      languages.python.dap.enable = true;

      lazy.plugins = {
        nvim-dap-python = {
          package = pkgs.vimPlugins.nvim-dap-python;
          event = [
            {
              event = "BufEnter";
              pattern = "*.py";
            }
          ];
          after =
            /*
            lua
            */
            ''
              require("dap-python").setup("uv")
            '';
        };
      };
    };
  };
}
