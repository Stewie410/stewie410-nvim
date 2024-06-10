---@diagnostic disable: undefined-global
return {
    -- basic
    s(
        {
            trig = "bh",
            name = "basic header",
            dscr = "basic header comment",
        },
        fmt(
            [[
                <#
                .SYNOPSIS
                {syn}

                .DESCRIPTION
                {desc}
                #>
            ]],
            {
                syn = i(1, "synopsis"),
                desc = i(2, "description"),
            }
        )
    ),

    -- basic w/ params
    s(
        {
            trig = "bph",
            name = "basic param header",
            dscr = "basic param header comment",
        },
        fmt(
            [[
                <#
                .SYNOPSIS
                {syn}

                .DESCRIPTION
                {desc}

                .PARAMETER {param}
                {expl}
                #>
            ]],
            {
                syn = i(1, "synopsis"),
                desc = i(2, "description"),
                param = i(3, "ParamName"),
                expl = i(4, "parameter description"),
            }
        )
    ),

    -- full header
    s(
        {
            trig = "fh",
            name = "full header",
            dscr = "full header comment",
        },
        fmt(
            [[
                <#
                .SYNOPSIS
                {syn}

                .DESCRIPTION
                {desc}

                .PARAMETER {param}
                {expl}

                .EXAMPLE
                {example}

                .INPUTS
                {in_type}

                .OUTPUTS
                {out_type}

                .NOTES
                {notes}

                .LINK
                {link}
                #>
            ]],
            {
                syn = i(1, "synopsis"),
                desc = i(2, "description"),
                param = i(3, "ParamName"),
                expl = i(4, "parameter description"),
                example = i(5, "example usage"),
                in_type = i(6, "input types"),
                out_type = i(7, "output types"),
                notes = i(8, "notes"),
                link = i(9, "uri"),
            }
        )
    ),
}
