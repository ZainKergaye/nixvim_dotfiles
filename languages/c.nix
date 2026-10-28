{
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
        "--compile-commands-dir=result"
      ];
    };

    none-ls.sources.formatting.clang_format.enable = true;

    dap-lldb = {
      enable = true;
      settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
    };

    dap = {
      configurations.c = [
        {
          name = "Debug ARM C";
          type = "gdb";
          # GDB's DAP adapter connects to OpenOCD through its `attach` request.
          # `MIMode`, `miDebugger*`, and `postRemoteConnectCommands` are
          # cpptools settings and are ignored by GDB DAP.
          request = "attach";
          target = "localhost:3333";
          program.__raw = ''
            function()
              local default = vim.g.arm_gdb_last_program or vim.fn.getcwd() .. "/"
              local program = vim.fn.input("Path to executable: ", default, "file")
              if program ~= "" then
                vim.g.arm_gdb_last_program = program
              end
              return program
            end
          '';
        }
      ];

      adapters = {
        executables.gdb = {
          # gcc-arm-embedded's GDB does not include the DAP interpreter.
          # Nixpkgs GDB does and can debug ARM ELF files over OpenOCD.
          command = "${lib.getExe' pkgs.gdb "gdb"}";
          args = [
            "--interpreter=dap"
            "--eval-command"
            "set pretty print on"
            "--eval-command"
            "set pagination off"
          ];
        };
      };
    };
  };
  extraPackages = with pkgs; [
    gcc-arm-embedded
  ];
}
