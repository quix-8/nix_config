{
	description = "Nixos desktop";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

	};

	outputs = { nixpkgs, zapret-discord-youtube,... }: {
		nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				zapret-discord-youtube.nixosModules.default{
          				services.zapret-discord-youtube = {
            					enable = true;
            					configName = "general (SIMPLE FAKE)"; 
          				};
				}
			];
		};
	};

}
