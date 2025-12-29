{ config, lib, pkgs, ... }:

let
    name = "wireguard";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;

        configurations = mkOption {
            type = types.listOf (types.submodule {
                options = {
                    name = mkOption {
                        type = types.str;
                        description = "Name of the WireGuard configuration";
                    };
                    configFile = mkOption {
                        type = types.path;
                        description = "Path to the WireGuard configuration file";
                    };
                };
            });
            default = [];
            description = "List of WireGuard configurations to manage";
        };
    };

    config = lib.mkIf self.enable {
        # Create interfaces and services for all wireguard configurations with existing files
        networking.wg-quick.interfaces = lib.listToAttrs (
            map (wgConfig: {
                name = wgConfig.name;
                value.configFile = wgConfig.configFile;
            }) self.configurations
        );

        # Disable all configurations from automatically starting at boot
        systemd.services = lib.listToAttrs (
            map (wgConfig: {
                name = "wg-quick-${wgConfig.name}";
                value.wantedBy = lib.mkForce [];
            }) self.configurations
        );

        # Create a command to toggle wireguard service by name
        environment.systemPackages = with pkgs; [
            (writeShellApplication {
                name = "vpn";
                text = ''
                    if [ $# -ne 1 ]; then
                        echo "Usage: vpn <name>"
                        echo "Available configurations: ${lib.concatMapStringsSep ", " (c: c.name) self.configurations}"
                        exit 1
                    fi

                    CONFIG_NAME="$1"
                    SERVICE="wg-quick-$CONFIG_NAME"

                    if systemctl is-active "$SERVICE" > /dev/null 2>&1; then
                        sudo systemctl stop "$SERVICE" && \
                        printf "Stopped WireGuard '%s' VPN\n" "$CONFIG_NAME"
                    else
                        sudo systemctl start "$SERVICE" && \
                        printf "Started WireGuard '%s' VPN\n" "$CONFIG_NAME"
                    fi
                '';
            })
        ];
    };
}
