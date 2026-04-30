{ lib, ... }:

{
    options.cfg.locale = lib.mkOption {
        type = lib.types.str;
        default = "en_CA.UTF-8";
        description = "The locale of the system";
    };
}
