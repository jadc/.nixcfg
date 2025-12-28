{ pkgs, ... }:

{
    # Use home-manager for actual zsh configuration
    home-manager.sharedModules = [ ./home.nix ];

    # Set default shell to zsh for all users
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];
}