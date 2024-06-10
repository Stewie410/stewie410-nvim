---@diagnostic disable: undefined-global
return {
    -- cleanup()
    s({
        trig = "cleanup",
        name = "cleanup()",
        dscr = "cleanup function",
    }, t({ "cleanup() {", "\tunset log", "}" })),

    -- log()
    s(
        {
            trig = "logf",
            name = "log()",
            dscr = "log function",
        },
        t({
            "log() {",
            '\tprintf \'%s|%s|%s\\n\' "$(date --iso-8601=\'sec\')" "${FUNCNAME[1]}" "${1}" | \\',
            '\t\ttee --append "${log:-/dev/null}" | \\',
            '\t\tcut --fields="2-" --delimiter="|"',
            "}",
        })
    ),

    -- show_help()
    s(
        {
            trig = "help",
            name = "show_help()",
            dscr = "help function",
        },
        fmt(
            [[
                show_help() {{
                    cat << EOF
                {desc}

                USAGE: ${{0##*/}} [OPTIONS]

                OPTIONS:
                    -h, --help          Show this help message
                    {last}
                EOF
                }}
            ]],
            {
                desc = i(1, "Description"),
                last = i(0),
            }
        )
    ),

    -- require()
    s(
        {
            trig = "require",
            name = "require()",
            dscr = "require function",
        },
        t({
            "require() {",
            '\tcommand -v "${1}" &>/dev/null && return 0',
            "\tprintf 'Missing required application: %s\\n' \"${1}\" >&2",
            "\treturn 1",
            "}",
        })
    ),

    -- is_admin()
    s(
        {
            trig = "admin",
            name = "is_admin()",
            dscr = "is-admin function",
        },
        t({
            "is_admin() {",
            "\t(( EUID == 0 )) && return 0",
            "\tprintf 'Requires root/sudo\\n' >&2",
            "\treturn 1",
            "}",
        })
    ),

    -- init_defaults()
    s(
        {
            trig = "init[]",
            name = "init_defaults()",
            dscr = "initialize default options array",
        },
        fmt(
            [[
                init_defaults() {{
                    local i

                    defaults["{key}"]="{val}"
                    {last}

                    for i in "${{defaults[@]}}"; do
                        settings["${{i}}"]="${{defaults["$i"]}}"
                    done
                }}
            ]],
            {
                key = i(1, "key"),
                val = i(2, "val"),
                last = i(0),
            }
        )
    ),

    -- main()
    s(
        {
            trig = "main",
            name = "main()",
            dscr = "main function",
        },
        fmt(
            [[
                main() {{
                    local opts
                    opts="$(getopt \
                        --options h \
                        --longoptions help \
                        --name "${{0##*/}}" \
                        -- "${{@}}" \
                    )"

                    eval set -- "${{opts}}"
                    while true; do
                        case "${{1}}" in
                            -h | --help )       show_help; return 0;;
                            -- )                shift; break;;
                            * )                 break;;
                        esac
                        shift
                    done

                    {run}
                }}
            ]],
            {
                run = i(1, "run..."),
            }
        )
    ),
}
