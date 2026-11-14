{ pkgs, ... }:
{
  # Verible's LSP supplies linting, navigation, and formatting. The existing
  # lsp-format integration handles format-on-save and the format toggle.
  plugins.lsp.servers.verible = {
    enable = true;
    filetypes = [ "systemverilog" ];
    cmd = [
      "${pkgs.verible}/bin/verible-verilog-ls"
      "--rules_config_search"
    ];
  };
}
