{ config, lib, username, ... }:

let
    name = "syncthing";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.syncthing = {
            enable = true;
            openDefaultPorts = true;
            user = username;
            group = "wheel";
        };
    };
}
