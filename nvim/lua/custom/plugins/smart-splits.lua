return {
  {
    "mrjones2014/smart-splits.nvim",
    event = { "VimEnter" },
    dependencies = {
      "kwkarlwang/bufresize.nvim",
    },
    config = function()
      local br = require("bufresize")
      local ss = require("smart-splits")

      br.setup()

      ss.setup({
        resize_mode = {
          hooks = {
            on_leave = br.register,
          },
        },
      })

      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = desc })
      end

      -- Resizing
      map("<A-h>", ss.resize_left, "Resize Left")
      map("<A-j>", ss.resize_down, "Resize Down")
      map("<A-k>", ss.resize_up, "Resize Up")
      map("<A-l>", ss.resize_right, "Resize Right")

      -- Navigation
      map("<C-h>", ss.move_cursor_left, "Navigate Left")
      map("<C-j>", ss.move_cursor_down, "Navigate Down")
      map("<C-k>", ss.move_cursor_up, "Navigate Up")
      map("<C-l>", ss.move_cursor_right, "Navigate Right")

      -- Swap buffers between windows
      map("<leader><leader>h", ss.swap_buf_left, "Swap Buffer Left")
      map("<leader><leader>j", ss.swap_buf_down, "Swap Buffer Down")
      map("<leader><leader>k", ss.swap_buf_up, "Swap Buffer Up")
      map("<leader><leader>l", ss.swap_buf_right, "Swap Buffer Right")
    end,
  },
}
