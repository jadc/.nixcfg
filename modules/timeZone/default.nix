{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Timezone string, or null for automatic detection via automatic-timezoned";
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkMerge [
            (lib.mkIf (self == null) {
                services.automatic-timezoned.enable = true;
                services.geoclue2.enable = true;
                time.timeZone = lib.mkForce null;
            })
            (lib.mkIf (self != null) {
                time.timeZone = self;
            })
        ];
    };
}
