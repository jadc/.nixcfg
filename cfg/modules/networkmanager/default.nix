{ config, lib, ... }:

let
    name = "networkmanager";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Enable networking
        networking.networkmanager.enable = true;

        # Disable weird service that fails
        systemd.services.NetworkManager-wait-online.enable = false;

        # Add user to networkmanager group
        users.users.${config.cfg.const.username}.extraGroups = [ "networkmanager" ];
    };
}
