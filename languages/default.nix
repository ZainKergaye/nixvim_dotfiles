{ lib, system, ... }:
{
  imports =
    let
      darwin-undefined =
        if lib.hasSuffix "-linux" system then
          [
            #./csharp.nix
            #./kotlin.nix
          ]
        else
          [ ];
      # Keep Verible on platforms with dependency hashes in the pinned package.
      verible-supported = lib.optionals (builtins.elem system [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ]) [ ./systemverilog-verible.nix ];
    in
    [
      ./c.nix
      ./lua.nix
      ./markdown.nix
      ./nix.nix
      ./ruby.nix
      ./typescript.nix
      ./scss.nix
      ./systemverilog.nix
      # ./latex.nix
      ./cmake.nix
      #./arduino.nix
    ]
    ++ darwin-undefined
    ++ verible-supported;
}
