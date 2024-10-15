{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bun
    commitizen
    curlie
    delta
    doggo
    fd
    fnm
    ghq
    httpie
    jq
    mas
    neofetch
    neovim
    nixfmt
    pnpm
    ripgrep
    speedtest-cli
    termshark
  ];

  fonts.packages = with pkgs; [ fira-code-nerdfont ];
}
