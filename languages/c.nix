{ system, pkgs, ... }:
{
  plugins = {
    lsp.servers.clangd =
      let
        cpkgs =
          # cland-tools version 11
          import
            (builtins.fetchGit {
              name = "old-2019-pkgs";
              url = "https://github.com/NixOS/nixpkgs/";
              ref = "refs/heads/nixpkgs-unstable";
              rev = "5c1ffb7a9fc96f2d64ed3523c2bdd379bdb7b471";
            })
            { inherit system; };

        myPkg = cpkgs.clang-tools;
      in
      {
        enable = true;
        package = myPkg;
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
