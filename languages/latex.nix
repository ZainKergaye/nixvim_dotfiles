{ pkgs, ... }:
{
  plugins = {
    texpresso.enable = true;
    vimtex = {
      enable = true;
      settings = {
        compiler_method = "latexmk";
        toc_config = {
          split_pos = "vert topleft";
          split_width = 40;
        };
        view_method = "general";
      };
    };

    cmp.settings.sources = [
      { name = "vimtex"; }
    ];
    cmp-vimtex.enable = true;

  };
  keymaps = [
    {
      key = "<leader>lv";
			action = "<cmd> TeXpresso %<CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "TeXpresso open view";
      };
    }
    {
      key = "<leader>le";
      action = "<cmd> VimtexError <CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "VimTex Error Check";
      };
    }
    {
      key = "<leader>lt";
      action = "<cmd> VimtexToCToggle <CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "VimTex toggle ToC";
      };
    }
    {
      key = "<leader>lc";
      action = "<cmd> VimtexCompile <CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "VimTex compile";
      };
    }
  ];
  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<Leader>l";
      desc = "LaTeX";
    }
  ];

}
