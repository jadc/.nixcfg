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

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.upower.enable = true;
            services.power-profiles-daemon.enable = true;

            services.udev.extraRules = ''
                SUBSYSTEM=="power_supply", ATTR{type}=="Mains", TAG+="systemd", ENV{SYSTEMD_WANTS}="power-profile-auto-switch.service"
            '';

            systemd.services.power-profile-auto-switch = {
                description = "Switch power profile based on AC status";
                after = [ "power-profiles-daemon.service" ];
                serviceConfig = {
                    Type = "oneshot";
                    ExecStart = pkgs.writeShellScript "power-profile-auto-switch" ''
                        if [ "$(cat /sys/class/power_supply/AC/online)" = "1" ]; then
                            ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
                        else
                            ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
                        fi
                    '';
                };
            };
        };
    };
}
