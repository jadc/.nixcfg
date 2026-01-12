{ config, pkgs, lib, ... }:

let
    name = "kernel";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;

        build = mkOption {
            type = types.raw;
            default = pkgs.linuxPackages_latest;
        };

        flags = {
            quiet = mkOption {
                type = types.bool;
                default = false;
            };

            performance = mkOption {
                type = types.bool;
                default = false;
            };

            vfio = mkOption {
                type = types.listOf types.str;
                default = [];
                description = "Enable VFIO kernel modules and specify PCI device IDs to passthrough";
            };

            intel = mkOption {
                type = types.bool;
                default = false;
            };

            nvidia = mkOption {
                type = types.bool;
                default = false;
            };
        };
    };

    config = with lib; mkIf self.enable {
        hardware.enableAllFirmware = true;
        hardware.enableRedistributableFirmware = true;

        boot = {
            kernelPackages = self.build;

            # Load GPU kernel modules early in boot process
            initrd.kernelModules =
                optionals (self.flags.vfio != []) [
                    "vfio_pci"
                    "vfio"
                    "vfio_iommu_type1"
                ] ++ optionals self.flags.intel [
                    "xe"             # Intel Xe graphics driver
                ] ++ optionals self.flags.nvidia [
                    "nvidia"         # NVIDIA proprietary driver
                    "nvidia_drm"     # NVIDIA DRM kernel module
                    "nvidia_modeset" # NVIDIA modesetting module
                ];

            # Blacklist GPU drivers when their respective flags are disabled
            blacklistedKernelModules =
                optionals (!self.flags.intel) [
                    "xe"             # Intel Xe graphics driver
                ] ++ optionals (!self.flags.nvidia) [
                    "nouveau"        # Open-source NVIDIA driver
                    "nvidia"         # Proprietary NVIDIA driver
                    "nvidia_drm"     # NVIDIA DRM kernel module
                    "nvidia_modeset" # NVIDIA modesetting module
                    "nvidia_uvm"     # NVIDIA Unified Memory module
                ];

            kernelParams =
                optionals self.flags.quiet [
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
                ] ++ optionals self.flags.performance [
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
                ] ++ optionals (self.flags.vfio != []) [
                    # Specify PCI device IDs for VFIO passthrough
                    "vfio-pci.ids=${lib.concatStringsSep "," self.flags.vfio}"
                ] ++ optionals self.flags.intel [
                    # Enable IOMMU functionality
                    "intel_iommu=on"
                    "iommu=pt"
                ] ++ optionals (!self.flags.nvidia) [
                    # Disable NVIDIA GPU
                    "nouveau.modeset=0"
                ];

        };

        services.xserver.videoDrivers = mkIf self.flags.intel [ "modesetting" ];

        hardware.graphics = mkIf self.flags.intel {
            enable = true;
            enable32Bit = true;
            extraPackages = with pkgs; [
                # Required for modern Intel GPUs (Xe iGPU and ARC)
                intel-media-driver            # VA-API (iHD) userspace
                vpl-gpu-rt                    # oneVPL (QSV) runtime
                intel-compute-runtime         # OpenCL (NEO) + Level Zero for Arc/Xe
            ];
        };

        # System-wide environment variables for Intel hardware acceleration
        environment.sessionVariables = mkIf self.flags.intel {
            LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
        };

        hardware.nvidia = mkIf self.flags.nvidia {
            modesetting.enable = true;

            # Use open drivers (for modern cards)
            open = true;

            # Use beta channel
            package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
    };
}
