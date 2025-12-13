{ config, lib, ... }:

{
    options.cfg.system = {
        timeZone = lib.mkOption {
            type = lib.types.str;
            default = "America/Edmonton";
            description = "The timezone of the system";
        };

        locale = lib.mkOption {
            type = lib.types.str;
            default = "en_CA.UTF-8";
            description = "The locale of the system";
        };
    };

    config = let
        timeZone = config.cfg.system.timeZone;
        locale = config.cfg.system.locale;
    in {
        time.timeZone = timeZone;
        i18n.defaultLocale = locale;
        i18n.extraLocaleSettings = {
            LC_ADDRESS = locale;
            LC_IDENTIFICATION = locale;
            LC_MEASUREMENT = locale;
            LC_MONETARY = locale;
            LC_NAME = locale;
            LC_NUMERIC = locale;
            LC_PAPER = locale;
            LC_TELEPHONE = locale;
            LC_TIME = locale;
        };
    };
}
