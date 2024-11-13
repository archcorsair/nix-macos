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
    sl
    speedtest-cli
    termshark
    zigpkgs."0.13.0"
  ];

  fonts.packages = with pkgs; [ fira-code-nerdfont ];
}
