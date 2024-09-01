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

    # Disable app quarantine
    system.defaults.LaunchServices.LSQuarantine = false;

    system.defaults.dock = {
        # Set size of dock icons
        tilesize = 48;

        # Enable auto hiding dock
        autohide = true;

        # Hide recent applications
        show-recents = false;

        # Minimize windows into application icon
        minimize-to-application = true;
    };

    system.defaults.finder = {
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

        # Disable desktop icons
        CreateDesktop = false;

        # Change the default finder view. “icnv” = Icon view
        FXPreferredViewStyle = "icnv"; 
    };

    system.defaults.trackpad = {
        # Enable tap to click
        Clicking = true;

        # Enable two finger right click
        TrackpadRightClick = true;

        # Enable three finger drag
        TrackpadThreeFingerDrag = true;
    };

    system.defaults.NSGlobalDomain = {
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
    };

    system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape  = true;
    };

    # Do not need to update
    system.stateVersion = lib.mkForce 4;
}
