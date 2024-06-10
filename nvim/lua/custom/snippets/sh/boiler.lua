---@diagnostic disable: undefined-global

return {
  -- minimal
  s(
    {
      trig = "boiler-min",
      name = "minimal boilerplate",
      dscr = '"Minimal" boilerplate for a sensible script',
    },
    fmt(
      [[
        #!/usr/bin/env bash
        #
        # {comment}

        main() {{
            if \[\[ "${{1}}" =~ -(h|-help) \]\]; then
                cat <<- EOF
                    {desc}

                    USAGE: ${{0##*/}} [-h|--help] {params}
                EOF
                return 0
            fi

            {run}
        }}

        main "${{@}}"
      ]],
      {
        comment = i(1, "Description"),
        desc = rep(1),
        params = i(2, "[PARAMS]"),
        run = i(0, "# run..."),
      }
    )
  ),

  -- minimal w/ logging
  s(
    {
      trig = "boiler-min-log",
      name = "minimal boilerplate w/ logging",
      dscr = '"Minimal" boilerplate with log support',
    },
    fmt(
      [[
        #!/usr/bin/env bash
        #
        # {comment}

        log() {{
            printf '%s|%s|%s\n' "$(date --iso-8601='sec')" "${{FUNCNAME[1]}}" "${{1}}" | \
                tee --append "${{log:-/dev/null}}" | \
                cut --fields='2-' --delimiter='|'
        }}

        main() {{
            if \[\[ "${{1}}" =~ -(h|-help) \]\]; then
                cat <<- EOF
                    {desc}

                    USAGE: ${{0##*/}} [-h|--help] {params}
                EOF
                return 0
            fi

            mkdir --parents "${{log%/*}}"
            touch -a "${{log}}"

            {run}
        }}

        log="/var/log/scripts/$(basename "${{0%.*}}").log"
        trap 'unset log' EXIT
        main "${{@}}"
      ]],
      {
        comment = i(1, "Description"),
        desc = rep(1),
        params = i(2, "[PARAMS]"),
        run = i(0, "# run..."),
      }
    )
  ),

  -- argparse
  s(
    {
      trig = "boiler-arg",
      name = "boilerplate /w argparse",
      dscr = "Boilerplate script with argparse",
    },
    fmt(
      [[
                #!/usr/bin/env bash
                #
                # {comment}

                show_help() {{
                    cat << EOF
                {desc}

                USAGE: ${{0##*/}} [OPTIONS] {params}

                OPTIONS:
                    -h, --help          Show this help message
                    {options}
                EOF
                }}

                main() {{
                    local opts
                    opts="$(getopt \
                        --options h{short} \
                        --longoptions help,{long} \
                        --name "${{0##*/}}" \
                        -- "${{@}}" \
                    )"

                    eval set -- "${{opts}}"
                    while true; do
                        case "${{1}}" in
                            -h | --help )       show_help; return 0;;
                            {opts}
                            -- )                shift; break;;
                            * )                 break;;
                        esac
                        shift
                    done

                    {run}
                }}

                main "${{@}}"
            ]],
      {
        comment = i(1, "Description"),
        desc = rep(1),
        params = i(2, "PARAMS [...]"),
        options = i(3, "options..."),
        short = i(4, "short-opts..."),
        long = i(5, "long-opts..."),
        opts = i(6, "short/log opt cases"),
        run = i(0),
      }
    )
  ),

  -- full (argparse + log)
  s(
    {
      trig = "boiler",
      name = "full boilerplate: argparse & logging",
      dscr = "Typical script boilerplate, with argparse & logging",
    },
    fmt(
      [[
                #!/usr/bin/env bash
                #
                # {comment}

                log() {{
                    printf '%s|%s|%s\n' "$(date --iso-8601='sec')" "${{FUNCNAME[1]}}" "${{1}}" | \
                        tee --append "${{log:-/dev/null}}" | \
                        cut --fields='2-' --delimiter='|'
                }}

                show_help() {{
                    cat << EOF
                {desc}

                USAGE: ${{0##*/}} [OPTIONS] {params}

                OPTIONS:
                    -h, --help          Show this help message
                    {options}
                EOF
                }}

                main() {{
                    local opts
                    opts="$(getopt \
                        --options h{short} \
                        --longoptions help,{long} \
                        --name "${{0##*/}}" \
                        -- "${{@}}" \
                    )"

                    eval set -- "${{opts}}"
                    while true; do
                        case "${{1}}" in
                            -h | --help )       show_help; return 0;;
                            {opts}
                            -- )                shift; break;;
                            * )                 break;;
                        esac
                        shift
                    done

                    mkdir --parents "${{log%/*}}"
                    touch -a "${{log}}"

                    {run}
                }}

                log="/var/log/scripts/$(basename "${{0%.*}}").log"
                trap 'unset log' EXIT
                main "${{@}}"
            ]],
      {
        comment = i(1, "Description"),
        desc = rep(1),
        params = i(2, "PARAMS [...]"),
        options = i(3, "options..."),
        short = i(4, "short-opts..."),
        long = i(5, "long-opts..."),
        opts = i(6, "short/log opt cases"),
        run = i(0),
      }
    )
  ),
}
