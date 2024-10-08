# The following configuration.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ config, pkgs, ... }:

{
    imports = [ ./options.common.nix ];

    # Hostname
    networking.hostName = config.common.hostname;

    # Nix configuration
    nix.settings = {
        auto-optimise-store = pkgs.stdenv.isLinux;

        # Enable flakes
        experimental-features = [ "nix-command" "flakes" ];
    };

    # Ensure nixpkgs serves binaries for the correct architecture
    nixpkgs.hostPlatform = config.common.arch;

    # Set default shell to zsh for all users
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];

    # Do not need to update
    system.stateVersion = "24.05";
}
