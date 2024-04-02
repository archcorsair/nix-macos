# nix-macos

My Nix Flake for MacOS

# Restore the configuration

## Prerequisites

- Login to the App Store for `mas` to properly install applications.

## Steps

1. Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install)
```

2. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Clone this repository

```bash
git clone https://github.com/archcorsair/nix-macos.git
```

4. Build the flake

```bash
nix build .#darwinConfigurations.nixos.system
```

5. Remove the default nix configuration

```bash
sudo rm -f /etc/nix/nix.conf
```

6. Install the flake

```bash
./result/sw/bin/darwin-rebuild switch --flake .#nixos
```

7. Add the shell to `/etc/shells`

```bash
echo "/run/current-system/sw/bin/zsh" | sudo tee -a /etc/shells
```

8. Change the default shell to nix zsh

```bash
chsh -s /run/current-system/sw/bin/zsh
```

# Updates

Future updates can be done by running the following commands:

```bash
git pull
nix flake update
darwin-rebuild switch --flake .#nixos
```
