# To support intel integrated graphics
{
    boot.kernelParams = [
        "i915.enable_fbc=1"
        "i915.fastboot=1"
        "i915.modeset=1"
    ];
}
