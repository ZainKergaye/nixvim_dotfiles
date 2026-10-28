{ ... }:
{
  # Ruby LSP automatically discovers Rails when the project includes
  # `ruby-lsp-rails` in its development dependencies.
  plugins.lsp.servers.ruby_lsp = {
    enable = true;

    # Prefer the version installed by Bundler in a Rails project over the
    # Nix-provided fallback, so it can use the application's Rails version.
    packageFallback = true;
  };
}
