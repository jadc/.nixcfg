{ config, lib, ... }:

let
    name = "ripgrep";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.ripgrep.enable = true;
    };
}
