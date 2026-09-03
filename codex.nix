{ pkgs, ... }: {
  plugins.codex.enable = true;

  keymaps = [
    {
      key = "<Leader>rc";
      action = ":CodexToggle<CR>";
      mode = "n";
      options.desc = "Codex toggle";
    }
  ];

  extraPackages = with pkgs; [
    codex
  ];
}
