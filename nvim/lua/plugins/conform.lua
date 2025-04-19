return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
            timeout_ms = 2000,
          })
        end,
        desc = "[F]or[m]at",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end,
      format_after_save = {
        lsp_format = "fallback",
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    },
    init = function()
      vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.g.disable_autoformat = true
        end
        vim.b.disable_autoformat = true
      end, { desc = "Disable Autoformat-On-Save", bang = true })

      vim.api.nvim_create_user_command("FormatEnable", function(args)
        if args.bang then
          vim.g.disable_autoformat = false
        end
        vim.b.disable_autoformat = false
      end, { desc = "Enable Autoformat-On-Save", bang = true })
    end,
  },
}
