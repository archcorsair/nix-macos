export def main [
    --verbose(-v)
] {
    let trusted_ssids = ["nxc"]

    # Get current SSID using system_profiler (literally nothing else worked lol)
    def get_current_ssid [verbose: bool] {
        if $verbose { print "🔍 Debug: Trying system_profiler..." }

        try {
            let wifi_info = (^system_profiler SPAirPortDataType | str trim)

            if $verbose { print "🔍 Debug: Got system_profiler output, checking for Current Network Information..." }

            let lines = ($wifi_info | lines)
            mut found_current = false
            mut ssid = null
            mut debug_lines = []

            for line in $lines {
                let trimmed = ($line | str trim)

                if $verbose and (($trimmed | str contains "Current Network Information:") or ($trimmed | str contains "Name:") or ($trimmed | str contains "Status:") or ($trimmed | str ends-with ":")) {
                    $debug_lines = ($debug_lines | append $"  -> ($trimmed)")
                }

                if ($trimmed | str contains "Current Network Information:") {
                    $found_current = true
                    if $verbose { print "🔍 Debug: Found Current Network Information section" }
                    continue
                }

                if $found_current {
                    # Method 1: Look for "Name:" field
                    if ($trimmed | str starts-with "Name:") {
                        $ssid = ($trimmed | str replace "Name: " "" | str trim)
                        if $verbose { print $"🔍 Debug: Found SSID via Name field: ($ssid)" }
                        break
                    }

                    # Method 2: Look for a section that ends with ":" - this might be the SSID
                    if ($trimmed | str ends-with ":") and not ($trimmed | str starts-with " ") and $trimmed != "Current Network Information:" {
                        # Remove the trailing colon to get the SSID
                        $ssid = ($trimmed | str replace --regex ":$" "" | str trim)
                        if $verbose { print $"🔍 Debug: Found SSID via section header: ($ssid)" }
                        break
                    }
                }
            }

            if $verbose and (($debug_lines | length) > 0) {
                print "🔍 Debug: Relevant lines found:"
                for debug_line in $debug_lines {
                    print $debug_line
                }
            }

            return $ssid
        } catch { |err|
            if $verbose { print $"🔍 Debug: Error running system_profiler: ($err)" }
            return null
        }
    }

    let current_ssid = (get_current_ssid $verbose)

    if $current_ssid == null {
        print "❌ Could not determine current Wi-Fi network"
        if not $verbose {
            print "Make sure you're connected to Wi-Fi and try running with sudo if needed"
            print "Use -v or --verbose flag for detailed troubleshooting information"
        } else {
            print "Make sure you're connected to Wi-Fi and try running with sudo if needed"
        }
        exit 1
    }

    print $"📡 Current network: ($current_ssid)"

    if ($current_ssid in $trusted_ssids) {
        print $"🔒 Trusted network: ($current_ssid) — disabling Tailscale DNS"
        try {
            ^sudo tailscale up --accept-dns=false --accept-routes=true
            print "✅ Tailscale DNS disabled successfully"
        } catch {
            print "❌ Failed to configure Tailscale"
            exit 1
        }
    } else {
        print $"🌐 Untrusted network: ($current_ssid) — enabling Tailscale DNS"
        try {
            ^sudo tailscale up --accept-dns=true --accept-routes=true
            print "✅ Tailscale DNS enabled successfully"
        } catch {
            print "❌ Failed to configure Tailscale"
            exit 1
        }
    }
}
