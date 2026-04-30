{ lib, ... }:

{
    options.cfg.const = {
        aliases = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
            description = "The shell aliases of the system";
            default = {};
        };
    };
}
