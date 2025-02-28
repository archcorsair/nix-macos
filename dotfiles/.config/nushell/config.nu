  $env.config = {
    show_banner: false
  }

  $env.EDITOR = "hx"

  # update homebrew
  def brewup [] {
    brew update
    brew upgrade
  }

  # update nix
  def rebuild [] {
    cd ~/ghq/github.com/archcorsair/nix-macos
    nix flake update
    darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace
  }

  def "version-completions" [] {
  [
    {value: "4", description: "IPv4 address (default)"},
    {value: "6", description: "IPv6 address"}
  ]}

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

# Zoxide
source ~/.zoxide.nu

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Caparace
source ~/.cache/carapace/init.nu

# Atuin
source ~/.local/share/atuin/init.nu

alias "cd" = z
alias "code" = code-insiders
alias "eza" = eza --icons auto --git -l -g --git-repos --group-directories-first --hyperlink --smart-group --no-quotes
alias "g" = git
alias "grep" = rg
alias "la" = eza -a
alias "ll" = eza --icons auto --git -lah -g --git-repos --group-directories-first --hyperlink --smart-group --no-quotes
alias "ls" = eza --icons auto
alias "lt" = eza --icons auto --tree --level=2 --no-quotes
alias "man" = batman
alias "wimi" = whatismyip
alias "rm" = rm -vi
alias "mv" = mv -vi
alias "cp" = cp -vi

# Zellij
use ./zellij.nu

# fnm
# use ./fnm.nu # Disabled until I can find a proper workaround in fnm.nu

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
