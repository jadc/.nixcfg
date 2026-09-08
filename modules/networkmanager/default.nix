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

            # Prevent conflicts when wired and wireless interfaces
            # are connected to the same subnet.
            boot.kernel.sysctl = {
                "net.ipv4.conf.all.arp_ignore" = 1;
                "net.ipv4.conf.default.arp_ignore" = 1;
                "net.ipv4.conf.all.arp_announce" = 2;
                "net.ipv4.conf.default.arp_announce" = 2;
            };

            # Disable weird service that fails
            systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

            # Add user to networkmanager group
            users.users.${username}.extraGroups = [ "networkmanager" ];

            cfg.save.root.dirs = [ "/etc/NetworkManager/system-connections" ];
        };
    };
}
