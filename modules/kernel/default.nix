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

            cachyos = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Override kernel build with CachyOS variant";
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
                    type = lib.types.bool;
                    default = false;
                    description = "Load VFIO kernel modules so devices can be bound to vfio-pci";
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

    flake.modules.nixos.${name} = { config, inputs, pkgs, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            hardware.enableAllFirmware = true;
            hardware.enableRedistributableFirmware = true;

            boot = {
                # Use CachyOS variant if its defined, otherwise use a kernel from nixpkgs
                kernelPackages =
                    if self.cachyos != null
                    then pkgs.cachyosKernels.${self.cachyos}
                    else self.build;

                # Load the iGPU driver early so the console comes up on it
                initrd.kernelModules = lib.optionals self.flags.intel [
                    "xe"             # Intel Xe graphics driver
                ];

                # Loaded once userspace is up
                kernelModules =
                    lib.optionals self.flags.vfio [
                        "vfio_pci"
                        "vfio"
                        "vfio_iommu_type1"
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
                        # Disable split-lock detection to prevent stalls in Wine/Proton games
                        "split_lock_detect=off"
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

            boot.kernel.sysctl = lib.mkIf self.flags.performance {
                # Prefer keeping pages in RAM over swapping
                "vm.swappiness" = 10;
                # Flush dirty pages in small batches instead of large bursts
                "vm.dirty_bytes" = 256 * 1024 * 1024;            # hard limit
                "vm.dirty_background_bytes" = 128 * 1024 * 1024; # soft limit
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
                LIBVA_DRIVER_NAME = "iHD";
            };

            hardware.nvidia = lib.mkIf self.flags.nvidia {
                modesetting.enable = true;

                # fbcon on the NVIDIA card pins the driver open
                # preventing runtime handover of the card to a guest
                moduleParams."nvidia-drm".fbdev = lib.mkForce 0;

                # Enable settings menu (nvidia-settings)
                nvidiaSettings = true;

                # Use open drivers (for modern cards)
                open = true;
                package = config.boot.kernelPackages.nvidiaPackages.stable;
            };

            nixpkgs.overlays = lib.optionals (self.cachyos != null) [
                inputs.nix-cachyos-kernel.overlays.pinned
            ];

            nix.settings = lib.mkIf (self.cachyos != null) {
                substituters = [ "https://attic.xuyh0120.win/lantian" ];
                trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
            };
        };
    };
}
