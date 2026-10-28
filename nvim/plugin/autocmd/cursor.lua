vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	desc = "Restore cursor position",
	group = vim.api.nvim_create_augroup("cursor.pos_restore", { clear = true }),
	callback = function()
		local exclude = {
			"gitcommit",
		}

		local buf = vim.api.nvim_get_current_buf()
		if vim.list_contains(exclude, vim.bo[buf].filetype) then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local len = vim.api.nvim_buf_line_count(buf)

		if mark[1] > 0 and mark[1] <= len then
			local ok, _ = pcall(vim.api.nvim_win_set_cursor, 0, mark)
			if not ok then
				vim.notify("Failed to restore cursor position", vim.log.levels.WARN)
				return
			end
			vim.api.nvim_feedkeys("zvzz", "n", true)
		end
	end,
})
