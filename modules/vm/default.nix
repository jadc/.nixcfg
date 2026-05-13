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

    flake.modules.nixos.${name} = { config, lib, pkgs, username, ... }: let self = config.cfg.${name}; in {
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

            cfg.save.root.dirs = [ "/var/lib/libvirt" ];
        };
    };
}
