{
  description = "Nixos desktop";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      zapret-discord-youtube,
      zen-browser,
      ...
    }@inputs:
    {
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          zapret-discord-youtube.nixosModules.default
          {
            services.zapret-discord-youtube = {
              enable = true;
              configName = "general (SIMPLE FAKE)";
            };
          }

        ];
      };
    };

}
