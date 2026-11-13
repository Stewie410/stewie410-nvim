local ag = vim.api.nvim_create_augroup("lsp.codelens", { clear = true })

_G.CodeLensFix = _G.CodeLensFix or {}

---@param bufnr integer
---@param lens lsp.CodeLens
local function fix_lens_indent(bufnr, lens)
	local s = lens.range.start
	local line = vim.api.nvim_buf_get_lines(bufnr, s.line, s.line + 1, false)[1]
	local indent = line and line:match("^%s*") or ""
	if indent:find("\t", 1, true) and s.character >= #indent then
		local width = vim.api.nvim_buf_call(bufnr, function()
			return vim.fn.strdisplaywidth(indent)
		end)
		s.character = s.character - #indent + width
	end
end

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Fix codelens padding on tab-indented lines",
	group = ag,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client or _G.CodeLensFix[ev.data.client_id] then
			return
		end
		_G.CodeLensFix[ev.data.client_id] = true

		local request = client.request
		client.request = function(self, method, params, handler, bufnr)
			local og_handler = handler
			if handler and method == "textDocument/codeLens" then
				handler = function(err, result, ctx)
					for _, lens in ipairs(result or {}) do
						fix_lens_indent(ctx.bufnr, lens)
					end
					return og_handler(err, result, ctx)
				end
			elseif handler and method == "codeLens/resolve" then
				handler = function(err, result, ctx)
					if result then
						result.range = params.range
					end
					return og_handler(err, result, ctx)
				end
			end
			return request(self, method, params, handler, bufnr)
		end
	end,
})
