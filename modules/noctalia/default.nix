{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
            wallpaper = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.upower.enable = true;
            services.power-profiles-daemon.enable = true;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, inputs, pkgs, ... }: let self = config.cfg.${name}; in {
        imports = [ inputs.noctalia.homeModules.default ];

        config = lib.mkIf self.enable {
            # Prevent telemetry pop-up after first time
            cfg.impermanence.home.files = [
                ".cache/noctalia/shell-state.json"
            ];

            # Point wallpaper to path in nix store
            home.file.".cache/noctalia/wallpapers.json" = lib.mkIf (self.wallpaper != null) {
                text = builtins.toJSON {
                    defaultWallpaper = toString self.wallpaper;
                };
            };

            programs.noctalia-shell = {
                enable = true;
                package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

                colors = lib.mkForce {
                    mPrimary          = "#ffffff";
                    mOnPrimary        = "#000000";
                    mSecondary        = "#cccccc";
                    mOnSecondary      = "#000000";
                    mTertiary         = "#999999";
                    mOnTertiary       = "#000000";
                    mError            = "#ffffff";
                    mOnError          = "#000000";
                    mSurface          = "#000000";
                    mOnSurface        = "#ffffff";
                    mSurfaceVariant   = "#1a1a1a";
                    mOnSurfaceVariant = "#cccccc";
                    mOutline          = "#444444";
                    mShadow           = "#000000";
                    mHover            = "#222222";
                    mOnHover          = "#ffffff";
                };

                settings = lib.mkForce {
                    # Bar layout
                    bar = {
                        backgroundOpacity = 0.66;
                        contentPadding = 0;
                        fontScale = 1.1;
                        hideOnOverview = true;
                        showCapsule = false;
                        widgetSpacing = 8;
                        widgets = {
                            center = [
                                {
                                    clockColor = "none";
                                    customFont = config.stylix.fonts.sansSerif.name;
                                    formatHorizontal = "h:mm:ss a";
                                    formatVertical = "";
                                    id = "Clock";
                                    tooltipFormat = "dddd, MMMM d";
                                    useCustomFont = true;
                                }
                            ];
                            left = [
                                {
                                    colorizeDistroLogo = false;
                                    colorizeSystemIcon = "none";
                                    colorizeSystemText = "none";
                                    customIconPath = "";
                                    enableColorization = true;
                                    icon = "noctalia";
                                    id = "ControlCenter";
                                    useDistroLogo = true;
                                }
                                {
                                    characterCount = 2;
                                    colorizeIcons = true;
                                    emptyColor = "secondary";
                                    enableScrollWheel = true;
                                    focusedColor = "primary";
                                    followFocusedScreen = false;
                                    fontWeight = "bold";
                                    groupedBorderOpacity = 1;
                                    hideUnoccupied = true;
                                    iconScale = 0.9;
                                    id = "Workspace";
                                    labelMode = "index";
                                    occupiedColor = "secondary";
                                    pillSize = 0.8;
                                    showApplications = false;
                                    showApplicationsHover = false;
                                    showBadge = false;
                                    showLabelsOnlyWhenOccupied = true;
                                    unfocusedIconsOpacity = 1;
                                }
                                {
                                    compactMode = false;
                                    hideMode = "hidden";
                                    hideWhenIdle = false;
                                    id = "MediaMini";
                                    maxWidth = 360;
                                    panelShowAlbumArt = true;
                                    scrollingMode = "hover";
                                    showAlbumArt = true;
                                    showArtistFirst = true;
                                    showProgressRing = true;
                                    showVisualizer = true;
                                    textColor = "none";
                                    useFixedWidth = false;
                                    visualizerType = "mirrored";
                                }
                            ];
                            right = [
                                {
                                    compactMode = true;
                                    diskPath = "/";
                                    iconColor = "none";
                                    id = "SystemMonitor";
                                    showCpuCores = false;
                                    showCpuFreq = false;
                                    showCpuTemp = true;
                                    showCpuUsage = true;
                                    showDiskAvailable = false;
                                    showDiskUsage = false;
                                    showDiskUsageAsPercent = false;
                                    showGpuTemp = true;
                                    showLoadAverage = false;
                                    showMemoryAsPercent = false;
                                    showMemoryUsage = true;
                                    showNetworkStats = false;
                                    showSwapUsage = false;
                                    textColor = "none";
                                    useMonospaceFont = false;
                                    usePadding = false;
                                }
                                {
                                    displayMode = "onhover";
                                    iconColor = "none";
                                    id = "VPN";
                                    textColor = "none";
                                }
                                {
                                    displayMode = "onhover";
                                    iconColor = "none";
                                    id = "Network";
                                    textColor = "none";
                                }
                                {
                                    displayMode = "onhover";
                                    iconColor = "none";
                                    id = "Bluetooth";
                                    textColor = "none";
                                }
                                {
                                    displayMode = "onhover";
                                    iconColor = "none";
                                    id = "Volume";
                                    middleClickCommand = "pwvucontrol || pavucontrol";
                                    textColor = "none";
                                }
                                {
                                    deviceNativePath = "__default__";
                                    displayMode = "icon-always";
                                    hideIfIdle = true;
                                    hideIfNotDetected = true;
                                    id = "Battery";
                                    showNoctaliaPerformance = true;
                                    showPowerProfiles = true;
                                }
                            ];
                        };
                    };

                    # Brightness
                    brightness = {
                        enableDdcSupport = true;
                        enforceMinimum = false;
                    };

                    # Use default terminal for shell commands
                    appLauncher.terminalCommand = "$TERMINAL";

                    # Make a noise when adjusting volume
                    audio.volumeFeedback = true;

                    # Control center
                    controlCenter = {
                        cards = [
                            { enabled = true; id = "profile-card"; }
                            { enabled = true; id = "shortcuts-card"; }
                            { enabled = true; id = "audio-card"; }
                            { enabled = true; id = "brightness-card"; }
                            { enabled = true; id = "weather-card"; }
                            { enabled = true; id = "media-sysmon-card"; }
                        ];
                        shortcuts = {
                            left = [
                                { id = "Network"; }
                                { id = "Bluetooth"; }
                                { id = "AirplaneMode"; }
                            ];
                            right = [
                                { id = "Notifications"; }
                                { id = "NightLight"; }
                                { id = "KeepAwake"; }
                            ];
                        };
                    };

                    # Disable Dock
                    dock.enabled = false;

                    # Only turn off display during idle, do not sleep
                    idle = {
                        enabled = true;
                        lockTimeout = 0;
                        suspendTimeout = 0;
                    };

                    # Location
                    location = {
                        hideWeatherCityName = true;
                        hideWeatherTimezone = true;
                        use12hourFormat = true;
                    };

                    # Night light
                    nightLight = {
                        enabled = true;
                        nightTemp = "2500";
                    };

                    # System monitor
                    systemMonitor = {
                        enableDgpuMonitoring = true;
                        criticalColor = "#ff6f9b";
                        warningColor = "#d8b4ff";
                    };

                    # UI
                    ui = {
                        fontDefault = config.stylix.fonts.sansSerif.name;
                        fontFixed = config.stylix.fonts.monospace.name;
                        panelBackgroundOpacity = 1;
                        scrollbarAlwaysVisible = false;
                    };
                    general = {
                        enableBlurBehind = false;
                        enableShadows = false;
                        forceBlackScreenCorners = true;
                        screenRadiusRatio = 0.5;
                        shadowDirection = "bottom";
                        shadowOffsetX = 0;
                        showChangelogOnStartup = false;
                        showScreenCorners = true;
                    };


                    # Wallpaper
                    wallpaper.enabled = self.wallpaper != null;
                    noctaliaPerformance.disableWallpaper = false;
                };
            };
        };
    };
}
