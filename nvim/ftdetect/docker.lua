-- compose.yml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
  },
  callback = function()
    vim.opt_local.filetype = "yaml.docker-compose"
    vim.opt_local.syntax = "yaml"
  end,
  desc = "Docker-Compose Support",
})

-- ~/.docker/*.json configs
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    os.getenv('HOME') .. "/.docker/*.json",
  },
  callback = function()
    local ts = 2
    vim.opt_local.tabstop = ts
    vim.opt_local.softtabstop = ts
    vim.opt_local.shiftwidth = ts
    vim.opt_local.expandtab = false
  end
})
