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

  # hardware.firmware = [
  #   (pkgs.runCommand "hda-jack-retask-firmware" {} ''
  #     mkdir -p $out/lib/firmware
  #     # Используем \${./...} — это заставит Nix скопировать файл в Store
  #     # и подставить сюда правильный длинный путь (/nix/store/...)
  #     cp ${./hda-jack-retask.fw} $out/lib/firmware/
  #   '')
  # ];

  # boot.extraModprobeConfig = ''
  #   options snd-hda-intel patch=hda-jack-retask.fw
  # '';

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

  #programs.obs-studio.enable = false;

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     stdenv.cc.cc
  #     zlib
  #   ];
  # };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  hardware.amdgpu.opencl.enable = true; 

  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
  ];


  nixpkgs.config.allowUnfree = true;

   users.users.quix_ = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
       tree
     ];
   };
  
  users.defaultUserShell = pkgs.bash;
  environment.shells = with pkgs; [ bash ];

  documentation.man.generateCaches = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
  };
  # networking.nameservers = [ "176.99.11.77" ];


  system.stateVersion = "25.05"; 

}

