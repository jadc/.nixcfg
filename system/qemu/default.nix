{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        spice spice-gtk
        spice-protocol
        virt-manager
        virt-viewer
        win-spice
        win-virtio
    ];

    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                swtpm.enable = true;
                ovmf.enable = true;
                ovmf.packages = [ pkgs.OVMFFull.fd ];
            };
        };
        spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;

    # Enable dconf (system management tool)
    programs.dconf.enable = true;

    # Add user to libvirtd group
    users.users.${config.common.username}.extraGroups = [ "libvirtd" ];
}
