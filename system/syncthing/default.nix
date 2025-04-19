{ config, ... }:

{
    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = config.common.username;
        group = "wheel";
    };
}
