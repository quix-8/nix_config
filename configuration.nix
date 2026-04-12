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

  hardware.amdgpu.opencl.enable = true; 
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications 
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];


  nixpkgs.config.allowUnfree = true;

   users.users.quix_ = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
   };
  
  users.defaultUserShell = pkgs.bash;
  environment.shells = with pkgs; [ bash ];

  documentation.man.generateCaches = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
  };

  system.stateVersion = "25.05"; 

}

