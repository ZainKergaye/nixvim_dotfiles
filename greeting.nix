{ ... }:
{
  plugins = {
    alpha = {
      enable = true;
      settings.layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            # NOTE: If this gets too crings, make it a ascii moon
            "                                   "
            "                                   "
            "                                   "
            "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
            "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
            "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
            "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
            "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
            "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
            "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
            " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
            " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
            "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
            "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
            "                                   "
          ];
        }
        {
          type = "padding";
          val = 5;
        }
        {
          type = "group";
          val = [
            {
              on_press = {
                __raw = "function() vim.cmd[[colorscheme catppuccin-latte]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = "󰔎 Lightmode";
            }
            {
              type = "padding";
              val = 1;
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[enew]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = "  New file";
            }
            {
              type = "padding";
              val = 1;
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[NvimTreeToggle]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = " Open Tree";
            }
            {
              type = "padding";
              val = 1;
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[Telescope find_files]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = " Find File";
            }
            {
              type = "padding";
              val = 1;
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[Telescope oldfiles]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = "  Recent File";
            }
            {
              type = "padding";
              val = 1;
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[qa]] end";
              };
              opts = {
                shortcut = "";
                position = "center";
              };
              type = "button";
              val = "󰈆 Quit";
            }
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "Inspiring quote here.";
        }
      ];
    };
    illuminate.settings.filetypes_denylist = [ "alpha" ];
    lualine.settings.options.disabled_filetypes = {
      statusline = [ "alpha" ];
      winbar = [ "alpha" ];
    };
  };
}
