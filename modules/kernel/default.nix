{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, pkgs, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            build = lib.mkOption {
                type = lib.types.raw;
                default = pkgs.linuxPackages_latest;
            };

            flags = {
                quiet = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                };

                performance = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                };

                vfio = lib.mkOption {
                    type = lib.types.listOf lib.types.str;
                    default = [];
                    description = "Enable VFIO kernel modules and specify PCI device IDs to passthrough";
                };

                intel = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                };

                nvidia = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                };
            };
        };
    };

    flake.modules.nixos.${name} = { config, pkgs, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            hardware.enableAllFirmware = true;
            hardware.enableRedistributableFirmware = true;

            boot = {
                kernelPackages = self.build;

                # Load GPU kernel modules early in boot process
                initrd.kernelModules =
                    lib.optionals (self.flags.vfio != []) [
                        "vfio_pci"
                        "vfio"
                        "vfio_iommu_type1"
                    ] ++ lib.optionals self.flags.intel [
                        "xe"             # Intel Xe graphics driver
                    ] ++ lib.optionals self.flags.nvidia [
                        "nvidia"         # NVIDIA proprietary driver
                        "nvidia_drm"     # NVIDIA DRM kernel module
                        "nvidia_modeset" # NVIDIA modesetting module
                    ];

                # Blacklist GPU drivers when their respective flags are disabled
                blacklistedKernelModules =
                    lib.optionals (!self.flags.intel) [
                        "xe"             # Intel Xe graphics driver
                    ] ++ lib.optionals (!self.flags.nvidia) [
                        "nouveau"        # Open-source NVIDIA driver
                        "nvidia"         # Proprietary NVIDIA driver
                        "nvidia_drm"     # NVIDIA DRM kernel module
                        "nvidia_modeset" # NVIDIA modesetting module
                        "nvidia_uvm"     # NVIDIA Unified Memory module
                    ];

                kernelParams =
                    lib.optionals self.flags.quiet [
                        # Report Linux to ACPI for better hardware compatibility
                        "acpi_osi=Linux"
                        # Only show errors and critical messages in kernel log
                        "loglevel=3"
                        # Suppress most boot messages
                        "quiet"
                        # Only show systemd status if boot takes too long
                        "rd.systemd.show_status=auto"
                        # Reduce udev logging to errors only
                        "rd.udev.log_level=3"
                    ] ++ lib.optionals self.flags.performance [
                        # Disable hardware watchdog timer to save CPU cycles
                        "nowatchdog"
                        # Disable machine check exception logging for performance
                        "nomce"
                        # Disable CPU vulnerability mitigations for maximum speed
                        "mitigations=off"
                        # Trust CPU's random number generator to speed up entropy gathering
                        "random.trust_cpu=on"
                        # Skip filesystem checks at boot
                        "fsck.mode=skip"
                        # Disable staggered spin-up for SATA drives (faster boot)
                        "libahci.ignore_sss=1"
                        # Disable audit subsystem to reduce overhead
                        "audit=0"
                        # Disable transparent hugepages defrag to reduce latency spikes
                        "transparent_hugepage=madvise"
                        # Disable NUMA balancing for better performance on single-node systems
                        "numa_balancing=disable"
                    ] ++ lib.optionals (self.flags.vfio != []) [
                        # Specify PCI device IDs for VFIO passthrough
                        "vfio-pci.ids=${lib.concatStringsSep "," self.flags.vfio}"
                    ] ++ lib.optionals self.flags.intel [
                        # Enable IOMMU functionality
                        "intel_iommu=on"
                        "iommu=pt"
                    ] ++ lib.optionals self.flags.nvidia [
                        # Enable kernel modesetting for NVIDIA driver
                        "nvidia-drm.modeset=1"
                    ] ++ lib.optionals (!self.flags.nvidia) [
                        # Disable NVIDIA GPU
                        "nouveau.modeset=0"
                    ];

            };

            services.xserver.videoDrivers =
                lib.optionals self.flags.intel [ "modesetting" ]
                ++ lib.optionals self.flags.nvidia [ "nvidia" ];

            hardware.graphics = {
                enable = true;
                enable32Bit = true;
                extraPackages = lib.optionals self.flags.intel [
                    # Required for modern Intel GPUs (Xe iGPU and ARC)
                    pkgs.intel-media-driver            # VA-API (iHD) userspace
                    pkgs.vpl-gpu-rt                    # oneVPL (QSV) runtime
                    pkgs.intel-compute-runtime         # OpenCL (NEO) + Level Zero for Arc/Xe
                ];
            };

            # System-wide environment variables for Intel hardware acceleration
            environment.sessionVariables = lib.mkIf self.flags.intel {
                LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
            };

            hardware.nvidia = lib.mkIf self.flags.nvidia {
                modesetting.enable = true;

                # Use open drivers (for modern cards)
                open = true;

                # Enable settings menu (nvidia-settings)
                nvidiaSettings = true;

                # Use beta channel
                package = config.boot.kernelPackages.nvidiaPackages.beta;
            };
        };
    };
}
