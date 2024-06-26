---@diagnostic disable: undefined-global

local function req_opts()
  return {
    t(""),
    t("-RunAsAdministrator"),
    fmt("-Version {}", i(1, "5.1")),
    fmt("-Edition {}", i(1, "Desktop")),
    fmt("-Modules @({})", i(1, "modules")),
  }
end

return {
  -- require admin
  s({
    trig = "#admin",
    name = "require admin",
    dscr = "require administrator shell",
  }, t("#Requires -RunAsAdministrator")),

  -- require PS version
  s({
    trig = "#version",
    name = "require version",
    dscr = "require ps version",
  }, fmt("#Requires -Version {}", i(1, "5.1"))),

  -- require PS edition
  s({
    trig = "#edition",
    name = "require edition",
    dscr = "require ps edition",
  }, fmt("#Requires -Edition {}", i(1, "Desktop"))),

  -- require module(s)
  s({
    trig = "#modules",
    name = "require module(s)",
    dscr = "require module(s)",
  }, fmt("#Requires -Modules @({})", i(1, "modules"))),

  -- require any
  s(
    {
      trig = "#requires",
      name = "require <any>",
      dscr = "require <any>",
    },
    fmt("#Requires {} {} {} {}", {
      c(1, req_opts()),
      c(2, req_opts()),
      c(3, req_opts()),
      c(4, req_opts()),
    })
  ),
}
