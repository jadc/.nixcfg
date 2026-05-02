{ ... }:

{
    flake.modules.nixos.identity = { hostname, username, ... }: {
        # Hostname
        networking.hostName = hostname;

        # Create user
        users.users.${username} = {
            isNormalUser = true;
            description = username;
            extraGroups = [ "wheel" ];
        };

        # Enable automatic login for the user.
        services.getty.autologinUser = username;

        # Allow wheel group to skip sudo password
        security.sudo.wheelNeedsPassword = false;
    };
}
