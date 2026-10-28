{
  pkgs,
  inputs,
  ...
}:
{
  plugins = {
    copilot-lua.enable = true;

    codex = {
      enable = true;
      settings.border = "rounded";
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "codex.nvim";
        version = "unstable";
        src = inputs.codex-nvim;
      };
    };
  };

  keymaps = [
    {
      key = "<Leader>rc";
      action = "<cmd>lua require('codex').setup({ panel = false }); require('codex').toggle()<CR>";
      mode = "n";
      options.desc = "Codex toggle";
    }
    {
      key = "<Leader>rv";
      action = "<cmd>lua require('codex').setup({ panel = true }); require('codex').toggle()<CR>";
      mode = "n";
      options.desc = "Codex toggle right panel";
    }
  ];

  extraPackages = with pkgs; [
    codex
  ];
}
