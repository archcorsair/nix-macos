  { inputs, pkgs, ... }:

  {
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
      bat
      btop
      bun
      doggo
      eza
      fd
      fnm
      fzf
      ghq
      git
      jq
      mas
      neofetch
      ripgrep
      speedtest-cli
      tailscale
      zoxide
    ];

    nix = {
      extraOptions = "experimental-features = nix-command flakes";
    };

    programs = {
      bat = {
        config = {
          style = "header,header-filesize";
          theme = "base16";
        };
        enable = true;
      };
      eza = {
        enable = true;
        extraOptions = [
          "-l"
          "-g"
          "--icons"
        ];
      };
      fzf = {
        defaultCommand = "fd --type file --color=always";
        defaultOptions = [
          "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
        ];
        enable = true;
      };
      git = {
        enable = true;
        userEmail = "archcorsair@gmail.com";
        userName = "Daniel Shneyder";
        delta = {
          enable = true;
          options = {
            side-by-side = true;
            line-numbers = true;
            dark = true;
          };
        };
      };
      jq.enable = true;
      ripgrep.enable = true;
      ssh = {
        enable = true;
        extraConfig = ''
          Host *
              IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        '';
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;

          command_timeout = 1000;

          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };

          directory = {
            read_only = " 󰌾";
            truncation_symbol = "../";
          };

          git_metrics = {
            added_style = "bold blue";
            format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
            disabled = false;
          };

          git_commit = {
            tag_disabled = false;
          };

          git_state = {
            cherry_pick = "[🍒 PICKING](bold red)";
          };

          aws = {
            symbol = "  ";
          };

          dart = {
            symbol = " ";
          };

          docker_context = {
            symbol = " ";
          };

          elixir = {
            symbol = " ";
          };

          fossil_branch = {
            symbol = " ";
          };

          git_branch = {
            symbol = " ";
          };

          golang = {
            symbol = " ";
          };


          hg_branch = {
            symbol = " ";
          };

          hostname = {
            ssh_symbol = " ";
          };

          java = {
            symbol = " ";
          };

          kotlin = {
            symbol = " ";
          };

          lua = {
            symbol = " ";
          };

          memory_usage = {
            symbol = "󰍛 ";
          };

          nix_shell = {
            symbol = " ";
          };

          nodejs = {
            symbol = " ";
          };

          ocaml = {
            symbol = " ";
          };

          os.symbols = {
            Alpaquita = " ";
            Alpine = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            OpenBSD = "󰈺 ";
            openSUSE = " ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            Redhat = " ";
            RedHatEnterprise = " ";
            Redox = "󰀘 ";
            Solus = "󰠳 ";
            SUSE = " ";
            Ubuntu = " ";
            Unknown = " ";
            Windows = "󰍲 ";
          };

          package = {
            symbol = "󰏗 ";
          };

          perl = {
            symbol = " ";
          };

          php = {
            symbol = " ";
          };

          pijul_channel = {
            symbol = " ";
          };

          python = {
            symbol = " ";
          };


          ruby = {
            symbol = " ";
          };

          rust = {
            symbol = " ";
          };

          scala = {
            symbol = " ";
          };

          swift = {
            symbol = " ";
          };

          zig = {
            symbol = " ";
          };
        };
      };
      vim = {
        enable = true;
        defaultEditor = true;
        extraConfig = ''
          set nocompatible
          syntax on
          set number
          set ruler
          set modelines=0
          set visualbell
          set encoding=utf-8
          set hidden
          set ttyfast
          set laststatus=2
          set showmode
          set showcmd
          set backspace=indent,eol,start
          set rtp+=${pkgs.fzf}/share/fzf
        '';
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        initExtra = ''
          # Bun
          export BUN_INSTALL="$HOME/.bun"
          export PATH="$BUN_INSTALL/bin:$PATH"

          # fnm
          eval "$(fnm env --use-on-cd)"

          # options
          setopt clobber

          # port killer
          function port() {
            OUTPUT=$(lsof -nP -iTCP:$1 | grep LISTEN)
            if [ -z "$OUTPUT" ]
            then
              echo There is no process listening on port "$1"
            else
              WHO=$(echo $OUTPUT | awk 'NR==1{ print $1 }');
              PID=$(echo $OUTPUT | awk 'NR==1{ print $2 }');
              read -sk "INPUT?Kill process $WHO (PID: $PID) listening on port $1? [Y/n]: "
              if [[ $INPUT =~ ^[Yy]$ ]]
              then
                kill -9 $PID
              fi
            fi
          }
        '';
        shellAliases = {
          code = "code-insiders";
          g = "git";
          grep = "rg";
          ll = "eza";
          nix-shell = "nix-shell --run $SHELL";
          man = "batman";
          cd = "z";
          whatismyip = "curl -s 'https://api.ipify.org?format=json' | jq -r '.ip'";
          wimi = "whatismyip";
          vim = "nvim";
          rust-env = "~/.config/nix/rust-env.sh";
        };
        syntaxHighlighting = {
          enable = true;
          package = pkgs.zsh-syntax-highlighting;
        };
      };
    };
  }