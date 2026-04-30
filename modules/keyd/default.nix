{ config, lib, ... }:

let
    name = "keyd";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.keyd.enable = true;
        environment.etc."keyd/default.conf".source = ./keyd.conf;
    };
}
