{ config, lib, ... }:

let
    name = "docker";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Enable docker
        virtualisation.docker.enable = true;

        # Add user to docker group
        users.users.${config.cfg.const.username}.extraGroups = [ "docker" ];
    };
}
