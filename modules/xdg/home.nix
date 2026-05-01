{ config, lib, ... }:

let
    name = "xdg";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        xdg = {
            enable = true;
            userDirs = {
                enable = true;
                createDirectories = true;

                # Disable undesired directories
                desktop = null;
                projects = null;
                publicShare = null;
                templates = null;
            };
        };
    };
}
