{ config, pkgs, ... }:

{
    imports =
        [
            ./hardware-configuration.nix
            ./../../system/grub.nix
            ./../../system/locale.nix
            ./../../system/nix-gc.nix
            ./../../system/networkmanager.nix
            ./../../system/users.nix
            ./../../system/zsh.nix
        ];

    config = {
        # Hostname
        networking.hostName = "jadc";

        # environment.systemPackages = with pkgs; [];

        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Do not need to update
        system.stateVersion = "24.05";
    };
}
