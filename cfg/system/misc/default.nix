{ config, lib, pkgs, ... }:

{

    home = {
        username = lib.mkForce config.common.username;
        homeDirectory = lib.mkForce ("/home/" + config.common.username);
        stateVersion = "24.05";  # Do not need to update
    };

    # Automatically start systemd user services
    systemd.user.startServices = true;

    # Use xdg user directories
    xdg.configFile."mimeapps.list".force = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Allow unfree packages in nix shells
    xdg.configFile."nixpkgs/config.nix".text = ''{ allowUnfree = true; }'';




    # Set default shell to zsh for all users
    # TODO: move to shell opt
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;

    # Ensure all firmware and drivers is installed
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];

    # Do not need to update
    system.stateVersion = "24.05";
}
