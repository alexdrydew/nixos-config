{ inputs, pkgs, ... }:
let
  nixCats = inputs.nixCats;
  nixpkgs = inputs.nixpkgs;
  inherit (nixCats) utils;
  luaPath = "${./.}";
  # the following extra_pkg_config contains any values
  # which you want to pass to the config set of nixpkgs
  # import nixpkgs { config = extra_pkg_config; inherit system; }
  # will not apply to module imports
  # as that will have your system values
  extra_pkg_config = {
    # allowUnfree = true;
  };
  # management of the system variable is one of the harder parts of using flakes.

  # so I have done it here in an interesting way to keep it out of the way.
  # It gets resolved within the builder itself, and then passed to your
  # categoryDefinitions and packageDefinitions.

  # this allows you to use ${pkgs.system} whenever you want in those sections
  # without fear.

  # sometimes our overlays require a ${system} to access the overlay.
  # Your dependencyOverlays can either be lists
  # in a set of ${system}, or simply a list.
  # the nixCats builder function will accept either.
  # see :help nixCats.flake.outputs.overlays
  dependencyOverlays = /* (import ./overlays inputs) ++ */ [
    # This overlay grabs all the inputs named in the format
    # `plugins-<pluginName>`
    # Once we add this overlay to our nixpkgs, we are able to
    # use `pkgs.neovimPlugins`, which is a set of our plugins.
    (utils.standardPluginOverlay inputs)
    # add any other flake overlays here.

    # when other people mess up their overlays by wrapping them with system,
    # you may instead call this function on their overlay.
    # it will check if it has the system in the set, and if so return the desired overlay
    # (utils.fixSystemizedOverlay inputs.codeium.overlays
    #   (system: inputs.codeium.overlays.${system}.default)
    # )
  ];

  # see :help nixCats.flake.outputs.categories
  # and
  # :help nixCats.flake.outputs.categoryDefinitions.scheme
  categoryDefinitions = { pkgs, settings, categories, extra, name, mkNvimPlugin, ... }@packageDef: {
    # to define and use a new category, simply add a new list to a set here, 
    # and later, you will include categoryname = true; in the set you
    # provide when you build the package using this builder function.
    # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

    # lspsAndRuntimeDeps:
    # this section is for dependencies that should be available
    # at RUN TIME for plugins. Will be available to PATH within neovim terminal
    # this includes LSPs
    lspsAndRuntimeDeps = with pkgs; {
      general = [
        universal-ctags
        ripgrep
        fd
        stdenv.cc.cc
        nix-doc
        lua-language-server
        nixd
        stylua
        basedpyright
        ruff
      ];
      kickstart-debug = [
        delve
      ];
      kickstart-lint = [
        markdownlint-cli
      ];
      jupyter = [
        imagemagick
      ];
    };

    # This is for plugins that will load at startup without using packadd:
    startupPlugins = with pkgs.vimPlugins; {
      general = [
        vim-sleuth
        lazy-nvim
        comment-nvim
        gitsigns-nvim
        which-key-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        nvim-web-devicons
        plenary-nvim
        nvim-lspconfig
        lazydev-nvim
        fidget-nvim
        conform-nvim
        nvim-cmp
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        tokyonight-nvim
        todo-comments-nvim
        mini-nvim
        lualine-nvim
        lsp-status-nvim
        nvim-treesitter.withAllGrammars
        # This is for if you only want some of the grammars
        # (nvim-treesitter.withPlugins (
        #   plugins: with plugins; [
        #     nix
        #     lua
        #   ]
        # ))
      ];
      ai = [
        copilot-lua
        copilot-lualine
        copilot-cmp
      ];
      jupyter = [
        molten-nvim
        image-nvim
      ];
      kickstart-debug = [
        nvim-dap
        nvim-dap-ui
        nvim-dap-go
        nvim-nio
      ];
      kickstart-indent_line = [
        indent-blankline-nvim
      ];
      kickstart-lint = [
        nvim-lint
      ];
      kickstart-autopairs = [
        nvim-autopairs
      ];
      kickstart-neo-tree = [
        neo-tree-nvim
        nui-nvim
        # nixCats will filter out duplicate packages
        # so you can put dependencies with stuff even if they're
        # also somewhere else
        nvim-web-devicons
        plenary-nvim
      ];
    };


    # shared libraries to be added to LD_LIBRARY_PATH
    # variable available to nvim runtime
    sharedLibraries = {
      general = with pkgs; [
        # libgit2
      ];
    };

    # environmentVariables:
    # this section is for environmentVariables that should be available
    # at RUN TIME for plugins. Will be available to path within neovim terminal
    environmentVariables = {
      test = {
        CATTESTVAR = "It worked!";
      };
    };

    # If you know what these are, you can provide custom ones by category here.
    # If you dont, check this link out:
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
    extraWrapperArgs = {
      test = [
        '' --set CATTESTVAR2 "It worked again!"''
      ];
    };

    # lists of the functions you would have passed to
    # python.withPackages or lua.withPackages

    # get the path to this python environment
    # in your lua config via
    # vim.g.python3_host_prog
    # or run from nvim terminal via :!<packagename>-python3
    extraPython3Packages = {
      jupyter = ps: with ps; [
        pynvim
        # jupyter-client
        cairosvg
        pnglatex # for image rendering
        plotly # for image rendering
        pyperclip
        ipython
        nbformat
      ];
    };
    # populates $LUA_PATH and $LUA_CPATH
    extraLuaPackages = {
      jupyter = ps: with ps; [
        magick # for image rendering
      ];
    };
  };



  # And then build a package with specific categories from above here:
  # All categories you wish to include must be marked true,
  # but false may be omitted.
  # This entire set is also passed to nixCats for querying within the lua.

  # see :help nixCats.flake.outputs.packageDefinitions
  packageDefinitions = {
    # These are the names of your packages
    # you can include as many as you wish.
    nvim = { pkgs, ... }: {
      # they contain a settings set defined above
      # see :help nixCats.flake.outputs.settings
      settings = {
        wrapRc = true;
        # IMPORTANT:
        # your alias may not conflict with your other packages.
        aliases = [ "nvim-cats" ];
        # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;

        # so that by default nvim uses project lsps
        suffix-path = true;
      };
      # and a set of categories that you want
      # (and other information to pass to lua)
      categories = {
        general = true;
        ai = true;
        jupyter = true;
        gitPlugins = true;
        customPlugins = true;
        test = true;

        kickstart-autopairs = true;
        kickstart-neo-tree = true;
        kickstart-debug = true;
        kickstart-lint = true;
        kickstart-indent_line = true;

        # this kickstart extra didnt require any extra plugins
        # so it doesnt have a category above.
        # but we can still send the info from nix to lua that we want it!
        kickstart-gitsigns = true;

        # we can pass whatever we want actually.
        have_nerd_font = false;

        example = {
          youCan = "add more than just booleans";
          toThisSet = [
            "and the contents of this categories set"
            "will be accessible to your lua with"
            "nixCats('path.to.value')"
            "see :help nixCats"
            "and type :NixCats to see the categories set in nvim"
          ];
        };
      };
    };
    nvim-vscode = { ... }: {
      settings = {
        wrapRc = true;
        aliases = [ "nvim-code" ];
        suffix-path = true;
      };
      categories = {
        general = false;
        ai = false;
        gitPlugins = false;
        customPlugins = false;
        test = true;

        kickstart-autopairs = false;
        kickstart-neo-tree = false;
        kickstart-debug = false;
        kickstart-lint = false;
        kickstart-indent_line = false;

        # this kickstart extra didnt require any extra plugins
        # so it doesnt have a category above.
        # but we can still send the info from nix to lua that we want it!
        kickstart-gitsigns = false;

        # we can pass whatever we want actually.
        have_nerd_font = false;

        example = {
          youCan = "add more than just booleans";
          toThisSet = [
            "and the contents of this categories set"
            "will be accessible to your lua with"
            "nixCats('path.to.value')"
            "see :help nixCats"
            "and type :NixCats to see the categories set in nvim"
          ];
        };
      };
    };
  };
  # In this section, the main thing you will need to do is change the default package name
  # to the name of the packageDefinitions entry you wish to use as the default.
  defaultPackageName = "nvim";
  homeModule = utils.mkHomeModules {
    inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
  };
in
{
  imports = [
    homeModule
  ];
  config = {
    # this value, nixCats is the defaultPackageName you pass to mkNixosModules
    # it will be the namespace for your options.
    nvim = {
      enable = true;
      packageNames = [ "nvim" "nvim-vscode" ];
    };
  };
}
