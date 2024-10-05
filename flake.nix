{
  description = "MacOS Personal Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
    let
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations = {
        default = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwinConfigurations/nixos.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}