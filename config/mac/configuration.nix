{ config, lib, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix

            # System configuration
            #./../../system/users.nix
            ./../../system/gc
            ./../../system/fonts

            # Require superuser
            ## Homebrew
            ./../../user/app/jellyfin-player/mac.nix
            ./../../user/app/wireguard/mac.nix
        ];

    # Set hostname
    networking.computerName = config.common.hostname;

    # Enable Nix daemon for macOS
    services.nix-daemon.enable = true;

    # Enable homebrew packages
    homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
    };

    # Allow Touch ID to grant superuser
    security.pam.enableSudoTouchIdAuth = true;

    # System preferences
    system.defaults = {
        dock = {
            # Set size of dock icons
            tilesize = 48;

            # Enable auto hiding dock
            autohide = true;

            # Hide recent applications
            show-recents = false;

            # Minimize windows into application icon
            minimize-to-application = true;

            # Faster dock (default 1.0)
            autohide-time-modifier = 0.5;

            # Faster Mission Control (default 1.0)
            expose-animation-duration = 0.5;

            # Disable reorganizing spaces based on use
            mru-spaces = false;
        };

        finder = {
            # Show full path in finder title
            _FXShowPosixPathInTitle = true;

            # Show all file extensions
            AppleShowAllExtensions = true;

            # Disable warning when changing file extension
            FXEnableExtensionChangeWarning = false;

            # Allow quitting Finder
            QuitMenuItem = true;

            # Show status bar
            ShowStatusBar = true;

            # Disable desktop icons
            CreateDesktop = false;

            # Change the default finder view to list
            FXPreferredViewStyle = "Nlsv";
        };

        trackpad = {
            # Enable tap to click
            Clicking = true;

            # Enable two finger right click
            TrackpadRightClick = true;

            # Enable three finger drag
            TrackpadThreeFingerDrag = true;
        };

        screencapture = {
            # Disable drop shadow border
            disable-shadow = true;

            # Save screenshots to ~/Downloads
            location = "${config.common.home}/Downloads";
        };

        # Disable app quarantine
        LaunchServices.LSQuarantine = false;

        # Automatically update macOS
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

        # Allow any downloaded Application that has been signed to accept incoming requests
        alf.allowdownloadsignedenabled = 1;

        # Auto-login
        loginwindow.autoLoginUser = config.common.username;

        # Disable guest account
        loginwindow.GuestEnabled = false;

        # Show seconds in menu bar clock
        menuExtraClock.ShowSeconds = true;

        # Disable animation when switching screens or opening apps
        universalaccess.reduceMotion = true;

        ".GlobalPreferences" = {
            # Disable mouse acceleration
            "com.apple.mouse.scaling" = -1.0;
        };

        NSGlobalDomain = {
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

            # Disable adding . after pressing space twice
            NSAutomaticPeriodSubstitutionEnabled = false;

            # Disable auto quote substitution
            NSAutomaticQuoteSubstitutionEnabled = false;

            # Disable spell checker
            NSAutomaticSpellingCorrectionEnabled = false;

            # Expand save panel by default
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;

            # Disable opening and closing animation
            NSAutomaticWindowAnimationsEnabled = false;

            # Disable auto save text files to iCloud (TextEdit)
            NSDocumentSaveNewDocumentsToCloud = false;

            # Move window by dragging from anywhere
            NSWindowShouldDragOnGesture = true;
        };

        # Any system preferences that aren't currently in nix-darwin
        CustomUserPreferences = {
            "com.apple.finder" = {
                # Keep folders on top when sorting
                "_FXSortFoldersFirst" = true;

                # Automatically empty trash every 30 days
                "FXRemoveOldTrashItems" = true;
            };
            "com.apple.TimeMachine" = {
                # Prevent prompting to use new drives for Time Machine
                "DoNotOfferNewDisksForBackup" = true;
            };
        };
    };

    # Disable startup chime
    system.startup.chime = false;

    system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape  = true;
    };

    # Do not need to update
    system.stateVersion = lib.mkForce 4;
}
