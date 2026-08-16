{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            size = lib.mkOption {
                type = lib.types.int;
                default = 32;
                description = "Size of the shared framebuffer in MB";
            };

            device = lib.mkOption {
                type = lib.types.str;
                default = "/dev/kvmfr0";
                description = "kvmfr character device backing the shared framebuffer";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            assertions = [{
                assertion = lib.bitAnd self.size (self.size - 1) == 0;
                message = "ramebuffer size must be a power of two";
            }];

            # kvmfr publishes the framebuffer as a character device rather than a
            # /dev/shm file, so the client can import it as a DMABUF and sample it
            # directly instead of copying every frame out of shared memory first.
            boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
            boot.kernelModules = [ "kvmfr" ];
            boot.extraModprobeConfig = "options kvmfr static_size_mb=${toString self.size}";

            # The client runs unprivileged, so hand the node to the user directly.
            # DRM minors are not involved here, so a static rule is enough.
            services.udev.extraRules = ''
                SUBSYSTEM=="kvmfr", OWNER="${username}", GROUP="kvm", MODE="0660"
            '';

            # Any definition of verbatimConfig replaces the NixOS default wholesale,
            # so `namespaces` is restated here alongside the device ACL. QEMU runs as
            # root and clears DAC on the node, but the cgroup device controller still
            # denies it unless the path is named; libvirt's built-in ACL covers only
            # the list below.
            virtualisation.libvirtd.qemu.verbatimConfig = ''
                namespaces = []
                cgroup_device_acl = [
                    "/dev/null", "/dev/full", "/dev/zero",
                    "/dev/random", "/dev/urandom",
                    "/dev/ptmx", "/dev/kvm", "/dev/userfaultfd",
                    "${self.device}"
                ]
            '';

            # libvirt's <shmem> element can only point at /dev/shm, so the ivshmem
            # device and its kvmfr backing are passed to QEMU verbatim. Guests opt in
            # by carrying the @extraDomainXml@ token.
            cfg.vm.extraDomainXml = ''
                <qemu:commandline>
                  <qemu:arg value='-device'/>
                  <qemu:arg value='{"driver":"ivshmem-plain","id":"shmem0","memdev":"looking-glass"}'/>
                  <qemu:arg value='-object'/>
                  <qemu:arg value='{"qom-type":"memory-backend-file","id":"looking-glass","mem-path":"${self.device}","size":${toString (self.size * 1024 * 1024)},"share":true}'/>
                </qemu:commandline>
            '';
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.looking-glass-client ];

            xdg.configFile."looking-glass/client.ini".text = ''
                [app]
                shmFile=${self.device}

                [input]
                # Send unaccelerated deltas, so the guest applies its own sensitivity
                # curve instead of stacking one on top of the host's
                rawMouse=yes
                # Keep the pointer captured while the guest wants it
                autoCapture=yes

                [spice]
                # Keyboard and mouse ride the guest's SPICE channel; the shared
                # framebuffer is display-only
                enable=yes
            '';
        };
    };
}
