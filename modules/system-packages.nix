{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bun
    commitizen
    cowsay
    curlie
    delta
    doggo
    fd
    fnm
    fortune
    ghq
    httpie
    jq
    lolcat
    mas
    neofetch
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
