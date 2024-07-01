# vesktop: An alternate client for Discord with Vencord built-in.

{ pkgs, ... }:

{
    home.packages = with pkgs; [ vesktop ];
    xdg.configFile.vesktop = { 
        target = "vesktop/settings/settings.json";
        recursive = true;
        executable = false; 
        text = ''
            {
                "notifyAboutUpdates": true,
                "autoUpdate": true,
                "autoUpdateNotification": true,
                "useQuickCss": true,
                "themeLinks": [],
                "enabledThemes": [],
                "enableReactDevtools": false,
                "frameless": true,
                "transparent": false,
                "winCtrlQ": false,
                "disableMinSize": true,
                "winNativeTitleBar": false,
                "plugins": {
                    "BadgeAPI": { "enabled": true },
                    "CommandsAPI": { "enabled": true },
                    "ContextMenuAPI": { "enabled": true },
                    "MessageAccessoriesAPI": { "enabled": true },
                    "MessageEventsAPI": { "enabled": true },
                    "NoticesAPI": { "enabled": true },
                    "NoTrack": {
                        "enabled": true,
                        "disableAnalytics": true
                    },
                    "Settings": {
                        "enabled": true,
                        "settingsLocation": "aboveActivity"
                    },
                    "SupportHelper": { "enabled": true },
                    "CallTimer": {
                        "enabled": true,
                        "format": "stopwatch"
                    },
                    "ClearURLs": { "enabled": true },
                    "ClientTheme": {
                        "enabled": true,
                        "color": "0a0806"
                    },
                    "CrashHandler": { "enabled": true },
                    "FavoriteGifSearch": { "enabled": true },
                    "ForceOwnerCrown": { "enabled": true },
                    "MemberCount": {
                        "enabled": true,
                        "memberList": true,
                        "toolTip": true
                    },
                    "MessageLogger": {
                        "enabled": true,
                        "deleteStyle": "text",
                        "ignoreBots": true,
                        "ignoreSelf": true,
                        "ignoreUsers": "",
                        "ignoreChannels": "",
                        "ignoreGuilds": "",
                        "logEdits": true,
                        "logDeletes": true
                    },
                    "NoBlockedMessages": {
                        "enabled": true,
                        "ignoreBlockedMessages": false
                    },
                    "NoF1": { "enabled": true },
                    "NoProfileThemes": { "enabled": true },
                    "NoSystemBadge": { "enabled": true },
                    "NoTypingAnimation": { "enabled": true },
                    "OpenInApp": {
                        "enabled": true,
                        "spotify": true,
                        "steam": true,
                        "epic": true,
                        "tidal": true
                    },
                    "ReverseImageSearch": { "enabled": true },
                    "RoleColorEverywhere": {
                        "enabled": true,
                        "chatMentions": true,
                        "memberList": true,
                        "voiceUsers": true,
                        "reactorsList": true
                    },
                    "SendTimestamps": {
                        "enabled": true,
                        "replaceMessageContents": true
                    },
                    "SpotifyControls": {
                        "enabled": true,
                        "hoverControls": false,
                        "useSpotifyUris": false
                    },
                    "ValidUser": { "enabled": true },
                    "VoiceMessages": { "enabled": true },
                    "ChatInputButtonAPI": { "enabled": true },
                    "WebContextMenus": {
                        "enabled": true,
                        "addBack": true
                    },
                    "WebKeybinds": { "enabled": true },
                    "ShowHiddenThings": {
                        "enabled": true,
                        "showTimeouts": true,
                        "showInvitesPaused": true,
                        "showModView": true,
                        "disableDiscoveryFilters": true,
                        "disableDisallowedDiscoveryFilters": true
                    },
                    "WebScreenShareFixes": { "enabled": true },
                    "MessageUpdaterAPI": { "enabled": true },
                    "UserSettingsAPI": { "enabled": true }
                }
            }
    ''; 
    };
}
