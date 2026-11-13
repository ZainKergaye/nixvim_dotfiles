{ pkgs, ... }:
{
  plugins = {
    # Ruby LSP automatically discovers Rails when the project includes
    # `ruby-lsp-rails` in its development dependencies.
    lsp.servers.ruby_lsp = {
      enable = true;

      # Prefer a `ruby-lsp` on PATH over the Nix-provided fallback. The Nix
      # build is tied to Nix's Ruby, so Bundler rejects projects that pin a
      # different version. Install it under the project's Ruby instead:
      #   gem install ruby-lsp && mise reshim
      packageFallback = true;
    };

    # Runs tests with `bundle exec ruby -Itest`, under the project's Ruby.
    neotest = {
      enable = true;
      adapters.minitest.enable = true;
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<Leader>T";
        desc = "Test options";
      }
      {
        __unkeyed-1 = "<Leader>R";
        desc = "Rails options";
      }
    ];
  };

  extraPlugins = with pkgs.vimPlugins; [
    # DAP adapter for the `debug` gem (rdbg).
    nvim-dap-ruby
    # :A / :R alternate and related files, :Emodel, :Econtroller, gf on constants.
    vim-rails
  ];

  extraConfigLua = ''
    require("dap-ruby").setup()
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>Tn";
      action = "<cmd>lua require('neotest').run.run()<cr>";
      options = {
        silent = true;
        desc = "Run Nearest Test";
      };
    }
    {
      mode = "n";
      key = "<leader>Tf";
      action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>";
      options = {
        silent = true;
        desc = "Run Test File";
      };
    }
    {
      mode = "n";
      key = "<leader>Tl";
      action = "<cmd>lua require('neotest').run.run_last()<cr>";
      options = {
        silent = true;
        desc = "Run Last Test";
      };
    }
    {
      mode = "n";
      key = "<leader>TS";
      action = "<cmd>lua require('neotest').run.stop()<cr>";
      options = {
        silent = true;
        desc = "Stop Tests";
      };
    }
    {
      mode = "n";
      key = "<leader>Ts";
      action = "<cmd>lua require('neotest').summary.toggle()<cr>";
      options = {
        silent = true;
        desc = "Toggle Test Summary";
      };
    }
    {
      mode = "n";
      key = "<leader>To";
      action = "<cmd>lua require('neotest').output.open({ enter = true })<cr>";
      options = {
        silent = true;
        desc = "Test Output";
      };
    }
    {
      mode = "n";
      key = "<leader>Ra";
      action = "<cmd>A<cr>";
      options = {
        silent = true;
        desc = "Rails Alternate File";
      };
    }
    {
      mode = "n";
      key = "<leader>Rr";
      action = "<cmd>R<cr>";
      options = {
        silent = true;
        desc = "Rails Related File";
      };
    }
  ];
}
