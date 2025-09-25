{
  plugins = {
    lualine = {
      enable = true;
      settings = {
        options.theme = "auto";
        extensions = [
          "nvim-dap-ui"
          "nvim-tree"
          "toggleterm"
        ];
      };
    };

    which-key = {
      enable = true;
    };

    bufferline = {
      enable = true;

      settings.options = {
        buffer_close_icon = null;
        close_icon = null;
        always_show_bufferline = false;
        separator_style = "slant";
        diagnostics = "nvim_lsp";
        offsets = [
          { filetype = "NvimTree"; }
          { text = "File Explorer"; }
          { highlight = "Directory"; }
          { separator = true; }
        ];
      };
    };

    toggleterm = {
      enable = true;
      settings.float_opts.border = "curved";
    };

    nvim-tree = {
      enable = true;
      settings = {
        git = {
          enable = true;
          ignore = false;
        };
        renderer = {
          # TODO: Fix this
          highlight_git = true;
          root_folder_label = false;
          indent_markers = {
            enable = true;
            icons = {
              bottom = "─";
              edge = "│";
              corner = "╰";
            };
          };
          icons = {
            glyphs = {
              default = "󰈚 ";
              folder = {
                default = " ";
                empty = " ";
                empty_open = " ";
                open = " ";
                symlink = " ";
              };
              git = {
                unmerged = "";
              };
            };
          };
        };
        view.side = "right";
        hijack_cursor = true;
      };
    };
    bufdelete.enable = true; # Replacement for bdelete that keeps windows intact
  };

  keymaps = [
    {
      key = "<leader>x";
      action = ":Bdelete <CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
  ];
}
