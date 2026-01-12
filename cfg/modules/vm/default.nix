{ config, lib, pkgs, ... }:

let
    name = "vm";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        environment.systemPackages = with pkgs; [
            spice
            spice-gtk
            spice-protocol
            win-spice
            virtio-win
        ];

        services.spice-vdagentd.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;
        virtualisation.libvirtd = {
            enable = true;
            qemu = {
                runAsRoot = true;
                swtpm.enable = true;
            };
        };

        # Enable dconf (system management tool)
        programs.dconf.enable = true;

        # Add user to libvirtd group
        users.users.${config.cfg.const.username}.extraGroups = [ "libvirtd" ];
    };
}
