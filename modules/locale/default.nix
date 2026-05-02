{ ... }:

{
    flake.modules.generic.locale = { lib, ... }: {
        options.cfg.locale = lib.mkOption {
            type = lib.types.str;
            default = "en_CA.UTF-8";
            description = "The locale of the system";
        };
    };

    flake.modules.nixos.locale = { config, ... }: {
        config = let
            locale = config.cfg.locale;
        in {
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
    };
}
