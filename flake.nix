{
  description = "Daniel's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    # rust-overlay.url = "github:oxalica/rust-overlay";
    # rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    tokyonight-overlay.url = "github:mrjones2014/tokyonight.nix";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-stable,
      nix-homebrew,
      home-manager,
      zig-overlay,
      # rust-overlay,
      tokyonight-overlay,
    }:
    let
      stablePkgs = import nixpkgs-stable {
        system = "aarch64-darwin";
      };

      configuration =
        { pkgs, ... }:
        {
          imports = [
            ./modules/homebrew.nix
            ./modules/system-packages.nix
            ./modules/system-defaults.nix
          ];

          # Home Manager configuration
          home-manager.extraSpecialArgs = { inherit stablePkgs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nxc =
            { pkgs, ... }:
            {
              imports = [
                tokyonight-overlay.homeManagerModules.default
                ./modules/home-manager/broot.nix
                ./modules/home-manager/bat.nix
                ./modules/home-manager/btop.nix
                ./modules/home-manager/carapace.nix
                ./modules/home-manager/eza.nix
                ./modules/home-manager/fzf.nix
                ./modules/home-manager/git.nix
                ./modules/home-manager/helix.nix
                ./modules/home-manager/neovim.nix
                ./modules/home-manager/nushell.nix
                ./modules/home-manager/ssh.nix
                ./modules/home-manager/starship.nix
                ./modules/home-manager/zoxide.nix
                ./modules/home-manager/zsh.nix
              ];

              tokyonight = {
                enable = true;
                style = "night";
              };

              home.stateVersion = "24.05";
            };

          users.users.nxc = {
            home = "/Users/nxc";
          };

          nix.package = pkgs.nixVersions.latest;

          programs.zsh.enable = true;

          nix.settings.experimental-features = "nix-command flakes";

          system.configurationRevision = self.rev or self.dirtyRev or null;

          system.stateVersion = 5;

          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit stablePkgs; };
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                zig-overlay.overlays.default
                # rust-overlay.overlays.default
              ];
            }
          )
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "nxc";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
        ];
      };

      darwinPackages = self.darwinConfigurations."mbp".pkgs;
    };
}
