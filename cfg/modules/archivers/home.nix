{ config, lib, pkgs, ... }:

let
    name = "archivers";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [
            zip unzip
            p7zip
        ];
    };
}
