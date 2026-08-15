{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption "a wired LAN bridge";

            interface = lib.mkOption {
                type = lib.types.str;
                description = "Physical ethernet interface attached to the LAN bridge";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Keep the physical interface out of NetworkManager's generated
            # standalone profile; it must be enslaved to br0 instead.
            networking.networkmanager.settings.main.no-auto-default = self.interface;
            networking.networkmanager.ensureProfiles.profiles = {
                br0 = {
                    connection = {
                        id = "br0";
                        type = "bridge";
                        interface-name = "br0";
                        autoconnect = true;
                    };
                    ipv4.method = "auto";
                    ipv6.method = "auto";
                };
                "br0-${self.interface}" = {
                    connection = {
                        id = "br0-${self.interface}";
                        type = "ethernet";
                        interface-name = self.interface;
                        master = "br0";
                        slave-type = "bridge";
                        autoconnect = true;
                    };
                    ipv4.method = "disabled";
                    ipv6.method = "disabled";
                };
            };
        };
    };
}
