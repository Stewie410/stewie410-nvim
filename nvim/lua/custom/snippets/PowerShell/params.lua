---@diagnostic disable: undefined-global
return {
  -- basic params
  s({
    trig = "paramf",
    name = "basic params",
    dscr = "basic/function params",
  }, fmt("param({})", i(1))),

  -- cmdlet params
  s(
    {
      trig = "paramc",
      name = "cmdlet params",
      dscr = "basic cmdlet params",
    },
    fmt(
      [[
        [CmdletBinding({options})]
        param(
            {list}
        )
      ]],
      {
        options = i(1, "options"),
        list = i(0),
      }
    )
  ),
}
