-- install/setup servers
require("custom.lsp.servers").setup()

local disable_semantic_tokens = {
  lua = true,
}

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function(args)
    local tsb = require("telescope.builtin")
    local bufnr = args.buf

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, {
        desc = desc,
        buffer = 0,
      })
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    map("gd", tsb.lsp_definitions, "[G]oto [D]efinition")
    map("gr", tsb.lsp_references, "[G]oto [R]efences")
    map("gI", tsb.lsp_implementations, "[G]oto [I]mplementations")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>D", tsb.lsp_type_definitions, "Goto Type [D]finitions")
    map("<leader>ds", tsb.lsp_document_symbols, "Goto [D]ocument [S]ymbols")
    map("<leader>ws", tsb.lsp_workspace_symbols, "Goto [W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    -- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>ca", function()
      require("tiny-code-action").code_action({})
    end, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Autoformat setup
require("custom.lsp.conform").setup()
