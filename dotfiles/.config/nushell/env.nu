# FNM
# fnm env --json | from json | load-env
# use std "path add"
# $env.FNM_BIN = $"($env.FNM_DIR)/bin"
# path add $env.FNM_BIN
# $env.FNM_MULTISHELL_PATH = $"($env.FNM_DIR)/nodejs"
# path add $env.FNM_MULTISHELL_PATH


# Environment Variables
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_DATA_DIRS = ["/usr/local/share" "/usr/share"]

# Path
$env.PATH = (
   $env.PATH
   | split row (char esep)
   | prepend '/usr/local/bin'
   | prepend '/opt/homebrew/bin'
   | prepend '/opt/homebrew/sbin'
   | prepend '/nix/var/nix/profiles/default/bin'
   | prepend '/run/current-system/sw/bin/'
   | prepend ('/etc/profiles/per-user' | path join $env.USER bin)
   | prepend ($env.HOME | path join '.nix-profile/bin')
   | uniq # filter so the paths are unique
)

let zoxide_cache = "/Users/nxc/.cache/zoxide"
if not ($zoxide_cache | path exists) {
  mkdir $zoxide_cache
}
/nix/store/jacrfckg5s88l7clxyk3kibiwm0jjd63-zoxide-0.9.7/bin/zoxide init nushell  |
  save --force /Users/nxc/.cache/zoxide/init.nu

let starship_cache = "/Users/nxc/.cache/starship"
if not ($starship_cache | path exists) {
  mkdir $starship_cache
}
/etc/profiles/per-user/nxc/bin/starship init nu | save --force /Users/nxc/.cache/starship/init.nu
