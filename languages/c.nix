{ pkgs, ... }: {
  plugins = {
    lsp.servers.clangd = {
      enable = true;
    };
    none-ls.sources.formatting.clang_format.enable = true;

    dap-lldb = {
      enable = true;
      #settings.codelldb_path = "${lib.getExe' pkgs.lldb_21 "lldb-server"}";
      settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
    };

    # dap.adapters = {
    #   executables.gdb = {
    #     command = "${lib.getExe' pkgs.gdb "gdb"}";
    #     args = [
    #       "--interpreter=dap"
    #       "--eval-command"
    #       "set pretty print on"
    #     ];
    #   };
    # };
  };
}
