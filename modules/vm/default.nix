{ config, lib, pkgs, username, ... }:

let
    name = "vm";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

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
        users.users.${username}.extraGroups = [ "libvirtd" ];
    };
}
