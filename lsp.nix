{ ... }:
{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        cssls.enable = true;
        html.enable = true;
        bashls.enable = true;
      };
    };

    noice.settings.presets."inc_rename" = true;
    inc-rename.enable = true; # Nice renaming UI
  };

  # Ability to toggle cmp
  extraConfigLua = ''
       local format_enabled = true
       vim.api.nvim_create_user_command(
           "ToggleFormatNotified",
           function()
               if format_enabled then
                   vim.cmd("FormatDisable")
                   require("notify")("Disabled formatting")
                   format_enabled = false
               else
                   vim.cmd("FormatEnable")
                   require("notify")("Enabled formatting")
                   format_enabled = true
               end
           end,
           {}
       )

      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = "󱧤 ",
        Info  = " ",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

       vim.diagnostic.config(
           {
               virtual_text = false,
               float = {border = "rounded"}
           }
       )

       vim.o.updatetime = 500
       -- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])


    local diagnostic_float_win = nil
    local diagnostic_float_enabled = true

    -- Open diagnostic float on CursorHold
    vim.api.nvim_create_autocmd("CursorHold", { callback = function() if diagnostic_float_enabled and (diagnostic_float_win == nil or not vim.api.nvim_win_is_valid(diagnostic_float_win)) then _, diagnostic_float_win = vim.diagnostic.open_float(nil, {focus = false}) end end, })

    vim.api.nvim_create_user_command(
        "ToggleDiagnosticFloatNotified",
        function()
            diagnostic_float_enabled = not diagnostic_float_enabled
            if not diagnostic_float_enabled and diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
                vim.api.nvim_win_close(diagnostic_float_win, true)
                diagnostic_float_win = nil
            end
            require("notify")((diagnostic_float_enabled and "Enabled" or "Disabled") .. " diagnostic popup")
        end,
        {}
    )

    -- Close diagnostic float on any window/buffer leave or cursor move vim.api.nvim_create_autocmd({ "CursorMoved", "WinLeave", "BufWinLeave", "BufLeave", "FocusLost" }, { callback = function() if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then vim.api.nvim_win_close(diagnostic_float_win, true) diagnostic_float_win = nil end end, })

       vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335 guifg=#abb2bf]])
  '';
  keymaps = [
    {
      key = "<leader>fm";
      action = "<cmd> Format <CR>";
      mode = "n";
      options = {
        silent = true;
        desc = "Format Files";
      };
    }

    {
      key = "<leader>tf";
      action = "<cmd> ToggleFormatNotified <CR>";
      mode = "n";
      options.desc = "Format Toggle";
    }

    {
      key = "<leader>tl";
      action = "<cmd> ToggleDiagnosticFloatNotified <CR>";
      mode = "n";
      options.desc = "Diagnostic Popup Toggle";
    }

    {
      key = "<Leader>ra";
      action = "<cmd> IncRename <CR>";
      mode = "n";
      options.desc = "LSP Rename";
    }
  ];
}
