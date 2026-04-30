# noxide: frequency cd

{ config, lib, ... }:

let
    name = "zoxide";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.zoxide = {
            enable = true;

            # Replace cd with zoxide
            options = [ "--cmd cd" ];
        };
    };
}
