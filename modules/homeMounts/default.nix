{ config, lib, username, ... }:

let
    name = "homeMounts";
    self = config.cfg.${name};

    home = "/home/${username}";
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        fileSystems = lib.listToAttrs (map (n: {
            name = "${home}/${n}";
            value = {
                device = "${self.source}/${n}";
                fsType = "none";
                options = [ "bind" ];
            };
        }) self.dirs);
    };
}
