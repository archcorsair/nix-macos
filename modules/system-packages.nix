{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    devenv
    gopls
    nil
    nixfmt-rfc-style
    # (rust-bin.stable.latest.default.override {
    #   extensions = [
    #     "clippy"
    #     "rust-src"
    #     "rust-std"
    #   ];
    #   targets = [
    #     "aarch64-apple-darwin"
    #     "x86_64-apple-darwin"
    #   ];
    # })
    zigpkgs."0.13.0"
  ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
}
