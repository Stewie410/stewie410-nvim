-- Dockerfile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*-Dockerfile",
    "Dockerfile-*",
  },
  callback = function()
    vim.bo.filetype = "dockerfile"
    -- vim.bo.syntax = "dockerfile"
  end,
  desc = "Detect badly-named Dockerfiles",
})

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
    vim.fn.resolve('~/.docker/*.json'),
    vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/docker/*.json'),
  },
  callback = function()
    vim.opt_local.tabstop = 2
  end
})
