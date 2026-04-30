{ config, lib, ... }:

let
    name = "fzf";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.fzf.enable = true;
    };
}
