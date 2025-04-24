local M = {}

---@alias util.template.Type { [string]: string[] }

local Snacks = require("snacks")

local xdg = os.getenv("XDG_CONFIG_HOME") or "~/.config"
local search_paths = {
  vim.fn.stdpath("config") .. "/snippets/boilerplate",
  vim.fn.stdpath("config") .. "/boilerplate",
  vim.fn.stdpath("data") .. "/snippets/boilerplate",
  vim.fn.stdpath("data") .. "/boilerplate",
  xdg .. "/snippets/boilerplate",
  xdg .. "/boilerplate",
}

local has_snacks = function()
  local ok, _ = pcall(require, "snacks")
  return ok
end

M._cache = M._cache or {}
M._is_debug = M._is_debug or false

---Determine if current buffer is "empty"
---@param bufnr integer buffer
---@return boolean
function M.buf_is_empty(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return vim.iter(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)):all(function(line)
    return #line == 0 or string.find(line, "[^%s]") == nil
  end)
end

---Write template content(s) to buffer
---@param item snacks.picker.Item
function M.insert(item)
  if M._is_debug then
    vim.notify(("item: %s\npreview: %s"):format(item.text, item.preview.text), vim.log.levels.DEBUG, {
      title = "util.template.insert()",
      timeout = 5000,
    })
  end
  vim.cmd("0r " .. item.text)
end

---Scan search paths for any tempalte files
---@param paths? string[] top-level paths to search
function M.scan(paths)
  local glob = require("glob")

  M._cache = vim.iter(paths or search_paths)
      :map(vim.fs.normalize)
      :filter(vim.uv.fs_stat)
      :fold({}, function(acc, root)
        for file in glob.iter(root .. "/*") do
          table.insert(acc.all, file)
        end

        for dir in glob.iter(root .. "/*/") do
          local name = vim.fs.basename(vim.fs.normalize(dir))
          acc[name] = acc[name] or {}
          for file in glob.iter(dir .. "/**/*") do
            table.insert(acc[name], file)
          end
        end

        return acc
      end)

  vim.notify("Updated Cache", vim.log.levels.INFO, {
    title = "util.boiler.scan",
    timeout = 2000,
  })
  if M._is_debug then
    vim.notify(vim.inspect(M._cache), vim.log.levels.DEBUG, {
      title = "util.boiler.scan",
      timeout = 5000,
    })
  end
end

local function get_items(filter)
  if vim.tbl_isempty(M._cache) then
    M.scan()
  end

  return vim.iter(pairs(M._cache))
      :filter(function(ft, _)
        return (not filter) or ft == vim.bo.filetype or ft == "all"
      end)
      :fold({}, function(acc, ft, files)
        local name = ft == "all" and "text" or ft
        for _, f in ipairs(files) do
          table.insert(acc, {
            text = string.gsub(f, vim.env.HOME, "~"),
            preview = {
              text = vim.iter(io.lines(f)):join("\n"),
              ft = name,
              loc = false,
            },
          })
        end
        return acc
      end)
end

---Pick boilerplate file
---@param items snacks.picker.Item[]
local function _picker(items)
  if M._is_debug then
    vim.notify(vim.inspect(M._cache), vim.log.levels.DEBUG, {
      title = "util.boiler._picker",
      timeout = 5000,
    })
  end

  if vim.tbl_isempty(items) or vim.tbl_count(items) == 0 then
    vim.notify("No items for: " .. vim.bo.filetype, vim.log.levels.WARN, {
      title = "util.boiler._picker",
      timeout = 3000,
    })
  elseif vim.tbl_count(items) == 1 then
    M.insert(items[1].text)
    return
  end

  if has_snacks() then
    Snacks.picker.pick({
      source = "util.boiler._picker",
      items = items,
      preview = "preview",
      format = "text",
      confirm = function(picker, item)
        picker:close()
        M.insert(item)
      end,
    })
  else
    local basic = vim.iter(items)
        :map(function(i) return i.text end)
        :totable()
    vim.ui.select(basic, {
      prompt = "Select Template:",
      kind = "util.boiler._picker",
    }, function(_, idx)
      M.insert(items[idx])
    end)
  end
end

---Pick boilerplate by buffer filetype
function M.pick_ft()
  _picker(get_items(true))
end

---Pick boilerplate from all options
function M.pick_all()
  _picker(get_items(false))
end

return M
