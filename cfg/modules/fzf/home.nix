{ config, lib, ... }:

let
    name = "fzf";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.fzf.enable = true;
    };
}
