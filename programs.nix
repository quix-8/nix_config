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

  programs.kdeconnect.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      ff = "fastfetch";
      nrs = "sudo nixos-rebuild switch --flake ~/nxdt#pc";
      ncd = "nix-collect-garbage -d";
      nxsh = "nix-shell .";
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  users.users.jellyfin.extraGroups = [ "users" ];

  programs.amnezia-vpn.enable = true;
  programs.steam.enable = true;
  programs.firefox.enable = true;

  users.users.quix_.packages = with pkgs; [
    tree
    discord
    telegram-desktop
    prismlauncher
    tauon
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
    nicotine-plus
  ];

  environment.systemPackages = with pkgs; [
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
     protonup-qt
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
