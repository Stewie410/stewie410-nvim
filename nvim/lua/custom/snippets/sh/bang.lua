---@diagnostic disable: undefined-global

local env = "#!/usr/bin/env"

local M = {
  s("#!", {
    t(env .. " "),
    i(1, "bash"),
  }),

  s("#b", {
    t(env .. " bash"),
  }),

  s("#s", {
    t(env .. " sh"),
  }),

  s("#p", {
    t("#!/bin/sh"),
  }),
}

return M
