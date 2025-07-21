  $env.config = {
    show_banner: false
  }

  $env.EDITOR = "hx"

  # homebrew backup module
  use brewbak.nu

  # update homebrew
  def brewup [] {
    brew update
    brew upgrade
    brewbak
  }

  # update nix
  def rebuild [] {
    cd ~/ghq/github.com/archcorsair/nix-macos
    nix flake update
    sudo darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace
  }

# speedtest wrapper
  def "speed" [] {
    speedtest -f json-pretty
    | from json
    | do {
      {
        "Download (Mbps)": ($in.download.bandwidth * 8 / 1_000_000)
        "Upload (Mbps)": ($in.upload.bandwidth * 8 / 1_000_000)
        "Packet Loss": $in.packetLoss
        "Ping (ms)": $in.ping.latency
        "Jitter (ms)": $in.ping.jitter
        Timestamp: $in.timestamp
        ISP: $in.isp
        Server: ($in.server.name + " (" + $in.server.location + ")")
        Result: $in.result.url
      }
    }
  }

  def "version-completions" [] {
  [
    {value: "4", description: "IPv4 address (default)"},
    {value: "6", description: "IPv6 address"}
  ]}

def "summarize" [url: string] {
    crwl $url -q "From the crawled content, extract the following details: 1. Title of the page 2. Summary of the page, which is a detailed summary 3. If there are multiple articles, just focus on the first one from the top and ignore the rest"
}

def "whatismyip" [
    version?: int@version-completions # Parameter with custom completion
] {
    try {
        # Validate and set default version
        let version = if ($version == null) {
            4
        } else if ($version in [4 6]) {
            $version
        } else {
            error make {
                msg: "Invalid IP version. Must be either 4 or 6."
            }
        }

        # Try to fetch IP address
        try {
            let ip = (http get $"https://api($version).ipify.org")
            return {
                $"ip($version)": $ip
            } | table
        } catch {
            error make {
                msg: "Failed to connect to ipify.org. Please check your internet connection."
            }
        }
    } catch {|err|
        # Display user-friendly error message without stack trace
        print $"Error: ($err.msg)"
        return
    }
}

# fzf
$env.FZF_DEFAULT_COMMAND = "/opt/homebrew/bin/fd --type file --color=always -H --no-require-git"
$env.FZF_DEFAULT_OPTS = "--ansi --preview '/opt/homebrew/bin/eza --tree --icons --git --level=1 --no-quotes --color=always --color-scale-mode=fixed --group-directories-first'"

# Zoxide
source ~/.zoxide.nu

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml" )

# Caparace
source ~/.cache/carapace/init.nu

# Atuin
source ~/.local/share/atuin/init.nu

alias "cd" = z
alias "code" = code-insiders
alias "g" = git
alias "grep" = rg
alias "la" = eza -a
alias "ll" = eza --icons auto --git -lah -g --git-repos --group-directories-first --hyperlink --smart-group --no-quotes
# alias "ls" = eza --icons auto
alias "lt" = eza --icons auto --tree --level=2 --no-quotes
alias "man" = batman
alias "wimi" = whatismyip
alias "rm" = rm -vi
alias "mv" = mv -vi
alias "cp" = cp -vi

# Zellij - Temporarily Disabled
# use ./zellij.nu

# fnm
if not (which fnm | is-empty) {
    ^fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
    $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD? | append {
            condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
            code: {|| ^fnm use}
        }
    )
}

# External Completers
let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # default nushell behavior for cd
        cd => null
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
    completions: {
        external: {
            enable: true
            completer: $external_completer
        }
    }
}
