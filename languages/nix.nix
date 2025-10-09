{ ... }: {
  plugins = {
    none-ls.sources.formatting = {
      nixpkgs_fmt.enable = true;
    };
    lsp.servers.nil_ls.enable = true;
  };
}
