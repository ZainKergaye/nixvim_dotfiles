{ ... }: {
  imports = [
    ./mappings.nix
    ./lsp.nix
    ./ui.nix
    ./dap.nix
    ./greeting.nix
    ./window.nix
    ./cmp.nix
    ./languages
  ];

  viAlias = true;
  vimAlias = true;

  # Performance
  performance = {
    byteCompileLua.enable = true;
    #combinePlugins.enable = true; Image.nvim breaks with this enabled
  };

  globals.mapleader = " ";

  opts = {
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    showbreak = "󰘍 ";
  };

  clipboard.providers.wl-copy.enable = true;

  colorschemes.catppuccin = {
    enable = true;
    #settings.flavour = "mocha";
    settings.flavour = "latte";
  };

  plugins = {
    todo-comments = {
      enable = true;
      settings.keywords = {
        "HELP" = {
          icon = "󰮥 ";
          color = "warning";
          alt = [
            "FUCK"
            "AAAA"
            "REEE"
          ];
        };
        "LABEL" = {
          icon = "󰌕 ";
          color = "info";
          alt = [ "FILL IN" ];
        };
        "DEPRICATED" = {
          icon = "󰁨 ";
          color = "warning";
          alt = [
            "DEP"
            "UNEEDED"
          ];
        };
        "DEBUG" = {
          icon = " ";
          color = "#FF5747";
          alt = [
            "TESTING"
            "REMOVELATER"
            "REMOVE"
          ];
        };
      };
      settings.highlight.multiline = true;
    };

    fugitive.enable = true;
    neogen.enable = true;
  };
}
