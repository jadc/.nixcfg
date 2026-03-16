{ config, lib, pkgs, ... }:

let
    name = "wireguard";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;

        configurations = mkOption {
            type = types.attrsOf types.path;
            default = {};
            description = "WireGuard configurations to manage (name -> config file path)";
        };
    };

    config = lib.mkIf self.enable {
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
}
