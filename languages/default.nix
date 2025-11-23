{ system, ... }:
{
  imports =
    let
      darwin-undefined =
        if (system == "x64_86-linux") then
          [
            ./verilog.nix
            ./csharp.nix
            ./kotlin.nix
          ]
        else
          [ ];
    in
    [
      ./c.nix
      ./lua.nix
      ./markdown.nix
      ./nix.nix
      ./arduino.nix
    ]
    ++ darwin-undefined;
}
