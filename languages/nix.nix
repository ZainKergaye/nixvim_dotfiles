{ ... }: {
  plugins = {
    none-ls.sources.formatting = {
      alejandra.enable = true;
    };
    lsp.servers.nil_ls.enable = true;
  };
}
