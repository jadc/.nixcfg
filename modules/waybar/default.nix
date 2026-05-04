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

    flake.modules.homeManager.${name} = { config, lib, ... }: let
        self = config.cfg.${name};
    in {
        config = lib.mkIf self.enable {
            programs.waybar = {
                enable = true;
                systemd.enable = true;

                settings.mainBar = {
                    layer = "top";
                    position = "top";
                    spacing = 0;

                    modules-left = [ "niri/workspaces" ];
                    modules-center = [ "clock" ];
                    modules-right = [ "pulseaudio" "backlight" "network" "battery" "custom/power" ];

                    clock = {
                        format = "  {:%I:%M %p}";
                        format-alt = "  {:%A, %B %d, %Y}";
                        tooltip-format = "<tt>{calendar}</tt>";
                    };

                    pulseaudio = {
                        format = "{icon}  {volume}%";
                        format-muted = "  muted";
                        format-icons.default = [ "" "" "" ];
                    };

                    backlight = {
                        format = "  {percent}%";
                        format-icons = [ "" "" ];
                    };

                    network = {
                        format-wifi = "  {essid}";
                        format-ethernet = "  {ifname}";
                        format-disconnected = "  disconnected";
                        tooltip-format = "{ipaddr}/{cidr}";
                    };

                    battery = {
                        format = "{icon}  {capacity}%";
                        format-charging = "  {capacity}%";
                        format-icons = [ "" "" "" "" "" ];
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                    };

                    "custom/power" = {
                        format = "⏻";
                        on-click = "systemctl poweroff";
                        tooltip = false;
                    };
                    "niri/workspaces" = {
                        format = "{icon}";
                        format-icons = {
                            active = "";
                            default = "";
                        };
                    };
                };

                style = builtins.readFile ./style.css;
            };
        };
    };
}
