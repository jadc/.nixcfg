{
    boot.kernelParams = [
        "nowatchdog"
        "nomce"
        "mitigations=off"
        "random.trust_cpu=on"
        "fsck.mode=skip"
        "libahci.ignore_sss=1"
    ];
}
