local map = vim.keymap.set

-- buffer
map("n", "[b", vim.cmd.bprevious, { desc = "Previous [B]uffer" })
map("n", "]b", vim.cmd.bnext, { desc = "Next [B]uffer" })

-- diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
map(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Show [E]rror List " }
)
map(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Show [Q]uickfix List" }
)

-- increment/decrement
map({ "n", "v" }, "+", "<C-a>", { desc = "Increment" })
map({ "n", "v" }, "-", "<C-d>", { desc = "Decrement" })

-- splits
map("n", "<C-=>", "<C-w>=", { desc = "Equalize split sizes" })

-- toggle hlsearch
map("n", "<CR>", function()
  if vim.o.hlsearch then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true, desc = "Toggle hlsearch if set, else <CR>" })

-- templates (legacy)
map("n", "<leader>lt", function()
  local root = "$XDG_CONFIG_HOME"
  if vim.fn.expand(root) == root then
    if vim.uv.os_uname().sysname == "Windows_NT" then
      root = "$LOCALAPPDATA"
    else
      root = "~/.config"
    end
  end
  root = vim.fn.expand(root .. "/templates/")

  local ft = vim.bo.filetype
  local ext = vim.fn.expand("%"):match(".+%.(.+)")

  local t = vim.uv.fs_stat(root .. ext) and ext
    or vim.uv.fs_stat(root .. ft) and ft
    or nil

  if t == nil then
    vim.notify(
      "No template available for " .. ext .. "/" .. ft,
      vim.log.levels.WARN
    )
    return
  end

  vim.cmd("0r " .. root .. t)
end, { desc = "[L]oad [T]emplate" })

-- spellcheck
map("n", "<leader>sc", function()
  vim.opt.spell = not vim.o.spell
end, { desc = "Toggle [S]pell [C]heck" })
