{ config, lib, username, ... }:

let
    name = "networkmanager";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        # Enable networking
        networking.networkmanager.enable = true;

        # Disable weird service that fails
        systemd.services.NetworkManager-wait-online.enable = false;

        # Add user to networkmanager group
        users.users.${username}.extraGroups = [ "networkmanager" ];
    };
}
