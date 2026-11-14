# Nixvim dotfiles

These are my nixvim dotfiles, I daily this everyday. I am still learning and if you find anything
of interest, please feel free to copy and paste.

## Screenshots

![Screenshot](./media/c-dap-preview.png)

![Screenshot](./media/split-screen-preview.png)

![Screenshot](./media/start-screen-preview.png)

## Ruby on Rails

Ruby support uses Ruby LSP and prefers the version installed by Bundler in the
current project. Add the LSP and its Rails extension to each Rails application:

```sh
bundle add ruby-lsp ruby-lsp-rails --group development
```

## SystemVerilog

`.sv` and `.svh` files use the `systemverilog` filetype. The
[Verilog/SystemVerilog Vim plugin](https://github.com/vhda/verilog_systemverilog.vim)
provides syntax, indentation, compiler error formats, and instance/port navigation.
`vim-matchup` adds `%` navigation between matching block keywords.

[Verible](https://github.com/chipsalliance/verible) provides LSP diagnostics,
navigation, and formatting on Linux and Apple Silicon macOS. Use `<leader>fm`
to format or `<leader>tf` to toggle format-on-save. Project-specific lint rules
can go in `.rules.verible_lint`; the default SystemVerilog rules remain enabled.
Supported systems are x86_64 Linux, aarch64 Linux, and Apple Silicon macOS.
Platform-specific tooling imports are selected in `languages/default.nix`.

For tags-based completion and `:VerilogFollowInstance` / `:VerilogFollowPort`,
generate project tags with the bundled Universal Ctags:

```sh
ctags -R --extras=+q --fields=+i -n .
```

## Debugging an ARM board with OpenOCD

The `Debug ARM C` DAP profile connects Nixpkgs GDB (which includes GDB's DAP
interpreter and ARM support) to OpenOCD's GDB server at `localhost:3333`.

Start OpenOCD in a terminal with the interface and target configuration for
your probe and board, for example:

```sh
openocd -f interface/<probe>.cfg -f target/<mcu>.cfg
```

Build the firmware with debug information, open a C source file in Nixvim, set
a breakpoint with `<leader>db`, then use `<leader>dc`. Select `Debug ARM C`
and enter the path to the unstripped ELF file when prompted. The first time you
flash a program, open the DAP REPL (`<leader>de`) and run:

```gdb
monitor reset halt
load
```

Then use `<leader>dc` to continue through DAP; do not issue `continue` from
the REPL. Do not reset a second time after `load`: GDB DAP can lose its current
frame when OpenOCD reports that reset event. `monitor reset halt` must be used
before `load` so OpenOCD can write the target's flash safely.
