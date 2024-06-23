{ pkgs, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_zen;
}

/*
ROOT='ccfb5fe7-02'

# Kernel flags
QUIET='quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_level=3'
PERFORMANCE='nowatchdog nomce mitigations=off random.trust_cpu=on fsck.mode=skip libahci.ignore_sss=1'
NVIDIA='nvidia-drm.modeset=1'
INTEL='i915.enable_fbc=1 i915.fastboot=1 i915.modeset=1'
#KVM='intel_iommu=on vfio-pci.ids=10de:1e84,10de:10f8,10de:1ad8,10de:1ad9'
FLAG="$PERFORMANCE $NVIDIA $INTEL"

sudo efibootmgr \
    --disk /dev/nvme0n1 --part 1 \
    --create --label "Linux Zen" \
    --loader /vmlinuz-linux-zen --unicode \
    "root=PARTUUID=$ROOT rw initrd=\intel-ucode.img initrd=\initramfs-linux-zen.img 
*/
