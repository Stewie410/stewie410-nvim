local M = {}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
    },
  })

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function(args)
      require("conform").format({
        bufnr = args.buf,
        lsp_fallback = true,
        quiet = true,
      })
    end,
    desc = "Autoformat",
  })
end

return M
