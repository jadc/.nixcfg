{
    home-manager.sharedModules = [ ./home.nix ];

    # Ensure all firmware and drivers is installed
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    # Enable compatibility shim for dynamically linked executables
    programs.nix-ld.enable = true;

    # Do not need to update
    system.stateVersion = "24.05";
}
