{ ... }: {
  plugins = {
    treesitter = {
      enable = true;
      settings.indent.enable = true;
    };

    gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "│";
        change.text = "│";
        delete.text = "│";
        topdelete.text = "󰍵";
        changedelete.text = "~";
        untracked.text = "│";
      };
    };

    nvim-autopairs.enable = true;

    navic.enable = false; # Not setup

    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          show_end = false;
          show_exact_scope = true;
          show_start = false;
        };
      };
    };

    telescope.enable = true;

    notify = {
      enable = true;
      settings.render = "minimal";
    };

    colorizer = {
      enable = true;
      settings.user_default_options.names = false;
      settings.filetypes = [
        "css"
        "scss"
      ];
    };

    illuminate = {
      enable = true; # Used to illuminate same words
      filetypesDenylist = [
        "adoc"
        "asciidoc"
        "dirvish"
        "fugitive"
        "nvimtree"
        "nvim-tree"
        "NvimTree"
      ];
    };

    noice.enable = true;

    web-devicons.enable = true;
  };
}
