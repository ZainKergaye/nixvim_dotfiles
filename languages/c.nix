{ system, pkgs, ... }:
{
  plugins = {
    lsp.servers.clangd =
      let
        cpkgs =
          # cland-tools version 11
          import (builtins.fetchGit {
            name = "old-2019-pkgs";
            url = "https://github.com/NixOS/nixpkgs/";
            ref = "refs/heads/nixpkgs-unstable";
            rev = "5c1ffb7a9fc96f2d64ed3523c2bdd379bdb7b471";
          }) { inherit system; };

        myPkg = pkgs.clang-tools;
      in
      {
        enable = true;
        package = myPkg;
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
  extraPackages = with pkgs; [
    gcc-arm-embedded
  ];
}
