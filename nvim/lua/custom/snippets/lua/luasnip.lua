---@diagnostic disable: undefined-global

local M = {
  s(
    "snipf",
    fmt(
      [[
        ---@diagnostic disable: undefined-global

        local M = {
          <>
        }

        return M
      ]],
      { i(1, "snippets...") },
      { delimiters = "<>" }
    )
  ),

  s(
    "snip",
    fmt(
      [[
        s("<>", {
          <>
        }),
      ]],
      { i(1, "trigger"), i(2, "-- nodes...") },
      { delimiters = "<>" }
    )
  ),
}

return M
