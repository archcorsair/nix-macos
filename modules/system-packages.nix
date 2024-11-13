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
    gopls
    httpie
    jq
    lolcat
    mas
    ncdu
    neovim
    nil
    nixfmt-rfc-style
    pnpm
    ripgrep
    sl
    speedtest-cli
    termshark
  ];

  fonts.packages = with pkgs; [ fira-code-nerdfont ];
}
