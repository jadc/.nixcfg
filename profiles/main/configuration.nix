{ config, pkgs, ... }:

{
    imports =
        [
            # System configuration
            ./hardware-configuration.nix
            ./../../system/grub.nix
            ./../../system/locale.nix
            ./../../system/nix-gc.nix
            ./../../system/networkmanager.nix
            ./../../system/users.nix
            ./../../system/paths-to-link.nix

            # Requires superuser
            ./../../system/xserver.nix
        ];

    config = {
        # Hostname
        networking.hostName = (import ./constants.nix).hostname;

        # Rebuild won't work without git
        environment.systemPackages = with pkgs; [ git ];

        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Do not need to update
        system.stateVersion = "24.05";
    };
}
