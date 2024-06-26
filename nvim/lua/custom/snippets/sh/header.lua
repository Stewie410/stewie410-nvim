---@diagnostic disable: undefined-global
return {
  s(
    {
      trig = "bh",
      name = "bash header",
      dscr = "bash header",
    },
    fmt(
      [[
        #!/usr/bin/env bash
        #
        # {desc}
      ]],
      {
        desc = i(1, "Description"),
      }
    )
  ),
  s(
    {
      trig = "sh",
      name = "sh header",
      dscr = "sh header",
    },
    fmt(
      [[
        #!/usr/bin/sh
        #
        # {desc}
      ]],
      {
        desc = i(1, "Description"),
      }
    )
  ),
  s(
    {
      trig = "ph",
      name = "posix header",
      dscr = "posix header",
    },
    fmt(
      [[
        #!/bin/sh
        #
        # {desc}
      ]],
      {
        desc = i(1, "Description"),
      }
    )
  ),
}
