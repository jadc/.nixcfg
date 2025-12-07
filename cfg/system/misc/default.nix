{ pkgs, ... }:

{
    # Set default shell to zsh for all users
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
