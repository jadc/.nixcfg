# The following configuration.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ common, pkgs, ... }:

{
    # Hostname
    networking.hostName = common.hostname;

    # Setup locale
    time.timeZone = common.region.timeZone;
    i18n.defaultLocale = common.region.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = common.region.locale;
        LC_IDENTIFICATION = common.region.locale;
        LC_MEASUREMENT = common.region.locale;
        LC_MONETARY = common.region.locale;
        LC_NAME = common.region.locale;
        LC_NUMERIC = common.region.locale;
        LC_PAPER = common.region.locale;
        LC_TELEPHONE = common.region.locale;
        LC_TIME = common.region.locale;
    };

    # Rebuild won't work without git
    environment.systemPackages = with pkgs; [ git ];

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Do not need to update
    system.stateVersion = "24.05";
}
