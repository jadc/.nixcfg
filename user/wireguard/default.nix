{ pkgs, lib, ... }:

let
    wg-name = "home";
in
{
    # Create interface and service for wireguard vpn
    networking.wg-quick.interfaces."${wg-name}".configFile = "/etc/wireguard/${wg-name}.conf";

    # Disable automatically starting at boot
    systemd.services."wg-quick-${wg-name}".wantedBy = lib.mkForce [];

    # Create a command to toggle wireguard service
    environment.systemPackages = with pkgs; [
        (writeShellApplication {
            name = "vpn";
            text = let service = "wg-quick-${wg-name}"; in ''
                if systemctl is-active ${service} > /dev/null 2>&1; then
                    sudo systemctl stop ${service} && \
                    printf "Stopped WireGuard '%s' VPN\n" "${wg-name}"
                else
                    sudo systemctl start ${service} && \
                    printf "Started WireGuard '%s' VPN\n" "${wg-name}"
                fi
            '';
        })
    ];
}
