{ config, lib, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix

            # System configuration
            #./../../system/users.nix
        ];

    # Enable Nix daemon for macOS
    services.nix-daemon.enable = true;

    # Clean >= 30 day old generations every week
    nix.gc = {
        user = config.common.username;
        automatic = true;
        options = "--delete-older-than 7d";
        interval = [{ Hour = 21; Minute = 0; Weekday = 7; }];
    };

    # Fonts
    /*
    fonts.packages = with pkgs; [
        (nerdfonts.override {
            fonts = [
                "NerdFontsSymbolsOnly"
                "JetBrainsMono"
            ];
        })
    ];
    */

    # Enable homebrew packages
    homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
        casks = [
            #discord
            "jellyfin-media-player"
            "spotify"
            #mactex
            #moonlight
            #obsidian
        ];
        masApps = {
            "Wireguard" = 1451685025;
        };
    };

    # Allow Touch ID to grant superuser
    security.pam.enableSudoTouchIdAuth = true;

    # Dock configuration
    system.defaults.dock = {
        tilesize = 48;
        autohide = true;
        show-recents = false;
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

    system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape  = true;
    };


    # Do not need to update
    system.stateVersion = lib.mkForce 4;
}
