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
