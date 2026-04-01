{ config, pkgs, ... }:

{
	home.username = "quix_";
	home.homeDirectory = "/home/quix_";
	home.stateVersion = "25.05";
	# programs.bash = {
	# 	enable = true;
	# 	shellAliases = {
	# 		ff = "fastfetch";
	# 		nrs = "sudo nixos-rebuild switch --flake ~/nxdt#pc";
	# 	};
	# };

	home.file.".config/helix".source = ./config/helix;
}
