{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bun
    commitizen
    cowsay
    curlie
    delta
    deno
    devenv
    doggo
    fastfetch
    fd
    fnm
    fortune
    ghq
    glow
    gopls
    httpie
    jq
    lolcat
    mas
    neovim
    nil
    nixfmt-rfc-style
    pnpm
    ripgrep
    (rust-bin.stable.latest.default.override {
      extensions = [
        "clippy"
        "rust-src"
        "rust-std"
      ];
      targets = [
        "aarch64-apple-darwin"
        "x86_64-apple-darwin"
      ];
    })
    sl
    speedtest-cli
    termshark
    zigpkgs."0.13.0"
  ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
}
