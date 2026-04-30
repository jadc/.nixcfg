{ config, lib, username, ... }:

let
    name = "docker";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        # Enable docker
        virtualisation.docker.enable = true;

        # Add user to docker group
        users.users.${username}.extraGroups = [ "docker" ];
    };
}
