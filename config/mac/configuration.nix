{ self, lib, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix

            # System configuration
            #./../../system/users.nix
            ./../../system/nix-gc.nix
            #./../../system/fonts.nix
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

    system.defaults = {
        dock = {
            autohide = true;
            show-recents = false;
        };

        finder = {
            # Show full path in finder title
            _FXShowPosixPathInTitle = true;
            # Show all file extensions
            AppleShowAllExtensions = true;
            # Disable warning when changing file extension
            FXEnableExtensionChangeWarning = false;
            # Enable quit menu item
            QuitMenuItem = true;
            # Show path bar
            ShowPathbar = true;
            # Show status bar
            ShowStatusBar = true;
        };

        trackpad = {
            # Enable tap to click
            Clicking = true;
            # Enable two finger right click
            TrackpadRightClick = true;
            # Enable three finger drag
            TrackpadThreeFingerDrag = true;
        };

        NSGlobalDomain = {
            # Enable natural scrolling
            "com.apple.swipescrolldirection" = true;
            # Disable beep sound when pressing volume up/down key
            "com.apple.sound.beep.feedback" = 0;
            # Dark mode
            AppleInterfaceStyle = "Dark";
            # Enable full keyboard control
            AppleKeyboardUIMode = 3;
            # Disable auto capitalization
            NSAutomaticCapitalizationEnabled = false;
            # Disable auto dash substitution
            NSAutomaticDashSubstitutionEnabled = false;
            # Disable auto period substitution
            NSAutomaticPeriodSubstitutionEnabled = false;
            # Disable auto quote substitution
            NSAutomaticQuoteSubstitutionEnabled = false;
            # Disable auto spelling correction
            NSAutomaticSpellingCorrectionEnabled = false;
            # Expand save panel by default
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
        };

        keyboard = {
            enableKeyMapping = true;
            remapCapsLockToEscape  = true;
        };
    };

    # Do not need to update
    system.stateVersion = lib.mkForce 4;
}
