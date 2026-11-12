---@module "lsp.settings.shell-lsp"

---Only enable codeLens for functions, drop for other items
---@param bufnr integer
---@param lens lsp.CodeLens
---@return boolean
local function func_only_codelens(bufnr, lens)
	local ok, node = pcall(vim.treesitter.get_node, {
		bufnr = bufnr,
		pos = { lens.range.start.line, lens.range.start.character },
		ignore_injections = true,
	})
	if not ok or not node then
		return true
	end

	local parent = node:parent()
	return parent ~= nil and parent:type() == "function_definition"
end

---@type vim.lsp.Config
return {
	on_init = function(client)
		local req = client.request
		client.request = function(self, method, params, handler, bufnr)
			if handler and method == "textDocument/codeLens" then
				local og_handler = handler
				handler = function(err, result, ctx)
					if result then
						result = vim.tbl_filter(function(lens)
							return lens.command ~= nil or func_only_codelens(ctx.bufnr, lens)
						end, result)
					end
					return og_handler(err, result, ctx)
				end
			end

			return req(self, method, params, handler, bufnr)
		end
	end,
	---@type lsp.settings.shell_lsp
	settings = {
		shellLsp = {
			format = {
				binaryNextLine = true,
				spaceRedirects = true,
			},
		},
	}
}
