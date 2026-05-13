{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            configurations = lib.mkOption {
                type = lib.types.attrsOf lib.types.path;
                default = {};
                description = "WireGuard configurations to manage (name -> config file path)";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            cfg.save.root.files = map toString (lib.attrValues self.configurations);

            # Import WireGuard configs into NetworkManager on boot
            systemd.services.wireguard-nm-import = {
                description = "Import WireGuard configurations into NetworkManager";
                after = [ "NetworkManager.service" ];
                requires = [ "NetworkManager.service" ];
                wantedBy = [ "multi-user.target" ];
                path = [ pkgs.networkmanager ];
                serviceConfig = {
                    Type = "oneshot";
                    RemainAfterExit = true;
                };
                script = lib.concatStrings (lib.mapAttrsToList (name: configFile: ''
                    nmcli connection delete "${name}" 2>/dev/null || true

                    nmcli connection import type wireguard file "${configFile}"

                    IMPORTED_NAME="$(basename "${configFile}" .conf)"
                    nmcli connection modify "$IMPORTED_NAME" connection.id "${name}" connection.autoconnect no
                '') self.configurations);
            };
        };
    };
}
