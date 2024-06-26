---@diagnostic disable: undefined-global
return {
  -- for: a b c
  s(
    {
      trig = "fl",
      name = "for list",
      dscr = "for list",
    },
    fmt(
      [[
        for {iter} in {a} {b}; do
            {oper}
        done
      ]],
      {
        iter = i(1, "i"),
        a = i(2, "a"),
        b = i(3, "b"),
        oper = i(0),
      }
    )
  ),

  -- for: $arr[]
  s(
    {
      trig = "fa",
      name = "for array",
      dscr = "for array",
    },
    fmt(
      [[
        for {iter} in "${{{var}}}"; do
            {oper}
        done
      ]],
      {
        iter = i(1, "i"),
        var = i(2, "variable"),
        oper = i(0),
      }
    )
  ),

  -- for: c-style
  s(
    {
      trig = "fc",
      name = "for c-style",
      dscr = "for c-style",
    },
    fmt(
      [[
        for (( {init}; {cond}; {prog} )); do
            {oper}
        done
      ]],
      {
        init = i(1, "initialize"),
        cond = i(2, "condition"),
        prog = i(3, "progress"),
        oper = i(0),
      }
    )
  ),

  -- infinite loop (while true)
  s(
    {
      trig = "infl",
      name = "infinite loop",
      dscr = "infinite loop",
    },
    fmt(
      [[
        while true; do
            {oper}
        done
      ]],
      {
        oper = i(0),
      }
    )
  ),

  -- while expr
  s(
    {
      trig = "wx",
      name = "while expression",
      dscr = "while expression",
    },
    fmt(
      [[
        while {expr}; do
            {oper}
        done
      ]],
      {
        expr = i(1, "expression"),
        oper = i(0),
      }
    )
  ),

  -- while read file
  s(
    {
      trig = "wrf",
      name = "while read file",
      dscr = "while read file",
    },
    fmt(
      [[
        while read -r {var}; do
            {oper}
        done < "{file}"
      ]],
      {
        var = i(1, "var"),
        oper = i(0),
        file = i(2, "file"),
      }
    )
  ),

  -- while read command
  s(
    {
      trig = "wrc",
      name = "while read command",
      dscr = "while read command",
    },
    fmt(
      [[
        while read -r {var}; do
            {oper}
        done < <({cmd})
      ]],
      {
        var = i(1, "var"),
        oper = i(0),
        cmd = i(2, "command"),
      }
    )
  ),
}
