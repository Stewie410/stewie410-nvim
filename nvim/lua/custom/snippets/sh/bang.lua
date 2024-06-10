---@diagnostic disable: undefined-global
return {
    s({
        trig = "!b",
        name = "env bash",
        dscr = "#!/usr/bin/env bash",
    }, t("#!/usr/bin/env bash")),
    s({
        trig = "!s",
        name = "env sh",
        dscr = "#!/usr/bin/env sh",
    }, t("#!/usr/bin/env sh")),
    s({
        trig = "!p",
        name = "portable shebang",
        dscr = "#!/bin/sh",
    }, t("#!/bin/sh")),
}
