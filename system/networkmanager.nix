{ config, ... }:

{
    # Enable networking
    networking.networkmanager.enable = true;

    # Disable weird service that fails
    systemd.services.NetworkManager-wait-online.enable = false;

    # Add user to networkmanager group
    users.users.${config.common.username}.extraGroups = [ "networkmanager" ];
}
