{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./programs.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.earlyoom.enable = true;

  services.printing.enable = true;
  services.pipewire = {
     enable = true;
     audio.enable = true;
     pulse.enable = true;
   };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    fallback = true;
    connect-timeout = 5;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
  environment.variables = {
    HIP_PATH = "${pkgs.rocmPackages.clr}";
  };


  nixpkgs.config.allowUnfree = true;

   users.users.quix_ = {
     isNormalUser = true;
     shell = pkgs.fish;
     extraGroups = [ "wheel" ];
   };
  
  users.defaultUserShell = pkgs.bash;
  environment.shells = with pkgs; [ bash ];

  documentation.man.cache.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
  };

  system.stateVersion = "25.05"; 

}

