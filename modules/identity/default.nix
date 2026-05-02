{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            passwordFile = lib.mkOption {
                type = lib.types.str;
                default = "/password";
                description = "Path to file containing the hashed password for the user and root.";
            };
        };
    };

    flake.modules.nixos.${name} = { config, hostname, username, ... }: let
        self = config.cfg.${name};
    in {
        # Hostname
        networking.hostName = hostname;

        # Create user
        users.mutableUsers = false;
        users.users.${username} = {
            isNormalUser = true;
            description = username;
            extraGroups = [ "wheel" ];
            hashedPasswordFile = self.passwordFile;
        };

        users.users.root.hashedPasswordFile = self.passwordFile;

        # Enable automatic login for the user.
        services.getty.autologinUser = username;

        # Allow wheel group to skip sudo password
        security.sudo.wheelNeedsPassword = false;
    };
}
