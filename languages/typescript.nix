{ ... }:
{
  plugins = {
    lsp.servers = {
      ts_ls.enable = true;
      eslint.enable = true;
      tailwindcss.enable = true;
      jsonls.enable = true;
      cssls.enable = true;
      yamlls.enable = true;
      dockerls.enable = true;
    };

    # prettierd uses the project's local prettier + prettier-plugin-tailwindcss.
    none-ls.sources.formatting.prettierd = {
      enable = true;
      # Prettier owns formatting; keep tsserver from racing it on save.
      disableTsServerFormatter = true;
    };
  };
}
