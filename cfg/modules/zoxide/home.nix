# noxide: frequency cd

{ config, lib, ... }:

let
    name = "zoxide";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.zoxide = {
            enable = true;

            # Replace cd with zoxide
            options = [ "--cmd cd" ];
        };
    };
}
