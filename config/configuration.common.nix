# The following configuration.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ config, pkgs, ... }:

{
    imports = [ ./options.common.nix ];

    # Hostname
    networking.hostName = config.common.hostname;

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

    # Rebuild won't work without git
    environment.systemPackages = with pkgs; [ git ];

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Ensure nixpkgs serves binaries for the correct architecture
    nixpkgs.hostPlatform = config.common.arch;

    # Do not need to update
    system.stateVersion = "24.05";
}
