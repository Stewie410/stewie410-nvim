---@diagnostic disable: undefined-global
return {
    -- snippet definition
    s(
        {
            trig = "s()",
            name = "snippet",
            dscr = "snippet definition",
        },
        fmt(
            [[
                -- {comment}
                s(
                    {{
                        trig = "{trig}",
                        name = "{name}",
                        dscr = "{dscr}",
                    }},
                    {{
                        {nodes}
                    }}
                ),
            ]],
            {
                trig = i(1, "trigger"),
                name = i(2, "name"),
                dscr = i(3, "description"),
                comment = rep(2),
                nodes = i(0),
            }
        )
    ),
    -- snippet file
    s({
        trig = "snipfile",
        name = "snippet file",
        dscr = "snippet file",
    }, {
        t({
            "---@diagnostic disable: undefined-global",
            "return {",
            "\t",
        }),
        i(0),
        t({
            "",
            "}",
        }),
    }),
}
