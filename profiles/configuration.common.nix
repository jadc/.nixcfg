# The following configuration.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ config, pkgs, ... }:

{
    imports = [ ./options.common.nix ];

    # Nix configuration
    nix.settings = {
        auto-optimise-store = pkgs.stdenv.isLinux;

        # Enable flakes
        experimental-features = [ "nix-command" "flakes" ];

        # Use pre-compiled binaries from nix-community cache if available
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
        trusted-users = [ "@wheel" ];
    };

    # Set default shell to zsh for all users
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;

    # Ensure all firmware and drivers is installed
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    # Setup locale
    time.timeZone = config.common.timeZone;
    i18n.defaultLocale = config.common.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = config.common.locale;
        LC_IDENTIFICATION = config.common.locale;
        LC_MEASUREMENT = config.common.locale;
        LC_MONETARY = config.common.locale;
        LC_NAME = config.common.locale;
        LC_NUMERIC = config.common.locale;
        LC_PAPER = config.common.locale;
        LC_TELEPHONE = config.common.locale;
        LC_TIME = config.common.locale;
    };

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];

    # Do not need to update
    system.stateVersion = "24.05";
}
