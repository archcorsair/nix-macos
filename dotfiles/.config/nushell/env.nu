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
   | prepend ($env.HOME | path join '.cargo/bin')
   | prepend ($env.HOME | path join '.nix-profile/bin')
   | uniq # filter so the paths are unique
)

# Zoxide
zoxide init nushell | save -f ~/.zoxide.nu

# Carapace
$env.CARAPACE_BRIDGES = 'zsh,bash,inshellisense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu