{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { config, lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            domains = lib.mkOption {
                type = lib.types.attrsOf lib.types.path;
                default = {};
            };

            imageDir = lib.mkOption {
                type = lib.types.str;
                default = "/var/lib/libvirt/images";
                description = "Directory holding VM disk images";
            };

            passthrough = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
                example = [ "0000:01:00.0" ];
                description = "PCI addresses of devices handed to guests at runtime";
            };

            memory = lib.mkOption {
                type = lib.types.int;
                description = "Guest memory in MB";
            };

            memoryLimit = lib.mkOption {
                type = lib.types.int;
                default = config.cfg.${name}.memory + 8*1024;
                description = ''
                    Ceiling on host memory for a guest's QEMU process in MB.
                    Must exceed guest memory by enough to cover QEMU overhead
                    and pinned VRAM mappings.
                '';
            };

            hugepages = lib.mkEnableOption "backing guest memory with 2MB hugepages allocated while the guest runs";

            extraDomainXml = lib.mkOption {
                type = lib.types.lines;
                default = "";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, username, ... }: let
        self = config.cfg.${name};
        virsh = "${config.virtualisation.libvirtd.package}/bin/virsh --connect qemu:///system";

        # Convert passthrough addresses into <hostdev> format
        pciHostdev = addr: let
            parts = lib.splitString ":" addr;
            dom = lib.elemAt parts 0;
            bus = lib.elemAt parts 1;
            slotFn = lib.splitString "." (lib.elemAt parts 2);
            slot = lib.elemAt slotFn 0;
            fn = lib.elemAt slotFn 1;
        in ''
            <hostdev mode='subsystem' type='pci' managed='yes'>
              <driver name='vfio'/>
              <source>
                <address domain='0x${dom}' bus='0x${bus}' slot='0x${slot}' function='0x${fn}'/>
              </source>
            </hostdev>'';

        domainXml = guest: xml: pkgs.writeText "${guest}.xml" (
            builtins.replaceStrings
                [ "@imageDir@" "@memoryKiB@" "@memoryLimitKiB@" "@hostdevs@" "@extraDomainXml@" ]
                [
                    self.imageDir
                    (toString (self.memory * 1024))
                    (toString (self.memoryLimit * 1024))
                    (lib.concatMapStringsSep "\n" pciHostdev self.passthrough)
                    self.extraDomainXml
                ]
                (builtins.readFile xml)
        );
    in {
        config = lib.mkIf self.enable {
            assertions = [{
                assertion = lib.mod self.memory 2 == 0;
                message = "guest memory size must be even";
            }];

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
                    package = pkgs.qemu_kvm;
                    runAsRoot = true;
                    swtpm.enable = true;
                };

                # Dynamically allocate/free hugepages on hugepage-backed guest start/stop.
                hooks.qemu = lib.optionalAttrs self.hugepages {
                    hugepages = pkgs.writeShellScript "qemu-hugepages-hook" (
                        builtins.replaceStrings
                            [ "@HUGEPAGES@" ]
                            [ (toString self.memory) ]
                            (builtins.readFile ./qemu-hugepages-hook.sh)
                    );
                } // lib.optionalAttrs (self.passthrough != []) {
                    gpu = pkgs.writeShellScript "qemu-gpu-hook" (
                        builtins.replaceStrings
                            [ "@PASSTHROUGH@" ]
                            [ (lib.concatStringsSep " " self.passthrough) ]
                            (builtins.readFile ./qemu-gpu-hook.sh)
                    );
                };
            };

            # Ensure VM XMLs from this repo are defined
            systemd.services.libvirt-domains = lib.mkIf (self.domains != {}) {
                description = "Define declarative libvirt domains";
                after = [ "libvirtd.service" ];
                requires = [ "libvirtd.service" ];
                wantedBy = [ "multi-user.target" ];

                serviceConfig = {
                    Type = "oneshot";
                    RemainAfterExit = true;
                };

                script = lib.concatLines (
                    # Start libvirt default NAT network
                    [
                        "${virsh} net-autostart default || true"
                        "${virsh} net-start default || true"
                    ]
                    ++ lib.mapAttrsToList
                        (guest: xml: "${virsh} define --validate ${domainXml guest xml}")
                        self.domains
                );
            };

            # Allow libvirt to lock memory for hugepages
            systemd.services.libvirtd.serviceConfig.LimitMEMLOCK = "infinity";

            # Enable dconf (system management tool)
            programs.dconf.enable = true;

            # Add user to libvirtd group
            users.users.${username}.extraGroups = [ "libvirtd" ];

            # Preserve libvirt directory
            cfg.save.root.dirs = [ "/var/lib/libvirt" ];

            # Keep passthrough devices off the seat. logind hands every
            # master-of-seat DRM card to the session and the compositor then
            # opens it as a secondary output device even with nothing plugged
            # in, pinning the driver so libvirt cannot detach it. The render
            # node is untagged and mode 0666, so offloaded clients are
            # unaffected.
            services.udev.extraRules = lib.concatMapStringsSep "\n" (addr:
                ''SUBSYSTEM=="drm", KERNEL=="card*", ENV{ID_PATH}=="pci-${addr}", TAG-="master-of-seat", TAG-="seat"''
            ) self.passthrough;

            # Create imageDir
            systemd.tmpfiles.rules = lib.mkIf (self.domains != {}) [
                "d ${self.imageDir} 0755 ${username} users -"
            ];
        };
    };
}
