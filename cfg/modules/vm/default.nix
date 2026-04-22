{ config, lib, pkgs, ... }:

let
    name = "vm";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        environment.systemPackages = [
            pkgs.spice
            pkgs.spice-gtk
            pkgs.spice-protocol
            pkgs.win-spice
            pkgs.virtio-win
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
