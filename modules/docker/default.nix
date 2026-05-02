{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Enable docker
            virtualisation.docker.enable = true;

            # Add user to docker group
            users.users.${username}.extraGroups = [ "docker" ];

            cfg.impermanence.root.dirs = [ "/var/lib/docker" ];
        };
    };
}
