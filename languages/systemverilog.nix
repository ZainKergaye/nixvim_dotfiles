{ pkgs, ... }:
{
  filetype.extension = {
    sv = "systemverilog";
    svh = "systemverilog";
  };

  # Syntax, indentation, compiler error formats, and instance/port navigation.
  extraPlugins = [ pkgs.vimPlugins.verilog_systemverilog-vim ];
  extraPackages = [ pkgs.universal-ctags ];

  # Upstream names its runtime files verilog_systemverilog; keep the standard
  # filetype for LSP/Tree-sitter while loading its buffer settings explicitly.
  extraFiles."after/ftplugin/systemverilog.vim".text = ''
    unlet! b:did_ftplugin
    runtime! ftplugin/verilog_systemverilog.vim
  '';
  extraFiles."after/indent/systemverilog.vim".text = ''
    unlet! b:did_indent
    runtime! indent/verilog_systemverilog.vim
  '';

  # Match SystemVerilog block keywords (begin/end, module/endmodule, etc.) with %.
  plugins.vim-matchup.enable = true;

  # The shared Verilog parser also handles SystemVerilog. Use the Vim plugin's
  # indentation rather than running two indentation engines for these buffers.
  plugins.treesitter = {
    languageRegister.verilog = [ "systemverilog" ];
    indent.disable = [ "verilog" ];
  };
}
