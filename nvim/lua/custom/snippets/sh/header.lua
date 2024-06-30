---@diagnostic disable: undefined-global

local M = {
  s("hb", {
    t({
      "#!/usr/bin/env bash",
      "#",
      "# ",
    }),
    i(1, "description"),
  }),

  s("hs", {
    t({
      "#!/usr/bin/env sh",
      "#",
      "# ",
    }),
    i(1, "description"),
  }),

  s("hp", {
    t({
      "#!/bin/sh",
      "#",
      "# ",
    }),
    i(1, "description"),
  }),
}

return M
