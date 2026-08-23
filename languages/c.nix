{
  system,
  pkgs,
  lib,
  ...
}:
{
  plugins = {
    lsp.servers.clangd = {
      enable = true;
      package = pkgs.clang-tools;
      cmd = [
        "clangd"
        "--background-index"
        "--clang-tidy"
        "--header-insertion=never"
        "--query-driver=${pkgs.gcc-arm-embedded}/bin/arm-none-eabi-*"
      ];
    };

    none-ls.sources.formatting.clang_format.enable = true;

    dap-lldb = {
      enable = true;
      settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
    };

    dap.adapters = {
      executables.gdb = {
        command = "${lib.getExe' pkgs.gdb "gdb"}";
        args = [
          "--interpreter=dap"
          "--eval-command"
          "set pretty print on"
        ];
      };
    };
  };
  extraPackages = with pkgs; [
    gcc-arm-embedded
  ];
}
