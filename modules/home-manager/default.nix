top@{ inputs, lib, ... }:

{
    flake.modules.nixos.home-manager = { config, username, ... }: {
        imports = [ inputs.home-manager.nixosModules.home-manager ];

        home-manager = {
            extraSpecialArgs = { inherit inputs username; };
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules =
                (lib.attrValues top.config.flake.modules.generic)
                ++ (lib.attrValues top.config.flake.modules.homeManager);
            users.${username}.cfg = config.cfg;
        };
    };

    flake.modules.homeManager.home-manager = { config, lib, username, ... }: {
        home = {
            username = lib.mkForce username;
            homeDirectory = lib.mkForce ("/home/" + username);
            stateVersion = config.cfg.const.stateVersion;
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        # Automatically start systemd user services
        systemd.user.startServices = true;
    };
}
