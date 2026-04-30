{ config, lib, ... }:

let
    name = "ripgrep";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.ripgrep.enable = true;
    };
}
