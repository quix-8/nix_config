{
  description = "Nixos desktop";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    blender-bin.url = "https://flakehub.com/f/edolstra/blender-bin/*";
  };

  outputs = { nixpkgs, zapret-discord-youtube, ... }: {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            configName = "general (SIMPLE FAKE)";
          };
        }
        ({ self, system, ... }: {
          environment.systemPackages = with self.inputs.blender-bin.packages.${system}; [
            # 'default' is the latest blender version, though you can also pull a specific version e.g. 'blender_4_3'
            default
          ];
        })
      ];
    };
  };

}
