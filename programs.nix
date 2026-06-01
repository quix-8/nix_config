{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      github.github-vscode-theme
      ms-vscode.cpptools-extension-pack
      twxs.cmake
      ms-vscode.cmake-tools
      pkief.material-icon-theme
      jdinhlife.gruvbox
      rust-lang.rust-analyzer
      davidanson.vscode-markdownlint
      ms-python.python
      ms-python.debugpy
      catppuccin.catppuccin-vsc
    ];
  };

  virtualisation.docker.enable = true;

  programs.kdeconnect.enable = true;
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ff = "fastfetch";
      nrs = "sudo nixos-rebuild switch --flake ~/nxdt#pc";
      ncd = "nix-collect-garbage -d";
      nxsh = "nix-shell .";
    };
  };

  # services.ollama.enable = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true; # Открывает порт 8096
  };
  users.users.jellyfin.extraGroups = [ "users" ];

  programs.steam.enable = true;
  programs.firefox.enable = true;

  users.users.quix_.packages = with pkgs; [
    tree
    discord
    telegram-desktop
    lutris
    prismlauncher
    tauon
    appflowy
    chromium
    flclash
    libreoffice-qt
    obsidian
    spotify
    qbittorrent-enhanced
    abcde
    cdparanoia
    flac
    cddiscid
    krita
    mpv
  ];

  environment.systemPackages = with pkgs; [
     amnezia-vpn
     vim 
     wget
     curl
     git   
     pavucontrol
     btop
     fastfetch
     alsa-tools
     clang
     clang-tools
     cmake
     ninja
     android-tools
     kdePackages.ark
     helix
     unar
     qview
     radeontop
     protonup-qt
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
