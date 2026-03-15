{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
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
    ];
  };
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
  programs.steam.enable = true;
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
     vim 
     wget
     curl
     git
     discord 
     telegram-desktop
     pavucontrol
     btop
     fastfetch
     lutris
     alsa-tools
     zoom-us
     prismlauncher
     clang
     clang-tools
     cmake
     tauon
     ninja
     kdePackages.ark
     helix
     unar
     appflowy
     obsidian
     qview
     radeontop
     libreoffice-qt
     protonup-qt
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
