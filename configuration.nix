{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./programs.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "pc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 22 ];
    };
  };

  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    earlyoom.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
    };
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
    experimental-features = [ "nix-command" "flakes" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
  environment = {
    shells = with pkgs; [ bash ];
    variables = {
      HIP_PATH = "${pkgs.rocmPackages.clr}";
    };
  };


  nixpkgs.config.allowUnfree = true;

  users = {
    users = {
      quix_ = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
      root = {
        shell = pkgs.fish;
      };
    };
  };

  documentation.man.cache.enable = false;

  system.stateVersion = "25.05"; 

}

