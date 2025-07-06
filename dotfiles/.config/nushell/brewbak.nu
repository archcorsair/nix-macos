# Homebrew backup module for Nushell
# Usage: brewbak [--output <path>] [--force] [--verbose]

# Main backup function
export def main [
    --output (-o): string = "~/.config/homebrew/Brewfile" # Output file path
    --verbose (-v)                                       # Add additional output that lists the backed up taps/formulae/casks
    --no-force                                           # Don't overwrite existing file (prompt instead)
    --force-backup                                       # Force backup even if no changes detected
    --test                                               # Test mode: show fake data without creating backup
] {
    # --- Test Mode ---
    if $test {
        let output_path = $output | path expand
        print "🧪 Test Mode - Displaying fake data"
        print $"Creating Homebrew backup at `($output_path)`..."
        print "✅ Backup completed successfully!"
        print ""

        let summary_table = [
            {Category: "📦 Taps", Count: 1},
            {Category: "🍺 Formulae", Count: 3},
            {Category: "📱 Casks", Count: 2},
            {Category: "🏪 Mac App Store", Count: 1}
        ]

        print "📊 Backup Summary:"
        print ($summary_table | table | to text)

        if $verbose {
            print ""
            print "🔍 Verbose Output:"
            print "\n🍺 Formulae:"
            print (["btop", "fzf", "neovim"] | table -c | to text)

            print "\n📱 Casks:"
            print (["iterm2", "visual-studio-code"] | table -c | to text)

            print "\n📦 Taps:"
            print (["homebrew/cask-fonts"] | table -c | to text)

            print "\n🏪 Mac App Store Apps:"
            print ([{name: "Xcode", id: "497799835"}] | table | to text)
        }

        print ""
        print $"📁 Brewfile location: `($output_path)`"
        return
    }

    # Check if brew is available
    if not (which brew | is-not-empty) {
        error make { msg: "Homebrew not found. Please install Homebrew first." }
        return
    }

    # Resolve output path
    let output_path = $output | path expand

    # Check if backup is needed
    if not $force_backup {
        if not (check_if_backup_needed $output_path) {
            print "✅ No changes detected. Backup is up-to-date."
            print "💡 Use --force-backup to create a backup anyway."
            return
        }
    }

    # Check if file exists and no-force flag is set
    if ($output_path | path exists) and $no_force {
        let response = input $"File `($output_path)` already exists. Overwrite? (y/N): "
        if ($response | str downcase) not-in ["y", "yes"] {
            print "Backup cancelled."
            return
        }
    }

    let backup_dir = $output_path | path dirname
    if not ($backup_dir | path exists) {
        mkdir $backup_dir
    }

    print $"🍺 Creating Homebrew backup at `($output_path)`..."

    try {
        # Create the Brewfile on disk.
        ^brew bundle dump --file $output_path --force

        print "✅ Backup completed successfully!"
        print ""

        # Get package lists and counts directly from `brew` to avoid filesystem race conditions.
        let formulae = (^brew list --formula --full-name | lines | sort)
        let casks = (^brew list --cask --full-name | lines | sort)
        let taps = (^brew tap | lines | sort)
        # We still read the file for MAS apps, as there's no direct brew command for them.
        let mas_apps_lines = (open $output_path | lines | where $it starts-with "mas ")

        let tap_count = $taps | length
        let brew_count = $formulae | length
        let cask_count = $casks | length
        let mas_count = $mas_apps_lines | length

        mut table_data = []
        $table_data = ($table_data | append {Category: "📦 Taps", Count: $tap_count})
        $table_data = ($table_data | append {Category: "🍺 Formulae", Count: $brew_count})
        $table_data = ($table_data | append {Category: "📱 Casks", Count: $cask_count})

        if $mas_count > 0 {
            $table_data = ($table_data | append {Category: "🏪 Mac App Store", Count: $mas_count})
        }

        print "📊 Backup Summary:"
        print ($table_data | table | to text)

        # --- Verbose Output Logic ---
        if $verbose {
            print ""
            print "🔍 Verbose Output:"

            if not ($formulae | is-empty) {
                print "\n🍺 Formulae:"
                print ($formulae | table -c | to text)
            }

            if not ($casks | is-empty) {
                print "\n📱 Casks:"
                print ($casks | table -c | to text)
            }

            if not ($taps | is-empty) {
                print "\n📦 Taps:"
                print ($taps | table -c | to text)
            }

            if not ($mas_apps_lines | is-empty) {
                print "\n🏪 Mac App Store Apps:"
                $mas_apps_lines | parse 'mas "{name}", id: {id}' | select name id | table
            }
        }

        print ""
        print $"📁 Brewfile location: `($output_path)`"

    } catch {
        error make { msg: "Failed to create Brewfile. Please check if Homebrew is properly installed." }
    }
}

# Helper function to check if backup is needed
def check_if_backup_needed [output_path: string] {
    if not ($output_path | path exists) {
        return true
    }

    let current_formulae = try { ^brew list --formula --full-name | lines | sort } catch { return true }
    let current_casks = try { ^brew list --cask --full-name | lines | sort } catch { return true }

    let current_state = ($current_formulae | str join "\n") + "\n---\n" + ($current_casks | str join "\n")
    let current_hash = $current_state | hash sha256

    let hash_file = $"($output_path).sha256"
    if ($hash_file | path exists) {
        let previous_hash = open $hash_file | str trim
        if $current_hash == $previous_hash {
            return false
        }
    }

    $current_hash | save --force $hash_file
    return true
}
