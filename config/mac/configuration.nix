{ self, lib, ... }:

{
    imports =
        [
            # System configuration
            ./../../system/users.nix
        ];

    # Enable Nix daemon for macOS
    services.nix-daemon.enable = true;
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Enable homebrew packages
    homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
    };

    # Allow Touch ID to grant superuser
    security.pam.enableSudoTouchIdAuth = true;

    # Do not need to update
    system.stateVersion = lib.mkForce 4;
}
