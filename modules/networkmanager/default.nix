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
            # Enable networking
            networking.networkmanager.enable = true;

            # Disable weird service that fails
            systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

            # Add user to networkmanager group
            users.users.${username}.extraGroups = [ "networkmanager" ];

            cfg.impermanence.root.dirs = [ "/etc/NetworkManager/system-connections" ];
        };
    };
}
