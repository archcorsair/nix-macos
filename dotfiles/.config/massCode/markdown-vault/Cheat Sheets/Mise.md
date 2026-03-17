---
contents:
  - id: 36
    label: Fragment 1
    language: markdown
createdAt: 1770884762043
description: null
folderId: 12
id: 24
isDeleted: 0
isFavorites: 0
name: Mise
tags:
  - 36
  - 37
updatedAt: 1770884909751
---

## Fragment: Fragment 1
```markdown
# Version management

`mise use node@22` — install and pin node 22 in the current project's mise.toml

`mise use -g node@lts` — set the global default

`mise install node@20` — install without activating

`mise ls` — show what's active and where it's coming from

`mise ls-remote node` — see all available versions

# Day-to-day

`mise current` — quick view of active tool versions in current directory

`mise doctor` — diagnose issues (activation, shims, missing tools)

`mise prune` — clean up unused installed versions

# Adding more tools (beyond node)

`mise use -g bun@latest` — could replace the Homebrew bun formula

`mise use zig@0.13.0` — could replace the nix zig overlay per-project

`mise settings add idiomatic_version_file_enable_tools bun` — if you want .bun-version file support for other tools too

# Useful to know

`mise outdated` — shows which tools have newer versions available

`mise up` — upgrade tools to latest within their configured range

`mise where node@22` — prints the install path (handy for debugging)

```
