{ ... }:
{
  # combinePlugins (nixvim.nix) hides friendly-snippets' files from luasnip.
  performance.combinePlugins.standalonePlugins = [ "friendly-snippets" ];

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

    neotest = {
      enable = true;
      # Call jest directly: `npm test` in some projects also runs e2e suites.
      adapters.jest = {
        enable = true;
        settings.jestCommand = "npx jest";
      };
    };

    # prettierd uses the project's local prettier + prettier-plugin-tailwindcss.
    none-ls.sources.formatting.prettierd = {
      enable = true;
      # Prettier owns formatting; keep tsserver from racing it on save.
      disableTsServerFormatter = true;
    };

    # Auto-close and auto-rename JSX tags.
    ts-autotag.enable = true;
    # `gc` writes {/* */} inside JSX instead of //.
    ts-comments.enable = true;

    # React snippets (rfc, useState, ...) from friendly-snippets.
    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [
        {
          include = [
            "javascript"
            "typescript"
            "javascriptreact"
            "typescriptreact"
          ];
        }
      ];
    };
  };
}
