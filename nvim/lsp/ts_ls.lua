local cmd = "typscript-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  init_options = { hostInfo = "neovim" },
  cmd = { cmd, "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = function(bufnr, on_dir)
    local project_path = vim.fs.root(bufnr, {
      "package-lock.json",
      "yarn.lock",
      "pnpm-lock.yaml",
      "bun.lockb",
      "bun.lock",
      {
        ".git",
        ".svn",
      },
    })

    --exclude deno
    local deno_path = vim.fs.root(bufnr, {
      "deno.json",
      "deno.jsonc",
      "deno.lock",
    })
    if deno_path and (not project_path or #deno_path >= #project_path) then
      return
    end

    on_dir(project_path or vim.fn.getcwd())
  end,
  handlers = {
    ["_typescript.rename"] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          ["start"] = result.position,
          ["end"] = result.position,
        },
      }, client.offset_encoding)

      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
  commands = {
    ["editor.action.showReferences"] = function(command, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      local file_uri, position, references = unpack(command.arguments)

      vim.fn.setqflist({}, " ", {
        title = command.title,
        items = vim.lsp.util.locations_to_items(references --[[@as any]], client.offset_encoding),
        context = {
          command = command,
          bufnr = ctx.bufnr,
        },
      })

      vim.lsp.util.show_document({
        uri = file_uri --[[@as string]],
        range = {
          ["start"] = position --[[@as lsp.Position]],
          ["end"] = position --[[@as lsp.Position]],
        },
      }, client.offset_encoding)
      ---@diagnostic enable: assign-type-mismatch

      vim.cmd("botright copen")
    end,
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
          diagnostics = {},
        },
      })
    end, {
      desc = "Source.* Code Action"
    })

    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptGoToSourceDefinition", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)

      local lsp_cmd = {
        command = "_typescript.goToSourceDefinition",
        title = "Goto source definition",
        arguments = {
          params.textDocument.uri,
          params.position,
        },
      }

      client:exec_cmd(lsp_cmd, { bufnr = bufnr }, function(err, result)
        if err then
          vim.notify("Goto source definition failed: " .. err.message, vim.log.levels.ERROR)
          return
        end
        if not result or vim.tbl_isempty(result) then
          vim.notify("No source definition found", vim.log.levels.INFO)
          return
        end
        vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
      end)
    end, {
      desc = "Go to source definition",
    })
  end,
}
