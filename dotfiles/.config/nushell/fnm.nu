# WIP - THIS DOESN'T WORK AS EXPECTED YET
export-env {
    # Define a function to get fnm environment variable settings
    def fnm-env [] {
        # Create a mutable empty record to store environment variables
        mut env_vars = {}
        mut path_entries = []

        # Get fnm environment variable settings under bash
        let shell_vars = (
            ^fnm env --shell bash |
            lines |
            parse -r '^export (?P<key>\w+)=(?P<value>.*)$' |
            each { |row|
                # Clean up value by removing surrounding quotes
                let cleaned_value = ($row.value | str trim -c '"' | str trim -c "'")
                {key: $row.key, value: $cleaned_value}
            }
        )

        # Process parsed variables
        for v in $shell_vars {
            if $v.key == "PATH" {
                # Split PATH into segments and expand $PATH reference
                let path_segments = ($v.value | split row ':')
                for segment in $path_segments {
                    if $segment == "$PATH" {
                        # Append existing PATH entries
                        $path_entries = ($path_entries | append $env.PATH)
                    } else {
                        $path_entries = ($path_entries | append $segment)
                    }
                }
            } else {
                $env_vars = ($env_vars | insert $v.key $v.value)
            }
        }

        # Handle PATH updates
        if not ($path_entries | is-empty) {
            let env_used_path = ($env | columns | where { str downcase == "path" } | get 0)
            $env_vars = ($env_vars | insert $env_used_path $path_entries)
        }

        return $env_vars
    }

    # Check if fnm command exists
    if not (which fnm | is-empty) {
        # Load fnm environment variables
        fnm-env | load-env

        # Set directory change hook (only set once)
        if (not ($env | default false __fnm_hooked | get __fnm_hooked)) {
            # Mark hook as set
            $env.__fnm_hooked = true

            # Initialize configuration structure
            $env.config = ($env | default {} config).config
            $env.config = ($env.config | default {} hooks)
            $env.config = ($env.config | update hooks ($env.config.hooks | default {} env_change))
            $env.config = ($env.config | update hooks.env_change ($env.config.hooks.env_change | default [] PWD))

            # Add directory change handler function
            $env.config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append { |before, after|
                if ('FNM_DIR' in $env) and ([.nvmrc .node-version] | path exists | any { |it| $it }) {
                    (fnm-env | load-env); (^fnm use)
                }
            }))
        }
    }
}