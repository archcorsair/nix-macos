export-env {
  def start_zellij [] {
    # Check if already inside a Zellij session
    if 'ZELLIJ' not-in ($env | columns) {
      # Attach to an existing session or create a new one
      if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
        # Attempt to attach to an existing session
        let session_exists = (zellij list-sessions | lines | length) > 0
        if $session_exists {
          zellij attach -c
        } else {
          zellij
        }
      } else {
        # Start a new Zellij session
        zellij
      }

      # Exit the shell if ZELLIJ_AUTO_EXIT is set to 'true'
      if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
        exit
      }
    }
  }

  # Start Zellij
  start_zellij
}
