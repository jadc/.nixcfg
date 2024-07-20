{ config, ... }:

{
    # Enable docker
    virtualisation.docker.enable = true;

    # Add user to docker group
    users.users.${config.common.username}.extraGroups = [ "docker" ];
}
